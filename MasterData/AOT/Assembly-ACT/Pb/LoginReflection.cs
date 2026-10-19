using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class LoginReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static LoginReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgtsb2dpbi5wcm90bxICcGIaDGNvbW1vbi5wcm90byLZAQoITG9naW5SZXES" + "EwoLbG9naW5UaWNrZXQYASABKAkSDgoGb3BlbklkGAIgASgJEhIKCmFwcFZl" + "cnNpb24YAyABKAkSEQoJYWNjb3VudElkGAQgASgDEiwKD29wZXJhdGlvbmFs" + "SW5mbxgFIAEoCzITLnBiLk9wZXJhdGlvbmFsSW5mbxISCgpkaXN0aW5jdElE" + "GAYgASgJEiAKBnRkRGF0YRgHIAEoCzIQLnBiLlREQ2xpZW50RGF0YRIQCghp" + "c0VkaXRvchgIIAEoCBILCgNlbnYYCSABKAkizgEKCExvZ2luQWNrEg4KBm9w" + "ZW5JZBgBIAEoCRIQCghsb2dpbktleRgCIAEoCRIRCglhY2NvdW50SWQYAyAB" + "KAMSEAoIZ2F0ZUFkZHIYBCABKAkSDAoEY29kZRgFIAEoBRITCgtzZXJ2ZXJH" + "cm91cBgGIAEoCRIOCgZzZGtBaWQYByABKAMSDgoGYWVzS2V5GAggASgMEg8K" + "B2lzRW5jcnkYCSABKAgSDwoHZmFpclRhZxgKIAEoBRIWCg5nYXRlQWRkckJh" + "Y2t1cBgLIAEoCWIGcHJvdG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[2]
		{
			new GeneratedClrTypeInfo(typeof(LoginReq), LoginReq.Parser, new string[9] { "LoginTicket", "OpenId", "AppVersion", "AccountId", "OperationalInfo", "DistinctID", "TdData", "IsEditor", "Env" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LoginAck), LoginAck.Parser, new string[11]
			{
				"OpenId", "LoginKey", "AccountId", "GateAddr", "Code", "ServerGroup", "SdkAid", "AesKey", "IsEncry", "FairTag",
				"GateAddrBackup"
			}, null, null, null, null)
		}));
	}
}
