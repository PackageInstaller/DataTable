using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class HandbookReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static HandbookReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg5oYW5kYm9vay5wcm90bxICcGIaDGNvbW1vbi5wcm90byI2Cg9IYW5kYm9v" + "a0luZm9OdGYSIwoJaGFuZGJvb2tzGAEgAygLMhAucGIuSGFuZGJvb2tJbmZv" + "Ii0KC0hhbmRib29rTnRmEh4KCGhhbmRib29rGAEgASgLMgwucGIuSGFuZGJv" + "b2siWwoRSGFuZGJvb2tVcGRhdGVSZXESFgoOdW5sb2NrTW9uc3RlcnMYASAD" + "KAUSFgoOa2lsbGVkTW9uc3RlcnMYAiADKAUSFgoOdW5sb2NrV2lsZEJvc3MY" + "AyADKAUimQEKEUhhbmRib29rVXBkYXRlQWNrEkkKEm1vbnN0ZXJLaWxsZWRD" + "b3VudBgBIAMoCzItLnBiLkhhbmRib29rVXBkYXRlQWNrLk1vbnN0ZXJLaWxs" + "ZWRDb3VudEVudHJ5GjkKF01vbnN0ZXJLaWxsZWRDb3VudEVudHJ5EgsKA2tl" + "eRgBIAEoBRINCgV2YWx1ZRgCIAEoBToCOAEiMwoiSGFuZGJvb2tEYWlseU1p" + "c3Npb25DbGFpbVJld2FyZFJlcRINCgVyb3dJZBgBIAEoBSJ2CiJIYW5kYm9v" + "a0RhaWx5TWlzc2lvbkNsYWltUmV3YXJkQWNrEiAKBWl0ZW1zGAEgAygLMhEu" + "cGIuVW5pdmVyc2FsSXRlbRIuCgxyZXdhcmRTdGF0dXMYAiABKAsyGC5wYi5I" + "YW5kYm9va1Jld2FyZFN0YXR1cyI5CiNIYW5kYm9va0RhaWx5QWN0aXZlUHRD" + "bGFpbVJld2FyZFJlcRISCgpwdFJld2FyZElkGAEgASgFIncKI0hhbmRib29r" + "RGFpbHlBY3RpdmVQdENsYWltUmV3YXJkQWNrEiAKBWl0ZW1zGAEgAygLMhEu" + "cGIuVW5pdmVyc2FsSXRlbRIuCgxyZXdhcmRTdGF0dXMYAiABKAsyGC5wYi5I" + "YW5kYm9va1Jld2FyZFN0YXR1cyJJCihIYW5kYm9va0dyb3d0aEd1aWRlTWlz" + "c2lvbkNsYWltUmV3YXJkUmVxEgoKAmlkGAEgASgFEhEKCWNoYXB0ZXJJRBgC" + "IAEoBSJ4CihIYW5kYm9va0dyb3d0aEd1aWRlTWlzc2lvbkNsYWltUmV3YXJk" + "QWNrEiAKBWl0ZW1zGAEgAygLMhEucGIuVW5pdmVyc2FsSXRlbRIqCgtncm93" + "dGhHdWlkZRgCIAEoCzIVLnBiLlBsYXllckdyb3d0aEd1aWRlIjYKKEhhbmRi" + "b29rR3Jvd3RoR3VpZGVDaGFwdGVyQ2xhaW1SZXdhcmRSZXESCgoCaWQYASAB" + "KAUieAooSGFuZGJvb2tHcm93dGhHdWlkZUNoYXB0ZXJDbGFpbVJld2FyZEFj" + "axIgCgVpdGVtcxgBIAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0SKgoLZ3Jvd3Ro" + "R3VpZGUYAiABKAsyFS5wYi5QbGF5ZXJHcm93dGhHdWlkZWIGcHJvdG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[12]
		{
			new GeneratedClrTypeInfo(typeof(HandbookInfoNtf), HandbookInfoNtf.Parser, new string[1] { "Handbooks" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookNtf), HandbookNtf.Parser, new string[1] { "Handbook" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookUpdateReq), HandbookUpdateReq.Parser, new string[3] { "UnlockMonsters", "KilledMonsters", "UnlockWildBoss" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookUpdateAck), HandbookUpdateAck.Parser, new string[1] { "MonsterKilledCount" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(HandbookDailyMissionClaimRewardReq), HandbookDailyMissionClaimRewardReq.Parser, new string[1] { "RowId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookDailyMissionClaimRewardAck), HandbookDailyMissionClaimRewardAck.Parser, new string[2] { "Items", "RewardStatus" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookDailyActivePtClaimRewardReq), HandbookDailyActivePtClaimRewardReq.Parser, new string[1] { "PtRewardId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookDailyActivePtClaimRewardAck), HandbookDailyActivePtClaimRewardAck.Parser, new string[2] { "Items", "RewardStatus" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookGrowthGuideMissionClaimRewardReq), HandbookGrowthGuideMissionClaimRewardReq.Parser, new string[2] { "Id", "ChapterID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookGrowthGuideMissionClaimRewardAck), HandbookGrowthGuideMissionClaimRewardAck.Parser, new string[2] { "Items", "GrowthGuide" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookGrowthGuideChapterClaimRewardReq), HandbookGrowthGuideChapterClaimRewardReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(HandbookGrowthGuideChapterClaimRewardAck), HandbookGrowthGuideChapterClaimRewardAck.Parser, new string[2] { "Items", "GrowthGuide" }, null, null, null, null)
		}));
	}
}
