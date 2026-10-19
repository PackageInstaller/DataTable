using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class ActivityReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static ActivityReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg5hY3Rpdml0eS5wcm90bxICcGIaDGNvbW1vbi5wcm90byIUChJBY3Rpdml0" + "eVJlZnJlc2hSZXEiFAoSQWN0aXZpdHlSZWZyZXNoQWNrIlQKFkFjdGl2aXR5" + "TGV2ZWxSZXdhcmROdGYSOgoWYWN0aXZpdExldmVsUmV3YXJkSW5mbxgBIAEo" + "CzIaLnBiLkFjdGl2aXRMZXZlbFJld2FyZEluZm8iYQoZQWN0aXZpdHlHZXRM" + "ZXZlbFJld2FyZFJlcRISCgphY3Rpdml0eUlkGAEgASgFEhUKDWFjdGl2aXR5" + "R3JvdXAYAiABKAUSGQoRYWN0aXZpdHlDaGFsbGVuZ2UYAyABKAUiQAoZQWN0" + "aXZpdHlHZXRMZXZlbFJld2FyZEFjaxIjCghnb3RJdGVtcxgBIAMoCzIRLnBi" + "LlVuaXZlcnNhbEl0ZW0iWgoYQWN0aXZpdHlEb3VibGVEdW5nZW9uTnRmEj4K" + "GGFjdGl2aXREb3VibGVEdW5nZW9uSW5mbxgBIAEoCzIcLnBiLkFjdGl2aXRE" + "b3VibGVEdW5nZW9uSW5mbyJGCh5BY3Rpdml0eURvdWJsZUR1bmdlb25SZXdh" + "cmRSZXESEgoKYWN0aXZpdHlJZBgBIAEoBRIQCghyZXdhcmRJZBgCIAEoBSIg" + "Ch5BY3Rpdml0eURvdWJsZUR1bmdlb25SZXdhcmRBY2siRQoRQWN0aXZpdHlT" + "aWduSW5OdGYSMAoRYWN0aXZpdFNpZ25JbkluZm8YASABKAsyFS5wYi5BY3Rp" + "dml0U2lnbkluSW5mbyJqCh1BY3Rpdml0eVNpZ25JbkNob29zZVJld2FyZFJl" + "cRISCgphY3Rpdml0eUlkGAEgASgFEg8KB2dyb3VwSWQYAiABKAUSEwoLY2hh" + "bGxlbmdlSWQYAyABKAUSDwoHcmV3YXJkcxgEIAMoBSIfCh1BY3Rpdml0eVNp" + "Z25JbkNob29zZVJld2FyZEFjayJTChdBY3Rpdml0eVNpZ25JblJld2FyZFJl" + "cRISCgphY3Rpdml0eUlkGAEgASgFEg8KB2dyb3VwSWQYAiABKAUSEwoLY2hh" + "bGxlbmdlSWQYAyABKAUiVwoXQWN0aXZpdHlTaWduSW5SZXdhcmRBY2sSFwoF" + "aXRlbXMYASADKAsyCC5wYi5JdGVtEiMKCGdvdEl0ZW1zGAIgAygLMhEucGIu" + "VW5pdmVyc2FsSXRlbSJCChBBY3Rpdml0eUFieXNzTnRmEi4KEGFjdGl2aXRB" + "Ynlzc0luZm8YASABKAsyFC5wYi5BY3Rpdml0QWJ5c3NJbmZvIl4KFkFjdGl2" + "aXR5QWJ5c3NSZXdhcmRSZXESEgoKYWN0aXZpdHlJZBgBIAEoBRIVCg1hY3Rp" + "dml0eUdyb3VwGAIgASgFEhkKEWFjdGl2aXR5Q2hhbGxlbmdlGAMgASgFIjEK" + "FkFjdGl2aXR5QWJ5c3NSZXdhcmRBY2sSFwoFaXRlbXMYASADKAsyCC5wYi5J" + "dGVtIlQKFkFjdGl2aXR5Q29tYmluYXRpb25OdGYSOgoWYWN0aXZpdENvbWJp" + "bmF0aW9uSW5mbxgBIAEoCzIaLnBiLkFjdGl2aXRDb21iaW5hdGlvbkluZm8i" + "SQocQWN0aXZpdHlDb21iaW5hdGlvblJld2FyZFJlcRISCgphY3Rpdml0eUlk" + "GAEgASgFEhUKDWFjdGl2aXR5R3JvdXAYAiABKAUiNwocQWN0aXZpdHlDb21i" + "aW5hdGlvblJld2FyZEFjaxIXCgVpdGVtcxgBIAMoCzIILnBiLkl0ZW0iYAoa" + "QWN0aXZpdHlUZW1wbGVDaGFsbGVuZ2VOdGYSQgoaYWN0aXZpdFRlbXBsZUNo" + "YWxsZW5nZUluZm8YASABKAsyHi5wYi5BY3Rpdml0VGVtcGxlQ2hhbGxlbmdl" + "SW5mbyJOChRBY3Rpdml0eVJvbGVUcmlhbE50ZhI2ChRhY3Rpdml0Um9sZVRy" + "aWFsSW5mbxgBIAEoCzIYLnBiLkFjdGl2aXRSb2xlVHJpYWxJbmZvImIKGkFj" + "dGl2aXR5Um9sZVRyaWFsUmV3YXJkUmVxEhIKCmFjdGl2aXR5SWQYASABKAUS" + "FQoNYWN0aXZpdHlHcm91cBgCIAEoBRIZChFhY3Rpdml0eUNoYWxsZW5nZRgD" + "IAEoBSI+ChpBY3Rpdml0eVJvbGVUcmlhbFJld2FyZEFjaxIgCgVpdGVtcxgB" + "IAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0iTgoUQWN0aXZpdHlTa2luVHJpYWxO" + "dGYSNgoUYWN0aXZpdFNraW5UcmlhbEluZm8YASABKAsyGC5wYi5BY3Rpdml0" + "U2tpblRyaWFsSW5mbyJiChpBY3Rpdml0eVNraW5UcmlhbFJld2FyZFJlcRIS" + "CgphY3Rpdml0eUlkGAEgASgFEhUKDWFjdGl2aXR5R3JvdXAYAiABKAUSGQoR" + "YWN0aXZpdHlDaGFsbGVuZ2UYAyABKAUiPgoaQWN0aXZpdHlTa2luVHJpYWxS" + "ZXdhcmRBY2sSIAoFaXRlbXMYASADKAsyES5wYi5Vbml2ZXJzYWxJdGVtIlkK" + "F0FjdGl2aXR5RGFpbHlMb3R0ZXJ5TnRmEj4KGGFjdGl2aXR5RGFpbHlMb3R0" + "ZXJ5SW5mbxgBIAEoCzIcLnBiLkFjdGl2aXR5RGFpbHlMb3R0ZXJ5SW5mbyJd" + "ChxBY3Rpdml0eURhaWx5TG90dGVyeUdhY2hhUmVxEhIKCmFjdGl2aXR5SWQY" + "ASABKAUSFQoNbG90dGVyeVBvb2xJZBgCIAEoBRISCgpnYWNoYUNvbnV0GAMg" + "ASgFIkAKHEFjdGl2aXR5RGFpbHlMb3R0ZXJ5R2FjaGFBY2sSIAoFaXRlbXMY" + "ASADKAsyES5wYi5Vbml2ZXJzYWxJdGVtIlwKGEFjdGl2aXR5VG90YWxSZWNo" + "YXJnZU50ZhJAChlhY3Rpdml0eVRvdGFsUmVjaGFyZ2VJbmZvGAEgASgLMh0u" + "cGIuQWN0aXZpdHlUb3RhbFJlY2hhcmdlSW5mbyJmCh5BY3Rpdml0eVRvdGFs" + "UmVjaGFyZ2VSZXdhcmRSZXESEgoKYWN0aXZpdHlJZBgBIAEoBRIVCg1hY3Rp" + "dml0eUdyb3VwGAIgASgFEhkKEWFjdGl2aXR5Q2hhbGxlbmdlGAMgASgFIkIK" + "HkFjdGl2aXR5VG90YWxSZWNoYXJnZVJld2FyZEFjaxIgCgVpdGVtcxgBIAMo" + "CzIRLnBiLlVuaXZlcnNhbEl0ZW0iQQoPQWN0aXZpdHlLdWppTnRmEi4KEGFj" + "dGl2aXR5S3VqaUluZm8YASABKAsyFC5wYi5BY3Rpdml0eUt1amlJbmZvIkIK" + "FUFjdGl2aXR5S3VqaVJld2FyZFJlcRISCgphY3Rpdml0eUlkGAEgASgFEhUK" + "DWFjdGl2aXR5R3JvdXAYAiABKAUiOQoVQWN0aXZpdHlLdWppUmV3YXJkQWNr" + "EiAKBWl0ZW1zGAEgAygLMhEucGIuVW5pdmVyc2FsSXRlbSIpChNBY3Rpdml0" + "eUt1amlEcmF3UmVxEhIKCmFjdGl2aXR5SWQYASABKAUiNwoTQWN0aXZpdHlL" + "dWppRHJhd0FjaxIgCgVpdGVtcxgBIAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0i" + "UAoUQWN0aXZpdHlNYWluU3RvcnlOdGYSOAoVYWN0aXZpdHlNYWluU3RvcnlJ" + "bmZvGAEgASgLMhkucGIuQWN0aXZpdHlNYWluU3RvcnlJbmZvIkcKGkFjdGl2" + "aXR5TWFpblN0b3J5UmV3YXJkUmVxEhIKCmFjdGl2aXR5SWQYASABKAUSFQoN" + "YWN0aXZpdHlHcm91cBgCIAEoBSI+ChpBY3Rpdml0eU1haW5TdG9yeVJld2Fy" + "ZEFjaxIgCgVpdGVtcxgBIAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0iUwoVQWN0" + "aXZpdHlNYXBFeHBsb3JlTnRmEjoKFmFjdGl2aXR5TWFwRXhwbG9yZUluZm8Y" + "ASABKAsyGi5wYi5BY3Rpdml0eU1hcEV4cGxvcmVJbmZvIkgKG0FjdGl2aXR5" + "TWFwRXhwbG9yZVJld2FyZFJlcRISCgphY3Rpdml0eUlkGAEgASgFEhUKDWFj" + "dGl2aXR5R3JvdXAYAiABKAUiPwobQWN0aXZpdHlNYXBFeHBsb3JlUmV3YXJk" + "QWNrEiAKBWl0ZW1zGAEgAygLMhEucGIuVW5pdmVyc2FsSXRlbSJWChZBY3Rp" + "dml0eU11bHRpRGV2aWNlTnRmEjwKF2FjdGl2aXR5TXVsdGlEZXZpY2VJbmZv" + "GAEgASgLMhsucGIuQWN0aXZpdHlNdWx0aURldmljZUluZm8iZAocQWN0aXZp" + "dHlNdWx0aURldmljZVJld2FyZFJlcRISCgphY3Rpdml0eUlkGAEgASgFEhUK" + "DWFjdGl2aXR5R3JvdXAYAiABKAUSGQoRYWN0aXZpdHlDaGFsbGVuZ2UYAyAB" + "KAUiQAocQWN0aXZpdHlNdWx0aURldmljZVJld2FyZEFjaxIgCgVpdGVtcxgB" + "IAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW1iBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[46]
		{
			new GeneratedClrTypeInfo(typeof(ActivityRefreshReq), ActivityRefreshReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityRefreshAck), ActivityRefreshAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityLevelRewardNtf), ActivityLevelRewardNtf.Parser, new string[1] { "ActivitLevelRewardInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityGetLevelRewardReq), ActivityGetLevelRewardReq.Parser, new string[3] { "ActivityId", "ActivityGroup", "ActivityChallenge" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityGetLevelRewardAck), ActivityGetLevelRewardAck.Parser, new string[1] { "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityDoubleDungeonNtf), ActivityDoubleDungeonNtf.Parser, new string[1] { "ActivitDoubleDungeonInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityDoubleDungeonRewardReq), ActivityDoubleDungeonRewardReq.Parser, new string[2] { "ActivityId", "RewardId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityDoubleDungeonRewardAck), ActivityDoubleDungeonRewardAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivitySignInNtf), ActivitySignInNtf.Parser, new string[1] { "ActivitSignInInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivitySignInChooseRewardReq), ActivitySignInChooseRewardReq.Parser, new string[4] { "ActivityId", "GroupId", "ChallengeId", "Rewards" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivitySignInChooseRewardAck), ActivitySignInChooseRewardAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivitySignInRewardReq), ActivitySignInRewardReq.Parser, new string[3] { "ActivityId", "GroupId", "ChallengeId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivitySignInRewardAck), ActivitySignInRewardAck.Parser, new string[2] { "Items", "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityAbyssNtf), ActivityAbyssNtf.Parser, new string[1] { "ActivitAbyssInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityAbyssRewardReq), ActivityAbyssRewardReq.Parser, new string[3] { "ActivityId", "ActivityGroup", "ActivityChallenge" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityAbyssRewardAck), ActivityAbyssRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityCombinationNtf), ActivityCombinationNtf.Parser, new string[1] { "ActivitCombinationInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityCombinationRewardReq), ActivityCombinationRewardReq.Parser, new string[2] { "ActivityId", "ActivityGroup" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityCombinationRewardAck), ActivityCombinationRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityTempleChallengeNtf), ActivityTempleChallengeNtf.Parser, new string[1] { "ActivitTempleChallengeInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityRoleTrialNtf), ActivityRoleTrialNtf.Parser, new string[1] { "ActivitRoleTrialInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityRoleTrialRewardReq), ActivityRoleTrialRewardReq.Parser, new string[3] { "ActivityId", "ActivityGroup", "ActivityChallenge" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityRoleTrialRewardAck), ActivityRoleTrialRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivitySkinTrialNtf), ActivitySkinTrialNtf.Parser, new string[1] { "ActivitSkinTrialInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivitySkinTrialRewardReq), ActivitySkinTrialRewardReq.Parser, new string[3] { "ActivityId", "ActivityGroup", "ActivityChallenge" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivitySkinTrialRewardAck), ActivitySkinTrialRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityDailyLotteryNtf), ActivityDailyLotteryNtf.Parser, new string[1] { "ActivityDailyLotteryInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityDailyLotteryGachaReq), ActivityDailyLotteryGachaReq.Parser, new string[3] { "ActivityId", "LotteryPoolId", "GachaConut" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityDailyLotteryGachaAck), ActivityDailyLotteryGachaAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityTotalRechargeNtf), ActivityTotalRechargeNtf.Parser, new string[1] { "ActivityTotalRechargeInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityTotalRechargeRewardReq), ActivityTotalRechargeRewardReq.Parser, new string[3] { "ActivityId", "ActivityGroup", "ActivityChallenge" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityTotalRechargeRewardAck), ActivityTotalRechargeRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityKujiNtf), ActivityKujiNtf.Parser, new string[1] { "ActivityKujiInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityKujiRewardReq), ActivityKujiRewardReq.Parser, new string[2] { "ActivityId", "ActivityGroup" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityKujiRewardAck), ActivityKujiRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityKujiDrawReq), ActivityKujiDrawReq.Parser, new string[1] { "ActivityId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityKujiDrawAck), ActivityKujiDrawAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMainStoryNtf), ActivityMainStoryNtf.Parser, new string[1] { "ActivityMainStoryInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMainStoryRewardReq), ActivityMainStoryRewardReq.Parser, new string[2] { "ActivityId", "ActivityGroup" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMainStoryRewardAck), ActivityMainStoryRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMapExploreNtf), ActivityMapExploreNtf.Parser, new string[1] { "ActivityMapExploreInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMapExploreRewardReq), ActivityMapExploreRewardReq.Parser, new string[2] { "ActivityId", "ActivityGroup" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMapExploreRewardAck), ActivityMapExploreRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMultiDeviceNtf), ActivityMultiDeviceNtf.Parser, new string[1] { "ActivityMultiDeviceInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMultiDeviceRewardReq), ActivityMultiDeviceRewardReq.Parser, new string[3] { "ActivityId", "ActivityGroup", "ActivityChallenge" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ActivityMultiDeviceRewardAck), ActivityMultiDeviceRewardAck.Parser, new string[1] { "Items" }, null, null, null, null)
		}));
	}
}
