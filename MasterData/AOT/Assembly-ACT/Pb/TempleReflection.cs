using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class TempleReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static TempleReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgx0ZW1wbGUucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iIwoPVGVtcGxlVW5s" + "b2NrUmVxEhAKCHRlbXBsZUlkGAEgASgFIjEKD1RlbXBsZVVubG9ja0FjaxIe" + "Cgp0ZW1wbGVJbmZvGAEgASgLMgoucGIuVGVtcGxlIkMKElRlbXBsZUNoYWxs" + "ZW5nZVJlcRIQCgh0ZW1wbGVJZBgBIAEoBRIbCgR0ZWFtGAIgASgLMg0ucGIu" + "VGVhbVVzYWdlInsKElRlbXBsZUNoYWxsZW5nZUFjaxIPCgd0cmFuc05vGAEg" + "ASgJEjQKE2NoYXJhY3RlclJlcG9zaXRvcnkYAiABKAsyFy5wYi5DaGFyYWN0" + "ZXJSZXBvc2l0b3J5Eh4KCnRlbXBsZUluZm8YAyABKAsyCi5wYi5UZW1wbGUi" + "PwoUVGVtcGxlUmVjaGFsbGVuZ2VSZXESJwoKc2V0dGxlSW5mbxgBIAEoCzIT" + "LnBiLlN0YWdlU2V0dGxlSW5mbyJ9ChRUZW1wbGVSZWNoYWxsZW5nZUFjaxIP" + "Cgd0cmFuc05vGAEgASgJEjQKE2NoYXJhY3RlclJlcG9zaXRvcnkYAiABKAsy" + "Fy5wYi5DaGFyYWN0ZXJSZXBvc2l0b3J5Eh4KCnRlbXBsZUluZm8YAyABKAsy" + "Ci5wYi5UZW1wbGUiOQoOVGVtcGxlTGVhdmVSZXESJwoKc2V0dGxlSW5mbxgB" + "IAEoCzITLnBiLlN0YWdlU2V0dGxlSW5mbyIQCg5UZW1wbGVMZWF2ZUFjayJB" + "ChZUZW1wbGVDb21wbGV0ZVN0YWdlUmVxEicKCnNldHRsZUluZm8YASABKAsy" + "Ey5wYi5TdGFnZVNldHRsZUluZm8idwoWVGVtcGxlQ29tcGxldGVTdGFnZUFj" + "axIZCgdyZXdhcmRzGAEgAygLMggucGIuSXRlbRIbCgduZXdJbmZvGAIgASgL" + "MgoucGIuVGVtcGxlEiUKCmdvdFJld2FyZHMYAyADKAsyES5wYi5Vbml2ZXJz" + "YWxJdGVtIjsKEFRlbXBsZUZhaWx1cmVSZXESJwoKc2V0dGxlSW5mbxgBIAEo" + "CzITLnBiLlN0YWdlU2V0dGxlSW5mbyIyChBUZW1wbGVGYWlsdXJlQWNrEh4K" + "CnRlbXBsZUluZm8YASABKAsyCi5wYi5UZW1wbGUiNQoTVGVtcGxlU2VsZWN0" + "QnVmZlJlcRIOCgZyb29tSWQYASABKAUSDgoGYnVmZklkGAIgASgFIhUKE1Rl" + "bXBsZVNlbGVjdEJ1ZmZBY2siOgoXVGVtcGxlVGFrZVN0YXJSZXdhcmRSZXES" + "DgoGYXJlYUlkGAEgASgFEg8KB3N0YXJOdW0YAiABKAUiXAoXVGVtcGxlVGFr" + "ZVN0YXJSZXdhcmRBY2sSGQoHcmV3YXJkcxgBIAMoCzIILnBiLkl0ZW0SJgoO" + "dGVtcGxlQXJlYUluZm8YAiABKAsyDi5wYi5UZW1wbGVBcmVhIi0KDVRlbXBs" + "ZUluZm9OdGYSHAoEaW5mbxgBIAEoCzIOLnBiLlRlbXBsZUluZm9iBnByb3Rv" + "Mw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[17]
		{
			new GeneratedClrTypeInfo(typeof(TempleUnlockReq), TempleUnlockReq.Parser, new string[1] { "TempleId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleUnlockAck), TempleUnlockAck.Parser, new string[1] { "TempleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleChallengeReq), TempleChallengeReq.Parser, new string[2] { "TempleId", "Team" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleChallengeAck), TempleChallengeAck.Parser, new string[3] { "TransNo", "CharacterRepository", "TempleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleRechallengeReq), TempleRechallengeReq.Parser, new string[1] { "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleRechallengeAck), TempleRechallengeAck.Parser, new string[3] { "TransNo", "CharacterRepository", "TempleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleLeaveReq), TempleLeaveReq.Parser, new string[1] { "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleLeaveAck), TempleLeaveAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleCompleteStageReq), TempleCompleteStageReq.Parser, new string[1] { "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleCompleteStageAck), TempleCompleteStageAck.Parser, new string[3] { "Rewards", "NewInfo", "GotRewards" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleFailureReq), TempleFailureReq.Parser, new string[1] { "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleFailureAck), TempleFailureAck.Parser, new string[1] { "TempleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleSelectBuffReq), TempleSelectBuffReq.Parser, new string[2] { "RoomId", "BuffId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleSelectBuffAck), TempleSelectBuffAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleTakeStarRewardReq), TempleTakeStarRewardReq.Parser, new string[2] { "AreaId", "StarNum" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleTakeStarRewardAck), TempleTakeStarRewardAck.Parser, new string[2] { "Rewards", "TempleAreaInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TempleInfoNtf), TempleInfoNtf.Parser, new string[1] { "Info" }, null, null, null, null)
		}));
	}
}
