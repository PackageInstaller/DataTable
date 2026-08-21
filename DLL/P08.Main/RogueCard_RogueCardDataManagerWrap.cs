using System;
using System.Collections.Generic;
using LuaInterface;
using RogueCard;

public class RogueCard_RogueCardDataManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("RogueCardDataManager");
		L.RegFunction("GetClue", GetClue);
		L.RegFunction("GameContinue", GameContinue);
		L.RegFunction("GameInit", GameInit);
		L.RegFunction("InitEffectData", InitEffectData);
		L.RegFunction("InitItemData", InitItemData);
		L.RegFunction("InitEnhanceData", InitEnhanceData);
		L.RegFunction("InitPackageData", InitPackageData);
		L.RegFunction("InitStageData", InitStageData);
		L.RegFunction("InitBossEffectData", InitBossEffectData);
		L.RegFunction("InitAttributeData", InitAttributeData);
		L.RegFunction("InitHandtypeData", InitHandtypeData);
		L.RegFunction("InitDeckData", InitDeckData);
		L.RegFunction("InitDifficultyData", InitDifficultyData);
		L.RegFunction("InitClueData", InitClueData);
		L.RegFunction("InitRecordData", InitRecordData);
		L.RegFunction("GetWealWoeIDList", GetWealWoeIDList);
		L.RegVar("effectDatabase", get_effectDatabase, set_effectDatabase);
		L.RegVar("itemDatabase", get_itemDatabase, set_itemDatabase);
		L.RegVar("enhanceDatabase", get_enhanceDatabase, set_enhanceDatabase);
		L.RegVar("packageDatabase", get_packageDatabase, set_packageDatabase);
		L.RegVar("stageDatabase", get_stageDatabase, set_stageDatabase);
		L.RegVar("wealAndWoeDatabase", get_wealAndWoeDatabase, set_wealAndWoeDatabase);
		L.RegVar("attributeDatabase", get_attributeDatabase, set_attributeDatabase);
		L.RegVar("handTypeDatabase", get_handTypeDatabase, set_handTypeDatabase);
		L.RegVar("deckDatabase", get_deckDatabase, set_deckDatabase);
		L.RegVar("difficultyDatabase", get_difficultyDatabase, set_difficultyDatabase);
		L.RegVar("recordItemData", get_recordItemData, set_recordItemData);
		L.RegVar("recordEnhanceData", get_recordEnhanceData, set_recordEnhanceData);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetClue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int groupID = (int)LuaDLL.luaL_checknumber(L, 1);
			int round = (int)LuaDLL.luaL_checknumber(L, 2);
			int type = (int)LuaDLL.luaL_checknumber(L, 3);
			string clue = RogueCardDataManager.GetClue(groupID, round, type);
			LuaDLL.lua_pushstring(L, clue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameContinue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int stageID = (int)LuaDLL.luaL_checknumber(L, 1);
			string saveData = ToLua.CheckString(L, 2);
			string rollbackData = ToLua.CheckString(L, 3);
			bool isGuide = LuaDLL.luaL_checkboolean(L, 4);
			RogueCardDataManager.GameContinue(stageID, saveData, rollbackData, isGuide);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameInit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int stageID = (int)LuaDLL.luaL_checknumber(L, 1);
			int deckID = (int)LuaDLL.luaL_checknumber(L, 2);
			int difficulty = (int)LuaDLL.luaL_checknumber(L, 3);
			bool isGuide = LuaDLL.luaL_checkboolean(L, 4);
			RogueCardDataManager.GameInit(stageID, deckID, difficulty, isGuide);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitEffectData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitEffectData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitItemData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitItemData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitEnhanceData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitEnhanceData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitPackageData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitPackageData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitStageData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitStageData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitBossEffectData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitBossEffectData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitAttributeData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitAttributeData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitHandtypeData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitHandtypeData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitDeckData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitDeckData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitDifficultyData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitDifficultyData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitClueData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RogueCardDataManager.InitClueData(ToLua.CheckObjectArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitRecordData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int[] items = ToLua.CheckNumberArray<int>(L, 1);
			int[] enhances = ToLua.CheckNumberArray<int>(L, 2);
			RogueCardDataManager.InitRecordData(items, enhances);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetWealWoeIDList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WealOrWoeType type = (WealOrWoeType)ToLua.CheckObject(L, 1, typeof(WealOrWoeType));
			int[] igonreID = ToLua.CheckNumberArray<int>(L, 2);
			List<int> wealWoeIDList = RogueCardDataManager.GetWealWoeIDList(type, igonreID);
			ToLua.PushSealed(L, wealWoeIDList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_effectDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.effectDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_itemDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.itemDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.enhanceDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_packageDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.packageDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.stageDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealAndWoeDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.wealAndWoeDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attributeDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.attributeDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handTypeDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.handTypeDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deckDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.deckDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_difficultyDatabase(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.difficultyDatabase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_recordItemData(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.recordItemData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_recordEnhanceData(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, RogueCardDataManager.recordEnhanceData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_effectDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.effectDatabase = (Dictionary<int, RogueCardEffectCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, RogueCardEffectCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_itemDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.itemDatabase = (List<RogueCardItemCfg>)ToLua.CheckObject(L, 2, typeof(List<RogueCardItemCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.enhanceDatabase = (Dictionary<int, RogueCardEnhanceCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, RogueCardEnhanceCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_packageDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.packageDatabase = (Dictionary<int, RogueCardPackageCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, RogueCardPackageCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.stageDatabase = (Dictionary<int, RogueCardStageCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, RogueCardStageCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealAndWoeDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.wealAndWoeDatabase = (Dictionary<int, RogueCardWealAndWoeCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, RogueCardWealAndWoeCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_attributeDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.attributeDatabase = (Dictionary<AttributeType, RogueAttributeCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<AttributeType, RogueAttributeCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handTypeDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.handTypeDatabase = (Dictionary<HandType, RogueHandTypeCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<HandType, RogueHandTypeCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deckDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.deckDatabase = (Dictionary<int, RogueDeckCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, RogueDeckCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_difficultyDatabase(IntPtr L)
	{
		try
		{
			RogueCardDataManager.difficultyDatabase = (Dictionary<int, RogueDifficultyCfg>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, RogueDifficultyCfg>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_recordItemData(IntPtr L)
	{
		try
		{
			RogueCardDataManager.recordItemData = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_recordEnhanceData(IntPtr L)
	{
		try
		{
			RogueCardDataManager.recordEnhanceData = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
