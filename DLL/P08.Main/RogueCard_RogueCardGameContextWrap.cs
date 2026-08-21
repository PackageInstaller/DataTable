using System;
using System.Collections.Generic;
using LuaInterface;
using RogueCard;

public class RogueCard_RogueCardGameContextWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RogueCardGameContext), typeof(object));
		L.RegFunction("GetSettleRound", GetSettleRound);
		L.RegFunction("SetPlayNum", SetPlayNum);
		L.RegFunction("SetDiscardNum", SetDiscardNum);
		L.RegFunction("OnDispose", OnDispose);
		L.RegFunction("InitStage", InitStage);
		L.RegFunction("SetTargetScore", SetTargetScore);
		L.RegFunction("FinishStage", FinishStage);
		L.RegFunction("GetJokerGold", GetJokerGold);
		L.RegFunction("GetStageReward", GetStageReward);
		L.RegFunction("ClearStageData", ClearStageData);
		L.RegFunction("ApplyPendingActionCountsIfNeeded", ApplyPendingActionCountsIfNeeded);
		L.RegFunction("ResetDeck", ResetDeck);
		L.RegFunction("NewStageData", NewStageData);
		L.RegFunction("RefreshStageData", RefreshStageData);
		L.RegFunction("RefreshWoeEffect", RefreshWoeEffect);
		L.RegFunction("EnterStage", EnterStage);
		L.RegFunction("SelectWuChangCard", SelectWuChangCard);
		L.RegFunction("DrawCard", DrawCard);
		L.RegFunction("RemoveCard", RemoveCard);
		L.RegFunction("InsertAndSortHand", InsertAndSortHand);
		L.RegFunction("PlaySelectedCard", PlaySelectedCard);
		L.RegFunction("DisCardAll", DisCardAll);
		L.RegFunction("RefreshWuChangWhiteData", RefreshWuChangWhiteData);
		L.RegFunction("RefreshWuChangBlackData", RefreshWuChangBlackData);
		L.RegFunction("RefreshWoeWealList", RefreshWoeWealList);
		L.RegFunction("InitShopData", InitShopData);
		L.RegFunction("RefreshByCost", RefreshByCost);
		L.RegFunction("DeSelect", DeSelect);
		L.RegFunction("SelectCard", SelectCard);
		L.RegFunction("GetSelectIndexList", GetSelectIndexList);
		L.RegFunction("GetUnSelectIndexList", GetUnSelectIndexList);
		L.RegFunction("GetSelectDataList", GetSelectDataList);
		L.RegFunction("GetUnSelectDataList", GetUnSelectDataList);
		L.RegFunction("GetHandCard", GetHandCard);
		L.RegFunction("RefreshWuChangData", RefreshWuChangData);
		L.RegFunction("WuChangSelectCard", WuChangSelectCard);
		L.RegFunction("WuChangSelectWuChang", WuChangSelectWuChang);
		L.RegFunction("SortCard", SortCard);
		L.RegFunction("SortJokerCard", SortJokerCard);
		L.RegFunction("RefreshWuChangPackage", RefreshWuChangPackage);
		L.RegFunction("ClearPackageJokerData", ClearPackageJokerData);
		L.RegFunction("AddPackageJokerData", AddPackageJokerData);
		L.RegFunction("GetPackageJokerVersion", GetPackageJokerVersion);
		L.RegFunction("RemovePackageJokerAt", RemovePackageJokerAt);
		L.RegFunction("RefreshJokerPackage", RefreshJokerPackage);
		L.RegFunction("New", _CreateRogueCard_RogueCardGameContext);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("destroyedCardsCache", get_destroyedCardsCache, set_destroyedCardsCache);
		L.RegVar("_scoreList", get__scoreList, set__scoreList);
		L.RegVar("isRestoringSave", get_isRestoringSave, set_isRestoringSave);
		L.RegVar("isChallengeContinue", get_isChallengeContinue, set_isChallengeContinue);
		L.RegVar("restoreChallengeNormalStoryImage", get_restoreChallengeNormalStoryImage, set_restoreChallengeNormalStoryImage);
		L.RegVar("challengeDifficulty", get_challengeDifficulty, set_challengeDifficulty);
		L.RegVar("result", get_result, set_result);
		L.RegVar("recordItems", get_recordItems, set_recordItems);
		L.RegVar("recordEnhance", get_recordEnhance, set_recordEnhance);
		L.RegVar("globalAttrDic", get_globalAttrDic, set_globalAttrDic);
		L.RegVar("stageID", get_stageID, set_stageID);
		L.RegVar("stageType", get_stageType, set_stageType);
		L.RegVar("allRoundNum", get_allRoundNum, set_allRoundNum);
		L.RegVar("curRound", get_curRound, set_curRound);
		L.RegVar("curStageState", get_curStageState, set_curStageState);
		L.RegVar("challengeStoryNormalImageIndex", get_challengeStoryNormalImageIndex, set_challengeStoryNormalImageIndex);
		L.RegVar("handTypeLevel", get_handTypeLevel, set_handTypeLevel);
		L.RegVar("gold", get_gold, set_gold);
		L.RegVar("stageUseTime", get_stageUseTime, set_stageUseTime);
		L.RegVar("rogueDeck", get_rogueDeck, set_rogueDeck);
		L.RegVar("handData", get_handData, set_handData);
		L.RegVar("jokerData", get_jokerData, set_jokerData);
		L.RegVar("score", get_score, set_score);
		L.RegVar("targetScore", get_targetScore, set_targetScore);
		L.RegVar("bossTargetScore", get_bossTargetScore, set_bossTargetScore);
		L.RegVar("roundPlayNum", get_roundPlayNum, set_roundPlayNum);
		L.RegVar("roundDiscardNum", get_roundDiscardNum, set_roundDiscardNum);
		L.RegVar("pendingRestoreActionCounts", get_pendingRestoreActionCounts, set_pendingRestoreActionCounts);
		L.RegVar("pendingRestorePlayNum", get_pendingRestorePlayNum, set_pendingRestorePlayNum);
		L.RegVar("pendingRestoreDiscardNum", get_pendingRestoreDiscardNum, set_pendingRestoreDiscardNum);
		L.RegVar("restoreForceSelectIndex", get_restoreForceSelectIndex, set_restoreForceSelectIndex);
		L.RegVar("scoreResult", get_scoreResult, set_scoreResult);
		L.RegVar("shopData", get_shopData, set_shopData);
		L.RegVar("curPackageID", get_curPackageID, set_curPackageID);
		L.RegVar("curPackageWuChangID", get_curPackageWuChangID, set_curPackageWuChangID);
		L.RegVar("lastPackageNum", get_lastPackageNum, set_lastPackageNum);
		L.RegVar("selectJokerIndex", get_selectJokerIndex, set_selectJokerIndex);
		L.RegVar("packageJokerIndex", get_packageJokerIndex, set_packageJokerIndex);
		L.RegVar("packageJoker", get_packageJoker, set_packageJoker);
		L.RegVar("packageJokerVersion", get_packageJokerVersion, set_packageJokerVersion);
		L.RegVar("wuChangWaitCards", get_wuChangWaitCards, set_wuChangWaitCards);
		L.RegVar("wuChangResetNum", get_wuChangResetNum, set_wuChangResetNum);
		L.RegVar("whiteWuChangID", get_whiteWuChangID, set_whiteWuChangID);
		L.RegVar("blackWuChangID", get_blackWuChangID, set_blackWuChangID);
		L.RegVar("selectWuChangIndex", get_selectWuChangIndex, set_selectWuChangIndex);
		L.RegVar("wuChangSelectCardNum", get_wuChangSelectCardNum, set_wuChangSelectCardNum);
		L.RegVar("packageWuChang", get_packageWuChang, set_packageWuChang);
		L.RegVar("wealWoeRefreshNum", get_wealWoeRefreshNum, set_wealWoeRefreshNum);
		L.RegVar("wealList", get_wealList, set_wealList);
		L.RegVar("woeList", get_woeList, set_woeList);
		L.RegVar("curWoeID", get_curWoeID, set_curWoeID);
		L.RegVar("settleContext", get_settleContext, set_settleContext);
		L.RegVar("isOtherSuit", get_isOtherSuit, set_isOtherSuit);
		L.RegVar("isBetterStraight", get_isBetterStraight, set_isBetterStraight);
		L.RegVar("isAlwaysWuChang", get_isAlwaysWuChang, set_isAlwaysWuChang);
		L.RegVar("isDisableType", get_isDisableType, set_isDisableType);
		L.RegVar("disableType", get_disableType, set_disableType);
		L.RegVar("isOnlyType", get_isOnlyType, set_isOnlyType);
		L.RegVar("onlyType", get_onlyType, set_onlyType);
		L.RegVar("handTrigger", get_handTrigger, set_handTrigger);
		L.RegVar("ignoreWoe", get_ignoreWoe, set_ignoreWoe);
		L.RegVar("ignoreWoeStageLocked", get_ignoreWoeStageLocked, set_ignoreWoeStageLocked);
		L.RegVar("ignoreSpade", get_ignoreSpade, set_ignoreSpade);
		L.RegVar("isOddEven", get_isOddEven, set_isOddEven);
		L.RegVar("oddValue", get_oddValue, set_oddValue);
		L.RegVar("evenValue", get_evenValue, set_evenValue);
		L.RegVar("randomRank", get_randomRank, set_randomRank);
		L.RegVar("jokerGold", get_jokerGold, set_jokerGold);
		L.RegVar("curEffectData", get_curEffectData, set_curEffectData);
		L.RegVar("drawCardPool", get_drawCardPool, set_drawCardPool);
		L.RegVar("isTargetDraw", get_isTargetDraw, set_isTargetDraw);
		L.RegVar("sortState", get_sortState, set_sortState);
		L.RegVar("rollBackNum", get_rollBackNum, set_rollBackNum);
		L.RegVar("RandomSeed", get_RandomSeed, null);
		L.RegVar("playNum", get_playNum, set_playNum);
		L.RegVar("discardNum", get_discardNum, set_discardNum);
		L.RegVar("GetTargetScore", get_GetTargetScore, null);
		L.RegVar("GetAllCards", get_GetAllCards, null);
		L.RegVar("GetWuChangSelect", get_GetWuChangSelect, null);
		L.RegVar("GetWuChangUnSelect", get_GetWuChangUnSelect, null);
		L.RegVar("GetWuChangUnSelectAll", get_GetWuChangUnSelectAll, null);
		L.RegVar("GetCurWealWoeNum", get_GetCurWealWoeNum, null);
		L.RegVar("GetShowWealWoeNum", get_GetShowWealWoeNum, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRogueCard_RogueCardGameContext(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				RogueCardGameContext o = new RogueCardGameContext((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<RogueCardSaveData>(L, 1))
			{
				RogueCardGameContext o2 = new RogueCardGameContext((RogueCardSaveData)ToLua.ToObject(L, 1));
				ToLua.PushObject(L, o2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RogueCard.RogueCardGameContext.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSettleRound(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int settleRound = ((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).GetSettleRound();
			LuaDLL.lua_pushinteger(L, settleRound);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPlayNum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int playNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetPlayNum(playNum);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDiscardNum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int discardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetDiscardNum(discardNum);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).OnDispose();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitStage(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 3:
			{
				RogueCardGameContext obj2 = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
				int stageID2 = (int)LuaDLL.luaL_checknumber(L, 2);
				RogueCardSaveData saveData2 = (RogueCardSaveData)ToLua.CheckObject<RogueCardSaveData>(L, 3);
				obj2.InitStage(stageID2, saveData2);
				return 0;
			}
			case 4:
				if (TypeChecker.CheckTypes<RogueCardSaveData, bool>(L, 3))
				{
					RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
					int stageID = (int)LuaDLL.luaL_checknumber(L, 2);
					RogueCardSaveData saveData = (RogueCardSaveData)ToLua.ToObject(L, 3);
					bool isRollback = LuaDLL.lua_toboolean(L, 4);
					obj.InitStage(stageID, saveData, isRollback);
					return 0;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, int>(L, 3))
			{
				RogueCardGameContext obj3 = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
				int stageID3 = (int)LuaDLL.luaL_checknumber(L, 2);
				int deckID = (int)LuaDLL.lua_tonumber(L, 3);
				int difficulty = (int)LuaDLL.lua_tonumber(L, 4);
				obj3.InitStage(stageID3, deckID, difficulty);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameContext.InitStage");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTargetScore(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).SetTargetScore();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FinishStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).FinishStage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetJokerGold(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int effectID = (int)LuaDLL.luaL_checknumber(L, 2);
			int goldNum = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.GetJokerGold(effectID, goldNum);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStageReward(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int[] stageReward = ((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).GetStageReward();
			ToLua.Push(L, stageReward);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearStageData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).ClearStageData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ApplyPendingActionCountsIfNeeded(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).ApplyPendingActionCountsIfNeeded();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetDeck(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).ResetDeck();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NewStageData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).NewStageData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshStageData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).RefreshStageData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshWoeEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).RefreshWoeEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).EnterStage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SelectWuChangCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SelectWuChangCard(num);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawCard(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).DrawCard();
				return 0;
			case 3:
			{
				RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
				int num = (int)LuaDLL.luaL_checknumber(L, 2);
				Rank rank = (Rank)ToLua.CheckObject(L, 3, typeof(Rank));
				obj.DrawCard(num, rank);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameContext.DrawCard");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			RogueCardData data = (RogueCardData)ToLua.CheckObject<RogueCardData>(L, 2);
			obj.RemoveCard(data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InsertAndSortHand(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			HandData<RogueCardData> targetHand = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 2);
			List<RogueCardData> newCards = (List<RogueCardData>)ToLua.CheckObject(L, 3, typeof(List<RogueCardData>));
			obj.InsertAndSortHand(targetHand, newCards);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlaySelectedCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			List<RogueCardData> cardList = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
			ScoreResult scoreResult = (ScoreResult)ToLua.CheckObject<ScoreResult>(L, 3);
			obj.PlaySelectedCard(cardList, scoreResult);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisCardAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).DisCardAll();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshWuChangWhiteData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).RefreshWuChangWhiteData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshWuChangBlackData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).RefreshWuChangBlackData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshWoeWealList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			bool isChange = LuaDLL.luaL_checkboolean(L, 2);
			obj.RefreshWoeWealList(isChange);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitShopData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).InitShopData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshByCost(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).RefreshByCost();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).DeSelect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SelectCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SelectCard(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSelectIndexList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int[] selectIndexList = ((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).GetSelectIndexList();
			ToLua.Push(L, selectIndexList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUnSelectIndexList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int[] unSelectIndexList = ((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).GetUnSelectIndexList();
			ToLua.Push(L, unSelectIndexList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSelectDataList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<RogueCardData> selectDataList = ((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).GetSelectDataList();
			ToLua.PushSealed(L, selectDataList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUnSelectDataList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<RogueCardData> unSelectDataList = ((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).GetUnSelectDataList();
			ToLua.PushSealed(L, unSelectDataList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHandCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			RogueCardData handCard = obj.GetHandCard(index);
			ToLua.PushObject(L, handCard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshWuChangData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).RefreshWuChangData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WuChangSelectCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.WuChangSelectCard(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WuChangSelectWuChang(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.WuChangSelectWuChang(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SortCard(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				RogueCardGameContext obj2 = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
				HandData<RogueCardData> handData2 = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 2);
				obj2.SortCard(handData2);
				return 0;
			}
			case 3:
			{
				RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
				HandData<RogueCardData> handData = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 2);
				int sortType = (int)LuaDLL.luaL_checknumber(L, 3);
				obj.SortCard(handData, sortType);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameContext.SortCard");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SortJokerCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).SortJokerCard();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshWuChangPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).RefreshWuChangPackage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearPackageJokerData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).ClearPackageJokerData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddPackageJokerData(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				RogueCardGameContext obj2 = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
				int jokerID2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.AddPackageJokerData(jokerID2);
				return 0;
			}
			case 3:
			{
				RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
				int jokerID = (int)LuaDLL.luaL_checknumber(L, 2);
				int versionID = (int)LuaDLL.luaL_checknumber(L, 3);
				obj.AddPackageJokerData(jokerID, versionID);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameContext.AddPackageJokerData");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPackageJokerVersion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			int packageJokerVersion = obj.GetPackageJokerVersion(index);
			LuaDLL.lua_pushinteger(L, packageJokerVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemovePackageJokerAt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameContext obj = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.RemovePackageJokerAt(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshJokerPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 1)).RefreshJokerPackage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_destroyedCardsCache(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HashSet<RogueCardData> destroyedCardsCache = ((RogueCardGameContext)obj).destroyedCardsCache;
			ToLua.PushObject(L, destroyedCardsCache);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index destroyedCardsCache on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__scoreList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> scoreList = ((RogueCardGameContext)obj)._scoreList;
			ToLua.PushSealed(L, scoreList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _scoreList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isRestoringSave(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isRestoringSave = ((RogueCardGameContext)obj).isRestoringSave;
			LuaDLL.lua_pushboolean(L, isRestoringSave);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isRestoringSave on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isChallengeContinue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isChallengeContinue = ((RogueCardGameContext)obj).isChallengeContinue;
			LuaDLL.lua_pushboolean(L, isChallengeContinue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isChallengeContinue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_restoreChallengeNormalStoryImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool restoreChallengeNormalStoryImage = ((RogueCardGameContext)obj).restoreChallengeNormalStoryImage;
			LuaDLL.lua_pushboolean(L, restoreChallengeNormalStoryImage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restoreChallengeNormalStoryImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_challengeDifficulty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int challengeDifficulty = ((RogueCardGameContext)obj).challengeDifficulty;
			LuaDLL.lua_pushinteger(L, challengeDifficulty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challengeDifficulty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_result(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool result = ((RogueCardGameContext)obj).result;
			LuaDLL.lua_pushboolean(L, result);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index result on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_recordItems(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HashSet<int> recordItems = ((RogueCardGameContext)obj).recordItems;
			ToLua.PushObject(L, recordItems);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recordItems on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_recordEnhance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HashSet<int> recordEnhance = ((RogueCardGameContext)obj).recordEnhance;
			ToLua.PushObject(L, recordEnhance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recordEnhance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_globalAttrDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<AttributeType, int> globalAttrDic = ((RogueCardGameContext)obj).globalAttrDic;
			ToLua.PushSealed(L, globalAttrDic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index globalAttrDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stageID = ((RogueCardGameContext)obj).stageID;
			LuaDLL.lua_pushinteger(L, stageID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LevelType stageType = ((RogueCardGameContext)obj).stageType;
			ToLua.Push(L, stageType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allRoundNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int allRoundNum = ((RogueCardGameContext)obj).allRoundNum;
			LuaDLL.lua_pushinteger(L, allRoundNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allRoundNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curRound(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curRound = ((RogueCardGameContext)obj).curRound;
			LuaDLL.lua_pushinteger(L, curRound);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curRound on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curStageState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageType curStageState = ((RogueCardGameContext)obj).curStageState;
			ToLua.Push(L, curStageState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curStageState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_challengeStoryNormalImageIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int challengeStoryNormalImageIndex = ((RogueCardGameContext)obj).challengeStoryNormalImageIndex;
			LuaDLL.lua_pushinteger(L, challengeStoryNormalImageIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challengeStoryNormalImageIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handTypeLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<HandType, int> handTypeLevel = ((RogueCardGameContext)obj).handTypeLevel;
			ToLua.PushSealed(L, handTypeLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handTypeLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int gold = ((RogueCardGameContext)obj).gold;
			LuaDLL.lua_pushinteger(L, gold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageUseTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stageUseTime = ((RogueCardGameContext)obj).stageUseTime;
			LuaDLL.lua_pushinteger(L, stageUseTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageUseTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rogueDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueDeck rogueDeck = ((RogueCardGameContext)obj).rogueDeck;
			ToLua.PushObject(L, rogueDeck);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rogueDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HandData<RogueCardData> handData = ((RogueCardGameContext)obj).handData;
			ToLua.PushObject(L, handData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HandData<RogueCardJokerData> jokerData = ((RogueCardGameContext)obj).jokerData;
			ToLua.PushObject(L, jokerData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int score = ((RogueCardGameContext)obj).score;
			LuaDLL.lua_pushinteger(L, score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long targetScore = ((RogueCardGameContext)obj).targetScore;
			LuaDLL.tolua_pushint64(L, targetScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bossTargetScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long bossTargetScore = ((RogueCardGameContext)obj).bossTargetScore;
			LuaDLL.tolua_pushint64(L, bossTargetScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bossTargetScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roundPlayNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int roundPlayNum = ((RogueCardGameContext)obj).roundPlayNum;
			LuaDLL.lua_pushinteger(L, roundPlayNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roundPlayNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roundDiscardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int roundDiscardNum = ((RogueCardGameContext)obj).roundDiscardNum;
			LuaDLL.lua_pushinteger(L, roundDiscardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roundDiscardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pendingRestoreActionCounts(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool pendingRestoreActionCounts = ((RogueCardGameContext)obj).pendingRestoreActionCounts;
			LuaDLL.lua_pushboolean(L, pendingRestoreActionCounts);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pendingRestoreActionCounts on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pendingRestorePlayNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int pendingRestorePlayNum = ((RogueCardGameContext)obj).pendingRestorePlayNum;
			LuaDLL.lua_pushinteger(L, pendingRestorePlayNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pendingRestorePlayNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pendingRestoreDiscardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int pendingRestoreDiscardNum = ((RogueCardGameContext)obj).pendingRestoreDiscardNum;
			LuaDLL.lua_pushinteger(L, pendingRestoreDiscardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pendingRestoreDiscardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_restoreForceSelectIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int restoreForceSelectIndex = ((RogueCardGameContext)obj).restoreForceSelectIndex;
			LuaDLL.lua_pushinteger(L, restoreForceSelectIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restoreForceSelectIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scoreResult(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ScoreResult scoreResult = ((RogueCardGameContext)obj).scoreResult;
			ToLua.PushObject(L, scoreResult);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scoreResult on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shopData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardShopData shopData = ((RogueCardGameContext)obj).shopData;
			ToLua.PushObject(L, shopData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shopData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curPackageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curPackageID = ((RogueCardGameContext)obj).curPackageID;
			LuaDLL.lua_pushinteger(L, curPackageID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curPackageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curPackageWuChangID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curPackageWuChangID = ((RogueCardGameContext)obj).curPackageWuChangID;
			LuaDLL.lua_pushinteger(L, curPackageWuChangID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curPackageWuChangID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastPackageNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int lastPackageNum = ((RogueCardGameContext)obj).lastPackageNum;
			LuaDLL.lua_pushinteger(L, lastPackageNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPackageNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectJokerIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int selectJokerIndex = ((RogueCardGameContext)obj).selectJokerIndex;
			LuaDLL.lua_pushinteger(L, selectJokerIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectJokerIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_packageJokerIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int packageJokerIndex = ((RogueCardGameContext)obj).packageJokerIndex;
			LuaDLL.lua_pushinteger(L, packageJokerIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packageJokerIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_packageJoker(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> packageJoker = ((RogueCardGameContext)obj).packageJoker;
			ToLua.PushSealed(L, packageJoker);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packageJoker on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_packageJokerVersion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> packageJokerVersion = ((RogueCardGameContext)obj).packageJokerVersion;
			ToLua.PushSealed(L, packageJokerVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packageJokerVersion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wuChangWaitCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HandData<RogueCardData> wuChangWaitCards = ((RogueCardGameContext)obj).wuChangWaitCards;
			ToLua.PushObject(L, wuChangWaitCards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangWaitCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wuChangResetNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int wuChangResetNum = ((RogueCardGameContext)obj).wuChangResetNum;
			LuaDLL.lua_pushinteger(L, wuChangResetNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangResetNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_whiteWuChangID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int whiteWuChangID = ((RogueCardGameContext)obj).whiteWuChangID;
			LuaDLL.lua_pushinteger(L, whiteWuChangID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index whiteWuChangID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blackWuChangID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int blackWuChangID = ((RogueCardGameContext)obj).blackWuChangID;
			LuaDLL.lua_pushinteger(L, blackWuChangID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blackWuChangID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectWuChangIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int selectWuChangIndex = ((RogueCardGameContext)obj).selectWuChangIndex;
			LuaDLL.lua_pushinteger(L, selectWuChangIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectWuChangIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wuChangSelectCardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int wuChangSelectCardNum = ((RogueCardGameContext)obj).wuChangSelectCardNum;
			LuaDLL.lua_pushinteger(L, wuChangSelectCardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangSelectCardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_packageWuChang(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> packageWuChang = ((RogueCardGameContext)obj).packageWuChang;
			ToLua.PushSealed(L, packageWuChang);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packageWuChang on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealWoeRefreshNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int wealWoeRefreshNum = ((RogueCardGameContext)obj).wealWoeRefreshNum;
			LuaDLL.lua_pushinteger(L, wealWoeRefreshNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealWoeRefreshNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> wealList = ((RogueCardGameContext)obj).wealList;
			ToLua.PushSealed(L, wealList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_woeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> woeList = ((RogueCardGameContext)obj).woeList;
			ToLua.PushSealed(L, woeList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curWoeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curWoeID = ((RogueCardGameContext)obj).curWoeID;
			LuaDLL.lua_pushinteger(L, curWoeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curWoeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_settleContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext settleContext = ((RogueCardGameContext)obj).settleContext;
			ToLua.PushObject(L, settleContext);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index settleContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isOtherSuit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isOtherSuit = ((RogueCardGameContext)obj).isOtherSuit;
			LuaDLL.lua_pushboolean(L, isOtherSuit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOtherSuit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isBetterStraight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isBetterStraight = ((RogueCardGameContext)obj).isBetterStraight;
			LuaDLL.lua_pushboolean(L, isBetterStraight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isBetterStraight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isAlwaysWuChang(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAlwaysWuChang = ((RogueCardGameContext)obj).isAlwaysWuChang;
			LuaDLL.lua_pushboolean(L, isAlwaysWuChang);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAlwaysWuChang on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isDisableType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isDisableType = ((RogueCardGameContext)obj).isDisableType;
			LuaDLL.lua_pushboolean(L, isDisableType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDisableType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_disableType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HashSet<HandType> disableType = ((RogueCardGameContext)obj).disableType;
			ToLua.PushObject(L, disableType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disableType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isOnlyType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isOnlyType = ((RogueCardGameContext)obj).isOnlyType;
			LuaDLL.lua_pushboolean(L, isOnlyType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOnlyType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onlyType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HandType? onlyType = ((RogueCardGameContext)obj).onlyType;
			ToLua.PusNullable(L, onlyType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onlyType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool handTrigger = ((RogueCardGameContext)obj).handTrigger;
			LuaDLL.lua_pushboolean(L, handTrigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ignoreWoe(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignoreWoe = ((RogueCardGameContext)obj).ignoreWoe;
			LuaDLL.lua_pushboolean(L, ignoreWoe);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreWoe on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ignoreWoeStageLocked(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignoreWoeStageLocked = ((RogueCardGameContext)obj).ignoreWoeStageLocked;
			LuaDLL.lua_pushboolean(L, ignoreWoeStageLocked);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreWoeStageLocked on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ignoreSpade(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignoreSpade = ((RogueCardGameContext)obj).ignoreSpade;
			LuaDLL.lua_pushboolean(L, ignoreSpade);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreSpade on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isOddEven(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isOddEven = ((RogueCardGameContext)obj).isOddEven;
			LuaDLL.lua_pushboolean(L, isOddEven);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOddEven on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_oddValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rank oddValue = ((RogueCardGameContext)obj).oddValue;
			ToLua.Push(L, oddValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index oddValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_evenValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rank evenValue = ((RogueCardGameContext)obj).evenValue;
			ToLua.Push(L, evenValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index evenValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_randomRank(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rank randomRank = ((RogueCardGameContext)obj).randomRank;
			ToLua.Push(L, randomRank);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index randomRank on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerGold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, int> jokerGold = ((RogueCardGameContext)obj).jokerGold;
			ToLua.PushSealed(L, jokerGold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerGold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curEffectData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardData curEffectData = ((RogueCardGameContext)obj).curEffectData;
			ToLua.PushObject(L, curEffectData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curEffectData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_drawCardPool(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardData> drawCardPool = ((RogueCardGameContext)obj).drawCardPool;
			ToLua.PushSealed(L, drawCardPool);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drawCardPool on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isTargetDraw(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isTargetDraw = ((RogueCardGameContext)obj).isTargetDraw;
			LuaDLL.lua_pushboolean(L, isTargetDraw);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTargetDraw on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sortState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sortState = ((RogueCardGameContext)obj).sortState;
			LuaDLL.lua_pushinteger(L, sortState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rollBackNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rollBackNum = ((RogueCardGameContext)obj).rollBackNum;
			LuaDLL.lua_pushinteger(L, rollBackNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rollBackNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RandomSeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int randomSeed = ((RogueCardGameContext)obj).RandomSeed;
			LuaDLL.lua_pushinteger(L, randomSeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RandomSeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int playNum = ((RogueCardGameContext)obj).playNum;
			LuaDLL.lua_pushinteger(L, playNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_discardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int discardNum = ((RogueCardGameContext)obj).discardNum;
			LuaDLL.lua_pushinteger(L, discardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GetTargetScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long getTargetScore = ((RogueCardGameContext)obj).GetTargetScore;
			LuaDLL.tolua_pushint64(L, getTargetScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GetTargetScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GetAllCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardData> getAllCards = ((RogueCardGameContext)obj).GetAllCards;
			ToLua.PushSealed(L, getAllCards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GetAllCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GetWuChangSelect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardData> getWuChangSelect = ((RogueCardGameContext)obj).GetWuChangSelect;
			ToLua.PushSealed(L, getWuChangSelect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GetWuChangSelect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GetWuChangUnSelect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardData> getWuChangUnSelect = ((RogueCardGameContext)obj).GetWuChangUnSelect;
			ToLua.PushSealed(L, getWuChangUnSelect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GetWuChangUnSelect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GetWuChangUnSelectAll(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardData> getWuChangUnSelectAll = ((RogueCardGameContext)obj).GetWuChangUnSelectAll;
			ToLua.PushSealed(L, getWuChangUnSelectAll);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GetWuChangUnSelectAll on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GetCurWealWoeNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int getCurWealWoeNum = ((RogueCardGameContext)obj).GetCurWealWoeNum;
			LuaDLL.lua_pushinteger(L, getCurWealWoeNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GetCurWealWoeNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GetShowWealWoeNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int getShowWealWoeNum = ((RogueCardGameContext)obj).GetShowWealWoeNum;
			LuaDLL.lua_pushinteger(L, getShowWealWoeNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GetShowWealWoeNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_destroyedCardsCache(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			HashSet<RogueCardData> destroyedCardsCache = (HashSet<RogueCardData>)ToLua.CheckObject<HashSet<RogueCardData>>(L, 2);
			obj2.destroyedCardsCache = destroyedCardsCache;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index destroyedCardsCache on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__scoreList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			List<int> scoreList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2._scoreList = scoreList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _scoreList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isRestoringSave(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isRestoringSave = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isRestoringSave = isRestoringSave;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isRestoringSave on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isChallengeContinue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isChallengeContinue = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isChallengeContinue = isChallengeContinue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isChallengeContinue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_restoreChallengeNormalStoryImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool restoreChallengeNormalStoryImage = LuaDLL.luaL_checkboolean(L, 2);
			obj2.restoreChallengeNormalStoryImage = restoreChallengeNormalStoryImage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restoreChallengeNormalStoryImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_challengeDifficulty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int challengeDifficulty = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.challengeDifficulty = challengeDifficulty;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challengeDifficulty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_result(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool result = LuaDLL.luaL_checkboolean(L, 2);
			obj2.result = result;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index result on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_recordItems(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			HashSet<int> recordItems = (HashSet<int>)ToLua.CheckObject<HashSet<int>>(L, 2);
			obj2.recordItems = recordItems;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recordItems on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_recordEnhance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			HashSet<int> recordEnhance = (HashSet<int>)ToLua.CheckObject<HashSet<int>>(L, 2);
			obj2.recordEnhance = recordEnhance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recordEnhance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_globalAttrDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			Dictionary<AttributeType, int> globalAttrDic = (Dictionary<AttributeType, int>)ToLua.CheckObject(L, 2, typeof(Dictionary<AttributeType, int>));
			obj2.globalAttrDic = globalAttrDic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index globalAttrDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int stageID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stageID = stageID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			LevelType stageType = (LevelType)ToLua.CheckObject(L, 2, typeof(LevelType));
			obj2.stageType = stageType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allRoundNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int allRoundNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.allRoundNum = allRoundNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allRoundNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curRound(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int curRound = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.curRound = curRound;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curRound on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curStageState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			StageType curStageState = (StageType)ToLua.CheckObject(L, 2, typeof(StageType));
			obj2.curStageState = curStageState;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curStageState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_challengeStoryNormalImageIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int challengeStoryNormalImageIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.challengeStoryNormalImageIndex = challengeStoryNormalImageIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challengeStoryNormalImageIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handTypeLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			Dictionary<HandType, int> handTypeLevel = (Dictionary<HandType, int>)ToLua.CheckObject(L, 2, typeof(Dictionary<HandType, int>));
			obj2.handTypeLevel = handTypeLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handTypeLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int gold = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.gold = gold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageUseTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int stageUseTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stageUseTime = stageUseTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageUseTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rogueDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			RogueDeck rogueDeck = (RogueDeck)ToLua.CheckObject<RogueDeck>(L, 2);
			obj2.rogueDeck = rogueDeck;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rogueDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			HandData<RogueCardData> handData = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 2);
			obj2.handData = handData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			HandData<RogueCardJokerData> jokerData = (HandData<RogueCardJokerData>)ToLua.CheckObject<HandData<RogueCardJokerData>>(L, 2);
			obj2.jokerData = jokerData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int score = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.score = score;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			long targetScore = LuaDLL.tolua_checkint64(L, 2);
			obj2.targetScore = targetScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bossTargetScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			long bossTargetScore = LuaDLL.tolua_checkint64(L, 2);
			obj2.bossTargetScore = bossTargetScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bossTargetScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_roundPlayNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int roundPlayNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.roundPlayNum = roundPlayNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roundPlayNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_roundDiscardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int roundDiscardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.roundDiscardNum = roundDiscardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roundDiscardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pendingRestoreActionCounts(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool pendingRestoreActionCounts = LuaDLL.luaL_checkboolean(L, 2);
			obj2.pendingRestoreActionCounts = pendingRestoreActionCounts;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pendingRestoreActionCounts on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pendingRestorePlayNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int pendingRestorePlayNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.pendingRestorePlayNum = pendingRestorePlayNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pendingRestorePlayNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pendingRestoreDiscardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int pendingRestoreDiscardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.pendingRestoreDiscardNum = pendingRestoreDiscardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pendingRestoreDiscardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_restoreForceSelectIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int restoreForceSelectIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.restoreForceSelectIndex = restoreForceSelectIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index restoreForceSelectIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scoreResult(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			ScoreResult scoreResult = (ScoreResult)ToLua.CheckObject<ScoreResult>(L, 2);
			obj2.scoreResult = scoreResult;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scoreResult on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shopData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			RogueCardShopData shopData = (RogueCardShopData)ToLua.CheckObject<RogueCardShopData>(L, 2);
			obj2.shopData = shopData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shopData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curPackageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int curPackageID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.curPackageID = curPackageID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curPackageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curPackageWuChangID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int curPackageWuChangID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.curPackageWuChangID = curPackageWuChangID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curPackageWuChangID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastPackageNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int lastPackageNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.lastPackageNum = lastPackageNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPackageNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectJokerIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int selectJokerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.selectJokerIndex = selectJokerIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectJokerIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_packageJokerIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int packageJokerIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.packageJokerIndex = packageJokerIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packageJokerIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_packageJoker(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			List<int> packageJoker = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.packageJoker = packageJoker;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packageJoker on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_packageJokerVersion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			List<int> packageJokerVersion = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.packageJokerVersion = packageJokerVersion;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packageJokerVersion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wuChangWaitCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			HandData<RogueCardData> wuChangWaitCards = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 2);
			obj2.wuChangWaitCards = wuChangWaitCards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangWaitCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wuChangResetNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int wuChangResetNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.wuChangResetNum = wuChangResetNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangResetNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_whiteWuChangID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int whiteWuChangID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.whiteWuChangID = whiteWuChangID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index whiteWuChangID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blackWuChangID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int blackWuChangID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.blackWuChangID = blackWuChangID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blackWuChangID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectWuChangIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int selectWuChangIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.selectWuChangIndex = selectWuChangIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectWuChangIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wuChangSelectCardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int wuChangSelectCardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.wuChangSelectCardNum = wuChangSelectCardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangSelectCardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_packageWuChang(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			List<int> packageWuChang = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.packageWuChang = packageWuChang;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index packageWuChang on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealWoeRefreshNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int wealWoeRefreshNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.wealWoeRefreshNum = wealWoeRefreshNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealWoeRefreshNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			List<int> wealList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.wealList = wealList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_woeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			List<int> woeList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.woeList = woeList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curWoeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int curWoeID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.curWoeID = curWoeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curWoeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_settleContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			RogueCardResultContext settleContext = (RogueCardResultContext)ToLua.CheckObject<RogueCardResultContext>(L, 2);
			obj2.settleContext = settleContext;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index settleContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isOtherSuit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isOtherSuit = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isOtherSuit = isOtherSuit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOtherSuit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isBetterStraight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isBetterStraight = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isBetterStraight = isBetterStraight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isBetterStraight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isAlwaysWuChang(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isAlwaysWuChang = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isAlwaysWuChang = isAlwaysWuChang;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAlwaysWuChang on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isDisableType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isDisableType = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isDisableType = isDisableType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDisableType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_disableType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			HashSet<HandType> disableType = (HashSet<HandType>)ToLua.CheckObject<HashSet<HandType>>(L, 2);
			obj2.disableType = disableType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disableType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isOnlyType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isOnlyType = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isOnlyType = isOnlyType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOnlyType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onlyType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			HandType? onlyType = ToLua.CheckNullable<HandType>(L, 2);
			obj2.onlyType = onlyType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onlyType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool handTrigger = LuaDLL.luaL_checkboolean(L, 2);
			obj2.handTrigger = handTrigger;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignoreWoe(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool ignoreWoe = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignoreWoe = ignoreWoe;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreWoe on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignoreWoeStageLocked(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool ignoreWoeStageLocked = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignoreWoeStageLocked = ignoreWoeStageLocked;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreWoeStageLocked on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignoreSpade(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool ignoreSpade = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignoreSpade = ignoreSpade;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreSpade on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isOddEven(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isOddEven = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isOddEven = isOddEven;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isOddEven on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_oddValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			Rank oddValue = (Rank)ToLua.CheckObject(L, 2, typeof(Rank));
			obj2.oddValue = oddValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index oddValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_evenValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			Rank evenValue = (Rank)ToLua.CheckObject(L, 2, typeof(Rank));
			obj2.evenValue = evenValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index evenValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_randomRank(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			Rank randomRank = (Rank)ToLua.CheckObject(L, 2, typeof(Rank));
			obj2.randomRank = randomRank;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index randomRank on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerGold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			Dictionary<int, int> jokerGold = (Dictionary<int, int>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, int>));
			obj2.jokerGold = jokerGold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerGold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curEffectData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			RogueCardData curEffectData = (RogueCardData)ToLua.CheckObject<RogueCardData>(L, 2);
			obj2.curEffectData = curEffectData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curEffectData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_drawCardPool(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			List<RogueCardData> drawCardPool = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
			obj2.drawCardPool = drawCardPool;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drawCardPool on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isTargetDraw(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			bool isTargetDraw = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isTargetDraw = isTargetDraw;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTargetDraw on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sortState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int sortState = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sortState = sortState;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rollBackNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int rollBackNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.rollBackNum = rollBackNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rollBackNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int playNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.playNum = playNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_discardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext obj2 = (RogueCardGameContext)obj;
			int discardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.discardNum = discardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discardNum on a nil value");
		}
	}
}
