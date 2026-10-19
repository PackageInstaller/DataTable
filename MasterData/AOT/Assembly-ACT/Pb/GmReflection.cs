using System;
using Google.Protobuf.Reflection;

namespace Pb;

public static class GmReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static GmReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CghnbS5wcm90bxICcGIiIQoSR21BY3Rpb25Qcm9jZXNzUmVxEgsKA2NtZBgB" + "IAEoCSIkChJHbUFjdGlvblByb2Nlc3NBY2sSDgoGcmVzdWx0GAEgASgJIi0K" + "BkdtQ2hhdBIKCgJ0cxgBIAEoBRILCgNtc2cYAiABKAkSCgoCZ20YAyABKAgi" + "DAoKR21DaGF0c1JlcSInCgpHbUNoYXRzQWNrEhkKBWNoYXRzGAEgAygLMgou" + "cGIuR21DaGF0IhgKCUdtQ2hhdFJlcRILCgNtc2cYASABKAkiCwoJR21DaGF0" + "QWNrIiUKCUdtQ2hhdE50ZhIYCgRjaGF0GAEgASgLMgoucGIuR21DaGF0YgZw" + "cm90bzM="), new FileDescriptor[0], new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[8]
		{
			new GeneratedClrTypeInfo(typeof(GmActionProcessReq), GmActionProcessReq.Parser, new string[1] { "Cmd" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GmActionProcessAck), GmActionProcessAck.Parser, new string[1] { "Result" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GmChat), GmChat.Parser, new string[3] { "Ts", "Msg", "Gm" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GmChatsReq), GmChatsReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GmChatsAck), GmChatsAck.Parser, new string[1] { "Chats" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GmChatReq), GmChatReq.Parser, new string[1] { "Msg" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GmChatAck), GmChatAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GmChatNtf), GmChatNtf.Parser, new string[1] { "Chat" }, null, null, null, null)
		}));
	}
}
