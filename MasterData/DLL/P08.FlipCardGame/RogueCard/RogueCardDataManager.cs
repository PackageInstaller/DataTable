using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

namespace RogueCard;

public static class RogueCardDataManager
{
	public static Dictionary<int, RogueCardEffectCfg> effectDatabase;

	public static List<RogueCardItemCfg> itemDatabase;

	public static Dictionary<int, RogueCardEnhanceCfg> enhanceDatabase;

	public static Dictionary<int, RogueCardPackageCfg> packageDatabase;

	public static Dictionary<int, RogueCardStageCfg> stageDatabase;

	public static Dictionary<int, RogueCardWealAndWoeCfg> wealAndWoeDatabase;

	public static Dictionary<AttributeType, RogueAttributeCfg> attributeDatabase;

	public static Dictionary<HandType, RogueHandTypeCfg> handTypeDatabase;

	public static Dictionary<int, RogueDeckCfg> deckDatabase;

	public static Dictionary<int, RogueDifficultyCfg> difficultyDatabase;

	public static List<int> recordItemData;

	public static List<int> recordEnhanceData;

	private static Dictionary<(int, int, int), string> clueGetDic;

	public static string GetClue(int groupID, int round, int type)
	{
		string value = "";
		if (clueGetDic.TryGetValue((groupID, round, type), out value))
		{
			return value;
		}
		return "";
	}

	public static void GameContinue(int stageID, string saveData, string rollbackData, bool isGuide)
	{
		RogueCardGameMain.Instance.GameInit(stageID, saveData, rollbackData, isGuide);
	}

	public static void GameInit(int stageID, int deckID, int difficulty, bool isGuide)
	{
		RogueCardGameMain.Instance.GameInit(stageID, deckID, difficulty, isGuide);
	}

	public static void InitEffectData(object[] luaData)
	{
		effectDatabase = new Dictionary<int, RogueCardEffectCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueCardEffectCfg rogueCardEffectCfg = new RogueCardEffectCfg();
			rogueCardEffectCfg.id = (int)(double)luaTable["id"];
			rogueCardEffectCfg.moment = (TriggerMoment)(double)luaTable["moment"];
			rogueCardEffectCfg.condition = (ConditionType)(double)luaTable["condition"];
			rogueCardEffectCfg.action = (ActionType)(double)luaTable["action"];
			rogueCardEffectCfg.param1 = luaTable2intArray(luaTable["param1"] as LuaTable);
			rogueCardEffectCfg.param2 = luaTable2intArray(luaTable["param2"] as LuaTable);
			rogueCardEffectCfg.effective_reset_moment = (int)(double)luaTable["effective_reset_moment"];
			rogueCardEffectCfg.effective_time = (int)(double)luaTable["effective_time"];
			rogueCardEffectCfg.lifetime_grow_moment = (int)(double)luaTable["lifetime_grow_moment"];
			rogueCardEffectCfg.max_lifetime = (int)(double)luaTable["max_lifetime"];
			if (rogueCardEffectCfg.effective_time == 0)
			{
				rogueCardEffectCfg.effective_time = -1;
			}
			if (rogueCardEffectCfg.max_lifetime == 0)
			{
				rogueCardEffectCfg.max_lifetime = -1;
			}
			effectDatabase.Add(rogueCardEffectCfg.id, rogueCardEffectCfg);
		}
		Debug.Log("RogueCard:初始化EffectData完成");
	}

	public static void InitItemData(object[] luaData)
	{
		itemDatabase = new List<RogueCardItemCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueCardItemCfg rogueCardItemCfg = new RogueCardItemCfg();
			rogueCardItemCfg.id = (int)(double)luaTable["id"];
			rogueCardItemCfg.type = (ItemType)(double)luaTable["type"];
			rogueCardItemCfg.name = luaTable["name"].ToString();
			rogueCardItemCfg.desc = luaTable["desc"].ToString();
			rogueCardItemCfg.ex_desc = luaTable["ex_desc"].ToString();
			rogueCardItemCfg.rare = (int)(double)luaTable["rare"];
			rogueCardItemCfg.price = (int)(double)luaTable["sell_price"];
			rogueCardItemCfg.effect_list = luaTable2intArray(luaTable["effect_list"] as LuaTable);
			rogueCardItemCfg.icon = luaTable["icon"].ToString();
			rogueCardItemCfg.limit = (int)(double)luaTable["limit"] == 1;
			rogueCardItemCfg.desc_type = (int)(double)luaTable["desc_value_type"];
			rogueCardItemCfg.sort_priority = (int)(double)luaTable["sort_priority"];
			rogueCardItemCfg.no_copy = (int)(double)luaTable["is_no_copy"] == 1;
			rogueCardItemCfg.tag = luaTable2intArray(luaTable["tag"] as LuaTable);
			itemDatabase.Add(rogueCardItemCfg);
		}
		Debug.Log("RogueCard:初始化ItemData完成");
	}

	public static void InitEnhanceData(object[] luaData)
	{
		enhanceDatabase = new Dictionary<int, RogueCardEnhanceCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueCardEnhanceCfg rogueCardEnhanceCfg = new RogueCardEnhanceCfg();
			rogueCardEnhanceCfg.id = (int)(double)luaTable["id"];
			rogueCardEnhanceCfg.type = (EnhanceType)(double)luaTable["type"];
			rogueCardEnhanceCfg.name = luaTable["name"].ToString();
			rogueCardEnhanceCfg.desc = luaTable["desc"].ToString();
			rogueCardEnhanceCfg.rare = (int)(double)luaTable["rare"];
			rogueCardEnhanceCfg.ex_price = (int)(double)luaTable["ex_price"];
			rogueCardEnhanceCfg.effect_list = luaTable2intArray(luaTable["effect_list"] as LuaTable);
			rogueCardEnhanceCfg.icon = luaTable["icon"].ToString();
			rogueCardEnhanceCfg.sort_priority = (int)(double)luaTable["sort_priority"];
			enhanceDatabase.Add(rogueCardEnhanceCfg.id, rogueCardEnhanceCfg);
		}
		Debug.Log("RogueCard:初始化EnhanceData完成");
	}

	public static void InitPackageData(object[] luaData)
	{
		packageDatabase = new Dictionary<int, RogueCardPackageCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueCardPackageCfg rogueCardPackageCfg = new RogueCardPackageCfg();
			rogueCardPackageCfg.id = (int)(double)luaTable["id"];
			rogueCardPackageCfg.type = (ItemType)(double)luaTable["type"];
			rogueCardPackageCfg.name = luaTable["name"].ToString();
			rogueCardPackageCfg.desc = luaTable["desc"].ToString();
			rogueCardPackageCfg.weight = (int)(double)luaTable["weight"];
			rogueCardPackageCfg.price = (int)(double)luaTable["sell_price"];
			rogueCardPackageCfg.content = luaTable2intArray(luaTable["content"] as LuaTable);
			rogueCardPackageCfg.icon = luaTable["icon"].ToString();
			rogueCardPackageCfg.icon2 = luaTable["icon2"].ToString();
			packageDatabase.Add(rogueCardPackageCfg.id, rogueCardPackageCfg);
		}
		Debug.Log("RogueCard:初始化PackageData完成");
	}

	public static void InitStageData(object[] luaData)
	{
		stageDatabase = new Dictionary<int, RogueCardStageCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueCardStageCfg rogueCardStageCfg = new RogueCardStageCfg();
			rogueCardStageCfg.id = (int)(double)luaTable["id"];
			rogueCardStageCfg.round = (int)(double)luaTable["round"];
			rogueCardStageCfg.name = luaTable["name"].ToString();
			rogueCardStageCfg.score_list = luaTable2intArray(luaTable["score_list"] as LuaTable);
			rogueCardStageCfg.boss_weal = luaTable2intArray(luaTable["boss_weal"] as LuaTable);
			rogueCardStageCfg.boss_woe = luaTable2intArray(luaTable["boss_woe"] as LuaTable);
			rogueCardStageCfg.type = (LevelType)(double)luaTable["type"];
			rogueCardStageCfg.false_picture = luaTable2stringArray(luaTable["false_picture"] as LuaTable);
			rogueCardStageCfg.truth_picture = luaTable2stringArray(luaTable["truth_picture"] as LuaTable);
			rogueCardStageCfg.clue_group_id = (int)(double)luaTable["clue_group_id"];
			stageDatabase.Add(rogueCardStageCfg.id, rogueCardStageCfg);
		}
	}

	public static void InitBossEffectData(object[] luaData)
	{
		wealAndWoeDatabase = new Dictionary<int, RogueCardWealAndWoeCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = new RogueCardWealAndWoeCfg();
			rogueCardWealAndWoeCfg.id = (int)(double)luaTable["id"];
			rogueCardWealAndWoeCfg.type = (WealOrWoeType)(double)luaTable["type"];
			rogueCardWealAndWoeCfg.coefficient = (int)(double)luaTable["coefficient"];
			rogueCardWealAndWoeCfg.max_num = (int)(double)luaTable["max_num"];
			rogueCardWealAndWoeCfg.effect_list = luaTable2intArray(luaTable["effect_list"] as LuaTable);
			rogueCardWealAndWoeCfg.desc = luaTable["desc"].ToString();
			rogueCardWealAndWoeCfg.weight = (int)(double)luaTable["weight"];
			wealAndWoeDatabase.Add(rogueCardWealAndWoeCfg.id, rogueCardWealAndWoeCfg);
		}
	}

	public static void InitAttributeData(object[] luaData)
	{
		attributeDatabase = new Dictionary<AttributeType, RogueAttributeCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueAttributeCfg rogueAttributeCfg = new RogueAttributeCfg();
			rogueAttributeCfg.type = (AttributeType)(double)luaTable["id"];
			rogueAttributeCfg.defaultValue = (int)(double)luaTable["default"];
			rogueAttributeCfg.maxValue = (int)(double)luaTable["max"];
			rogueAttributeCfg.minValue = (int)(double)luaTable["min"];
			attributeDatabase.Add(rogueAttributeCfg.type, rogueAttributeCfg);
		}
		Debug.Log("RogueCard:初始化EnhanceData完成");
	}

	public static void InitHandtypeData(object[] luaData)
	{
		handTypeDatabase = new Dictionary<HandType, RogueHandTypeCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueHandTypeCfg rogueHandTypeCfg = new RogueHandTypeCfg();
			rogueHandTypeCfg.type = (HandType)(double)luaTable["id"];
			rogueHandTypeCfg.base_score = (int)(double)luaTable["base_score"];
			rogueHandTypeCfg.base_multi = (int)(double)luaTable["base_multi"];
			rogueHandTypeCfg.add_score = (int)(double)luaTable["add_score"];
			rogueHandTypeCfg.add_multi = (int)(double)luaTable["add_multi"];
			rogueHandTypeCfg.name = luaTable["name"].ToString();
			rogueHandTypeCfg.desc = luaTable["desc"].ToString();
			rogueHandTypeCfg.exampleCard1 = luaTable2intArray(luaTable["exampleCard1"] as LuaTable);
			rogueHandTypeCfg.exampleCard2 = luaTable2intArray(luaTable["exampleCard2"] as LuaTable);
			rogueHandTypeCfg.exampleCard3 = luaTable2intArray(luaTable["exampleCard3"] as LuaTable);
			handTypeDatabase.Add(rogueHandTypeCfg.type, rogueHandTypeCfg);
		}
		Debug.Log("RogueCard:初始化HandtypeData完成");
	}

	public static void InitDeckData(object[] luaData)
	{
		deckDatabase = new Dictionary<int, RogueDeckCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueDeckCfg rogueDeckCfg = new RogueDeckCfg();
			rogueDeckCfg.id = (int)(double)luaTable["id"];
			rogueDeckCfg.deck = (int)(double)luaTable["deck"];
			rogueDeckCfg.name = luaTable["name"].ToString();
			rogueDeckCfg.desc = luaTable["desc"].ToString();
			rogueDeckCfg.effect_list = luaTable2intArray(luaTable["effect_list"] as LuaTable);
			rogueDeckCfg.pic = luaTable["pic"].ToString();
			rogueDeckCfg.score_rate = (int)(double)luaTable["score_rate"];
			deckDatabase.Add(rogueDeckCfg.id, rogueDeckCfg);
		}
		Debug.Log("RogueCard:初始化DeckData完成");
	}

	public static void InitDifficultyData(object[] luaData)
	{
		difficultyDatabase = new Dictionary<int, RogueDifficultyCfg>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueDifficultyCfg rogueDifficultyCfg = new RogueDifficultyCfg();
			rogueDifficultyCfg.id = (int)(double)luaTable["id"];
			rogueDifficultyCfg.desc = luaTable["desc"].ToString();
			rogueDifficultyCfg.effect_list = luaTable2intArray(luaTable["effect_list"] as LuaTable);
			rogueDifficultyCfg.score_rate = (int)(double)luaTable["score_rate"];
			difficultyDatabase.Add(rogueDifficultyCfg.id, rogueDifficultyCfg);
		}
		Debug.Log("RogueCard:初始化DifficultyData完成");
	}

	public static void InitClueData(object[] luaData)
	{
		clueGetDic = new Dictionary<(int, int, int), string>();
		for (int i = 0; i < luaData.Length; i++)
		{
			LuaTable luaTable = luaData[i] as LuaTable;
			RogueClueCfg rogueClueCfg = new RogueClueCfg();
			rogueClueCfg.id = (int)(double)luaTable["id"];
			rogueClueCfg.group_id = (int)(double)luaTable["group_id"];
			rogueClueCfg.round = (int)(double)luaTable["round"];
			rogueClueCfg.type = (int)(double)luaTable["type"];
			rogueClueCfg.clue = luaTable["clue"].ToString();
			clueGetDic.Add((rogueClueCfg.group_id, rogueClueCfg.round, rogueClueCfg.type), rogueClueCfg.clue);
		}
		Debug.Log("RogueCard:初始化ClueData完成");
	}

	public static void InitRecordData(int[] items, int[] enhances)
	{
		recordItemData = new List<int>();
		recordEnhanceData = new List<int>();
		recordItemData.AddRange(items);
		recordEnhanceData.AddRange(enhances);
	}

	private static int[] luaTable2intArray(LuaTable tbl)
	{
		int length = tbl.Length;
		int[] array = new int[length];
		for (int i = 0; i < length; i++)
		{
			array[i] = (int)(double)tbl[i + 1];
		}
		return array;
	}

	private static string[] luaTable2stringArray(LuaTable tbl)
	{
		int length = tbl.Length;
		string[] array = new string[length];
		for (int i = 0; i < length; i++)
		{
			array[i] = tbl[i + 1].ToString();
		}
		return array;
	}

	public static List<int> GetWealWoeIDList(WealOrWoeType type, int[] igonreID)
	{
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, RogueCardWealAndWoeCfg> item2 in wealAndWoeDatabase)
		{
			if (item2.Value.type == type)
			{
				list.Add(item2.Key);
			}
		}
		foreach (int item in igonreID)
		{
			list.Remove(item);
		}
		return list;
	}
}
