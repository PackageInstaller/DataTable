using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class RogueReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static RogueReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgtyb2d1ZS5wcm90bxICcGIaDGNvbW1vbi5wcm90byIwCgxSb2d1ZUluZm9O" + "dGYSIAoJUm9ndWVJbmZvGAEgASgLMg0ucGIuUm9ndWVJbmZvIi4KHFJvZ3Vl" + "VW5sb2NrVGFsZW50VHJlZUNvZGVSZXESDgoGY29yZUlkGAEgASgFIh4KHFJv" + "Z3VlVW5sb2NrVGFsZW50VHJlZUNvZGVBY2siLgocUm9ndWVVcGRhdGVUYWxl" + "bnRUcmVlTm9kZVJlcRIOCgZub2RlSWQYASABKAUiHgocUm9ndWVVcGRhdGVU" + "YWxlbnRUcmVlTm9kZUFjayJpChFSb2d1ZUNoYWxsZW5nZVJlcRIOCgZtb2Rl" + "SWQYASABKAUSDgoGY29yZUlkGAIgASgFEiYKD2JhdHRsZUNoYXJhY3RlchgD" + "IAEoCzINLnBiLlRlYW1Vc2FnZRIMCgRzZWVkGAQgASgDIjgKEVJvZ3VlQ2hh" + "bGxlbmdlQWNrEiMKCGdhbWVJbmZvGAEgASgLMhEucGIuUm9ndWVHYW1lSW5m" + "byL4AwoVUm9ndWVFbnRlck5leHRSb29tUmVxEiMKCHJvb21UeXBlGAEgASgO" + "MhEucGIuUm9ndWVSb29tVHlwZRIxCgRpdGVtGAIgAygLMiMucGIuUm9ndWVF" + "bnRlck5leHRSb29tUmVxLkl0ZW1FbnRyeRI3CgdsZWZ0VXNlGAMgAygLMiYu" + "cGIuUm9ndWVFbnRlck5leHRSb29tUmVxLkxlZnRVc2VFbnRyeRI9CgpiYXR0" + "bGVJbmZvGAQgAygLMikucGIuUm9ndWVFbnRlck5leHRSb29tUmVxLkJhdHRs" + "ZUluZm9FbnRyeRI9CgplZmZlY3RJbmZvGAUgAygLMikucGIuUm9ndWVFbnRl" + "ck5leHRSb29tUmVxLkVmZmVjdEluZm9FbnRyeRo6CglJdGVtRW50cnkSCwoD" + "a2V5GAEgASgFEhwKBXZhbHVlGAIgASgLMg0ucGIuUm9ndWVJdGVtOgI4ARou" + "CgxMZWZ0VXNlRW50cnkSCwoDa2V5GAEgASgFEg0KBXZhbHVlGAIgASgFOgI4" + "ARoxCg9CYXR0bGVJbmZvRW50cnkSCwoDa2V5GAEgASgFEg0KBXZhbHVlGAIg" + "ASgFOgI4ARoxCg9FZmZlY3RJbmZvRW50cnkSCwoDa2V5GAEgASgFEg0KBXZh" + "bHVlGAIgASgFOgI4ASJKChVSb2d1ZUVudGVyTmV4dFJvb21BY2sSDAoEY29p" + "bhgBIAEoBRIjCghyb29tSW5mbxgCIAEoCzIRLnBiLlJvZ3VlUm9vbUluZm8i" + "XAoPUm9ndWVCdXlJdGVtUmVxEg0KBWlzQnV5GAEgASgIEg4KBml0ZW1JZBgC" + "IAEoBRIRCglpc1JlcGxhY2UYAyABKAgSFwoPcmVwbGFjZVBvc2l0aW9uGAQg" + "ASgFIhEKD1JvZ3VlQnV5SXRlbUFjayIlChNSb2d1ZVJlY3ljbGVJdGVtUmVx" + "Eg4KBml0ZW1JZBgBIAEoBSIVChNSb2d1ZVJlY3ljbGVJdGVtQWNrIhIKEFJv" + "Z3VlSGFuZ0dhbWVSZXEiEgoQUm9ndWVIYW5nR2FtZUFjayIWChRSb2d1ZUNv" + "bnRpbnVlR2FtZVJlcSLfAQoUUm9ndWVDb250aW51ZUdhbWVBY2sSMAoPYmF0" + "dGxlQ2hhcmFjdGVyGAEgASgLMhcucGIuQ2hhcmFjdGVyUmVwb3NpdG9yeRIb" + "Cglyb3VnZVRlYW0YAiABKAsyCC5wYi5UZWFtEjgKCGJhZ0l0ZW1zGAMgAygL" + "MiYucGIuUm9ndWVDb250aW51ZUdhbWVBY2suQmFnSXRlbXNFbnRyeRo+Cg1C" + "YWdJdGVtc0VudHJ5EgsKA2tleRgBIAEoBRIcCgV2YWx1ZRgCIAEoCzINLnBi" + "LlJvZ3VlSXRlbToCOAEiPQoSUm9ndWVGaW5pc2hHYW1lUmVxEicKCmZpbmlz" + "aFR5cGUYASABKA4yEy5wYi5Sb2d1ZUZpbmlzaFR5cGUicwoSUm9ndWVGaW5p" + "c2hHYW1lQWNrEhcKD3RhbGVudFRyZWVQb2ludBgBIAEoBRIXCgVpdGVtcxgC" + "IAMoCzIILnBiLkl0ZW0SEwoLY2xlYXJlZE1vZGUYAyADKAUSFgoOd2Vla2x5" + "Q29pbkdhaW4YBCABKAUiFAoSUm9ndWVDb2luUmV3YXJkUmVxIhQKElJvZ3Vl" + "Q29pblJld2FyZEFjayJACgxSb2d1ZUNvaW5OdGYSDAoEY29pbhgBIAEoBRIQ" + "CghnYWluQ29pbhgCIAEoBRIQCghjb3N0Q29pbhgDIAEoBSIxChJSb2d1ZVRl" + "YW1DaGFuZ2VSZXESGwoEdGVhbRgBIAEoCzINLnBiLlRlYW1Vc2FnZSJAChJS" + "b2d1ZVRlYW1DaGFuZ2VBY2sSKgoJcm9ndWVUZWFtGAEgASgLMhcucGIuQ2hh" + "cmFjdGVyUmVwb3NpdG9yeSJQChJSb2d1ZVBpY2tVcEl0ZW1SZXESDgoGaXRl" + "bUlkGAEgASgFEhEKCWlzUmVwbGFjZRgCIAEoCBIXCg9yZXBsYWNlUG9zaXRp" + "b24YAyABKAUiFAoSUm9ndWVQaWNrVXBJdGVtQWNrIjQKElJvZ3VlTW9kaWZ5" + "Q29pblJlcRINCgVpc0FkZBgBIAEoCBIPCgdjb2luTnVtGAIgASgFIhQKElJv" + "Z3VlTW9kaWZ5Q29pbkFjayIZChdSb2d1ZVNldFJvb21GaW5pc2hlZFJlcSIZ" + "ChdSb2d1ZVNldFJvb21GaW5pc2hlZEFjayI9ChJSb2d1ZVRhbGVudFRyZWVO" + "dGYSJwoKdGFsZW50VHJlZRgBIAEoCzITLnBiLlJvZ3VlVGFsZW50VHJlZSIo" + "ChFSb2d1ZUVudGVyUm9vbVJlcRITCgtnYW1lV29ybGRJZBgBIAEoBSI4ChFS" + "b2d1ZUVudGVyUm9vbUFjaxIjCghnYW1lSW5mbxgBIAEoCzIRLnBiLlJvZ3Vl" + "R2FtZUluZm8iOQoSUm9ndWVHbU5leHRSb29tUmVxEiMKCHJvb21UeXBlGAEg" + "ASgOMhEucGIuUm9ndWVSb29tVHlwZSI5ChJSb2d1ZUdtTmV4dFJvb21BY2sS" + "IwoIcm9vbUluZm8YAiABKAsyES5wYi5Sb2d1ZVJvb21JbmZvIiMKEVJvZ3Vl" + "R21BZGRJdGVtUmVxEg4KBml0ZW1JZBgBIAEoBSITChFSb2d1ZUdtQWRkSXRl" + "bUFja2IGcHJvdG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[37]
		{
			new GeneratedClrTypeInfo(typeof(RogueInfoNtf), RogueInfoNtf.Parser, new string[1] { "RogueInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueUnlockTalentTreeCodeReq), RogueUnlockTalentTreeCodeReq.Parser, new string[1] { "CoreId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueUnlockTalentTreeCodeAck), RogueUnlockTalentTreeCodeAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueUpdateTalentTreeNodeReq), RogueUpdateTalentTreeNodeReq.Parser, new string[1] { "NodeId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueUpdateTalentTreeNodeAck), RogueUpdateTalentTreeNodeAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueChallengeReq), RogueChallengeReq.Parser, new string[4] { "ModeId", "CoreId", "BattleCharacter", "Seed" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueChallengeAck), RogueChallengeAck.Parser, new string[1] { "GameInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueEnterNextRoomReq), RogueEnterNextRoomReq.Parser, new string[5] { "RoomType", "Item", "LeftUse", "BattleInfo", "EffectInfo" }, null, null, null, new GeneratedClrTypeInfo[4]),
			new GeneratedClrTypeInfo(typeof(RogueEnterNextRoomAck), RogueEnterNextRoomAck.Parser, new string[2] { "Coin", "RoomInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueBuyItemReq), RogueBuyItemReq.Parser, new string[4] { "IsBuy", "ItemId", "IsReplace", "ReplacePosition" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueBuyItemAck), RogueBuyItemAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueRecycleItemReq), RogueRecycleItemReq.Parser, new string[1] { "ItemId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueRecycleItemAck), RogueRecycleItemAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueHangGameReq), RogueHangGameReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueHangGameAck), RogueHangGameAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueContinueGameReq), RogueContinueGameReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueContinueGameAck), RogueContinueGameAck.Parser, new string[3] { "BattleCharacter", "RougeTeam", "BagItems" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(RogueFinishGameReq), RogueFinishGameReq.Parser, new string[1] { "FinishType" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueFinishGameAck), RogueFinishGameAck.Parser, new string[4] { "TalentTreePoint", "Items", "ClearedMode", "WeeklyCoinGain" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueCoinRewardReq), RogueCoinRewardReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueCoinRewardAck), RogueCoinRewardAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueCoinNtf), RogueCoinNtf.Parser, new string[3] { "Coin", "GainCoin", "CostCoin" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueTeamChangeReq), RogueTeamChangeReq.Parser, new string[1] { "Team" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueTeamChangeAck), RogueTeamChangeAck.Parser, new string[1] { "RogueTeam" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoguePickUpItemReq), RoguePickUpItemReq.Parser, new string[3] { "ItemId", "IsReplace", "ReplacePosition" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoguePickUpItemAck), RoguePickUpItemAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueModifyCoinReq), RogueModifyCoinReq.Parser, new string[2] { "IsAdd", "CoinNum" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueModifyCoinAck), RogueModifyCoinAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueSetRoomFinishedReq), RogueSetRoomFinishedReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueSetRoomFinishedAck), RogueSetRoomFinishedAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueTalentTreeNtf), RogueTalentTreeNtf.Parser, new string[1] { "TalentTree" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueEnterRoomReq), RogueEnterRoomReq.Parser, new string[1] { "GameWorldId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueEnterRoomAck), RogueEnterRoomAck.Parser, new string[1] { "GameInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueGmNextRoomReq), RogueGmNextRoomReq.Parser, new string[1] { "RoomType" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueGmNextRoomAck), RogueGmNextRoomAck.Parser, new string[1] { "RoomInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueGmAddItemReq), RogueGmAddItemReq.Parser, new string[1] { "ItemId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RogueGmAddItemAck), RogueGmAddItemAck.Parser, null, null, null, null, null)
		}));
	}
}
