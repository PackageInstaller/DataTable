using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class EnterReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static EnterReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgtlbnRlci5wcm90bxICcGIaDGNvbW1vbi5wcm90byLLAQoMRW50ZXJHYW1l" + "UmVxEg4KBm9wZW5JZBgBIAEoCRIQCghsb2dpbktleRgCIAEoCRIRCglhY2Nv" + "dW50SWQYAyABKAMSEAoIaXNFZGl0b3IYBCABKAgSDgoGc2RrQWlkGAUgASgD" + "EhIKCmRpc3RpbmN0SUQYBiABKAkSFQoNY2xpZW50VmVyc2lvbhgHIAEoCRIg" + "CgZ0ZERhdGEYCCABKAsyEC5wYi5URENsaWVudERhdGESEQoJc2Vzc2lvbklE" + "GAkgASgJSgQIChALIpoCCgxFbnRlckdhbWVBY2sSCgoCdHMYASABKAMSDwoH" + "dmVyc2lvbhgCIAEoCRIQCghvcGVuVGltZRgDIAEoBRIgCgRpbmZvGAQgASgL" + "MhIucGIuRGV0YWlsVXNlckluZm8SFwoPZGF0YWJhc2VWZXJzaW9uGAUgASgJ" + "EhUKDWxhc3RFbnRlclRpbWUYBiABKAUSEQoJaXNOZXdVc2VyGAcgASgIEgwK" + "BGNvZGUYCCABKAUSEQoJYmFuTm90aWNlGAkgASgJEiYKDG1haW50YWluSW5m" + "bxgKIAEoCzIQLnBiLk1haW50YWluSW5mbxIRCglzZXNzaW9uSUQYCyABKAkS" + "GgoSbGFzdFNlc3Npb25FeHBpcmVkGAwgASgIIjEKDUNyZWF0ZVVzZXJSZXES" + "DgoGZ2VuZGVyGAEgASgFEhAKCG5pY2tOYW1lGAIgASgJIkYKDUNyZWF0ZVVz" + "ZXJBY2sSIAoEaW5mbxgBIAEoCzISLnBiLkRldGFpbFVzZXJJbmZvEhMKC2lz" + "VmFsaWROYW1lGAIgASgIIiUKEEVudGVyR2FtZUxvYWRSZXESEQoJbGFzdFNl" + "cUlEGAEgASgDIjQKEEVudGVyR2FtZUxvYWRBY2sSIAoEaW5mbxgBIAEoCzIS" + "LnBiLkRldGFpbFVzZXJJbmZvIg8KDVJhbmRvbU5hbWVSZXEiHQoNUmFuZG9t" + "TmFtZUFjaxIMCgRuYW1lGAEgASgJYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[8]
		{
			new GeneratedClrTypeInfo(typeof(EnterGameReq), EnterGameReq.Parser, new string[9] { "OpenId", "LoginKey", "AccountId", "IsEditor", "SdkAid", "DistinctID", "ClientVersion", "TdData", "SessionID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EnterGameAck), EnterGameAck.Parser, new string[12]
			{
				"Ts", "Version", "OpenTime", "Info", "DatabaseVersion", "LastEnterTime", "IsNewUser", "Code", "BanNotice", "MaintainInfo",
				"SessionID", "LastSessionExpired"
			}, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CreateUserReq), CreateUserReq.Parser, new string[2] { "Gender", "NickName" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CreateUserAck), CreateUserAck.Parser, new string[2] { "Info", "IsValidName" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EnterGameLoadReq), EnterGameLoadReq.Parser, new string[1] { "LastSeqID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EnterGameLoadAck), EnterGameLoadAck.Parser, new string[1] { "Info" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RandomNameReq), RandomNameReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RandomNameAck), RandomNameAck.Parser, new string[1] { "Name" }, null, null, null, null)
		}));
	}
}
