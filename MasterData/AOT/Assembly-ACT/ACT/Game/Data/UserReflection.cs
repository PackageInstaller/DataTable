using System;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public static class UserReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static UserReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgp1c2VyLnByb3RvEgJwYhoMY29tbW9uLnByb3RvGgxkYnVzZXIucHJvdG8i" + "mwEKC0RCQnJpZWZVc2VyEgoKAmlkGAEgASgDEhMKC3NlcnZlckluZGV4GAIg" + "ASgFEg4KBm9wZW5JZBgDIAEoCRISCgpjcmVhdGVUaW1lGAQgASgDEhAKCG5p" + "Y2tOYW1lGAUgASgJEg0KBWxldmVsGAYgASgFEhMKC29mZmxpbmVUaW1lGAcg" + "ASgDEhEKCWFjY291bnRJZBgIIAEoAyIlCghVc2VyTGlzdBIZCgV1c2VycxgB" + "IAMoCzIKLnBiLkRCVXNlciI8ChdRdWVyeVVzZXJCeUFjY291bnRJZFJlcRIR" + "CglhY2NvdW50SWQYASABKAMSDgoGZGJOYW1lGAIgASgJIjYKFFF1ZXJ5VXNl" + "ckJ5T3BlbklkUmVxEg4KBm9wZW5JZBgBIAEoCRIOCgZkYk5hbWUYAiABKAki" + "NgoUUXVlcnlVc2VyQnlTREtBaWRSZXESDgoGc2RrQWlkGAEgASgDEg4KBmRi" + "TmFtZRgCIAEoCSJFCgxRdWVyeVVzZXJSc3ASGwoFZXJyb3IYASABKAsyDC5w" + "Yi5FcnJvckFjaxIYCgR1c2VyGAIgASgLMgoucGIuREJVc2VyIjcKC1NhdmVV" + "c2VyUmVxEhgKBHVzZXIYASABKAsyCi5wYi5EQlVzZXISDgoGZGJOYW1lGAIg" + "ASgJIkAKC1NhdmVVc2VyUnNwEhsKBWVycm9yGAEgASgLMgwucGIuRXJyb3JB" + "Y2sSFAoMYWZmZWN0ZWRSb3dzGAIgASgDQhCqAg1BQ1QuR2FtZS5EYXRhYgZw" + "cm90bzM="), new FileDescriptor[2]
		{
			CommonReflection.Descriptor,
			DbuserReflection.Descriptor
		}, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[8]
		{
			new GeneratedClrTypeInfo(typeof(DBBriefUser), DBBriefUser.Parser, new string[8] { "Id", "ServerIndex", "OpenId", "CreateTime", "NickName", "Level", "OfflineTime", "AccountId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UserList), UserList.Parser, new string[1] { "Users" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(QueryUserByAccountIdReq), QueryUserByAccountIdReq.Parser, new string[2] { "AccountId", "DbName" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(QueryUserByOpenIdReq), QueryUserByOpenIdReq.Parser, new string[2] { "OpenId", "DbName" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(QueryUserBySDKAidReq), QueryUserBySDKAidReq.Parser, new string[2] { "SdkAid", "DbName" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(QueryUserRsp), QueryUserRsp.Parser, new string[2] { "Error", "User" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SaveUserReq), SaveUserReq.Parser, new string[2] { "User", "DbName" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SaveUserRsp), SaveUserRsp.Parser, new string[2] { "Error", "AffectedRows" }, null, null, null, null)
		}));
	}
}
