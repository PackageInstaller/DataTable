using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class ChipReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static ChipReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgpjaGlwLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIloKB0NoaXBOdGYSGQoH" + "Y2hhbmdlcxgBIAMoCzIILnBiLkNoaXASEgoKcmVtb3ZlVWlkcxgCIAMoBRIg" + "CgljaGFuZ2VXYXkYAyABKA4yDS5wYi5JdGVtc1dheXMiOgoQQ2hpcFdlYXJQ" + "b3NpdGlvbhILCgN1aWQYASABKAUSDAoEc2xvdBgCIAEoBRILCgNpZHgYAyAB" + "KAUiRwoLQ2hpcFdlYXJSZXESEwoLY2hhcmFjdGVySWQYASABKAUSIwoFY2hp" + "cHMYAiADKAsyFC5wYi5DaGlwV2VhclBvc2l0aW9uIg0KC0NoaXBXZWFyQWNr" + "IjUKDUNoaXBVbmxvYWRSZXESEwoLY2hhcmFjdGVySWQYASABKAUSDwoHY2hp" + "cFVpZBgCIAEoBSIPCg1DaGlwVW5sb2FkQWNrIigKC0NoaXBMb2NrUmVxEgsK" + "A3VpZBgBIAEoBRIMCgRsb2NrGAIgASgIIg0KC0NoaXBMb2NrQWNrIh0KDkNo" + "aXBMZXZlbFVwUmVxEgsKA3VpZBgBIAEoBSIrCg5DaGlwTGV2ZWxVcEFjaxIZ" + "CgdjaGFuZ2VzGAEgAygLMggucGIuSXRlbSIgChBDaGlwRGVjb21wb3NlUmVx" + "EgwKBHVpZHMYASADKAUiKwoQQ2hpcERlY29tcG9zZUFjaxIXCgVpdGVtcxgB" + "IAMoCzIILnBiLkl0ZW0iJAoUQ2hpcENhbmNlbE5ld0ZsYWdSZXESDAoEdWlk" + "cxgBIAMoBSIWChRDaGlwQ2FuY2VsTmV3RmxhZ0Fja2IGcHJvdG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[14]
		{
			new GeneratedClrTypeInfo(typeof(ChipNtf), ChipNtf.Parser, new string[3] { "Changes", "RemoveUids", "ChangeWay" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipWearPosition), ChipWearPosition.Parser, new string[3] { "Uid", "Slot", "Idx" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipWearReq), ChipWearReq.Parser, new string[2] { "CharacterId", "Chips" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipWearAck), ChipWearAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipUnloadReq), ChipUnloadReq.Parser, new string[2] { "CharacterId", "ChipUid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipUnloadAck), ChipUnloadAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipLockReq), ChipLockReq.Parser, new string[2] { "Uid", "Lock" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipLockAck), ChipLockAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipLevelUpReq), ChipLevelUpReq.Parser, new string[1] { "Uid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipLevelUpAck), ChipLevelUpAck.Parser, new string[1] { "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipDecomposeReq), ChipDecomposeReq.Parser, new string[1] { "Uids" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipDecomposeAck), ChipDecomposeAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipCancelNewFlagReq), ChipCancelNewFlagReq.Parser, new string[1] { "Uids" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChipCancelNewFlagAck), ChipCancelNewFlagAck.Parser, null, null, null, null, null)
		}));
	}
}
