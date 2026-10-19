using System;
using Google.Protobuf.Reflection;

namespace Pb;

public static class MatchReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static MatchReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgttYXRjaC5wcm90bxICcGIiRAoNRW50ZXJNYXRjaFJlcRIOCgZvcGVuSWQY" + "ASABKAkSEAoIbG9naW5LZXkYAiABKAkSEQoJYWNjb3VudElkGAMgASgDIhwK" + "DUVudGVyTWF0Y2hBY2sSCwoDcmV0GAEgASgIIg8KDU1hdGNoTXNnU3RhcnQi" + "DQoLTWF0Y2hNc2dFbmQiKQoWTWF0Y2hGb3J3YXJkTWVzc2FnZVJlcRIPCgdw" + "YXlsb2FkGAEgASgMIhgKFk1hdGNoRm9yd2FyZE1lc3NhZ2VBY2siKQoWTWF0" + "Y2hGb3J3YXJkTWVzc2FnZU50ZhIPCgdwYXlsb2FkGAEgASgMYgZwcm90bzM="), new FileDescriptor[0], new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[7]
		{
			new GeneratedClrTypeInfo(typeof(EnterMatchReq), EnterMatchReq.Parser, new string[3] { "OpenId", "LoginKey", "AccountId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EnterMatchAck), EnterMatchAck.Parser, new string[1] { "Ret" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MatchMsgStart), MatchMsgStart.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MatchMsgEnd), MatchMsgEnd.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MatchForwardMessageReq), MatchForwardMessageReq.Parser, new string[1] { "Payload" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MatchForwardMessageAck), MatchForwardMessageAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MatchForwardMessageNtf), MatchForwardMessageNtf.Parser, new string[1] { "Payload" }, null, null, null, null)
		}));
	}
}
