using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class CharacterReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static CharacterReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg9jaGFyYWN0ZXIucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iUAoMQ2hhcmFj" + "dGVyTnRmEh4KB2NoYW5nZXMYASADKAsyDS5wYi5DaGFyYWN0ZXISIAoJY2hh" + "bmdlV2F5GAIgASgOMg0ucGIuSXRlbXNXYXlzIrICChJDaGFyYWN0ZXJDaGFu" + "Z2VOdGYSEQoJc2NlbmVFbnVtGAEgASgFEjoKCmNoYXJhY3RlcnMYAiADKAsy" + "Ji5wYi5DaGFyYWN0ZXJDaGFuZ2VOdGYuQ2hhcmFjdGVyc0VudHJ5EkQKD2V4" + "dHJhQ2hhcmFjdGVycxgDIAMoCzIrLnBiLkNoYXJhY3RlckNoYW5nZU50Zi5F" + "eHRyYUNoYXJhY3RlcnNFbnRyeRpACg9DaGFyYWN0ZXJzRW50cnkSCwoDa2V5" + "GAEgASgFEhwKBXZhbHVlGAIgASgLMg0ucGIuQ2hhcmFjdGVyOgI4ARpFChRF" + "eHRyYUNoYXJhY3RlcnNFbnRyeRILCgNrZXkYASABKAUSHAoFdmFsdWUYAiAB" + "KAsyDS5wYi5DaGFyYWN0ZXI6AjgBIr4BChhDaGFyYWN0ZXJEZXBlbmRDaGFu" + "Z2VOdGYSEQoJc2NlbmVFbnVtGAEgASgFEjwKF2NoYXJhY3RlckRlcGVuZFNu" + "YXBzaG90GAIgASgLMhsucGIuQ2hhcmFjdGVyRGVwZW5kU25hcHNob3QSQQoc" + "ZXh0cmFDaGFyYWN0ZXJEZXBlbmRTbmFwc2hvdBgDIAEoCzIbLnBiLkNoYXJh" + "Y3RlckRlcGVuZFNuYXBzaG90Eg4KBnJlbW92ZRgEIAEoCCI7ChNDaGFyYWN0" + "ZXJMZXZlbFVwUmVxEgoKAmlkGAEgASgFEhgKBnNwZW5kcxgCIAMoCzIILnBi" + "Lkl0ZW0iMAoTQ2hhcmFjdGVyTGV2ZWxVcEFjaxIZCgdjaGFuZ2VzGAEgAygL" + "MggucGIuSXRlbSIwChFDaGFyYWN0ZXJTdGFnZVJlcRIKCgJpZBgBIAEoBRIP" + "Cgd0b1N0YWdlGAIgASgFIi4KEUNoYXJhY3RlclN0YWdlQWNrEhkKB2NoYW5n" + "ZXMYASADKAsyCC5wYi5JdGVtIjgKG0NoYXJhY3RlclRha2VTdGFnZVJld2Fy" + "ZFJlcRIKCgJpZBgBIAEoBRINCgVzdGFnZRgCIAEoBSI2ChtDaGFyYWN0ZXJU" + "YWtlU3RhZ2VSZXdhcmRBY2sSFwoFaXRlbXMYASADKAsyCC5wYi5JdGVtIqMB" + "ChZDaGFyYWN0ZXJTdGF0dXNTeW5jUmVxEi4KAmNzGAEgAygLMiIucGIuQ2hh" + "cmFjdGVyU3RhdHVzU3luY1JlcS5Dc0VudHJ5EhkKEWJhdHRsZUNoYXJhY3Rl" + "cklkGAIgASgFGj4KB0NzRW50cnkSCwoDa2V5GAEgASgFEiIKBXZhbHVlGAIg" + "ASgLMhMucGIuQ2hhcmFjdGVyU3RhdHVzOgI4ASIYChZDaGFyYWN0ZXJTdGF0" + "dXNTeW5jQWNrIkoKHUNoYXJhY3RlclVwZ3JhZGVTa2lsbEdyb3VwUmVxEhMK" + "C2NoYXJhY3RlcklkGAEgASgFEhQKDHNraWxsR3JvdXBJZBgCIAEoBSJECh1D" + "aGFyYWN0ZXJVcGdyYWRlU2tpbGxHcm91cEFjaxIjCghnb3RJdGVtcxgBIAMo" + "CzIRLnBiLlVuaXZlcnNhbEl0ZW0iUAogQ2hhcmFjdGVyVXBncmFkZUNvbnN0" + "ZWxsYXRpb25SZXESEwoLY2hhcmFjdGVySWQYASABKAUSFwoPY29uc3RlbGxh" + "dGlvbklkGAIgASgFIiIKIENoYXJhY3RlclVwZ3JhZGVDb25zdGVsbGF0aW9u" + "QWNrIk8KH0NoYXJhY3RlclJldHVybkNvbnN0ZWxsYXRpb25SZXESEwoLY2hh" + "cmFjdGVySWQYASABKAUSFwoPY29uc3RlbGxhdGlvbklkGAIgASgFIiEKH0No" + "YXJhY3RlclJldHVybkNvbnN0ZWxsYXRpb25BY2siUAofQ2hhcmFjdGVyVXBk" + "YXRlQ29uc3RlbGxhdGlvblJlcRITCgtjaGFyYWN0ZXJJZBgBIAEoBRIYChBj" + "b25zdGVsbGF0aW9uSWRzGAIgAygFIjsKH0NoYXJhY3RlclVwZGF0ZUNvbnN0" + "ZWxsYXRpb25BY2sSGAoQY29uc3RlbGxhdGlvbk51bRgBIAEoBSJRChhDaGFy" + "YWN0ZXJFbGl0ZUxldmVsVXBSZXESEwoLY2hhcmFjdGVySWQYASABKAUSDwoH" + "cG9pbnRJZBgCIAEoBRIPCgd0b0xldmVsGAMgASgFIhoKGENoYXJhY3RlckVs" + "aXRlTGV2ZWxVcEFjayJRChZDaGFyYWN0ZXJFbGl0ZVJlc2V0UmVxEhMKC2No" + "YXJhY3RlcklkGAEgASgFEg8KB3BvaW50SWQYAiABKAUSEQoJcG9pbnROb2Rl" + "GAMgASgFIhgKFkNoYXJhY3RlckVsaXRlUmVzZXRBY2tiBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[23]
		{
			new GeneratedClrTypeInfo(typeof(CharacterNtf), CharacterNtf.Parser, new string[2] { "Changes", "ChangeWay" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterChangeNtf), CharacterChangeNtf.Parser, new string[3] { "SceneEnum", "Characters", "ExtraCharacters" }, null, null, null, new GeneratedClrTypeInfo[2]),
			new GeneratedClrTypeInfo(typeof(CharacterDependChangeNtf), CharacterDependChangeNtf.Parser, new string[4] { "SceneEnum", "CharacterDependSnapshot", "ExtraCharacterDependSnapshot", "Remove" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterLevelUpReq), CharacterLevelUpReq.Parser, new string[2] { "Id", "Spends" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterLevelUpAck), CharacterLevelUpAck.Parser, new string[1] { "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterStageReq), CharacterStageReq.Parser, new string[2] { "Id", "ToStage" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterStageAck), CharacterStageAck.Parser, new string[1] { "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterTakeStageRewardReq), CharacterTakeStageRewardReq.Parser, new string[2] { "Id", "Stage" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterTakeStageRewardAck), CharacterTakeStageRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterStatusSyncReq), CharacterStatusSyncReq.Parser, new string[2] { "Cs", "BattleCharacterId" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(CharacterStatusSyncAck), CharacterStatusSyncAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterUpgradeSkillGroupReq), CharacterUpgradeSkillGroupReq.Parser, new string[2] { "CharacterId", "SkillGroupId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterUpgradeSkillGroupAck), CharacterUpgradeSkillGroupAck.Parser, new string[1] { "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterUpgradeConstellationReq), CharacterUpgradeConstellationReq.Parser, new string[2] { "CharacterId", "ConstellationId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterUpgradeConstellationAck), CharacterUpgradeConstellationAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterReturnConstellationReq), CharacterReturnConstellationReq.Parser, new string[2] { "CharacterId", "ConstellationId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterReturnConstellationAck), CharacterReturnConstellationAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterUpdateConstellationReq), CharacterUpdateConstellationReq.Parser, new string[2] { "CharacterId", "ConstellationIds" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterUpdateConstellationAck), CharacterUpdateConstellationAck.Parser, new string[1] { "ConstellationNum" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterEliteLevelUpReq), CharacterEliteLevelUpReq.Parser, new string[3] { "CharacterId", "PointId", "ToLevel" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterEliteLevelUpAck), CharacterEliteLevelUpAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterEliteResetReq), CharacterEliteResetReq.Parser, new string[3] { "CharacterId", "PointId", "PointNode" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharacterEliteResetAck), CharacterEliteResetAck.Parser, null, null, null, null, null)
		}));
	}
}
