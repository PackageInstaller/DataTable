using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class MailReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static MailReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgptYWlsLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIjoKEE1haWxDaGFuZ2VU" + "YWdSZXESCgoCaWQYASABKAUSGgoFdG9UYWcYAiABKA4yCy5wYi5NYWlsVGFn" + "IhIKEE1haWxDaGFuZ2VUYWdBY2siQQoSTWFpbENoYW5nZVN0YXRlUmVxEgsK" + "A2lkcxgBIAMoBRIeCgd0b1N0YXRlGAIgASgOMg0ucGIuTWFpbFN0YXRlIkYK" + "Ek1haWxDaGFuZ2VTdGF0ZUFjaxILCgNpZHMYASADKAUSIwoIZ290SXRlbXMY" + "AiADKAsyES5wYi5Vbml2ZXJzYWxJdGVtIhsKDU1haWxVbmxvY2tSZXESCgoC" + "aWQYASABKAUiJwoNTWFpbFVubG9ja0FjaxIWCgRtYWlsGAEgASgLMggucGIu" + "TWFpbCIQCg5NYWlsT3BlbkJveFJlcSJ2Cg5NYWlsT3BlbkJveEFjaxIsCgVt" + "YWlscxgBIAMoCzIdLnBiLk1haWxPcGVuQm94QWNrLk1haWxzRW50cnkaNgoK" + "TWFpbHNFbnRyeRILCgNrZXkYASABKAUSFwoFdmFsdWUYAiABKAsyCC5wYi5N" + "YWlsOgI4ASJ9CgdNYWlsTnRmEiUKBW1haWxzGAEgAygLMhYucGIuTWFpbE50" + "Zi5NYWlsc0VudHJ5EhMKC2xvY2tUbXBsSWRzGAIgAygFGjYKCk1haWxzRW50" + "cnkSCwoDa2V5GAEgASgFEhcKBXZhbHVlGAIgASgLMggucGIuTWFpbDoCOAEi" + "DwoNTWFpbEhhc05ld050ZipFCglNYWlsU3RhdGUSCgoGVU5SRUFEEAASCAoE" + "UkVBRBABEgoKBlJFV0FSRBACEgoKBkRFTEVURRADEgoKBlVOU0VORBAEKi8K" + "CE1haWxUeXBlEg0KCVpFUk9fRklMTBAAEgoKBk5PUk1BTBABEggKBFJBUkUQ" + "AiohCgdNYWlsVGFnEgkKBU5PVEFHEAASCwoHQ09MTEVDVBABYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(new Type[3]
		{
			typeof(MailState),
			typeof(MailType),
			typeof(MailTag)
		}, null, new GeneratedClrTypeInfo[10]
		{
			new GeneratedClrTypeInfo(typeof(MailChangeTagReq), MailChangeTagReq.Parser, new string[2] { "Id", "ToTag" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MailChangeTagAck), MailChangeTagAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MailChangeStateReq), MailChangeStateReq.Parser, new string[2] { "Ids", "ToState" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MailChangeStateAck), MailChangeStateAck.Parser, new string[2] { "Ids", "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MailUnlockReq), MailUnlockReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MailUnlockAck), MailUnlockAck.Parser, new string[1] { "Mail" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MailOpenBoxReq), MailOpenBoxReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MailOpenBoxAck), MailOpenBoxAck.Parser, new string[1] { "Mails" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(MailNtf), MailNtf.Parser, new string[2] { "Mails", "LockTmplIds" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(MailHasNewNtf), MailHasNewNtf.Parser, null, null, null, null, null)
		}));
	}
}
