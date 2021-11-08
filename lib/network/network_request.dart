import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_request_api/models/posts.dart';

class NetworkRequest {
  static const String url = "https://jsonplaceholder.typicode.com/posts";
  static List<Posts> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Posts> post = list.map((e) => Posts.fromJson(e)).toList();
    return post;
  }

  static Future<List<Posts>> fetchPosts({int page = 1}) async {
    final response = await http.get('$url');
    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    }else{
      throw Exception("Cant get post");
    }
  }
}
