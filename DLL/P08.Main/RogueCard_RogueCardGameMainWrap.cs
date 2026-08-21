using System;
using System.Collections;
using System.Collections.Generic;
using ControllerExSpace;
using LuaInterface;
using RogueCard;
using UnityEngine;
using UnityEngine.UI;

public class RogueCard_RogueCardGameMainWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RogueCardGameMain), typeof(MonoBehaviour));
		L.RegFunction("GetTempRogueCard", GetTempRogueCard);
		L.RegFunction("ReleaseTempRogueCard", ReleaseTempRogueCard);
		L.RegFunction("ClearAllTempRogueCards", ClearAllTempRogueCards);
		L.RegFunction("GetInputLock", GetInputLock);
		L.RegFunction("ReserveDrawLock", ReserveDrawLock);
		L.RegFunction("ReleaseInputLock", ReleaseInputLock);
		L.RegFunction("CheckDisableInput", CheckDisableInput);
		L.RegFunction("OnDisable", OnDisable);
		L.RegFunction("OnDispose", OnDispose);
		L.RegFunction("GameInit", GameInit);
		L.RegFunction("OnDestroy", OnDestroy);
		L.RegFunction("ConfirmBlackWuChangCoverIfNeeded", ConfirmBlackWuChangCoverIfNeeded);
		L.RegFunction("ChangeSellJokerState", ChangeSellJokerState);
		L.RegFunction("ShowDeckInfoUI", ShowDeckInfoUI);
		L.RegFunction("IsNormalStageComplete", IsNormalStageComplete);
		L.RegFunction("IsStageComplete", IsStageComplete);
		L.RegFunction("SwapJokerCard", SwapJokerCard);
		L.RegFunction("SelectCard", SelectCard);
		L.RegFunction("DeSelectCard", DeSelectCard);
		L.RegFunction("PlayCard", PlayCard);
		L.RegFunction("ShowScore", ShowScore);
		L.RegFunction("DisCardCard", DisCardCard);
		L.RegFunction("DiscardAndRedraw", DiscardAndRedraw);
		L.RegFunction("RemoveCard", RemoveCard);
		L.RegFunction("ChangeMainState", ChangeMainState);
		L.RegFunction("BackMainState", BackMainState);
		L.RegFunction("CheckBackState", CheckBackState);
		L.RegFunction("BeginDeferredRefreshUI", BeginDeferredRefreshUI);
		L.RegFunction("EndDeferredRefreshUI", EndDeferredRefreshUI);
		L.RegFunction("RefreshUI", RefreshUI);
		L.RegFunction("RefreshDeckUI", RefreshDeckUI);
		L.RegFunction("SetForcedDeckUICount", SetForcedDeckUICount);
		L.RegFunction("ClearForcedDeckUICount", ClearForcedDeckUICount);
		L.RegFunction("RefreshWealAndWoe", RefreshWealAndWoe);
		L.RegFunction("RefreshMainUI", RefreshMainUI);
		L.RegFunction("DelayDiscardNumDisplay", DelayDiscardNumDisplay);
		L.RegFunction("ApplyDelayedDiscardNumDisplay", ApplyDelayedDiscardNumDisplay);
		L.RegFunction("RefreshJoker", RefreshJoker);
		L.RegFunction("BuyShopItem", BuyShopItem);
		L.RegFunction("RefreshShopItem", RefreshShopItem);
		L.RegFunction("EndShop", EndShop);
		L.RegFunction("GainJokerCard", GainJokerCard);
		L.RegFunction("PackageGainJoker", PackageGainJoker);
		L.RegFunction("AddAllWuChang", AddAllWuChang);
		L.RegFunction("AddPackageWuChang", AddPackageWuChang);
		L.RegFunction("ClearWuChangData", ClearWuChangData);
		L.RegFunction("DoWuChang", DoWuChang);
		L.RegFunction("SortCard", SortCard);
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("PlayGoldFlyAnimation", PlayGoldFlyAnimation);
		L.RegFunction("InitializeWaveData", InitializeWaveData);
		L.RegFunction("EnterSelectStageState", EnterSelectStageState);
		L.RegFunction("EnterStageState", EnterStageState);
		L.RegFunction("InitShopState", InitShopState);
		L.RegFunction("EnterShopState", EnterShopState);
		L.RegFunction("StartPackage", StartPackage);
		L.RegFunction("StartBuyWuChang", StartBuyWuChang);
		L.RegFunction("EnterPackageState", EnterPackageState);
		L.RegFunction("ExitPackageState", ExitPackageState);
		L.RegFunction("OpenPackage", OpenPackage);
		L.RegFunction("OpenJokerPackage", OpenJokerPackage);
		L.RegFunction("OpenWuChangPackage", OpenWuChangPackage);
		L.RegFunction("PlayerExitedShop", PlayerExitedShop);
		L.RegFunction("StartWuChangPhase", StartWuChangPhase);
		L.RegFunction("EndWuChangPhase", EndWuChangPhase);
		L.RegFunction("WuChangPhaseCompleted", WuChangPhaseCompleted);
		L.RegFunction("IsWaveCompleted", IsWaveCompleted);
		L.RegFunction("EnterInitStageSubState", EnterInitStageSubState);
		L.RegFunction("ExitInitStageSubState", ExitInitStageSubState);
		L.RegFunction("ExitStageState", ExitStageState);
		L.RegFunction("DrawCard", DrawCard);
		L.RegFunction("PlayEffectDiscardCards", PlayEffectDiscardCards);
		L.RegFunction("CompactHandWithTempAnimationCoroutine", CompactHandWithTempAnimationCoroutine);
		L.RegFunction("DrawCardWithTempAnimationCoroutine", DrawCardWithTempAnimationCoroutine);
		L.RegFunction("PlayWuChangCopyAnimCoroutine", PlayWuChangCopyAnimCoroutine);
		L.RegFunction("AnimatePlayedCardsFlight", AnimatePlayedCardsFlight);
		L.RegFunction("AnimateScoredCardsExit", AnimateScoredCardsExit);
		L.RegFunction("ShowSuitLvUp", ShowSuitLvUp);
		L.RegFunction("CardsReadyToPlay", CardsReadyToPlay);
		L.RegFunction("HandlePlayerInput", HandlePlayerInput);
		L.RegFunction("PlayerFinishedTurn", PlayerFinishedTurn);
		L.RegFunction("CheckNoCard", CheckNoCard);
		L.RegFunction("EnterTurnSettleState", EnterTurnSettleState);
		L.RegFunction("ExitTurnSettleState", ExitTurnSettleState);
		L.RegFunction("EnterTurnSettleStateFromSave", EnterTurnSettleStateFromSave);
		L.RegFunction("FinishStage", FinishStage);
		L.RegFunction("CheckRoundSuccess", CheckRoundSuccess);
		L.RegFunction("CompleteStage", CompleteStage);
		L.RegFunction("GetCurrentScore", GetCurrentScore);
		L.RegFunction("GetTargetScore", GetTargetScore);
		L.RegFunction("IsStageFinish", IsStageFinish);
		L.RegFunction("GetLastTurn", GetLastTurn);
		L.RegFunction("WuChangSelectCard", WuChangSelectCard);
		L.RegFunction("WuChangSelectWuChang", WuChangSelectWuChang);
		L.RegFunction("PackageJokerSelect", PackageJokerSelect);
		L.RegFunction("CheckIsNew", CheckIsNew);
		L.RegFunction("GetAniTime", GetAniTime);
		L.RegFunction("ShowJokerSellGo", ShowJokerSellGo);
		L.RegFunction("OnJokerDrag", OnJokerDrag);
		L.RegFunction("SwitchStoryModule", SwitchStoryModule);
		L.RegFunction("SellJoker", SellJoker);
		L.RegFunction("PlayJokerSellAnimation", PlayJokerSellAnimation);
		L.RegFunction("ChangeAniSpeed", ChangeAniSpeed);
		L.RegFunction("ShowWoeTip", ShowWoeTip);
		L.RegFunction("HideTips", HideTips);
		L.RegFunction("ShowTips", ShowTips);
		L.RegFunction("RecordItem", RecordItem);
		L.RegFunction("ChallengeContinue", ChallengeContinue);
		L.RegFunction("GetStageUseTimeSeconds", GetStageUseTimeSeconds);
		L.RegFunction("GetMiniStage", GetMiniStage);
		L.RegFunction("GetGuideState", GetGuideState);
		L.RegFunction("LockGuide", LockGuide);
		L.RegFunction("UnlockGuide", UnlockGuide);
		L.RegFunction("CheckSelectCard", CheckSelectCard);
		L.RegFunction("CheckSelectShopItem", CheckSelectShopItem);
		L.RegFunction("CheckSelectPackageItem", CheckSelectPackageItem);
		L.RegFunction("CheckSelectJokerItem", CheckSelectJokerItem);
		L.RegFunction("ConfirmGame", ConfirmGame);
		L.RegFunction("CheckShowPause", CheckShowPause);
		L.RegFunction("GMSetAttr", GMSetAttr);
		L.RegFunction("GMAddGold", GMAddGold);
		L.RegFunction("GMAddPlayNum", GMAddPlayNum);
		L.RegFunction("GMAddDisCardNum", GMAddDisCardNum);
		L.RegFunction("GMSetJoker", GMSetJoker);
		L.RegFunction("GMGetJoker", GMGetJoker);
		L.RegFunction("GMSetPackage", GMSetPackage);
		L.RegFunction("GMSetWealWoe", GMSetWealWoe);
		L.RegFunction("GMWin", GMWin);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("randomSystem", get_randomSystem, set_randomSystem);
		L.RegVar("saveSystem", get_saveSystem, set_saveSystem);
		L.RegVar("guideSystem", get_guideSystem, set_guideSystem);
		L.RegVar("jokerHolder", get_jokerHolder, set_jokerHolder);
		L.RegVar("copyToDeckQueue", get_copyToDeckQueue, set_copyToDeckQueue);
		L.RegVar("copyToHandQueue", get_copyToHandQueue, set_copyToHandQueue);
		L.RegVar("copyDestToJokerMap", get_copyDestToJokerMap, set_copyDestToJokerMap);
		L.RegVar("tempCopiedCards", get_tempCopiedCards, set_tempCopiedCards);
		L.RegVar("gameContext", get_gameContext, set_gameContext);
		L.RegVar("curPackageID", get_curPackageID, set_curPackageID);
		L.RegVar("playerHandle", get_playerHandle, set_playerHandle);
		L.RegVar("curStateUI", get_curStateUI, set_curStateUI);
		L.RegVar("storyContent", get_storyContent, set_storyContent);
		L.RegVar("storyUI", get_storyUI, set_storyUI);
		L.RegVar("stateUIList", get_stateUIList, set_stateUIList);
		L.RegVar("mainAni", get_mainAni, set_mainAni);
		L.RegVar("storyResultGo", get_storyResultGo, set_storyResultGo);
		L.RegVar("storyResultText", get_storyResultText, set_storyResultText);
		L.RegVar("suitLvUpGo", get_suitLvUpGo, set_suitLvUpGo);
		L.RegVar("suitLvUpText", get_suitLvUpText, set_suitLvUpText);
		L.RegVar("targetScore", get_targetScore, set_targetScore);
		L.RegVar("curScore", get_curScore, set_curScore);
		L.RegVar("infScoreText", get_infScoreText, set_infScoreText);
		L.RegVar("lastPlayNum", get_lastPlayNum, set_lastPlayNum);
		L.RegVar("lastPlayAni", get_lastPlayAni, set_lastPlayAni);
		L.RegVar("playNumFly", get_playNumFly, set_playNumFly);
		L.RegVar("lastPlayFlyText", get_lastPlayFlyText, set_lastPlayFlyText);
		L.RegVar("lastPlayFlyText2", get_lastPlayFlyText2, set_lastPlayFlyText2);
		L.RegVar("lastDiscardNum", get_lastDiscardNum, set_lastDiscardNum);
		L.RegVar("lastDiscardAni", get_lastDiscardAni, set_lastDiscardAni);
		L.RegVar("discardNumFly", get_discardNumFly, set_discardNumFly);
		L.RegVar("lastDiscardFlyText", get_lastDiscardFlyText, set_lastDiscardFlyText);
		L.RegVar("lastDiscardFlyText2", get_lastDiscardFlyText2, set_lastDiscardFlyText2);
		L.RegVar("goldAni", get_goldAni, set_goldAni);
		L.RegVar("goldNumFly", get_goldNumFly, set_goldNumFly);
		L.RegVar("goldFlyText", get_goldFlyText, set_goldFlyText);
		L.RegVar("goldFlyText2", get_goldFlyText2, set_goldFlyText2);
		L.RegVar("goldNum", get_goldNum, set_goldNum);
		L.RegVar("deckInfo", get_deckInfo, set_deckInfo);
		L.RegVar("jokerNum", get_jokerNum, set_jokerNum);
		L.RegVar("jokerNumAni", get_jokerNumAni, set_jokerNumAni);
		L.RegVar("wealNum", get_wealNum, set_wealNum);
		L.RegVar("woeDesc", get_woeDesc, set_woeDesc);
		L.RegVar("jokerSortBtn", get_jokerSortBtn, set_jokerSortBtn);
		L.RegVar("controllerEx", get_controllerEx, set_controllerEx);
		L.RegVar("jokerSlotEx", get_jokerSlotEx, set_jokerSlotEx);
		L.RegVar("playContentGo", get_playContentGo, set_playContentGo);
		L.RegVar("storyContentGo", get_storyContentGo, set_storyContentGo);
		L.RegVar("playContentBtn", get_playContentBtn, set_playContentBtn);
		L.RegVar("storyContentBtn", get_storyContentBtn, set_storyContentBtn);
		L.RegVar("commonTip", get_commonTip, set_commonTip);
		L.RegVar("jokerTipTrans", get_jokerTipTrans, set_jokerTipTrans);
		L.RegVar("cardTipTrans", get_cardTipTrans, set_cardTipTrans);
		L.RegVar("battleInfoBtn", get_battleInfoBtn, set_battleInfoBtn);
		L.RegVar("woeTipGo", get_woeTipGo, set_woeTipGo);
		L.RegVar("woeTipAnimator", get_woeTipAnimator, set_woeTipAnimator);
		L.RegVar("woeTipText", get_woeTipText, set_woeTipText);
		L.RegVar("wealNumText", get_wealNumText, set_wealNumText);
		L.RegVar("wealTipBtn", get_wealTipBtn, set_wealTipBtn);
		L.RegVar("wealTipGo", get_wealTipGo, set_wealTipGo);
		L.RegVar("wealTipContent", get_wealTipContent, set_wealTipContent);
		L.RegVar("wealTipItem", get_wealTipItem, set_wealTipItem);
		L.RegVar("wealTextList", get_wealTextList, set_wealTextList);
		L.RegVar("wealGoList", get_wealGoList, set_wealGoList);
		L.RegVar("jokerSellTrans", get_jokerSellTrans, set_jokerSellTrans);
		L.RegVar("jokerSellEx", get_jokerSellEx, set_jokerSellEx);
		L.RegVar("jokerSellText", get_jokerSellText, set_jokerSellText);
		L.RegVar("jokerSellStateCon", get_jokerSellStateCon, set_jokerSellStateCon);
		L.RegVar("jokerSlotCon", get_jokerSlotCon, set_jokerSlotCon);
		L.RegVar("bgCon", get_bgCon, set_bgCon);
		L.RegVar("jokerSellCon", get_jokerSellCon, set_jokerSellCon);
		L.RegVar("resultCon", get_resultCon, set_resultCon);
		L.RegVar("resultTipCon", get_resultTipCon, set_resultTipCon);
		L.RegVar("isWuChangComplete", get_isWuChangComplete, set_isWuChangComplete);
		L.RegVar("isWuChangCopyAnimating", get_isWuChangCopyAnimating, set_isWuChangCopyAnimating);
		L.RegVar("suppressRoundStartForceSelectRefresh", get_suppressRoundStartForceSelectRefresh, set_suppressRoundStartForceSelectRefresh);
		L.RegVar("CardDrawDuration", get_CardDrawDuration, set_CardDrawDuration);
		L.RegVar("CalScoreDuration", get_CalScoreDuration, set_CalScoreDuration);
		L.RegVar("isAniSpeedUp", get_isAniSpeedUp, set_isAniSpeedUp);
		L.RegVar("isPlayingAni", get_isPlayingAni, set_isPlayingAni);
		L.RegVar("isShowingScore", get_isShowingScore, set_isShowingScore);
		L.RegVar("wuChangPackageCardHandler", get_wuChangPackageCardHandler, set_wuChangPackageCardHandler);
		L.RegVar("wuChangCardHandler", get_wuChangCardHandler, set_wuChangCardHandler);
		L.RegVar("jokerCardHandler", get_jokerCardHandler, set_jokerCardHandler);
		L.RegVar("handCardHandler", get_handCardHandler, set_handCardHandler);
		L.RegVar("backgroundBtn", get_backgroundBtn, set_backgroundBtn);
		L.RegVar("movieContentTrs", get_movieContentTrs, set_movieContentTrs);
		L.RegVar("movieTip", get_movieTip, set_movieTip);
		L.RegVar("movieBtn", get_movieBtn, set_movieBtn);
		L.RegVar("goldCommonTipBtn", get_goldCommonTipBtn, set_goldCommonTipBtn);
		L.RegVar("cardCommonTipBtn", get_cardCommonTipBtn, set_cardCommonTipBtn);
		L.RegVar("woeCommonTipBtn", get_woeCommonTipBtn, set_woeCommonTipBtn);
		L.RegVar("woeCommonTipBtn2", get_woeCommonTipBtn2, set_woeCommonTipBtn2);
		L.RegVar("wealCommonTipBtn", get_wealCommonTipBtn, set_wealCommonTipBtn);
		L.RegVar("scoreCommonTipBtn", get_scoreCommonTipBtn, set_scoreCommonTipBtn);
		L.RegVar("commonTipTrans", get_commonTipTrans, set_commonTipTrans);
		L.RegVar("storyMode", get_storyMode, set_storyMode);
		L.RegVar("mainTitle", get_mainTitle, set_mainTitle);
		L.RegVar("clueTitle", get_clueTitle, set_clueTitle);
		L.RegVar("deckOutPoint", get_deckOutPoint, set_deckOutPoint);
		L.RegVar("deckTransPoint", get_deckTransPoint, set_deckTransPoint);
		L.RegVar("cardEndPoint", get_cardEndPoint, set_cardEndPoint);
		L.RegVar("cardScorePoint", get_cardScorePoint, set_cardScorePoint);
		L.RegVar("goldFlyStartPoint", get_goldFlyStartPoint, set_goldFlyStartPoint);
		L.RegVar("goldFlyEndPoint", get_goldFlyEndPoint, set_goldFlyEndPoint);
		L.RegVar("goldFlyGo", get_goldFlyGo, set_goldFlyGo);
		L.RegVar("cardVisualPrefab", get_cardVisualPrefab, set_cardVisualPrefab);
		L.RegVar("deckImg", get_deckImg, set_deckImg);
		L.RegVar("score_maxRoundScore", get_score_maxRoundScore, set_score_maxRoundScore);
		L.RegVar("score_diffScore", get_score_diffScore, set_score_diffScore);
		L.RegVar("score_ratio", get_score_ratio, set_score_ratio);
		L.RegVar("challenge_target_score_ratio", get_challenge_target_score_ratio, set_challenge_target_score_ratio);
		L.RegVar("max_round_score", get_max_round_score, set_max_round_score);
		L.RegVar("rollBackMaxNum", get_rollBackMaxNum, set_rollBackMaxNum);
		L.RegVar("rollBackGainGold", get_rollBackGainGold, set_rollBackGainGold);
		L.RegVar("enhanceWindowGo", get_enhanceWindowGo, set_enhanceWindowGo);
		L.RegVar("enhanceWindowYesBtn", get_enhanceWindowYesBtn, set_enhanceWindowYesBtn);
		L.RegVar("enhanceWindowNoBtn", get_enhanceWindowNoBtn, set_enhanceWindowNoBtn);
		L.RegVar("enhanceWindowRepeatBtn", get_enhanceWindowRepeatBtn, set_enhanceWindowRepeatBtn);
		L.RegVar("enhanceWindowRepeatYesGo", get_enhanceWindowRepeatYesGo, set_enhanceWindowRepeatYesGo);
		L.RegVar("enhanceWindowRepeatNoGo", get_enhanceWindowRepeatNoGo, set_enhanceWindowRepeatNoGo);
		L.RegVar("enhanceWindowText", get_enhanceWindowText, set_enhanceWindowText);
		L.RegVar("notScore", get_notScore, set_notScore);
		L.RegVar("NoWuChangMovie", get_NoWuChangMovie, set_NoWuChangMovie);
		L.RegVar("gmStr", get_gmStr, set_gmStr);
		L.RegVar("Instance", get_Instance, null);
		L.RegVar("GameContext", get_GameContext, null);
		L.RegVar("Random", get_Random, null);
		L.RegVar("CurState", get_CurState, null);
		L.RegVar("isHandle", get_isHandle, set_isHandle);
		L.RegVar("ActiveSettle", get_ActiveSettle, null);
		L.RegVar("IsSettleAni", get_IsSettleAni, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTempRogueCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			Transform parent = (Transform)ToLua.CheckObject<Transform>(L, 2);
			GameObject tempRogueCard = obj.GetTempRogueCard(parent);
			ToLua.PushSealed(L, tempRogueCard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReleaseTempRogueCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			GameObject obj2 = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj.ReleaseTempRogueCard(obj2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearAllTempRogueCards(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ClearAllTempRogueCards();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInputLock(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				RogueCardGameMain obj4 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				string lockName4 = ToLua.CheckString(L, 2);
				InputLockToken inputLock4 = obj4.GetInputLock(lockName4);
				ToLua.PushObject(L, inputLock4);
				return 1;
			}
			case 3:
			{
				RogueCardGameMain obj3 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				string lockName3 = ToLua.CheckString(L, 2);
				GameObject boundObject3 = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
				InputLockToken inputLock3 = obj3.GetInputLock(lockName3, boundObject3);
				ToLua.PushObject(L, inputLock3);
				return 1;
			}
			case 4:
			{
				RogueCardGameMain obj2 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				string lockName2 = ToLua.CheckString(L, 2);
				GameObject boundObject2 = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
				float timeout2 = (float)LuaDLL.luaL_checknumber(L, 4);
				InputLockToken inputLock2 = obj2.GetInputLock(lockName2, boundObject2, timeout2);
				ToLua.PushObject(L, inputLock2);
				return 1;
			}
			case 5:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				string lockName = ToLua.CheckString(L, 2);
				GameObject boundObject = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
				float timeout = (float)LuaDLL.luaL_checknumber(L, 4);
				bool ignoreError = LuaDLL.luaL_checkboolean(L, 5);
				InputLockToken inputLock = obj.GetInputLock(lockName, boundObject, timeout, ignoreError);
				ToLua.PushObject(L, inputLock);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.GetInputLock");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReserveDrawLock(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				InputLockToken o3 = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ReserveDrawLock();
				ToLua.PushObject(L, o3);
				return 1;
			}
			case 2:
			{
				RogueCardGameMain obj2 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				GameObject boundObject2 = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				InputLockToken o2 = obj2.ReserveDrawLock(boundObject2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 3:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				GameObject boundObject = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				float timeout = (float)LuaDLL.luaL_checknumber(L, 3);
				InputLockToken o = obj.ReserveDrawLock(boundObject, timeout);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.ReserveDrawLock");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReleaseInputLock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			InputLockToken token = (InputLockToken)ToLua.CheckObject<InputLockToken>(L, 2);
			obj.ReleaseInputLock(token);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckDisableInput(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				bool value2 = RogueCardGameMain.CheckDisableInput();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				LockItemType type = (LockItemType)ToLua.CheckObject(L, 1, typeof(LockItemType));
				int index = (int)LuaDLL.luaL_checknumber(L, 2);
				bool value = RogueCardGameMain.CheckDisableInput(type, index);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.CheckDisableInput");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDisable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).OnDisable();
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
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).OnDispose();
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
			int num = LuaDLL.lua_gettop(L);
			if (num == 5 && TypeChecker.CheckTypes<string, string, bool>(L, 3))
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int stageID = (int)LuaDLL.luaL_checknumber(L, 2);
				string saveData = ToLua.ToString(L, 3);
				string rollbackData = ToLua.ToString(L, 4);
				bool isGuide = LuaDLL.lua_toboolean(L, 5);
				obj.GameInit(stageID, saveData, rollbackData, isGuide);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<int, int, bool>(L, 3))
			{
				RogueCardGameMain obj2 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int stageID2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int deckID = (int)LuaDLL.lua_tonumber(L, 3);
				int difficulty = (int)LuaDLL.lua_tonumber(L, 4);
				bool isGuide2 = LuaDLL.lua_toboolean(L, 5);
				obj2.GameInit(stageID2, deckID, difficulty, isGuide2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.GameInit");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDestroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).OnDestroy();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ConfirmBlackWuChangCoverIfNeeded(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int blackWuChangID = (int)LuaDLL.luaL_checknumber(L, 2);
			List<RogueCardData> cards = (List<RogueCardData>)ToLua.CheckObject(L, 3, typeof(List<RogueCardData>));
			Action onConfirmed = (Action)ToLua.CheckDelegate<Action>(L, 4);
			obj.ConfirmBlackWuChangCoverIfNeeded(blackWuChangID, cards, onConfirmed);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeSellJokerState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool isOnUI = LuaDLL.luaL_checkboolean(L, 2);
			int index = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.ChangeSellJokerState(isOnUI, index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowDeckInfoUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool isShow = LuaDLL.luaL_checkboolean(L, 2);
			obj.ShowDeckInfoUI(isShow);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsNormalStageComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int stageIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsNormalStageComplete(stageIndex);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsStageComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int stageIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsStageComplete(stageIndex);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SwapJokerCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			int index2 = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SwapJokerCard(index, index2);
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
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
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
	private static int DeSelectCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).DeSelectCard();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).PlayCard();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowScore(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool isShow = LuaDLL.luaL_checkboolean(L, 2);
			obj.ShowScore(isShow);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisCardCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).DisCardCard();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DiscardAndRedraw(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int discardCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.DiscardAndRedraw(discardCount);
			return 0;
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
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.RemoveCard(num);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeMainState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			IState newState = (IState)ToLua.CheckObject<IState>(L, 2);
			obj.ChangeMainState(newState);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BackMainState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).BackMainState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckBackState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).CheckBackState();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BeginDeferredRefreshUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).BeginDeferredRefreshUI();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndDeferredRefreshUI(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EndDeferredRefreshUI();
				return 0;
			case 2:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				bool refreshNow = LuaDLL.luaL_checkboolean(L, 2);
				obj.EndDeferredRefreshUI(refreshNow);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.EndDeferredRefreshUI");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).RefreshUI();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshDeckUI(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).RefreshDeckUI();
				return 0;
			case 2:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int deckCount = (int)LuaDLL.luaL_checknumber(L, 2);
				obj.RefreshDeckUI(deckCount);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.RefreshDeckUI");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetForcedDeckUICount(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				RogueCardGameMain obj2 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int deckCount2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.SetForcedDeckUICount(deckCount2);
				return 0;
			}
			case 3:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int deckCount = (int)LuaDLL.luaL_checknumber(L, 2);
				bool refreshNow = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetForcedDeckUICount(deckCount, refreshNow);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.SetForcedDeckUICount");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearForcedDeckUICount(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ClearForcedDeckUICount();
				return 0;
			case 2:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				bool refreshNow = LuaDLL.luaL_checkboolean(L, 2);
				obj.ClearForcedDeckUICount(refreshNow);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.ClearForcedDeckUICount");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshWealAndWoe(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).RefreshWealAndWoe();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshMainUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).RefreshMainUI();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DelayDiscardNumDisplay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int amount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.DelayDiscardNumDisplay(amount);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ApplyDelayedDiscardNumDisplay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int amount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ApplyDelayedDiscardNumDisplay(amount);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshJoker(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).RefreshJoker();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BuyShopItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).BuyShopItem();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshShopItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).RefreshShopItem();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndShop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EndShop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GainJokerCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			RogueCardJokerData jokerData = (RogueCardJokerData)ToLua.CheckObject<RogueCardJokerData>(L, 2);
			obj.GainJokerCard(jokerData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PackageGainJoker(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).PackageGainJoker();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddAllWuChang(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).AddAllWuChang();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddPackageWuChang(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).AddPackageWuChang();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearWuChangData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ClearWuChangData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DoWuChang(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).DoWuChang();
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
			case 1:
				((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).SortCard();
				return 0;
			case 2:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int sortType = (int)LuaDLL.luaL_checknumber(L, 2);
				obj.SortCard(sortType);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.SortCard");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 5 && TypeChecker.CheckTypes<string, string, bool>(L, 3))
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int stageID = (int)LuaDLL.luaL_checknumber(L, 2);
				string saveJson = ToLua.ToString(L, 3);
				string rollBackSaveJson = ToLua.ToString(L, 4);
				bool isGuide = LuaDLL.lua_toboolean(L, 5);
				obj.StartGame(stageID, saveJson, rollBackSaveJson, isGuide);
				return 0;
			}
			if (num == 5 && TypeChecker.CheckTypes<int, int, bool>(L, 3))
			{
				RogueCardGameMain obj2 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int stageID2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int deckID = (int)LuaDLL.lua_tonumber(L, 3);
				int difficulty = (int)LuaDLL.lua_tonumber(L, 4);
				bool isGuiding = LuaDLL.lua_toboolean(L, 5);
				obj2.StartGame(stageID2, deckID, difficulty, isGuiding);
				return 0;
			}
			if (num == 6)
			{
				RogueCardGameMain obj3 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int stageID3 = (int)LuaDLL.luaL_checknumber(L, 2);
				string saveJson2 = ToLua.CheckString(L, 3);
				string rollBackSaveJson2 = ToLua.CheckString(L, 4);
				bool isGuide2 = LuaDLL.luaL_checkboolean(L, 5);
				bool isRollBack = LuaDLL.luaL_checkboolean(L, 6);
				obj3.StartGame(stageID3, saveJson2, rollBackSaveJson2, isGuide2, isRollBack);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.StartGame");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayGoldFlyAnimation(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).PlayGoldFlyAnimation();
				return 0;
			case 2:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				Action onComplete = (Action)ToLua.CheckDelegate<Action>(L, 2);
				obj.PlayGoldFlyAnimation(onComplete);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.PlayGoldFlyAnimation");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitializeWaveData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).InitializeWaveData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterSelectStageState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EnterSelectStageState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterStageState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EnterStageState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitShopState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool isRefresh = LuaDLL.luaL_checkboolean(L, 2);
			obj.InitShopState(isRefresh);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterShopState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EnterShopState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int packageID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.StartPackage(packageID);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartBuyWuChang(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int itemID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.StartBuyWuChang(itemID);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterPackageState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EnterPackageState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitPackageState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ExitPackageState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).OpenPackage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenJokerPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).OpenJokerPackage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenWuChangPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).OpenWuChangPackage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayerExitedShop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).PlayerExitedShop();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartWuChangPhase(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).StartWuChangPhase();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndWuChangPhase(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EndWuChangPhase();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WuChangPhaseCompleted(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).WuChangPhaseCompleted();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsWaveCompleted(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).IsWaveCompleted();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterInitStageSubState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EnterInitStageSubState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitInitStageSubState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ExitInitStageSubState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitStageState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ExitStageState();
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
				((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).DrawCard();
				return 0;
			case 3:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int num = (int)LuaDLL.luaL_checknumber(L, 2);
				Rank rank = (Rank)ToLua.CheckObject(L, 3, typeof(Rank));
				obj.DrawCard(num, rank);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.DrawCard");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayEffectDiscardCards(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			List<RogueCardData> cards = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
			obj.PlayEffectDiscardCards(cards);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CompactHandWithTempAnimationCoroutine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			RogueCardHolder holder = (RogueCardHolder)ToLua.CheckObject<RogueCardHolder>(L, 2);
			HandData<RogueCardData> targetHandData = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 3);
			Dictionary<RogueCardData, Vector3> oldPositions = (Dictionary<RogueCardData, Vector3>)ToLua.CheckObject(L, 4, typeof(Dictionary<RogueCardData, Vector3>));
			IEnumerator iter = obj.CompactHandWithTempAnimationCoroutine(holder, targetHandData, oldPositions);
			ToLua.Push(L, iter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawCardWithTempAnimationCoroutine(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				RogueCardGameMain obj4 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				List<RogueCardData> drawnCards4 = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
				RogueCardHolder holder4 = (RogueCardHolder)ToLua.CheckObject<RogueCardHolder>(L, 3);
				HandData<RogueCardData> targetHandData4 = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 4);
				IEnumerator iter4 = obj4.DrawCardWithTempAnimationCoroutine(drawnCards4, holder4, targetHandData4);
				ToLua.Push(L, iter4);
				return 1;
			}
			case 5:
			{
				RogueCardGameMain obj3 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				List<RogueCardData> drawnCards3 = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
				RogueCardHolder holder3 = (RogueCardHolder)ToLua.CheckObject<RogueCardHolder>(L, 3);
				HandData<RogueCardData> targetHandData3 = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 4);
				Dictionary<RogueCardData, Vector3> passedOldPos3 = (Dictionary<RogueCardData, Vector3>)ToLua.CheckObject(L, 5, typeof(Dictionary<RogueCardData, Vector3>));
				IEnumerator iter3 = obj3.DrawCardWithTempAnimationCoroutine(drawnCards3, holder3, targetHandData3, passedOldPos3);
				ToLua.Push(L, iter3);
				return 1;
			}
			case 6:
			{
				RogueCardGameMain obj2 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				List<RogueCardData> drawnCards2 = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
				RogueCardHolder holder2 = (RogueCardHolder)ToLua.CheckObject<RogueCardHolder>(L, 3);
				HandData<RogueCardData> targetHandData2 = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 4);
				Dictionary<RogueCardData, Vector3> passedOldPos2 = (Dictionary<RogueCardData, Vector3>)ToLua.CheckObject(L, 5, typeof(Dictionary<RogueCardData, Vector3>));
				bool holderPreHidden2 = LuaDLL.luaL_checkboolean(L, 6);
				IEnumerator iter2 = obj2.DrawCardWithTempAnimationCoroutine(drawnCards2, holder2, targetHandData2, passedOldPos2, holderPreHidden2);
				ToLua.Push(L, iter2);
				return 1;
			}
			case 7:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				List<RogueCardData> drawnCards = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
				RogueCardHolder holder = (RogueCardHolder)ToLua.CheckObject<RogueCardHolder>(L, 3);
				HandData<RogueCardData> targetHandData = (HandData<RogueCardData>)ToLua.CheckObject<HandData<RogueCardData>>(L, 4);
				Dictionary<RogueCardData, Vector3> passedOldPos = (Dictionary<RogueCardData, Vector3>)ToLua.CheckObject(L, 5, typeof(Dictionary<RogueCardData, Vector3>));
				bool holderPreHidden = LuaDLL.luaL_checkboolean(L, 6);
				bool dontRefresh = LuaDLL.luaL_checkboolean(L, 7);
				IEnumerator iter = obj.DrawCardWithTempAnimationCoroutine(drawnCards, holder, targetHandData, passedOldPos, holderPreHidden, dontRefresh);
				ToLua.Push(L, iter);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.DrawCardWithTempAnimationCoroutine");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayWuChangCopyAnimCoroutine(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerator iter = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).PlayWuChangCopyAnimCoroutine();
			ToLua.Push(L, iter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AnimatePlayedCardsFlight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			List<RogueCardData> cardsToFly = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
			int[] cardsIndexes = ToLua.CheckNumberArray<int>(L, 3);
			List<RogueCardData> un_cardsToFly = (List<RogueCardData>)ToLua.CheckObject(L, 4, typeof(List<RogueCardData>));
			int[] un_cardsIndexes = ToLua.CheckNumberArray<int>(L, 5);
			List<GameObject> outPlayedTempGo = (List<GameObject>)ToLua.CheckObject(L, 6, typeof(List<GameObject>));
			IEnumerator iter = obj.AnimatePlayedCardsFlight(cardsToFly, cardsIndexes, un_cardsToFly, un_cardsIndexes, outPlayedTempGo);
			ToLua.Push(L, iter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AnimateScoredCardsExit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			List<GameObject> tempCards = (List<GameObject>)ToLua.CheckObject(L, 2, typeof(List<GameObject>));
			List<RogueCardData> cardDatas = (List<RogueCardData>)ToLua.CheckObject(L, 3, typeof(List<RogueCardData>));
			IEnumerator iter = obj.AnimateScoredCardsExit(tempCards, cardDatas);
			ToLua.Push(L, iter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowSuitLvUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int handType = (int)LuaDLL.luaL_checknumber(L, 2);
			int lv = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.ShowSuitLvUp(handType, lv);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CardsReadyToPlay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).CardsReadyToPlay();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HandlePlayerInput(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).HandlePlayerInput();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayerFinishedTurn(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).PlayerFinishedTurn();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckNoCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).CheckNoCard();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterTurnSettleState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			Action action = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.EnterTurnSettleState(action);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitTurnSettleState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ExitTurnSettleState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterTurnSettleStateFromSave(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).EnterTurnSettleStateFromSave();
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
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).FinishStage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckRoundSuccess(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).CheckRoundSuccess();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CompleteStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool victory = LuaDLL.luaL_checkboolean(L, 2);
			obj.CompleteStage(victory);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentScore(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int currentScore = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GetCurrentScore();
			LuaDLL.lua_pushinteger(L, currentScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTargetScore(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			long targetScore = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GetTargetScore();
			LuaDLL.tolua_pushint64(L, targetScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsStageFinish(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).IsStageFinish();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLastTurn(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int lastTurn = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GetLastTurn();
			LuaDLL.lua_pushinteger(L, lastTurn);
			return 1;
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
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
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
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
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
	private static int PackageJokerSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			IRogueCardNeedTip target = (IRogueCardNeedTip)ToLua.CheckObject<IRogueCardNeedTip>(L, 3);
			obj.PackageJokerSelect(index, target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckIsNew(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int type = (int)LuaDLL.luaL_checknumber(L, 2);
			int id = (int)LuaDLL.luaL_checknumber(L, 3);
			bool value = obj.CheckIsNew(type, id);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAniTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float aniTime = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GetAniTime();
			LuaDLL.lua_pushnumber(L, aniTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowJokerSellGo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool show = LuaDLL.luaL_checkboolean(L, 2);
			obj.ShowJokerSellGo(show);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnJokerDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool isDrag = LuaDLL.luaL_checkboolean(L, 2);
			int index = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.OnJokerDrag(isDrag, index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SwitchStoryModule(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool isStory = LuaDLL.luaL_checkboolean(L, 2);
			obj.SwitchStoryModule(isStory);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SellJoker(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			VisualJokerCard visual = (VisualJokerCard)ToLua.CheckObject<VisualJokerCard>(L, 3);
			obj.SellJoker(index, visual);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayJokerSellAnimation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			GameObject originalVisualGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			Vector3 dropPos = ToLua.ToVector3(L, 3);
			IEnumerator iter = obj.PlayJokerSellAnimation(originalVisualGo, dropPos);
			ToLua.Push(L, iter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeAniSpeed(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ChangeAniSpeed();
				return 0;
			case 2:
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				bool isSpeedUp = LuaDLL.luaL_checkboolean(L, 2);
				obj.ChangeAniSpeed(isSpeedUp);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.ChangeAniSpeed");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowWoeTip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			bool isShow = LuaDLL.luaL_checkboolean(L, 2);
			obj.ShowWoeTip(isShow);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HideTips(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).HideTips();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowTips(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<RogueCardData, IRogueCardNeedTip>(L, 2))
			{
				RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				RogueCardData data = (RogueCardData)ToLua.ToObject(L, 2);
				IRogueCardNeedTip target = (IRogueCardNeedTip)ToLua.ToObject(L, 3);
				obj.ShowTips(data, target);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<RogueCardJokerData, IRogueCardNeedTip>(L, 2))
			{
				RogueCardGameMain obj2 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				RogueCardJokerData joker = (RogueCardJokerData)ToLua.ToObject(L, 2);
				IRogueCardNeedTip target2 = (IRogueCardNeedTip)ToLua.ToObject(L, 3);
				obj2.ShowTips(joker, target2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<int, IRogueCardNeedTip>(L, 2))
			{
				RogueCardGameMain obj3 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				int wuChangID = (int)LuaDLL.lua_tonumber(L, 2);
				IRogueCardNeedTip target3 = (IRogueCardNeedTip)ToLua.ToObject(L, 3);
				obj3.ShowTips(wuChangID, target3);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<ShopItemData, IRogueCardNeedTip>(L, 2))
			{
				RogueCardGameMain obj4 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				ShopItemData cfg = (ShopItemData)ToLua.ToObject(L, 2);
				IRogueCardNeedTip target4 = (IRogueCardNeedTip)ToLua.ToObject(L, 3);
				obj4.ShowTips(cfg, target4);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<RogueCardPackageCfg, IRogueCardNeedTip>(L, 2))
			{
				RogueCardGameMain obj5 = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
				RogueCardPackageCfg cfg2 = (RogueCardPackageCfg)ToLua.ToObject(L, 2);
				IRogueCardNeedTip target5 = (IRogueCardNeedTip)ToLua.ToObject(L, 3);
				obj5.ShowTips(cfg2, target5);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: RogueCard.RogueCardGameMain.ShowTips");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecordItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int type = (int)LuaDLL.luaL_checknumber(L, 2);
			int id = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.RecordItem(type, id);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChallengeContinue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ChallengeContinue();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStageUseTimeSeconds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int stageUseTimeSeconds = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GetStageUseTimeSeconds();
			LuaDLL.lua_pushinteger(L, stageUseTimeSeconds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMiniStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int miniStage = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GetMiniStage();
			LuaDLL.lua_pushinteger(L, miniStage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGuideState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int guideState = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GetGuideState();
			LuaDLL.lua_pushinteger(L, guideState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LockGuide(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int type = (int)LuaDLL.luaL_checknumber(L, 2);
			int[] lockIndex = ToLua.CheckNumberArray<int>(L, 3);
			obj.LockGuide(type, lockIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnlockGuide(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).UnlockGuide();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckSelectCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int card = (int)LuaDLL.luaL_checknumber(L, 2);
			int card2 = (int)LuaDLL.luaL_checknumber(L, 3);
			int card3 = (int)LuaDLL.luaL_checknumber(L, 4);
			bool value = obj.CheckSelectCard(card, card2, card3);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckSelectShopItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.CheckSelectShopItem(index);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckSelectPackageItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.CheckSelectPackageItem(index);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckSelectJokerItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RogueCardGameMain obj = (RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.CheckSelectJokerItem(index);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ConfirmGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).ConfirmGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckShowPause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).CheckShowPause();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMSetAttr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMSetAttr();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMAddGold(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMAddGold();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMAddPlayNum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMAddPlayNum();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMAddDisCardNum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMAddDisCardNum();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMSetJoker(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMSetJoker();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMGetJoker(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMGetJoker();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMSetPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMSetPackage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMSetWealWoe(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMSetWealWoe();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GMWin(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RogueCardGameMain)ToLua.CheckObject<RogueCardGameMain>(L, 1)).GMWin();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_randomSystem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DeterministicRandom randomSystem = ((RogueCardGameMain)obj).randomSystem;
			ToLua.PushObject(L, randomSystem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index randomSystem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_saveSystem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSystem saveSystem = ((RogueCardGameMain)obj).saveSystem;
			ToLua.PushObject(L, saveSystem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index saveSystem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_guideSystem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGuideSystem guideSystem = ((RogueCardGameMain)obj).guideSystem;
			ToLua.PushObject(L, guideSystem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guideSystem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerHolder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueJokerHolder jokerHolder = ((RogueCardGameMain)obj).jokerHolder;
			ToLua.Push(L, jokerHolder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerHolder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_copyToDeckQueue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Tuple<RogueCardData, RogueCardData>> copyToDeckQueue = ((RogueCardGameMain)obj).copyToDeckQueue;
			ToLua.PushSealed(L, copyToDeckQueue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index copyToDeckQueue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_copyToHandQueue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Tuple<RogueCardData, RogueCardData>> copyToHandQueue = ((RogueCardGameMain)obj).copyToHandQueue;
			ToLua.PushSealed(L, copyToHandQueue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index copyToHandQueue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_copyDestToJokerMap(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<RogueCardData, RogueCardJokerData> copyDestToJokerMap = ((RogueCardGameMain)obj).copyDestToJokerMap;
			ToLua.PushSealed(L, copyDestToJokerMap);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index copyDestToJokerMap on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tempCopiedCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardData> tempCopiedCards = ((RogueCardGameMain)obj).tempCopiedCards;
			ToLua.PushSealed(L, tempCopiedCards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tempCopiedCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gameContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameContext gameContext = ((RogueCardGameMain)obj).gameContext;
			ToLua.PushObject(L, gameContext);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gameContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curPackageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curPackageID = ((RogueCardGameMain)obj).curPackageID;
			LuaDLL.lua_pushinteger(L, curPackageID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curPackageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playerHandle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int playerHandle = ((RogueCardGameMain)obj).playerHandle;
			LuaDLL.lua_pushinteger(L, playerHandle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerHandle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curStateUI(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardStateUIBase curStateUI = ((RogueCardGameMain)obj).curStateUI;
			ToLua.Push(L, curStateUI);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curStateUI on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_storyContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform storyContent = ((RogueCardGameMain)obj).storyContent;
			ToLua.Push(L, storyContent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_storyUI(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardStoryBaseUI storyUI = ((RogueCardGameMain)obj).storyUI;
			ToLua.Push(L, storyUI);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyUI on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stateUIList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardStateUIBase> stateUIList = ((RogueCardGameMain)obj).stateUIList;
			ToLua.PushSealed(L, stateUIList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stateUIList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator mainAni = ((RogueCardGameMain)obj).mainAni;
			ToLua.Push(L, mainAni);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_storyResultGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject storyResultGo = ((RogueCardGameMain)obj).storyResultGo;
			ToLua.PushSealed(L, storyResultGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyResultGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_storyResultText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text storyResultText = ((RogueCardGameMain)obj).storyResultText;
			ToLua.Push(L, storyResultText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyResultText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_suitLvUpGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject suitLvUpGo = ((RogueCardGameMain)obj).suitLvUpGo;
			ToLua.PushSealed(L, suitLvUpGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suitLvUpGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_suitLvUpText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text suitLvUpText = ((RogueCardGameMain)obj).suitLvUpText;
			ToLua.Push(L, suitLvUpText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suitLvUpText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text targetScore = ((RogueCardGameMain)obj).targetScore;
			ToLua.Push(L, targetScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber curScore = ((RogueCardGameMain)obj).curScore;
			ToLua.Push(L, curScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_infScoreText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject infScoreText = ((RogueCardGameMain)obj).infScoreText;
			ToLua.PushSealed(L, infScoreText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index infScoreText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastPlayNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text lastPlayNum = ((RogueCardGameMain)obj).lastPlayNum;
			ToLua.Push(L, lastPlayNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastPlayAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator lastPlayAni = ((RogueCardGameMain)obj).lastPlayAni;
			ToLua.Push(L, lastPlayAni);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playNumFly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject playNumFly = ((RogueCardGameMain)obj).playNumFly;
			ToLua.PushSealed(L, playNumFly);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playNumFly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastPlayFlyText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text lastPlayFlyText = ((RogueCardGameMain)obj).lastPlayFlyText;
			ToLua.Push(L, lastPlayFlyText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayFlyText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastPlayFlyText2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text lastPlayFlyText = ((RogueCardGameMain)obj).lastPlayFlyText2;
			ToLua.Push(L, lastPlayFlyText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayFlyText2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastDiscardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text lastDiscardNum = ((RogueCardGameMain)obj).lastDiscardNum;
			ToLua.Push(L, lastDiscardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastDiscardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastDiscardAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator lastDiscardAni = ((RogueCardGameMain)obj).lastDiscardAni;
			ToLua.Push(L, lastDiscardAni);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastDiscardAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_discardNumFly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject discardNumFly = ((RogueCardGameMain)obj).discardNumFly;
			ToLua.PushSealed(L, discardNumFly);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discardNumFly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastDiscardFlyText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text lastDiscardFlyText = ((RogueCardGameMain)obj).lastDiscardFlyText;
			ToLua.Push(L, lastDiscardFlyText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastDiscardFlyText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastDiscardFlyText2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text lastDiscardFlyText = ((RogueCardGameMain)obj).lastDiscardFlyText2;
			ToLua.Push(L, lastDiscardFlyText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastDiscardFlyText2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator goldAni = ((RogueCardGameMain)obj).goldAni;
			ToLua.Push(L, goldAni);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldNumFly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject goldNumFly = ((RogueCardGameMain)obj).goldNumFly;
			ToLua.PushSealed(L, goldNumFly);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldNumFly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldFlyText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text goldFlyText = ((RogueCardGameMain)obj).goldFlyText;
			ToLua.Push(L, goldFlyText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldFlyText2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text goldFlyText = ((RogueCardGameMain)obj).goldFlyText2;
			ToLua.Push(L, goldFlyText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyText2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber goldNum = ((RogueCardGameMain)obj).goldNum;
			ToLua.Push(L, goldNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deckInfo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text deckInfo = ((RogueCardGameMain)obj).deckInfo;
			ToLua.Push(L, deckInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deckInfo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text jokerNum = ((RogueCardGameMain)obj).jokerNum;
			ToLua.Push(L, jokerNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerNumAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator jokerNumAni = ((RogueCardGameMain)obj).jokerNumAni;
			ToLua.Push(L, jokerNumAni);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerNumAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text wealNum = ((RogueCardGameMain)obj).wealNum;
			ToLua.Push(L, wealNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_woeDesc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text woeDesc = ((RogueCardGameMain)obj).woeDesc;
			ToLua.Push(L, woeDesc);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeDesc on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerSortBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button jokerSortBtn = ((RogueCardGameMain)obj).jokerSortBtn;
			ToLua.Push(L, jokerSortBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSortBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_controllerEx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerExCollection controllerEx = ((RogueCardGameMain)obj).controllerEx;
			ToLua.Push(L, controllerEx);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index controllerEx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerSlotEx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerExCollection jokerSlotEx = ((RogueCardGameMain)obj).jokerSlotEx;
			ToLua.Push(L, jokerSlotEx);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSlotEx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playContentGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject playContentGo = ((RogueCardGameMain)obj).playContentGo;
			ToLua.PushSealed(L, playContentGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playContentGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_storyContentGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject storyContentGo = ((RogueCardGameMain)obj).storyContentGo;
			ToLua.PushSealed(L, storyContentGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyContentGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playContentBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button playContentBtn = ((RogueCardGameMain)obj).playContentBtn;
			ToLua.Push(L, playContentBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playContentBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_storyContentBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button storyContentBtn = ((RogueCardGameMain)obj).storyContentBtn;
			ToLua.Push(L, storyContentBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyContentBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_commonTip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardCommonTipItem commonTip = ((RogueCardGameMain)obj).commonTip;
			ToLua.Push(L, commonTip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index commonTip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerTipTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform jokerTipTrans = ((RogueCardGameMain)obj).jokerTipTrans;
			ToLua.Push(L, jokerTipTrans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerTipTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cardTipTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform cardTipTrans = ((RogueCardGameMain)obj).cardTipTrans;
			ToLua.Push(L, cardTipTrans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardTipTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_battleInfoBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button battleInfoBtn = ((RogueCardGameMain)obj).battleInfoBtn;
			ToLua.Push(L, battleInfoBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battleInfoBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_woeTipGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject woeTipGo = ((RogueCardGameMain)obj).woeTipGo;
			ToLua.PushSealed(L, woeTipGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeTipGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_woeTipAnimator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator woeTipAnimator = ((RogueCardGameMain)obj).woeTipAnimator;
			ToLua.Push(L, woeTipAnimator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeTipAnimator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_woeTipText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text woeTipText = ((RogueCardGameMain)obj).woeTipText;
			ToLua.Push(L, woeTipText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeTipText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealNumText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text wealNumText = ((RogueCardGameMain)obj).wealNumText;
			ToLua.Push(L, wealNumText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealNumText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button wealTipBtn = ((RogueCardGameMain)obj).wealTipBtn;
			ToLua.Push(L, wealTipBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealTipGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject wealTipGo = ((RogueCardGameMain)obj).wealTipGo;
			ToLua.PushSealed(L, wealTipGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTipGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealTipContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform wealTipContent = ((RogueCardGameMain)obj).wealTipContent;
			ToLua.Push(L, wealTipContent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTipContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealTipItem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject wealTipItem = ((RogueCardGameMain)obj).wealTipItem;
			ToLua.PushSealed(L, wealTipItem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTipItem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealTextList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Text> wealTextList = ((RogueCardGameMain)obj).wealTextList;
			ToLua.PushSealed(L, wealTextList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTextList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealGoList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GameObject> wealGoList = ((RogueCardGameMain)obj).wealGoList;
			ToLua.PushSealed(L, wealGoList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealGoList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerSellTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform jokerSellTrans = ((RogueCardGameMain)obj).jokerSellTrans;
			ToLua.PushSealed(L, jokerSellTrans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerSellEx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerExCollection jokerSellEx = ((RogueCardGameMain)obj).jokerSellEx;
			ToLua.Push(L, jokerSellEx);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellEx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerSellText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text jokerSellText = ((RogueCardGameMain)obj).jokerSellText;
			ToLua.Push(L, jokerSellText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerSellStateCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx jokerSellStateCon = ((RogueCardGameMain)obj).jokerSellStateCon;
			ToLua.PushObject(L, jokerSellStateCon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellStateCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerSlotCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx jokerSlotCon = ((RogueCardGameMain)obj).jokerSlotCon;
			ToLua.PushObject(L, jokerSlotCon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSlotCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bgCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx bgCon = ((RogueCardGameMain)obj).bgCon;
			ToLua.PushObject(L, bgCon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bgCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerSellCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx jokerSellCon = ((RogueCardGameMain)obj).jokerSellCon;
			ToLua.PushObject(L, jokerSellCon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resultCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx resultCon = ((RogueCardGameMain)obj).resultCon;
			ToLua.PushObject(L, resultCon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resultTipCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx resultTipCon = ((RogueCardGameMain)obj).resultTipCon;
			ToLua.PushObject(L, resultTipCon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultTipCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isWuChangComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isWuChangComplete = ((RogueCardGameMain)obj).isWuChangComplete;
			LuaDLL.lua_pushboolean(L, isWuChangComplete);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isWuChangComplete on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isWuChangCopyAnimating(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isWuChangCopyAnimating = ((RogueCardGameMain)obj).isWuChangCopyAnimating;
			LuaDLL.lua_pushboolean(L, isWuChangCopyAnimating);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isWuChangCopyAnimating on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_suppressRoundStartForceSelectRefresh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool suppressRoundStartForceSelectRefresh = ((RogueCardGameMain)obj).suppressRoundStartForceSelectRefresh;
			LuaDLL.lua_pushboolean(L, suppressRoundStartForceSelectRefresh);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suppressRoundStartForceSelectRefresh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CardDrawDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float cardDrawDuration = ((RogueCardGameMain)obj).CardDrawDuration;
			LuaDLL.lua_pushnumber(L, cardDrawDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardDrawDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CalScoreDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float calScoreDuration = ((RogueCardGameMain)obj).CalScoreDuration;
			LuaDLL.lua_pushnumber(L, calScoreDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CalScoreDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isAniSpeedUp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAniSpeedUp = ((RogueCardGameMain)obj).isAniSpeedUp;
			LuaDLL.lua_pushboolean(L, isAniSpeedUp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAniSpeedUp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPlayingAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPlayingAni = ((RogueCardGameMain)obj).isPlayingAni;
			LuaDLL.lua_pushboolean(L, isPlayingAni);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPlayingAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isShowingScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isShowingScore = ((RogueCardGameMain)obj).isShowingScore;
			LuaDLL.lua_pushboolean(L, isShowingScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isShowingScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wuChangPackageCardHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardVisualCardHandler wuChangPackageCardHandler = ((RogueCardGameMain)obj).wuChangPackageCardHandler;
			ToLua.Push(L, wuChangPackageCardHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangPackageCardHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wuChangCardHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardVisualCardHandler wuChangCardHandler = ((RogueCardGameMain)obj).wuChangCardHandler;
			ToLua.Push(L, wuChangCardHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangCardHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokerCardHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardVisualCardHandler jokerCardHandler = ((RogueCardGameMain)obj).jokerCardHandler;
			ToLua.Push(L, jokerCardHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerCardHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handCardHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardVisualCardHandler handCardHandler = ((RogueCardGameMain)obj).handCardHandler;
			ToLua.Push(L, handCardHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handCardHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_backgroundBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button backgroundBtn = ((RogueCardGameMain)obj).backgroundBtn;
			ToLua.Push(L, backgroundBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index backgroundBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_movieContentTrs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform movieContentTrs = ((RogueCardGameMain)obj).movieContentTrs;
			ToLua.Push(L, movieContentTrs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movieContentTrs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_movieTip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject movieTip = ((RogueCardGameMain)obj).movieTip;
			ToLua.PushSealed(L, movieTip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movieTip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_movieBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button movieBtn = ((RogueCardGameMain)obj).movieBtn;
			ToLua.Push(L, movieBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movieBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardCommonTipButton goldCommonTipBtn = ((RogueCardGameMain)obj).goldCommonTipBtn;
			ToLua.Push(L, goldCommonTipBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cardCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardCommonTipButton cardCommonTipBtn = ((RogueCardGameMain)obj).cardCommonTipBtn;
			ToLua.Push(L, cardCommonTipBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_woeCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardCommonTipButton woeCommonTipBtn = ((RogueCardGameMain)obj).woeCommonTipBtn;
			ToLua.Push(L, woeCommonTipBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_woeCommonTipBtn2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardCommonTipButton woeCommonTipBtn = ((RogueCardGameMain)obj).woeCommonTipBtn2;
			ToLua.Push(L, woeCommonTipBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeCommonTipBtn2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardCommonTipButton wealCommonTipBtn = ((RogueCardGameMain)obj).wealCommonTipBtn;
			ToLua.Push(L, wealCommonTipBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scoreCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardCommonTipButton scoreCommonTipBtn = ((RogueCardGameMain)obj).scoreCommonTipBtn;
			ToLua.Push(L, scoreCommonTipBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scoreCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_commonTipTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform[] commonTipTrans = ((RogueCardGameMain)obj).commonTipTrans;
			ToLua.Push(L, commonTipTrans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index commonTipTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_storyMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool storyMode = ((RogueCardGameMain)obj).storyMode;
			LuaDLL.lua_pushboolean(L, storyMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainTitle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text mainTitle = ((RogueCardGameMain)obj).mainTitle;
			ToLua.Push(L, mainTitle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTitle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clueTitle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text clueTitle = ((RogueCardGameMain)obj).clueTitle;
			ToLua.Push(L, clueTitle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clueTitle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deckOutPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform deckOutPoint = ((RogueCardGameMain)obj).deckOutPoint;
			ToLua.Push(L, deckOutPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deckOutPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deckTransPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform deckTransPoint = ((RogueCardGameMain)obj).deckTransPoint;
			ToLua.Push(L, deckTransPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deckTransPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cardEndPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform cardEndPoint = ((RogueCardGameMain)obj).cardEndPoint;
			ToLua.Push(L, cardEndPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardEndPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cardScorePoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform[] cardScorePoint = ((RogueCardGameMain)obj).cardScorePoint;
			ToLua.Push(L, cardScorePoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardScorePoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldFlyStartPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform goldFlyStartPoint = ((RogueCardGameMain)obj).goldFlyStartPoint;
			ToLua.Push(L, goldFlyStartPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyStartPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldFlyEndPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform goldFlyEndPoint = ((RogueCardGameMain)obj).goldFlyEndPoint;
			ToLua.Push(L, goldFlyEndPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyEndPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goldFlyGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject goldFlyGo = ((RogueCardGameMain)obj).goldFlyGo;
			ToLua.PushSealed(L, goldFlyGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cardVisualPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject cardVisualPrefab = ((RogueCardGameMain)obj).cardVisualPrefab;
			ToLua.PushSealed(L, cardVisualPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardVisualPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deckImg(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image deckImg = ((RogueCardGameMain)obj).deckImg;
			ToLua.Push(L, deckImg);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deckImg on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_score_maxRoundScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> score_maxRoundScore = ((RogueCardGameMain)obj).score_maxRoundScore;
			ToLua.PushSealed(L, score_maxRoundScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score_maxRoundScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_score_diffScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<float> score_diffScore = ((RogueCardGameMain)obj).score_diffScore;
			ToLua.PushSealed(L, score_diffScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score_diffScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_score_ratio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float score_ratio = ((RogueCardGameMain)obj).score_ratio;
			LuaDLL.lua_pushnumber(L, score_ratio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score_ratio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_challenge_target_score_ratio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float challenge_target_score_ratio = ((RogueCardGameMain)obj).challenge_target_score_ratio;
			LuaDLL.lua_pushnumber(L, challenge_target_score_ratio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challenge_target_score_ratio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_max_round_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int max_round_score = ((RogueCardGameMain)obj).max_round_score;
			LuaDLL.lua_pushinteger(L, max_round_score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index max_round_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rollBackMaxNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rollBackMaxNum = ((RogueCardGameMain)obj).rollBackMaxNum;
			LuaDLL.lua_pushinteger(L, rollBackMaxNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rollBackMaxNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rollBackGainGold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rollBackGainGold = ((RogueCardGameMain)obj).rollBackGainGold;
			LuaDLL.lua_pushinteger(L, rollBackGainGold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rollBackGainGold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceWindowGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject enhanceWindowGo = ((RogueCardGameMain)obj).enhanceWindowGo;
			ToLua.PushSealed(L, enhanceWindowGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceWindowYesBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button enhanceWindowYesBtn = ((RogueCardGameMain)obj).enhanceWindowYesBtn;
			ToLua.Push(L, enhanceWindowYesBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowYesBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceWindowNoBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button enhanceWindowNoBtn = ((RogueCardGameMain)obj).enhanceWindowNoBtn;
			ToLua.Push(L, enhanceWindowNoBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowNoBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceWindowRepeatBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button enhanceWindowRepeatBtn = ((RogueCardGameMain)obj).enhanceWindowRepeatBtn;
			ToLua.Push(L, enhanceWindowRepeatBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowRepeatBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceWindowRepeatYesGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject enhanceWindowRepeatYesGo = ((RogueCardGameMain)obj).enhanceWindowRepeatYesGo;
			ToLua.PushSealed(L, enhanceWindowRepeatYesGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowRepeatYesGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceWindowRepeatNoGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject enhanceWindowRepeatNoGo = ((RogueCardGameMain)obj).enhanceWindowRepeatNoGo;
			ToLua.PushSealed(L, enhanceWindowRepeatNoGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowRepeatNoGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceWindowText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text enhanceWindowText = ((RogueCardGameMain)obj).enhanceWindowText;
			ToLua.Push(L, enhanceWindowText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_notScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool notScore = ((RogueCardGameMain)obj).notScore;
			LuaDLL.lua_pushboolean(L, notScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index notScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NoWuChangMovie(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool noWuChangMovie = ((RogueCardGameMain)obj).NoWuChangMovie;
			LuaDLL.lua_pushboolean(L, noWuChangMovie);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index NoWuChangMovie on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gmStr(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string gmStr = ((RogueCardGameMain)obj).gmStr;
			LuaDLL.lua_pushstring(L, gmStr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gmStr on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RogueCardGameMain.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GameContext(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, RogueCardGameMain.GameContext);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Random(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, RogueCardGameMain.Random);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CurState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IState curState = ((RogueCardGameMain)obj).CurState;
			ToLua.PushObject(L, curState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CurState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isHandle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isHandle = ((RogueCardGameMain)obj).isHandle;
			LuaDLL.lua_pushboolean(L, isHandle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isHandle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ActiveSettle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool activeSettle = ((RogueCardGameMain)obj).ActiveSettle;
			LuaDLL.lua_pushboolean(L, activeSettle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ActiveSettle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsSettleAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSettleAni = ((RogueCardGameMain)obj).IsSettleAni;
			LuaDLL.lua_pushboolean(L, isSettleAni);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsSettleAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_randomSystem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			DeterministicRandom randomSystem = (DeterministicRandom)ToLua.CheckObject<DeterministicRandom>(L, 2);
			obj2.randomSystem = randomSystem;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index randomSystem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_saveSystem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardSaveSystem saveSystem = (RogueCardSaveSystem)ToLua.CheckObject<RogueCardSaveSystem>(L, 2);
			obj2.saveSystem = saveSystem;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index saveSystem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_guideSystem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardGuideSystem guideSystem = (RogueCardGuideSystem)ToLua.CheckObject<RogueCardGuideSystem>(L, 2);
			obj2.guideSystem = guideSystem;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guideSystem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerHolder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueJokerHolder jokerHolder = (RogueJokerHolder)ToLua.CheckObject<RogueJokerHolder>(L, 2);
			obj2.jokerHolder = jokerHolder;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerHolder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_copyToDeckQueue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			List<Tuple<RogueCardData, RogueCardData>> copyToDeckQueue = (List<Tuple<RogueCardData, RogueCardData>>)ToLua.CheckObject(L, 2, typeof(List<Tuple<RogueCardData, RogueCardData>>));
			obj2.copyToDeckQueue = copyToDeckQueue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index copyToDeckQueue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_copyToHandQueue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			List<Tuple<RogueCardData, RogueCardData>> copyToHandQueue = (List<Tuple<RogueCardData, RogueCardData>>)ToLua.CheckObject(L, 2, typeof(List<Tuple<RogueCardData, RogueCardData>>));
			obj2.copyToHandQueue = copyToHandQueue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index copyToHandQueue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_copyDestToJokerMap(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Dictionary<RogueCardData, RogueCardJokerData> copyDestToJokerMap = (Dictionary<RogueCardData, RogueCardJokerData>)ToLua.CheckObject(L, 2, typeof(Dictionary<RogueCardData, RogueCardJokerData>));
			obj2.copyDestToJokerMap = copyDestToJokerMap;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index copyDestToJokerMap on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tempCopiedCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			List<RogueCardData> tempCopiedCards = (List<RogueCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardData>));
			obj2.tempCopiedCards = tempCopiedCards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tempCopiedCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gameContext(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardGameContext gameContext = (RogueCardGameContext)ToLua.CheckObject<RogueCardGameContext>(L, 2);
			obj2.gameContext = gameContext;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gameContext on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curPackageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
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
	private static int set_playerHandle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			int playerHandle = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.playerHandle = playerHandle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerHandle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curStateUI(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardStateUIBase curStateUI = (RogueCardStateUIBase)ToLua.CheckObject<RogueCardStateUIBase>(L, 2);
			obj2.curStateUI = curStateUI;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curStateUI on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_storyContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform storyContent = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.storyContent = storyContent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_storyUI(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardStoryBaseUI storyUI = (RogueCardStoryBaseUI)ToLua.CheckObject<RogueCardStoryBaseUI>(L, 2);
			obj2.storyUI = storyUI;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyUI on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stateUIList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			List<RogueCardStateUIBase> stateUIList = (List<RogueCardStateUIBase>)ToLua.CheckObject(L, 2, typeof(List<RogueCardStateUIBase>));
			obj2.stateUIList = stateUIList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stateUIList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mainAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Animator mainAni = (Animator)ToLua.CheckObject<Animator>(L, 2);
			obj2.mainAni = mainAni;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_storyResultGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject storyResultGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.storyResultGo = storyResultGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyResultGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_storyResultText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text storyResultText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.storyResultText = storyResultText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyResultText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_suitLvUpGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject suitLvUpGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.suitLvUpGo = suitLvUpGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suitLvUpGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_suitLvUpText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text suitLvUpText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.suitLvUpText = suitLvUpText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suitLvUpText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text targetScore = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.targetScore = targetScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RollingNumber curScore = (RollingNumber)ToLua.CheckObject<RollingNumber>(L, 2);
			obj2.curScore = curScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_infScoreText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject infScoreText = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.infScoreText = infScoreText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index infScoreText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastPlayNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text lastPlayNum = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.lastPlayNum = lastPlayNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastPlayAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Animator lastPlayAni = (Animator)ToLua.CheckObject<Animator>(L, 2);
			obj2.lastPlayAni = lastPlayAni;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playNumFly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject playNumFly = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.playNumFly = playNumFly;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playNumFly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastPlayFlyText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text lastPlayFlyText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.lastPlayFlyText = lastPlayFlyText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayFlyText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastPlayFlyText2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text lastPlayFlyText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.lastPlayFlyText2 = lastPlayFlyText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayFlyText2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastDiscardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text lastDiscardNum = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.lastDiscardNum = lastDiscardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastDiscardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastDiscardAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Animator lastDiscardAni = (Animator)ToLua.CheckObject<Animator>(L, 2);
			obj2.lastDiscardAni = lastDiscardAni;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastDiscardAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_discardNumFly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject discardNumFly = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.discardNumFly = discardNumFly;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discardNumFly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastDiscardFlyText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text lastDiscardFlyText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.lastDiscardFlyText = lastDiscardFlyText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastDiscardFlyText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastDiscardFlyText2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text lastDiscardFlyText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.lastDiscardFlyText2 = lastDiscardFlyText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastDiscardFlyText2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Animator goldAni = (Animator)ToLua.CheckObject<Animator>(L, 2);
			obj2.goldAni = goldAni;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldNumFly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject goldNumFly = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.goldNumFly = goldNumFly;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldNumFly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldFlyText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text goldFlyText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.goldFlyText = goldFlyText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldFlyText2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text goldFlyText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.goldFlyText2 = goldFlyText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyText2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RollingNumber goldNum = (RollingNumber)ToLua.CheckObject<RollingNumber>(L, 2);
			obj2.goldNum = goldNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deckInfo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text deckInfo = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.deckInfo = deckInfo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deckInfo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text jokerNum = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.jokerNum = jokerNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerNumAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Animator jokerNumAni = (Animator)ToLua.CheckObject<Animator>(L, 2);
			obj2.jokerNumAni = jokerNumAni;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerNumAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text wealNum = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.wealNum = wealNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_woeDesc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text woeDesc = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.woeDesc = woeDesc;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeDesc on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerSortBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button jokerSortBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.jokerSortBtn = jokerSortBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSortBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_controllerEx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerExCollection controllerEx = (ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 2);
			obj2.controllerEx = controllerEx;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index controllerEx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerSlotEx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerExCollection jokerSlotEx = (ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 2);
			obj2.jokerSlotEx = jokerSlotEx;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSlotEx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playContentGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject playContentGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.playContentGo = playContentGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playContentGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_storyContentGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject storyContentGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.storyContentGo = storyContentGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyContentGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playContentBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button playContentBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.playContentBtn = playContentBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playContentBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_storyContentBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button storyContentBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.storyContentBtn = storyContentBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyContentBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_commonTip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardCommonTipItem commonTip = (RogueCardCommonTipItem)ToLua.CheckObject<RogueCardCommonTipItem>(L, 2);
			obj2.commonTip = commonTip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index commonTip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerTipTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform jokerTipTrans = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.jokerTipTrans = jokerTipTrans;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerTipTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cardTipTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform cardTipTrans = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.cardTipTrans = cardTipTrans;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardTipTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_battleInfoBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button battleInfoBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.battleInfoBtn = battleInfoBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battleInfoBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_woeTipGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject woeTipGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.woeTipGo = woeTipGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeTipGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_woeTipAnimator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Animator woeTipAnimator = (Animator)ToLua.CheckObject<Animator>(L, 2);
			obj2.woeTipAnimator = woeTipAnimator;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeTipAnimator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_woeTipText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text woeTipText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.woeTipText = woeTipText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeTipText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealNumText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text wealNumText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.wealNumText = wealNumText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealNumText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button wealTipBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.wealTipBtn = wealTipBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealTipGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject wealTipGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.wealTipGo = wealTipGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTipGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealTipContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform wealTipContent = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.wealTipContent = wealTipContent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTipContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealTipItem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject wealTipItem = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.wealTipItem = wealTipItem;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTipItem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealTextList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			List<Text> wealTextList = (List<Text>)ToLua.CheckObject(L, 2, typeof(List<Text>));
			obj2.wealTextList = wealTextList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealTextList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealGoList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			List<GameObject> wealGoList = (List<GameObject>)ToLua.CheckObject(L, 2, typeof(List<GameObject>));
			obj2.wealGoList = wealGoList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealGoList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerSellTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RectTransform jokerSellTrans = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.jokerSellTrans = jokerSellTrans;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerSellEx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerExCollection jokerSellEx = (ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 2);
			obj2.jokerSellEx = jokerSellEx;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellEx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerSellText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text jokerSellText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.jokerSellText = jokerSellText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerSellStateCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerEx jokerSellStateCon = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.jokerSellStateCon = jokerSellStateCon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellStateCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerSlotCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerEx jokerSlotCon = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.jokerSlotCon = jokerSlotCon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSlotCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bgCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerEx bgCon = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.bgCon = bgCon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bgCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerSellCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerEx jokerSellCon = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.jokerSellCon = jokerSellCon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerSellCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resultCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerEx resultCon = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.resultCon = resultCon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resultTipCon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			ControllerEx resultTipCon = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.resultTipCon = resultTipCon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultTipCon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isWuChangComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool isWuChangComplete = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isWuChangComplete = isWuChangComplete;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isWuChangComplete on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isWuChangCopyAnimating(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool isWuChangCopyAnimating = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isWuChangCopyAnimating = isWuChangCopyAnimating;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isWuChangCopyAnimating on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_suppressRoundStartForceSelectRefresh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool suppressRoundStartForceSelectRefresh = LuaDLL.luaL_checkboolean(L, 2);
			obj2.suppressRoundStartForceSelectRefresh = suppressRoundStartForceSelectRefresh;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suppressRoundStartForceSelectRefresh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CardDrawDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			float cardDrawDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.CardDrawDuration = cardDrawDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardDrawDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CalScoreDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			float calScoreDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.CalScoreDuration = calScoreDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CalScoreDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isAniSpeedUp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool isAniSpeedUp = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isAniSpeedUp = isAniSpeedUp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAniSpeedUp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isPlayingAni(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool isPlayingAni = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isPlayingAni = isPlayingAni;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPlayingAni on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isShowingScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool isShowingScore = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isShowingScore = isShowingScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isShowingScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wuChangPackageCardHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardVisualCardHandler wuChangPackageCardHandler = (RogueCardVisualCardHandler)ToLua.CheckObject<RogueCardVisualCardHandler>(L, 2);
			obj2.wuChangPackageCardHandler = wuChangPackageCardHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangPackageCardHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wuChangCardHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardVisualCardHandler wuChangCardHandler = (RogueCardVisualCardHandler)ToLua.CheckObject<RogueCardVisualCardHandler>(L, 2);
			obj2.wuChangCardHandler = wuChangCardHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wuChangCardHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokerCardHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardVisualCardHandler jokerCardHandler = (RogueCardVisualCardHandler)ToLua.CheckObject<RogueCardVisualCardHandler>(L, 2);
			obj2.jokerCardHandler = jokerCardHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokerCardHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handCardHandler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardVisualCardHandler handCardHandler = (RogueCardVisualCardHandler)ToLua.CheckObject<RogueCardVisualCardHandler>(L, 2);
			obj2.handCardHandler = handCardHandler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handCardHandler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_backgroundBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button backgroundBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.backgroundBtn = backgroundBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index backgroundBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_movieContentTrs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform movieContentTrs = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.movieContentTrs = movieContentTrs;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movieContentTrs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_movieTip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject movieTip = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.movieTip = movieTip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movieTip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_movieBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button movieBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.movieBtn = movieBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movieBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardCommonTipButton goldCommonTipBtn = (RogueCardCommonTipButton)ToLua.CheckObject<RogueCardCommonTipButton>(L, 2);
			obj2.goldCommonTipBtn = goldCommonTipBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cardCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardCommonTipButton cardCommonTipBtn = (RogueCardCommonTipButton)ToLua.CheckObject<RogueCardCommonTipButton>(L, 2);
			obj2.cardCommonTipBtn = cardCommonTipBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_woeCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardCommonTipButton woeCommonTipBtn = (RogueCardCommonTipButton)ToLua.CheckObject<RogueCardCommonTipButton>(L, 2);
			obj2.woeCommonTipBtn = woeCommonTipBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_woeCommonTipBtn2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardCommonTipButton woeCommonTipBtn = (RogueCardCommonTipButton)ToLua.CheckObject<RogueCardCommonTipButton>(L, 2);
			obj2.woeCommonTipBtn2 = woeCommonTipBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woeCommonTipBtn2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardCommonTipButton wealCommonTipBtn = (RogueCardCommonTipButton)ToLua.CheckObject<RogueCardCommonTipButton>(L, 2);
			obj2.wealCommonTipBtn = wealCommonTipBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scoreCommonTipBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			RogueCardCommonTipButton scoreCommonTipBtn = (RogueCardCommonTipButton)ToLua.CheckObject<RogueCardCommonTipButton>(L, 2);
			obj2.scoreCommonTipBtn = scoreCommonTipBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scoreCommonTipBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_commonTipTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform[] commonTipTrans = ToLua.CheckObjectArray<Transform>(L, 2);
			obj2.commonTipTrans = commonTipTrans;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index commonTipTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_storyMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool storyMode = LuaDLL.luaL_checkboolean(L, 2);
			obj2.storyMode = storyMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index storyMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mainTitle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text mainTitle = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.mainTitle = mainTitle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTitle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clueTitle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text clueTitle = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.clueTitle = clueTitle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clueTitle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deckOutPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform deckOutPoint = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.deckOutPoint = deckOutPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deckOutPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deckTransPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform deckTransPoint = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.deckTransPoint = deckTransPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deckTransPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cardEndPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform cardEndPoint = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.cardEndPoint = cardEndPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardEndPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cardScorePoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform[] cardScorePoint = ToLua.CheckObjectArray<Transform>(L, 2);
			obj2.cardScorePoint = cardScorePoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardScorePoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldFlyStartPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform goldFlyStartPoint = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.goldFlyStartPoint = goldFlyStartPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyStartPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldFlyEndPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Transform goldFlyEndPoint = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.goldFlyEndPoint = goldFlyEndPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyEndPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goldFlyGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject goldFlyGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.goldFlyGo = goldFlyGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goldFlyGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cardVisualPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject cardVisualPrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.cardVisualPrefab = cardVisualPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cardVisualPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deckImg(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Image deckImg = (Image)ToLua.CheckObject<Image>(L, 2);
			obj2.deckImg = deckImg;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deckImg on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_score_maxRoundScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			List<int> score_maxRoundScore = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.score_maxRoundScore = score_maxRoundScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score_maxRoundScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_score_diffScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			List<float> score_diffScore = (List<float>)ToLua.CheckObject(L, 2, typeof(List<float>));
			obj2.score_diffScore = score_diffScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score_diffScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_score_ratio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			float score_ratio = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.score_ratio = score_ratio;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score_ratio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_challenge_target_score_ratio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			float challenge_target_score_ratio = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.challenge_target_score_ratio = challenge_target_score_ratio;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challenge_target_score_ratio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_max_round_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			int max_round_score = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.max_round_score = max_round_score;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index max_round_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rollBackMaxNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			int rollBackMaxNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.rollBackMaxNum = rollBackMaxNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rollBackMaxNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rollBackGainGold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			int rollBackGainGold = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.rollBackGainGold = rollBackGainGold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rollBackGainGold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceWindowGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject enhanceWindowGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.enhanceWindowGo = enhanceWindowGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceWindowYesBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button enhanceWindowYesBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.enhanceWindowYesBtn = enhanceWindowYesBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowYesBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceWindowNoBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button enhanceWindowNoBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.enhanceWindowNoBtn = enhanceWindowNoBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowNoBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceWindowRepeatBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Button enhanceWindowRepeatBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.enhanceWindowRepeatBtn = enhanceWindowRepeatBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowRepeatBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceWindowRepeatYesGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject enhanceWindowRepeatYesGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.enhanceWindowRepeatYesGo = enhanceWindowRepeatYesGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowRepeatYesGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceWindowRepeatNoGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			GameObject enhanceWindowRepeatNoGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.enhanceWindowRepeatNoGo = enhanceWindowRepeatNoGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowRepeatNoGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceWindowText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			Text enhanceWindowText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.enhanceWindowText = enhanceWindowText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceWindowText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_notScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool notScore = LuaDLL.luaL_checkboolean(L, 2);
			obj2.notScore = notScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index notScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_NoWuChangMovie(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool noWuChangMovie = LuaDLL.luaL_checkboolean(L, 2);
			obj2.NoWuChangMovie = noWuChangMovie;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index NoWuChangMovie on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gmStr(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			string gmStr = ToLua.CheckString(L, 2);
			obj2.gmStr = gmStr;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gmStr on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isHandle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardGameMain obj2 = (RogueCardGameMain)obj;
			bool isHandle = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isHandle = isHandle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isHandle on a nil value");
		}
	}
}
