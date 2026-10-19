using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class AbyssReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static AbyssReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgthYnlzcy5wcm90bxICcGIaDGNvbW1vbi5wcm90byJvChZBYnlzc0NoYWxs" + "ZW5nZVN0YWdlUmVxEhgKEHNlbGVjdGVkU3RhZ2VJZHgYASABKAUSDwoHYWJ5" + "c3NJZBgCIAEoBRIcCgV0ZWFtcxgDIAMoCzINLnBiLlRlYW1Vc2FnZRIMCgRi" + "eUdNGAQgASgIIo0BChZBYnlzc0NoYWxsZW5nZVN0YWdlQWNrEg4KBmVyck1z" + "ZxgBIAEoCRIPCgd0cmFuc05vGAIgASgJEjQKE2NoYXJhY3RlclJlcG9zaXRv" + "cnkYAyABKAsyFy5wYi5DaGFyYWN0ZXJSZXBvc2l0b3J5EhwKCWFieXNzRGF0" + "YRgEIAEoCzIJLnBiLkFieXNzIlcKGEFieXNzQ29tcGxldGVTdWJTdGFnZVJl" + "cRISCgp1c2VTZWNvbmRzGAEgASgFEicKCnNldHRsZUluZm8YAiABKAsyEy5w" + "Yi5TdGFnZVNldHRsZUluZm8ikAIKGEFieXNzQ29tcGxldGVTdWJTdGFnZUFj" + "axIOCgZlcnJNc2cYASABKAkSFAoMY29tcGxldGVkQWxsGAIgASgIEioKEmNv" + "bXBsZXRlZFN0YWdlSW5mbxgDIAEoCzIOLnBiLkFieXNzU3RhZ2USFgoOdW5s" + "b2NrTmV3U3RhZ2UYBCABKAgSDwoHdHJhbnNObxgGIAEoCRIcCglhYnlzc0Rh" + "dGEYByABKAsyCS5wYi5BYnlzcxInCgxzdGFnZVJld2FyZHMYCCADKAsyES5w" + "Yi5Vbml2ZXJzYWxJdGVtEiwKEXF1aWNrU3RhZ2VSZXdhcmRzGAkgAygLMhEu" + "cGIuVW5pdmVyc2FsSXRlbUoECAUQBiJdChJBYnlzc1Rha2VSZXdhcmRSZXES" + "EgoKdGFyZ2V0U3RhchgBIAEoBRIPCgdhYnlzc0lkGAIgASgFEhAKCHN0YWdl" + "SWR4GAMgASgFEhAKCGNsYWltQWxsGAQgASgIIlQKEkFieXNzVGFrZVJld2Fy" + "ZEFjaxIgCgVpdGVtcxgBIAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0SHAoJYWJ5" + "c3NEYXRhGAIgASgLMgkucGIuQWJ5c3MiWAoTQWJ5c3NSZWNoYWxsZW5nZVJl" + "cRIYChBvbmx5Q3VycmVudExheWVyGAEgASgIEicKCnNldHRsZUluZm8YAiAB" + "KAsyEy5wYi5TdGFnZVNldHRsZUluZm8iegoTQWJ5c3NSZWNoYWxsZW5nZUFj" + "axIPCgd0cmFuc05vGAEgASgJEjQKE2NoYXJhY3RlclJlcG9zaXRvcnkYAiAB" + "KAsyFy5wYi5DaGFyYWN0ZXJSZXBvc2l0b3J5EhwKCWFieXNzRGF0YRgDIAEo" + "CzIJLnBiLkFieXNzIkUKDUFieXNzTGVhdmVSZXESCwoDdG1wGAEgASgIEicK" + "CnNldHRsZUluZm8YAiABKAsyEy5wYi5TdGFnZVNldHRsZUluZm8iLQoNQWJ5" + "c3NMZWF2ZUFjaxIcCglhYnlzc0RhdGEYASABKAsyCS5wYi5BYnlzcyISChBB" + "Ynlzc0NvbWViYWNrUmVxImYKEEFieXNzQ29tZWJhY2tBY2sSHAoJYWJ5c3NE" + "YXRhGAEgASgLMgkucGIuQWJ5c3MSNAoTY2hhcmFjdGVyUmVwb3NpdG9yeRgC" + "IAEoCzIXLnBiLkNoYXJhY3RlclJlcG9zaXRvcnkiOgoPQWJ5c3NGYWlsdXJl" + "UmVxEicKCnNldHRsZUluZm8YASABKAsyEy5wYi5TdGFnZVNldHRsZUluZm8i" + "LwoPQWJ5c3NGYWlsdXJlQWNrEhwKCWFieXNzRGF0YRgBIAEoCzIJLnBiLkFi" + "eXNzIqkBCghBYnlzc050ZhIYCgVhYnlzcxgBIAEoCzIJLnBiLkFieXNzEioK" + "B2FieXNzZXMYAiADKAsyGS5wYi5BYnlzc050Zi5BYnlzc2VzRW50cnkSHAoU" + "bGFzdENoYWxsZW5nZUFieXNzSUQYAyABKAUaOQoMQWJ5c3Nlc0VudHJ5EgsK" + "A2tleRgBIAEoBRIYCgV2YWx1ZRgCIAEoCzIJLnBiLkFieXNzOgI4AWIGcHJv" + "dG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[15]
		{
			new GeneratedClrTypeInfo(typeof(AbyssChallengeStageReq), AbyssChallengeStageReq.Parser, new string[4] { "SelectedStageIdx", "AbyssId", "Teams", "ByGM" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssChallengeStageAck), AbyssChallengeStageAck.Parser, new string[4] { "ErrMsg", "TransNo", "CharacterRepository", "AbyssData" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssCompleteSubStageReq), AbyssCompleteSubStageReq.Parser, new string[2] { "UseSeconds", "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssCompleteSubStageAck), AbyssCompleteSubStageAck.Parser, new string[8] { "ErrMsg", "CompletedAll", "CompletedStageInfo", "UnlockNewStage", "TransNo", "AbyssData", "StageRewards", "QuickStageRewards" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssTakeRewardReq), AbyssTakeRewardReq.Parser, new string[4] { "TargetStar", "AbyssId", "StageIdx", "ClaimAll" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssTakeRewardAck), AbyssTakeRewardAck.Parser, new string[2] { "Items", "AbyssData" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssRechallengeReq), AbyssRechallengeReq.Parser, new string[2] { "OnlyCurrentLayer", "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssRechallengeAck), AbyssRechallengeAck.Parser, new string[3] { "TransNo", "CharacterRepository", "AbyssData" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssLeaveReq), AbyssLeaveReq.Parser, new string[2] { "Tmp", "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssLeaveAck), AbyssLeaveAck.Parser, new string[1] { "AbyssData" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssComebackReq), AbyssComebackReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssComebackAck), AbyssComebackAck.Parser, new string[2] { "AbyssData", "CharacterRepository" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssFailureReq), AbyssFailureReq.Parser, new string[1] { "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssFailureAck), AbyssFailureAck.Parser, new string[1] { "AbyssData" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AbyssNtf), AbyssNtf.Parser, new string[3] { "Abyss", "Abysses", "LastChallengeAbyssID" }, null, null, null, new GeneratedClrTypeInfo[1])
		}));
	}
}
