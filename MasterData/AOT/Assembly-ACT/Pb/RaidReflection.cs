using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class RaidReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static RaidReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgpyYWlkLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIlMKDFJhaWRFbnRlclJl" + "cRIKCgJpZBgBIAEoBRIbCgR0ZWFtGAIgASgLMg0ucGIuVGVhbVVzYWdlEgwK" + "BHJhdGUYAyABKAUSDAoEYnlHTRgEIAEoCCJxCgxSYWlkRW50ZXJBY2sSDwoH" + "dHJhbnNObxgBIAEoCRI0ChNjaGFyYWN0ZXJSZXBvc2l0b3J5GAIgASgLMhcu" + "cGIuQ2hhcmFjdGVyUmVwb3NpdG9yeRIaCghyYWlkSW5mbxgDIAEoCzIILnBi" + "LlJhaWQiPQoSUmFpZFJlY2hhbGxlbmdlUmVxEicKCnNldHRsZUluZm8YASAB" + "KAsyEy5wYi5TdGFnZVNldHRsZUluZm8idwoSUmFpZFJlY2hhbGxlbmdlQWNr" + "Eg8KB3RyYW5zTm8YASABKAkSNAoTY2hhcmFjdGVyUmVwb3NpdG9yeRgCIAEo" + "CzIXLnBiLkNoYXJhY3RlclJlcG9zaXRvcnkSGgoIcmFpZEluZm8YAyABKAsy" + "CC5wYi5SYWlkIhMKEVJhaWRQbGF5ZXJEZWFkUmVxIi8KEVJhaWRQbGF5ZXJE" + "ZWFkQWNrEhoKCHJhaWRJbmZvGAEgASgLMggucGIuUmFpZCJRChJSYWlkVGFr" + "ZVJld2FyZHNSZXESEgoKcmV3YXJkUmF0ZRgBIAEoBRInCgpzZXR0bGVJbmZv" + "GAIgASgLMhMucGIuU3RhZ2VTZXR0bGVJbmZvIm4KElJhaWRUYWtlUmV3YXJk" + "c0FjaxIXCgVpdGVtcxgBIAMoCzIILnBiLkl0ZW0SIwoIZ290SXRlbXMYAiAD" + "KAsyES5wYi5Vbml2ZXJzYWxJdGVtEhoKCHJhaWRJbmZvGAMgASgLMggucGIu" + "UmFpZCInCgxSYWlkU3dlZXBSZXESCgoCaWQYASABKAUSCwoDbnVtGAIgASgF" + "ImgKDFJhaWRTd2VlcEFjaxIXCgVpdGVtcxgBIAMoCzIILnBiLkl0ZW0SGgoI" + "cmFpZEluZm8YAiABKAsyCC5wYi5SYWlkEiMKCGdvdEl0ZW1zGAMgAygLMhEu" + "cGIuVW5pdmVyc2FsSXRlbSI3CgxSYWlkTGVhdmVSZXESJwoKc2V0dGxlSW5m" + "bxgBIAEoCzITLnBiLlN0YWdlU2V0dGxlSW5mbyIqCgxSYWlkTGVhdmVBY2sS" + "GgoIcmFpZEluZm8YASABKAsyCC5wYi5SYWlkIjkKDlJhaWRGYWlsdXJlUmVx" + "EicKCnNldHRsZUluZm8YASABKAsyEy5wYi5TdGFnZVNldHRsZUluZm8iLAoO" + "UmFpZEZhaWx1cmVBY2sSGgoIcmFpZEluZm8YASABKAsyCC5wYi5SYWlkIoMB" + "CgdSYWlkTnRmEiUKBXJhaWRzGAEgAygLMhYucGIuUmFpZE50Zi5SYWlkc0Vu" + "dHJ5EhkKEWNoYWxsZW5naW5nUmFpZElkGAIgASgFGjYKClJhaWRzRW50cnkS" + "CwoDa2V5GAEgASgFEhcKBXZhbHVlGAIgASgLMggucGIuUmFpZDoCOAFiBnBy" + "b3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[15]
		{
			new GeneratedClrTypeInfo(typeof(RaidEnterReq), RaidEnterReq.Parser, new string[4] { "Id", "Team", "Rate", "ByGM" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidEnterAck), RaidEnterAck.Parser, new string[3] { "TransNo", "CharacterRepository", "RaidInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidRechallengeReq), RaidRechallengeReq.Parser, new string[1] { "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidRechallengeAck), RaidRechallengeAck.Parser, new string[3] { "TransNo", "CharacterRepository", "RaidInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidPlayerDeadReq), RaidPlayerDeadReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidPlayerDeadAck), RaidPlayerDeadAck.Parser, new string[1] { "RaidInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidTakeRewardsReq), RaidTakeRewardsReq.Parser, new string[2] { "RewardRate", "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidTakeRewardsAck), RaidTakeRewardsAck.Parser, new string[3] { "Items", "GotItems", "RaidInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidSweepReq), RaidSweepReq.Parser, new string[2] { "Id", "Num" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidSweepAck), RaidSweepAck.Parser, new string[3] { "Items", "RaidInfo", "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidLeaveReq), RaidLeaveReq.Parser, new string[1] { "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidLeaveAck), RaidLeaveAck.Parser, new string[1] { "RaidInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidFailureReq), RaidFailureReq.Parser, new string[1] { "SettleInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidFailureAck), RaidFailureAck.Parser, new string[1] { "RaidInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RaidNtf), RaidNtf.Parser, new string[2] { "Raids", "ChallengingRaidId" }, null, null, null, new GeneratedClrTypeInfo[1])
		}));
	}
}
