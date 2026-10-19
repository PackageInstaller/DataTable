using System;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public static class DbuserReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static DbuserReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgxkYnVzZXIucHJvdG8SAnBiGgxjb21tb24ucHJvdG8i9QkKBkRCVXNlchIK" + "CgJpZBgBIAEoAxIRCglhY2NvdW50SWQYAiABKAMSEwoLc2VydmVySW5kZXgY" + "AyABKAUSDgoGb3BlbklkGAQgASgJEg4KBnNka0FpZBgFIAEoBRISCgpjcmVh" + "dGVUaW1lGAYgASgDEhYKDmxhc3RVcGRhdGVUaW1lGAcgASgDEhEKCWVudGVy" + "VGltZRgIIAEoAxITCgtvZmZsaW5lVGltZRgJIAEoAxINCgVsZXZlbBgKIAEo" + "BRILCgNleHAYCyABKAUSEgoKd29ybGRMZXZlbBgMIAEoBRIQCghuaWNrTmFt" + "ZRgNIAEoCRIMCgRjb2luGA4gASgDEg0KBXBvd2VyGA8gASgFEhMKC2ZyZWVE" + "aWFtb25kGBAgASgDEhMKC2Nvc3REaWFtb25kGBEgASgDEg4KBmdlbmRlchgS" + "IAEoDRIuChB0b29rTGV2ZWxSZXdhcmRzGBMgASgLMhQucGIuVG9va0xldmVs" + "UmV3YXJkcxIoCg1vcGVuZWRTeXN0ZW1zGBQgASgLMhEucGIuT3BlbmVkU3lz" + "dGVtcxIYCgVpdGVtcxgVIAEoCzIJLnBiLkl0ZW1zEiIKCmF0dHJpYnV0ZXMY" + "FiABKAsyDi5wYi5BdHRyaWJ1dGVzEiIKCmNoYXJhY3RlcnMYFyABKAsyDi5w" + "Yi5DaGFyYWN0ZXJzEhwKB3dlYXBvbnMYGCABKAsyCy5wYi5XZWFwb25zEhgK" + "BWNoaXBzGBkgASgLMgkucGIuQ2hpcHMSHwoJaGFuZGJvb2tzGBogASgLMgwu" + "cGIuSGFuZGJvb2sSHgoIbWlzc2lvbnMYGyABKAsyDC5wYi5NaXNzaW9ucxIc" + "Cgdhc3Npc3RzGBwgASgLMgsucGIuQXNzaXN0cxIaCgZzY2VuZXMYHSABKAsy" + "Ci5wYi5TY2VuZXMSIgoHcHJvZmlsZRgeIAEoCzIRLnBiLlBsYXllclByb2Zp" + "bGUSGgoGZXF1aXBzGB8gASgLMgoucGIuRXF1aXBzEhYKBGdlbXMYICABKAsy" + "CC5wYi5HZW1zEioKC2NvbXBvc2VEYXRhGCEgASgLMhUucGIuUGxheWVyQ29t" + "cG9zZURhdGESHwoHbWFwSW5mbxgiIAEoCzIOLnBiLk1hcERiTW9kZWwSJQoK" + "bG91bmdlSW5mbxgjIAEoCzIRLnBiLkxvdW5nZURiTW9kZWwSKQoKYmF0dGxl" + "UGFzcxgkIAEoCzIVLnBiLkJhdHRsZVBhc3NEYk1vZGVsEi0KDnZvY2FidWxh" + "cnlJbmZvGCUgASgLMhUucGIuVm9jYWJ1bGFyeURiTW9kZWwSKAoOdGRfY2xp" + "ZW50X2RhdGEYJiABKAsyEC5wYi5URENsaWVudERhdGESKgoOdGltZUxpbWl0" + "SXRlbXMYJyABKAsyEi5wYi5UaW1lTGltaXRJdGVtcxIbCgVza2lucxgoIAMo" + "CzIMLnBiLlNraW5JbmZvEiQKC2RpYW1vbmREYXRhGCkgASgLMg8ucGIuRGlh" + "bW9uZERhdGESIgoKYnVuZGxlRGF0YRgqIAEoCzIOLnBiLkJ1bmRsZURhdGES" + "LAoObW9udGhseV9wYXNzZXMYKyADKAsyFC5wYi5Nb250aGx5UGFzc0VudHJ5" + "EioKDWVmZmVjdERyZXNzZXMYLCADKAsyEy5wYi5FZmZlY3REcmVzc0luZm9C" + "EKoCDUFDVC5HYW1lLkRhdGFiBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[1]
		{
			new GeneratedClrTypeInfo(typeof(DBUser), DBUser.Parser, new string[44]
			{
				"Id", "AccountId", "ServerIndex", "OpenId", "SdkAid", "CreateTime", "LastUpdateTime", "EnterTime", "OfflineTime", "Level",
				"Exp", "WorldLevel", "NickName", "Coin", "Power", "FreeDiamond", "CostDiamond", "Gender", "TookLevelRewards", "OpenedSystems",
				"Items", "Attributes", "Characters", "Weapons", "Chips", "Handbooks", "Missions", "Assists", "Scenes", "Profile",
				"Equips", "Gems", "ComposeData", "MapInfo", "LoungeInfo", "BattlePass", "VocabularyInfo", "TdClientData", "TimeLimitItems", "Skins",
				"DiamondData", "BundleData", "MonthlyPasses", "EffectDresses"
			}, null, null, null, null)
		}));
	}
}
