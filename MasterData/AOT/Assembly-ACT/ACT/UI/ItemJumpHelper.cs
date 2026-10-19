using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Model.Jump;
using Fundamental;

namespace ACT.UI;

public static class ItemJumpHelper
{
	private struct ItemJumpInfo(LuminModelType modelType, int param = int.MinValue, int param2 = int.MinValue, int param3 = int.MinValue, int param4 = int.MinValue, int param5 = int.MinValue)
	{
		public LuminModelType ModelType = modelType;

		public int Param = param;

		public int Param2 = param2;

		public int Param3 = param3;

		public int Param4 = param4;

		public int Param5 = param5;
	}

	private const int InvalidConfigId = 0;

	private const int InvalidNavigationId = -1;

	private const int EmptyCount = 0;

	private const int FirstIndex = 0;

	private const int UiJumpParamIndex = 0;

	private const int FirstExtraParamIndex = 1;

	private const int SecondExtraParamIndex = 2;

	private const int JumpTypeTeleport = 1;

	private const int JumpTypeOpenUi = 2;

	private const int MonsterTypeLargeMapTabId = 1;

	private const int InventoryBagChestTabId = 6;

	private const int HandBookDailyMissionTabId = 1;

	private const int HandBookRaidTabId = 3;

	private const int HandBookWildBossTabId = 7;

	private const int JumpRankCanJump = 0;

	private const int JumpRankOnlyText = 1;

	private const int JumpRankForbidden = 2;

	private const int JumpRankHide = 3;

	public static bool ItemHasJumpInfo(this ItemData itemData, List<RuntimeJumpData> infos)
	{
		if (CoreUtils.GetData(itemData.id, RuntimeConfigs.data.itemObtainJumps) == null)
		{
			return false;
		}
		GetItemJumpInfos(itemData.id, infos);
		return infos.Count > 0;
	}

	private static void GetItemJumpInfos(int itemID, List<RuntimeJumpData> jumpDatas)
	{
		ItemObtainJump data = CoreUtils.GetData(itemID, RuntimeConfigs.data.itemObtainJumps);
		if (data != null)
		{
			AddJumpInfos(data.collectionPoints, LuminModelType.CollectionPoints, itemID, jumpDatas);
			AddJumpInfos(data.abyssLayers, LuminModelType.AbyssLayers, itemID, jumpDatas);
			AddJumpInfos(data.raids, LuminModelType.Raids, itemID, jumpDatas);
			AddJumpInfos(data.temples, LuminModelType.Temples, itemID, jumpDatas);
			AddShopJumpInfos(data.shopSaleLists, itemID, jumpDatas);
			AddJumpInfos(data.missions, LuminModelType.Missions, itemID, jumpDatas);
			AddComposeJumpInfo(data, itemID, jumpDatas);
			AddJumpInfos(data.gacha, LuminModelType.Gacha, itemID, jumpDatas);
			AddJumpInfos(data.abyssConstantStar, LuminModelType.AbyssConstantStar, itemID, jumpDatas);
			AddJumpInfos(data.abyssCycleStar, LuminModelType.AbyssCycleStar, itemID, jumpDatas);
			AddJumpInfos(data.templeStar, LuminModelType.TempleStar, itemID, jumpDatas);
			AddJumpInfos(data.activities, LuminModelType.Activities, itemID, jumpDatas);
			AddBagChestJumpInfo(data, itemID, jumpDatas);
			AddJumpInfos(data.battlePass, LuminModelType.BattlePass, itemID, jumpDatas);
			AddDailyMissionPointJumpInfos(data, itemID, jumpDatas);
			AddWorldLevelMonsterPointJumpInfos(data, itemID, jumpDatas);
			AddWildBossMonsterPointJumpInfos(data, itemID, jumpDatas);
		}
	}

	private static void AddJumpInfos(int[] ids, LuminModelType modelType, int itemID, List<RuntimeJumpData> jumpDatas)
	{
		if (ids != null && ids.Length > 0)
		{
			foreach (int param in ids)
			{
				AddToList(new ItemJumpInfo(modelType, param), itemID, jumpDatas);
			}
		}
	}

	private static void AddShopJumpInfos(List<ItemKv> shopSaleLists, int itemID, List<RuntimeJumpData> jumpDatas)
	{
		if (shopSaleLists == null || shopSaleLists.Count <= 0)
		{
			return;
		}
		foreach (ItemKv shopSaleList in shopSaleLists)
		{
			int id = shopSaleList.id;
			int count = shopSaleList.count;
			int shopIdBySubShopId = GetShopIdBySubShopId(id);
			AddToList(new ItemJumpInfo(LuminModelType.Shops, shopIdBySubShopId, id, count), itemID, jumpDatas);
		}
	}

	private static int GetShopIdBySubShopId(int subShopId)
	{
		foreach (KeyValuePair<int, ShopData> shopData in RuntimeConfigs.data.shopDatas)
		{
			if (ContainsSubShopId(shopData.Value?.subshopIds, subShopId))
			{
				return shopData.Value.id;
			}
		}
		return 0;
	}

	private static bool ContainsSubShopId(int[] subShopIds, int subShopId)
	{
		if (subShopIds == null)
		{
			return false;
		}
		for (int i = 0; i < subShopIds.Length; i++)
		{
			if (subShopIds[i] == subShopId)
			{
				return true;
			}
		}
		return false;
	}

	private static void AddComposeJumpInfo(ItemObtainJump itemObtainJumpData, int itemID, List<RuntimeJumpData> jumpDatas)
	{
		if (itemObtainJumpData.compose)
		{
			AddToList(new ItemJumpInfo(LuminModelType.Compose, itemObtainJumpData.id), itemID, jumpDatas);
		}
	}

	private static void AddBagChestJumpInfo(ItemObtainJump itemObtainJumpData, int itemID, List<RuntimeJumpData> jumpDatas)
	{
		int[] bagChest = itemObtainJumpData.bagChest;
		if (bagChest != null && bagChest.Length > 0)
		{
			bagChest = itemObtainJumpData.bagChest;
			foreach (int param in bagChest)
			{
				AddToList(new ItemJumpInfo(LuminModelType.Inventory, 6, param), itemID, jumpDatas);
			}
		}
	}

	private static void AddWorldLevelMonsterPointJumpInfos(ItemObtainJump itemObtainJumpData, int itemID, List<RuntimeJumpData> jumpDatas)
	{
		List<ItemKv> worldLevelMonsterPoints = itemObtainJumpData.worldLevelMonsterPoints;
		if (worldLevelMonsterPoints == null || worldLevelMonsterPoints.Count <= 0)
		{
			return;
		}
		Dictionary<int, int> dictionary = DictionaryPool<int, int>.Get();
		foreach (ItemKv worldLevelMonsterPoint in itemObtainJumpData.worldLevelMonsterPoints)
		{
			int id = worldLevelMonsterPoint.id;
			EnemySpawn data = CoreUtils.GetData(worldLevelMonsterPoint.count, RuntimeConfigs.data.enemySpawns);
			List<Maybe> list = data?.enemy;
			if (list == null || list.Count <= 0)
			{
				continue;
			}
			foreach (Maybe item in data.enemy)
			{
				if (!dictionary.TryGetValue(item.id, out var value))
				{
					dictionary[item.id] = id;
				}
				else if (id < value)
				{
					dictionary[item.id] = id;
				}
			}
		}
		foreach (KeyValuePair<int, int> item2 in dictionary)
		{
			AddToList(new ItemJumpInfo(LuminModelType.MonsterType, 1, item2.Key, item2.Value), itemID, jumpDatas);
		}
		DictionaryPool<int, int>.Release(dictionary);
	}

	private static void AddDailyMissionPointJumpInfos(ItemObtainJump itemObtainJumpData, int itemID, List<RuntimeJumpData> jumpDatas)
	{
		int[] handbookDailyMissionPointRewardID = itemObtainJumpData.handbookDailyMissionPointRewardID;
		if (handbookDailyMissionPointRewardID != null && handbookDailyMissionPointRewardID.Length > 0)
		{
			handbookDailyMissionPointRewardID = itemObtainJumpData.handbookDailyMissionPointRewardID;
			int num = 0;
			if (num < handbookDailyMissionPointRewardID.Length)
			{
				_ = handbookDailyMissionPointRewardID[num];
				AddToList(new ItemJumpInfo(LuminModelType.HandBook, 1), itemID, jumpDatas);
			}
		}
	}

	private static void AddWildBossMonsterPointJumpInfos(ItemObtainJump itemObtainJumpData, int itemID, List<RuntimeJumpData> jumpDatas)
	{
		int[] wildBossMonsterPoints = itemObtainJumpData.wildBossMonsterPoints;
		if (wildBossMonsterPoints == null || wildBossMonsterPoints.Length <= 0)
		{
			return;
		}
		wildBossMonsterPoints = itemObtainJumpData.wildBossMonsterPoints;
		foreach (int num in wildBossMonsterPoints)
		{
			if (RuntimeConfigs.data.wildBossUses.ContainsKey(num))
			{
				AddToList(new ItemJumpInfo(LuminModelType.HandBook, 3, 7, num), itemID, jumpDatas);
			}
		}
	}

	private static RuntimeJumpData AddToList(ItemJumpInfo itemJumpInfo, int itemID, List<RuntimeJumpData> jumpDatas)
	{
		if (!TryGetItemJumpTarget(itemJumpInfo.ModelType, out var jumpType, out var uiJumpId))
		{
			return default;
		}
		List<int> list = new List<int>();
		if (jumpType == 1)
		{
			AddItemJumpInfoParams(list, itemJumpInfo);
		}
		else
		{
			list.Add(uiJumpId);
			AddItemJumpInfoParams(list, itemJumpInfo);
		}
		RuntimeJumpData runtimeJumpData = new RuntimeJumpData
		{
			ItemID = itemID,
			JumpType = jumpType,
			ModelType = itemJumpInfo.ModelType,
			Params = list
		};
		runtimeJumpData.Result = Model<JumpModel>.Interface.CanJump(runtimeJumpData);
		if (runtimeJumpData.Result.ShowType != JumpResult.JumpShowType.Hide)
		{
			if (ContainsSameJumpData(jumpDatas, runtimeJumpData))
			{
				runtimeJumpData.Result.Release();
				return default;
			}
			AddJumpDataByShowType(jumpDatas, runtimeJumpData);
			return runtimeJumpData;
		}
		runtimeJumpData.Result.Release();
		return default;
	}

	private static void AddJumpDataByShowType(List<RuntimeJumpData> jumpDatas, RuntimeJumpData jumpData)
	{
		int jumpShowTypeRank = GetJumpShowTypeRank(jumpData.Result.ShowType);
		for (int i = 0; i < jumpDatas.Count; i++)
		{
			RuntimeJumpData existingJumpData = jumpDatas[i];
			int jumpShowTypeRank2 = GetJumpShowTypeRank(existingJumpData.Result.ShowType);
			if (jumpShowTypeRank < jumpShowTypeRank2 || (jumpShowTypeRank == jumpShowTypeRank2 && ShouldInsertBeforeSameRank(jumpData, existingJumpData)))
			{
				jumpDatas.Insert(i, jumpData);
				return;
			}
		}
		jumpDatas.Add(jumpData);
	}

	private static bool ShouldInsertBeforeSameRank(RuntimeJumpData jumpData, RuntimeJumpData existingJumpData)
	{
		if (jumpData.ModelType != LuminModelType.Shops || existingJumpData.ModelType != LuminModelType.Shops)
		{
			return false;
		}
		return GetShopSortId(jumpData) < GetShopSortId(existingJumpData);
	}

	private static int GetShopSortId(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list == null || list.Count <= 1)
		{
			return int.MaxValue;
		}
		if (jumpData.Params.Count <= 2)
		{
			return jumpData.Params[1];
		}
		return jumpData.Params[2];
	}

	private static int GetJumpShowTypeRank(JumpResult.JumpShowType showType)
	{
		return showType switch
		{
			JumpResult.JumpShowType.CanJump => 0, 
			JumpResult.JumpShowType.OnlyText => 1, 
			JumpResult.JumpShowType.Forbidden => 2, 
			_ => 3, 
		};
	}

	private static bool TryGetItemJumpTarget(LuminModelType modelType, out int jumpType, out int uiJumpId)
	{
		jumpType = 2;
		uiJumpId = 0;
		switch (modelType)
		{
		case LuminModelType.Temples:
			jumpType = 1;
			return true;
		case LuminModelType.Raids:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_RAID];
			return true;
		case LuminModelType.AbyssLayers:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_ABYSSLIST];
			return true;
		case LuminModelType.Shops:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_SHOP];
			return true;
		case LuminModelType.Missions:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_TASK];
			return true;
		case LuminModelType.CollectionPoints:
		case LuminModelType.MonsterType:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_LARGEMAP];
			return true;
		case LuminModelType.Compose:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_POPUPITEMCRAFTING];
			return true;
		case LuminModelType.Gacha:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_CARDDRAW];
			return true;
		case LuminModelType.AbyssConstantStar:
		case LuminModelType.AbyssCycleStar:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_ABYSSLIST];
			return true;
		case LuminModelType.HandBook:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_HANDBOOK];
			return true;
		case LuminModelType.Activities:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_ACTIVITYCENTER];
			return true;
		case LuminModelType.Inventory:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_BAGPANEL];
			return true;
		case LuminModelType.BattlePass:
			uiJumpId = JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_BATTLEPASS];
			return true;
		default:
			return false;
		}
	}

	private static bool ContainsSameJumpData(List<RuntimeJumpData> jumpDatas, RuntimeJumpData jumpData)
	{
		if (jumpDatas == null || jumpDatas.Count <= 0)
		{
			return false;
		}
		foreach (RuntimeJumpData jumpData2 in jumpDatas)
		{
			if (jumpData2.ModelType == jumpData.ModelType && jumpData2.JumpType == jumpData.JumpType && ParamsEquals(jumpData2.Params, jumpData.Params))
			{
				return true;
			}
		}
		return false;
	}

	private static bool ParamsEquals(List<int> left, List<int> right)
	{
		if (left == right)
		{
			return true;
		}
		if (left == null || right == null || left.Count != right.Count)
		{
			return false;
		}
		for (int i = 0; i < left.Count; i++)
		{
			if (left[i] != right[i])
			{
				return false;
			}
		}
		return true;
	}

	private static void AddItemJumpInfoParams(List<int> @params, ItemJumpInfo itemJumpInfo)
	{
		AddParamIfAssigned(@params, itemJumpInfo.Param);
		AddParamIfAssigned(@params, itemJumpInfo.Param2);
		AddParamIfAssigned(@params, itemJumpInfo.Param3);
		AddParamIfAssigned(@params, itemJumpInfo.Param4);
		AddParamIfAssigned(@params, itemJumpInfo.Param5);
	}

	private static void AddParamIfAssigned(List<int> @params, int param)
	{
		if (param != int.MinValue)
		{
			@params.Add(param);
		}
	}

	public static void GetItemNavigation(this ItemData itemData, List<RuntimeJumpData> infos)
	{
		int[] navigation = itemData.navigation;
		if (navigation == null || navigation.Length <= 0 || itemData.navigation[0] == -1)
		{
			return;
		}
		navigation = itemData.navigation;
		foreach (int num in navigation)
		{
			ItemNavigation data = CoreUtils.GetData(num, RuntimeConfigs.data.ItemNavigations);
			if (data != null)
			{
				RuntimeJumpData runTimeJumpData = GetRunTimeJumpData(data.jumpId);
				runTimeJumpData.Result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
				if (runTimeJumpData.Result.ShowType != JumpResult.JumpShowType.Hide)
				{
					runTimeJumpData.ItemID = itemData.id;
					runTimeJumpData.NavigationID = num;
					infos.Add(runTimeJumpData);
				}
				else
				{
					runTimeJumpData.Result.Release();
				}
			}
		}
	}

	public static RuntimeJumpData GetRunTimeJumpData(int jumpId)
	{
		if (RuntimeConfigs.data.jumpDatas.TryGetValue(jumpId, out var value))
		{
			LuminModelType modelType;
			if (value.jumpType == 1)
			{
				modelType = LuminModelType.Map;
			}
			else
			{
				modelType = (LuminModelType)0;
				if (JumpModel.UIJumpIdToUITypeMap.TryGetValue(value.jumpParam[0], out var value2))
				{
					modelType = value2.Item2;
				}
			}
			return new RuntimeJumpData
			{
				ModelType = modelType,
				JumpType = value.jumpType,
				Params = new List<int>(value.jumpParam)
			};
		}
		return new RuntimeJumpData
		{
			ModelType = LuminModelType.Unmanaged,
			Params = null,
			Result = new JumpResult
			{
				ShowType = JumpResult.JumpShowType.OnlyText
			}
		};
	}
}
