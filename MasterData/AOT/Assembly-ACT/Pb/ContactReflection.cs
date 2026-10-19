using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class ContactReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static ContactReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg1jb250YWN0LnByb3RvEgJwYhoMY29tbW9uLnByb3RvIioKCkNvbnRhY3RO" + "dGYSHAoHY29udGFjdBgBIAEoCzILLnBiLkNvbnRhY3QijgEKGkNvbnRhY3RD" + "aGFyYWN0ZXJNZXNzYWdlTnRmEhEKCXNlc3Npb25JZBgBIAEoBRITCgtuZXdN" + "ZXNzYWdlcxgCIAMoBRIVCg1zZXNzaW9uRmluaXNoGAMgASgIEhcKD3VwZGF0" + "ZVRpbWVTdGFtcBgEIAEoBRIYChBuZXdNZXNzYWdlc0ludDY0GAUgAygDIm4K" + "GkNvbnRhY3RDaGFyYWN0ZXJTZXNzaW9uTnRmEi0KCHNlc3Npb25zGAEgAygL" + "MhsucGIuQ29udGFjdENoYXJhY3RlclNlc3Npb24SIQoGZ21Nb2RlGAIgASgO" + "MhEucGIuQ29udGFjdEdNTW9kZSI+ChZDb250YWN0Q2hvb3NlT3B0aW9uUmVx" + "EhEKCXNlc3Npb25JZBgBIAEoBRIRCgljaG9vc2VJZHgYAiABKAUiGAoWQ29u" + "dGFjdENob29zZU9wdGlvbkFjayJFChhDb250YWN0Q2hhdFdpdGhQbGF5ZXJS" + "ZXESKQoHbWVzc2FnZRgBIAEoCzIYLnBiLkNvbnRhY3RQbGF5ZXJNZXNzYWdl" + "IigKGENvbnRhY3RDaGF0V2l0aFBsYXllckFjaxIMCgRjb2RlGAEgASgFIkQK" + "F0NvbnRhY3RQbGF5ZXJNZXNzYWdlTnRmEikKB21lc3NhZ2UYASABKAsyGC5w" + "Yi5Db250YWN0UGxheWVyTWVzc2FnZSpiCg1Db250YWN0R01Nb2RlEhgKFENP" + "TlRBQ1RfR01fTU9ERV9OT05FEAASGgoWQ09OVEFDVF9HTV9NT0RFX05PUk1B" + "TBABEhsKF0NPTlRBQ1RfR01fTU9ERV9PUEVOX1VJEAJiBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(new Type[1] { typeof(ContactGMMode) }, null, new GeneratedClrTypeInfo[8]
		{
			new GeneratedClrTypeInfo(typeof(ContactNtf), ContactNtf.Parser, new string[1] { "Contact" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ContactCharacterMessageNtf), ContactCharacterMessageNtf.Parser, new string[5] { "SessionId", "NewMessages", "SessionFinish", "UpdateTimeStamp", "NewMessagesInt64" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ContactCharacterSessionNtf), ContactCharacterSessionNtf.Parser, new string[2] { "Sessions", "GmMode" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ContactChooseOptionReq), ContactChooseOptionReq.Parser, new string[2] { "SessionId", "ChooseIdx" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ContactChooseOptionAck), ContactChooseOptionAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ContactChatWithPlayerReq), ContactChatWithPlayerReq.Parser, new string[1] { "Message" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ContactChatWithPlayerAck), ContactChatWithPlayerAck.Parser, new string[1] { "Code" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ContactPlayerMessageNtf), ContactPlayerMessageNtf.Parser, new string[1] { "Message" }, null, null, null, null)
		}));
	}
}
