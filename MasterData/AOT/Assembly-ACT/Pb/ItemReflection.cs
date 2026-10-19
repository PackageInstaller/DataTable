using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class ItemReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static ItemReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgppdGVtLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIkYKB0l0ZW1OdGYSGQoH" + "Y2hhbmdlcxgBIAMoCzIILnBiLkl0ZW0SIAoJY2hhbmdlV2F5GAIgASgOMg0u" + "cGIuSXRlbXNXYXlzIjYKEEl0ZW1BZmZlY3RPYmplY3QSEgoKb2JqZWN0VHlw" + "ZRgBIAEoBRIOCgZvYmpJRHMYAiADKAUiVwoLVXNlSXRlbXNSZXESHwoEaXRl" + "bRgBIAEoCzIRLnBiLk9wZXJhdGlvbkl0ZW0SJwoJYWZmZWN0T2JqGAIgASgL" + "MhQucGIuSXRlbUFmZmVjdE9iamVjdCKGAQoLVXNlSXRlbXNBY2sSCgoCb2sY" + "ASABKAgSJwoJYWZmZWN0T2JqGAIgASgLMhQucGIuSXRlbUFmZmVjdE9iamVj" + "dBIdCgtvYnRhaW5JdGVtcxgDIAMoCzIILnBiLkl0ZW0SIwoIZ290SXRlbXMY" + "BCADKAsyES5wYi5Vbml2ZXJzYWxJdGVtIkEKC0RlbEl0ZW1zUmVxEhAKCGl0" + "ZW1UeXBlGAEgASgFEiAKBWl0ZW1zGAIgAygLMhEucGIuT3BlcmF0aW9uSXRl" + "bSIZCgtEZWxJdGVtc0FjaxIKCgJvaxgBIAEoCCIuCg5Db21wb3NlSXRlbVJl" + "cRIcCgp0YXJnZXRJdGVtGAEgASgLMggucGIuSXRlbSIQCg5Db21wb3NlSXRl" + "bUFjayI2Cg5MaXR0bGVJdGVtc050ZhIkCgtsaXR0bGVJdGVtcxgBIAEoCzIP" + "LnBiLkxpdHRsZUl0ZW1zIh4KEFVzZUxpdHRsZUl0ZW1SZXESCgoCaWQYASAB" + "KAUiEgoQVXNlTGl0dGxlSXRlbUFjayIOCgxQb3Rpb25Vc2VSZXEiIQoMUG90" + "aW9uVXNlQWNrEhEKCXVzZWRDb3VudBgBIAEoBSIvChBQb3Rpb25MZXZlbFVw" + "UmVxEgoKAmlkGAEgASgFEg8KB3RvTGV2ZWwYAiABKAUiEgoQUG90aW9uTGV2" + "ZWxVcEFjayI+ChdQb3Rpb25VcGRhdGVBZGRpdGl2ZVJlcRIQCghwb3Rpb25J" + "ZBgBIAEoBRIRCglhZGRpdGl2ZXMYAiADKAUiGQoXUG90aW9uVXBkYXRlQWRk" + "aXRpdmVBY2siKQoYUG90aW9uUmVjb3ZlclVzZUNvdW50UmVxEg0KBWNvdW50" + "GAEgASgFIi0KGFBvdGlvblJlY292ZXJVc2VDb3VudEFjaxIRCgl1c2VkQ291" + "bnQYASABKAUiMwoNUG90aW9uSW5mb050ZhIiCgpwb3Rpb25JbmZvGAEgASgL" + "Mg4ucGIuUG90aW9uSW5mbyIsCglQb3Rpb25OdGYSHwoHcG90aW9ucxgBIAMo" + "CzIOLnBiLlBvdGlvbkl0ZW0ipwEKD1BvdGlvbkNoYW5nZU50ZhIRCglzY2Vu" + "ZUVudW0YASABKAUSMQoHcG90aW9ucxgCIAMoCzIgLnBiLlBvdGlvbkNoYW5n" + "ZU50Zi5Qb3Rpb25zRW50cnkSDgoGcmVtb3ZlGAMgASgIGj4KDFBvdGlvbnNF" + "bnRyeRILCgNrZXkYASABKAUSHQoFdmFsdWUYAiABKAsyDi5wYi5Qb3Rpb25J" + "dGVtOgI4ASI/ChJTeW5jTGl0dGxlSXRlbXNSZXESKQoEaW5mbxgBIAEoCzIb" + "LnBiLkxpdHRsZUl0ZW1zU2hvcnRjdXRJbmZvIhQKElN5bmNMaXR0bGVJdGVt" + "c0FjayI5Cg9UcmVhc3VyZUluZm9OdGYSJgoMdHJlYXN1cmVJbmZvGAEgASgL" + "MhAucGIuVHJlYXN1cmVJbmZvIjMKD1JlY3ljbGVJdGVtc1JlcRIgCgVpdGVt" + "cxgBIAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0iMwoPUmVjeWNsZUl0ZW1zQWNr" + "EiAKBWl0ZW1zGAEgAygLMhEucGIuVW5pdmVyc2FsSXRlbSJFCg9PcGVuQmFn" + "Q2hlc3RSZXESDgoGaXRlbUlkGAEgASgFEg0KBWNvdW50GAIgASgFEhMKC2No" + "b29zZUluZGV4GAMgASgFIjMKD09wZW5CYWdDaGVzdEFjaxIgCgVpdGVtcxgB" + "IAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0iSgocQmFnQ2hlc3RSZXdhcmRTZWxl" + "Y3RDb3VudE50ZhIqCgRkYXRhGAEgASgLMhwucGIuQmFnQ2hlc3RSZXdhcmRT" + "ZWxlY3REYXRhYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[30]
		{
			new GeneratedClrTypeInfo(typeof(ItemNtf), ItemNtf.Parser, new string[2] { "Changes", "ChangeWay" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ItemAffectObject), ItemAffectObject.Parser, new string[2] { "ObjectType", "ObjIDs" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UseItemsReq), UseItemsReq.Parser, new string[2] { "Item", "AffectObj" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UseItemsAck), UseItemsAck.Parser, new string[4] { "Ok", "AffectObj", "ObtainItems", "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DelItemsReq), DelItemsReq.Parser, new string[2] { "ItemType", "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DelItemsAck), DelItemsAck.Parser, new string[1] { "Ok" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ComposeItemReq), ComposeItemReq.Parser, new string[1] { "TargetItem" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ComposeItemAck), ComposeItemAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LittleItemsNtf), LittleItemsNtf.Parser, new string[1] { "LittleItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UseLittleItemReq), UseLittleItemReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UseLittleItemAck), UseLittleItemAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionUseReq), PotionUseReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionUseAck), PotionUseAck.Parser, new string[1] { "UsedCount" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionLevelUpReq), PotionLevelUpReq.Parser, new string[2] { "Id", "ToLevel" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionLevelUpAck), PotionLevelUpAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionUpdateAdditiveReq), PotionUpdateAdditiveReq.Parser, new string[2] { "PotionId", "Additives" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionUpdateAdditiveAck), PotionUpdateAdditiveAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionRecoverUseCountReq), PotionRecoverUseCountReq.Parser, new string[1] { "Count" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionRecoverUseCountAck), PotionRecoverUseCountAck.Parser, new string[1] { "UsedCount" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionInfoNtf), PotionInfoNtf.Parser, new string[1] { "PotionInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionNtf), PotionNtf.Parser, new string[1] { "Potions" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PotionChangeNtf), PotionChangeNtf.Parser, new string[3] { "SceneEnum", "Potions", "Remove" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(SyncLittleItemsReq), SyncLittleItemsReq.Parser, new string[1] { "Info" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SyncLittleItemsAck), SyncLittleItemsAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TreasureInfoNtf), TreasureInfoNtf.Parser, new string[1] { "TreasureInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecycleItemsReq), RecycleItemsReq.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecycleItemsAck), RecycleItemsAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(OpenBagChestReq), OpenBagChestReq.Parser, new string[3] { "ItemId", "Count", "ChooseIndex" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(OpenBagChestAck), OpenBagChestAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BagChestRewardSelectCountNtf), BagChestRewardSelectCountNtf.Parser, new string[1] { "Data" }, null, null, null, null)
		}));
	}
}
