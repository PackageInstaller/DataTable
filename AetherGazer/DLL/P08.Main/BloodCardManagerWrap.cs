using System;
using System.Collections.Generic;
using ControllerExSpace;
using LuaInterface;
using P08.Quiz;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class BloodCardManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BloodCardManager), typeof(MonoSingleton<BloodCardManager>));
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("DetermineOrder", DetermineOrder);
		L.RegFunction("DrawInitialHand", DrawInitialHand);
		L.RegFunction("ShuffleHand", ShuffleHand);
		L.RegFunction("DecideSuffer", DecideSuffer);
		L.RegFunction("ReciveSufferResult", ReciveSufferResult);
		L.RegFunction("ReciveEenmySufferHand", ReciveEenmySufferHand);
		L.RegFunction("ReciveRoundStart", ReciveRoundStart);
		L.RegFunction("StartPlayerRound", StartPlayerRound);
		L.RegFunction("ReciveDrawCardResult", ReciveDrawCardResult);
		L.RegFunction("RecevieEndRoundResult", RecevieEndRoundResult);
		L.RegFunction("StartEnemyRound", StartEnemyRound);
		L.RegFunction("ReciveEnemyDrawCard", ReciveEnemyDrawCard);
		L.RegFunction("ReciveEnemyPlaceCard", ReciveEnemyPlaceCard);
		L.RegFunction("RecivePlaceCardResult", RecivePlaceCardResult);
		L.RegFunction("MidPause", MidPause);
		L.RegFunction("ReciveEndGame", ReciveEndGame);
		L.RegFunction("ResetGame", ResetGame);
		L.RegFunction("TransitionToNextState", TransitionToNextState);
		L.RegFunction("TransitionToNextStateFunc", TransitionToNextStateFunc);
		L.RegFunction("SetBtnFunc", SetBtnFunc);
		L.RegFunction("MoveCardToList", MoveCardToList);
		L.RegFunction("GetCardItem", GetCardItem);
		L.RegFunction("GetCurrentStatus", GetCurrentStatus);
		L.RegFunction("CheckCell", CheckCell);
		L.RegFunction("LockCell", LockCell);
		L.RegFunction("LockCardLisener", LockCardLisener);
		L.RegFunction("LockHandCard", LockHandCard);
		L.RegFunction("SendStarGame", SendStarGame);
		L.RegFunction("SendSufferCard", SendSufferCard);
		L.RegFunction("SendDrawCard", SendDrawCard);
		L.RegFunction("SendPlaceCard", SendPlaceCard);
		L.RegFunction("SendJumpRound", SendJumpRound);
		L.RegFunction("SendResetGame", SendResetGame);
		L.RegFunction("SendEndRound", SendEndRound);
		L.RegFunction("SendLuaMessage", SendLuaMessage);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("PlayerCardHand", get_PlayerCardHand, set_PlayerCardHand);
		L.RegVar("EnemyCardHand", get_EnemyCardHand, set_EnemyCardHand);
		L.RegVar("PlayerCardDeck", get_PlayerCardDeck, set_PlayerCardDeck);
		L.RegVar("EnemyCardDeck", get_EnemyCardDeck, set_EnemyCardDeck);
		L.RegVar("CardPoolDeck", get_CardPoolDeck, set_CardPoolDeck);
		L.RegVar("ChangeCardDeck", get_ChangeCardDeck, set_ChangeCardDeck);
		L.RegVar("ScreenAniRoot", get_ScreenAniRoot, set_ScreenAniRoot);
		L.RegVar("Board", get_Board, set_Board);
		L.RegVar("VisualCards", get_VisualCards, set_VisualCards);
		L.RegVar("slotPrefab", get_slotPrefab, set_slotPrefab);
		L.RegVar("turnGo", get_turnGo, set_turnGo);
		L.RegVar("buttonCancel", get_buttonCancel, set_buttonCancel);
		L.RegVar("buttonOk", get_buttonOk, set_buttonOk);
		L.RegVar("needChangeBtn", get_needChangeBtn, set_needChangeBtn);
		L.RegVar("resultMaskBtn", get_resultMaskBtn, set_resultMaskBtn);
		L.RegVar("resultYesBtn", get_resultYesBtn, set_resultYesBtn);
		L.RegVar("timeText", get_timeText, set_timeText);
		L.RegVar("ChangeSelectNumText", get_ChangeSelectNumText, set_ChangeSelectNumText);
		L.RegVar("firstPlayerScoreText", get_firstPlayerScoreText, set_firstPlayerScoreText);
		L.RegVar("lastPlayerScoreText", get_lastPlayerScoreText, set_lastPlayerScoreText);
		L.RegVar("controller", get_controller, set_controller);
		L.RegVar("resultController", get_resultController, set_resultController);
		L.RegVar("turnController", get_turnController, set_turnController);
		L.RegVar("curveLinePoint", get_curveLinePoint, set_curveLinePoint);
		L.RegVar("BezierOffset", get_BezierOffset, set_BezierOffset);
		L.RegVar("BezierTime", get_BezierTime, set_BezierTime);
		L.RegVar("stateController", get_stateController, set_stateController);
		L.RegVar("resultStateController", get_resultStateController, set_resultStateController);
		L.RegVar("turnStateController", get_turnStateController, set_turnStateController);
		L.RegVar("InitCardNum", get_InitCardNum, set_InitCardNum);
		L.RegVar("DealCardNum", get_DealCardNum, set_DealCardNum);
		L.RegVar("moveCardAniDuration", get_moveCardAniDuration, set_moveCardAniDuration);
		L.RegVar("stepMoveCardAniDuration", get_stepMoveCardAniDuration, set_stepMoveCardAniDuration);
		L.RegVar("groupIndex", get_groupIndex, set_groupIndex);
		L.RegVar("handCardIds", get_handCardIds, set_handCardIds);
		L.RegVar("startGameTimestamp", get_startGameTimestamp, set_startGameTimestamp);
		L.RegVar("drawCardTimestamp", get_drawCardTimestamp, set_drawCardTimestamp);
		L.RegVar("isPlayerFirst", get_isPlayerFirst, set_isPlayerFirst);
		L.RegVar("selfCantPutCard", get_selfCantPutCard, set_selfCantPutCard);
		L.RegVar("playerSufferAniDone", get_playerSufferAniDone, set_playerSufferAniDone);
		L.RegVar("playingEffectDone", get_playingEffectDone, set_playingEffectDone);
		L.RegVar("enemyPlaceOverlayCard", get_enemyPlaceOverlayCard, set_enemyPlaceOverlayCard);
		L.RegVar("isDrawCardDone", get_isDrawCardDone, set_isDrawCardDone);
		L.RegVar("isDealCardDone", get_isDealCardDone, set_isDealCardDone);
		L.RegVar("isAbandon", get_isAbandon, set_isAbandon);
		L.RegVar("sufferCardIndexs", get_sufferCardIndexs, set_sufferCardIndexs);
		L.RegVar("placingIndex", get_placingIndex, set_placingIndex);
		L.RegVar("guideIndex", get_guideIndex, set_guideIndex);
		L.RegVar("guideID", get_guideID, set_guideID);
		L.RegVar("stepID", get_stepID, set_stepID);
		L.RegVar("placingCard", get_placingCard, set_placingCard);
		L.RegVar("isMultiGame", get_isMultiGame, set_isMultiGame);
		L.RegVar("ObservationTime", get_ObservationTime, set_ObservationTime);
		L.RegVar("handCards", get_handCards, set_handCards);
		L.RegVar("enemyHandCards", get_enemyHandCards, set_enemyHandCards);
		L.RegVar("changeDeckCards", get_changeDeckCards, set_changeDeckCards);
		L.RegVar("RemainingSufferWatingTime", get_RemainingSufferWatingTime, set_RemainingSufferWatingTime);
		L.RegVar("PlayerRemainLeftTime", get_PlayerRemainLeftTime, set_PlayerRemainLeftTime);
		L.RegVar("PlayerBackupLeftTime", get_PlayerBackupLeftTime, set_PlayerBackupLeftTime);
		L.RegVar("CurrentStatus", get_CurrentStatus, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int order = (int)LuaDLL.luaL_checknumber(L, 2);
			int[] cardIDList = ToLua.CheckNumberArray<int>(L, 3);
			int[] selfLimitCardList = ToLua.CheckNumberArray<int>(L, 4);
			int[] enemyLimitCardList = ToLua.CheckNumberArray<int>(L, 5);
			obj.StartGame(order, cardIDList, selfLimitCardList, enemyLimitCardList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DetermineOrder(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).DetermineOrder();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DrawInitialHand(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).DrawInitialHand();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShuffleHand(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).ShuffleHand();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DecideSuffer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			bool need = LuaDLL.luaL_checkboolean(L, 2);
			obj.DecideSuffer(need);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReciveSufferResult(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int[] cardIDList = ToLua.CheckNumberArray<int>(L, 2);
			obj.ReciveSufferResult(cardIDList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReciveEenmySufferHand(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int sufferNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ReciveEenmySufferHand(sufferNum);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReciveRoundStart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int round = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ReciveRoundStart(round);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartPlayerRound(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).StartPlayerRound();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReciveDrawCardResult(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int[] cardIDList = ToLua.CheckNumberArray<int>(L, 2);
			obj.ReciveDrawCardResult(cardIDList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecevieEndRoundResult(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).RecevieEndRoundResult();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartEnemyRound(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).StartEnemyRound();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReciveEnemyDrawCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int round = (int)LuaDLL.luaL_checknumber(L, 2);
			int drawNum = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.ReciveEnemyDrawCard(round, drawNum);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReciveEnemyPlaceCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int round = (int)LuaDLL.luaL_checknumber(L, 2);
			int cardID = (int)LuaDLL.luaL_checknumber(L, 3);
			int index = (int)LuaDLL.luaL_checknumber(L, 4);
			LuaTable influenceList = ToLua.CheckLuaTable(L, 5);
			obj.ReciveEnemyPlaceCard(round, cardID, index, influenceList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecivePlaceCardResult(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				BloodCardManager obj2 = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				int result2 = (int)LuaDLL.luaL_checknumber(L, 2);
				LuaTable influenceList2 = ToLua.CheckLuaTable(L, 3);
				obj2.RecivePlaceCardResult(result2, influenceList2);
				return 0;
			}
			case 4:
			{
				BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				int result = (int)LuaDLL.luaL_checknumber(L, 2);
				LuaTable influenceList = ToLua.CheckLuaTable(L, 3);
				int useSeconds = (int)LuaDLL.luaL_checknumber(L, 4);
				obj.RecivePlaceCardResult(result, influenceList, useSeconds);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: BloodCardManager.RecivePlaceCardResult");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MidPause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).MidPause();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReciveEndGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int result = (int)LuaDLL.luaL_checknumber(L, 2);
			int firstPlayerScore = (int)LuaDLL.luaL_checknumber(L, 3);
			int lastPlayerScore = (int)LuaDLL.luaL_checknumber(L, 4);
			obj.ReciveEndGame(result, firstPlayerScore, lastPlayerScore);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).ResetGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TransitionToNextState(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				BloodCardManager obj2 = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				BloodCardEnum.GameStatus nextState2 = (BloodCardEnum.GameStatus)ToLua.CheckObject(L, 2, typeof(BloodCardEnum.GameStatus));
				obj2.TransitionToNextState(nextState2);
				return 0;
			}
			case 3:
			{
				BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				BloodCardEnum.GameStatus nextState = (BloodCardEnum.GameStatus)ToLua.CheckObject(L, 2, typeof(BloodCardEnum.GameStatus));
				float waitTime = (float)LuaDLL.luaL_checknumber(L, 3);
				obj.TransitionToNextState(nextState, waitTime);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: BloodCardManager.TransitionToNextState");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TransitionToNextStateFunc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			BloodCardEnum.GameStatus nextState = (BloodCardEnum.GameStatus)ToLua.CheckObject(L, 2, typeof(BloodCardEnum.GameStatus));
			obj.TransitionToNextStateFunc(nextState);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBtnFunc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				BloodCardManager obj3 = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				UnityAction okAction3 = (UnityAction)ToLua.CheckDelegate<UnityAction>(L, 2);
				UnityAction cancelAction3 = (UnityAction)ToLua.CheckDelegate<UnityAction>(L, 3);
				obj3.SetBtnFunc(okAction3, cancelAction3);
				return 0;
			}
			case 4:
			{
				BloodCardManager obj2 = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				UnityAction okAction2 = (UnityAction)ToLua.CheckDelegate<UnityAction>(L, 2);
				UnityAction cancelAction2 = (UnityAction)ToLua.CheckDelegate<UnityAction>(L, 3);
				string okText2 = ToLua.CheckString(L, 4);
				obj2.SetBtnFunc(okAction2, cancelAction2, okText2);
				return 0;
			}
			case 5:
			{
				BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				UnityAction okAction = (UnityAction)ToLua.CheckDelegate<UnityAction>(L, 2);
				UnityAction cancelAction = (UnityAction)ToLua.CheckDelegate<UnityAction>(L, 3);
				string okText = ToLua.CheckString(L, 4);
				string cancelText = ToLua.CheckString(L, 5);
				obj.SetBtnFunc(okAction, cancelAction, okText, cancelText);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: BloodCardManager.SetBtnFunc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveCardToList(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				BloodCardManager obj3 = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				CardHolder cardHolder3 = (CardHolder)ToLua.CheckObject<CardHolder>(L, 2);
				CardHolder to3 = (CardHolder)ToLua.CheckObject<CardHolder>(L, 3);
				Card card3 = (Card)ToLua.CheckObject<Card>(L, 4);
				bool immediately3 = LuaDLL.luaL_checkboolean(L, 5);
				obj3.MoveCardToList(cardHolder3, to3, card3, immediately3);
				return 0;
			}
			case 6:
			{
				BloodCardManager obj2 = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				CardHolder cardHolder2 = (CardHolder)ToLua.CheckObject<CardHolder>(L, 2);
				CardHolder to2 = (CardHolder)ToLua.CheckObject<CardHolder>(L, 3);
				Card card2 = (Card)ToLua.CheckObject<Card>(L, 4);
				bool immediately2 = LuaDLL.luaL_checkboolean(L, 5);
				bool updateImmediately2 = LuaDLL.luaL_checkboolean(L, 6);
				obj2.MoveCardToList(cardHolder2, to2, card2, immediately2, updateImmediately2);
				return 0;
			}
			case 7:
			{
				BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
				CardHolder cardHolder = (CardHolder)ToLua.CheckObject<CardHolder>(L, 2);
				CardHolder to = (CardHolder)ToLua.CheckObject<CardHolder>(L, 3);
				Card card = (Card)ToLua.CheckObject<Card>(L, 4);
				bool immediately = LuaDLL.luaL_checkboolean(L, 5);
				bool updateImmediately = LuaDLL.luaL_checkboolean(L, 6);
				bool needRefreshHandIDs = LuaDLL.luaL_checkboolean(L, 7);
				obj.MoveCardToList(cardHolder, to, card, immediately, updateImmediately, needRefreshHandIDs);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: BloodCardManager.MoveCardToList");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCardItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Card cardItem = ((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).GetCardItem();
			ToLua.Push(L, cardItem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentStatus(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int currentStatus = ((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).GetCurrentStatus();
			LuaDLL.lua_pushinteger(L, currentStatus);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckCell(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.CheckCell(index);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LockCell(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			bool locked = LuaDLL.luaL_checkboolean(L, 2);
			int unLockIndex = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.LockCell(locked, unLockIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LockCardLisener(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			bool lockCard = LuaDLL.luaL_checkboolean(L, 2);
			obj.LockCardLisener(lockCard);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LockHandCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			bool lockCard = LuaDLL.luaL_checkboolean(L, 2);
			obj.LockHandCard(lockCard);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendStarGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int groupIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SendStarGame(groupIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendSufferCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int[] sufferCard = ToLua.CheckNumberArray<int>(L, 2);
			obj.SendSufferCard(sufferCard);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendDrawCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).SendDrawCard();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendPlaceCard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			int cardID = (int)LuaDLL.luaL_checknumber(L, 2);
			int index = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SendPlaceCard(cardID, index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendJumpRound(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).SendJumpRound();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendResetGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).SendResetGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendEndRound(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager))).SendEndRound();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendLuaMessage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BloodCardManager obj = (BloodCardManager)ToLua.CheckObject(L, 1, typeof(BloodCardManager));
			string message = ToLua.CheckString(L, 2);
			object[] args = ToLua.CheckObjectArray(L, 3);
			obj.SendLuaMessage(message, args);
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
	private static int get_PlayerCardHand(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayerHand playerCardHand = ((BloodCardManager)obj).PlayerCardHand;
			ToLua.Push(L, playerCardHand);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerCardHand on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EnemyCardHand(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EnemyHand enemyCardHand = ((BloodCardManager)obj).EnemyCardHand;
			ToLua.Push(L, enemyCardHand);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EnemyCardHand on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayerCardDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Deck playerCardDeck = ((BloodCardManager)obj).PlayerCardDeck;
			ToLua.Push(L, playerCardDeck);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerCardDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EnemyCardDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Deck enemyCardDeck = ((BloodCardManager)obj).EnemyCardDeck;
			ToLua.Push(L, enemyCardDeck);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EnemyCardDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CardPoolDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Deck cardPoolDeck = ((BloodCardManager)obj).CardPoolDeck;
			ToLua.Push(L, cardPoolDeck);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardPoolDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ChangeCardDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Deck changeCardDeck = ((BloodCardManager)obj).ChangeCardDeck;
			ToLua.Push(L, changeCardDeck);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ChangeCardDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ScreenAniRoot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject screenAniRoot = ((BloodCardManager)obj).ScreenAniRoot;
			ToLua.PushSealed(L, screenAniRoot);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ScreenAniRoot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Board(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardBoard board = ((BloodCardManager)obj).Board;
			ToLua.Push(L, board);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Board on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VisualCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VisualCardsHandler visualCards = ((BloodCardManager)obj).VisualCards;
			ToLua.Push(L, visualCards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VisualCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_slotPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject slotPrefab = ((BloodCardManager)obj).slotPrefab;
			ToLua.PushSealed(L, slotPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index slotPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_turnGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject turnGo = ((BloodCardManager)obj).turnGo;
			ToLua.PushSealed(L, turnGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_buttonCancel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button buttonCancel = ((BloodCardManager)obj).buttonCancel;
			ToLua.Push(L, buttonCancel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buttonCancel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_buttonOk(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button buttonOk = ((BloodCardManager)obj).buttonOk;
			ToLua.Push(L, buttonOk);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buttonOk on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_needChangeBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button needChangeBtn = ((BloodCardManager)obj).needChangeBtn;
			ToLua.Push(L, needChangeBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index needChangeBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resultMaskBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button resultMaskBtn = ((BloodCardManager)obj).resultMaskBtn;
			ToLua.Push(L, resultMaskBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultMaskBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resultYesBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Button resultYesBtn = ((BloodCardManager)obj).resultYesBtn;
			ToLua.Push(L, resultYesBtn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultYesBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text timeText = ((BloodCardManager)obj).timeText;
			ToLua.Push(L, timeText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ChangeSelectNumText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text changeSelectNumText = ((BloodCardManager)obj).ChangeSelectNumText;
			ToLua.Push(L, changeSelectNumText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ChangeSelectNumText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_firstPlayerScoreText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text firstPlayerScoreText = ((BloodCardManager)obj).firstPlayerScoreText;
			ToLua.Push(L, firstPlayerScoreText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index firstPlayerScoreText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastPlayerScoreText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text lastPlayerScoreText = ((BloodCardManager)obj).lastPlayerScoreText;
			ToLua.Push(L, lastPlayerScoreText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayerScoreText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_controller(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerExCollection controller = ((BloodCardManager)obj).controller;
			ToLua.Push(L, controller);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index controller on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resultController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerExCollection resultController = ((BloodCardManager)obj).resultController;
			ToLua.Push(L, resultController);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_turnController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerExCollection turnController = ((BloodCardManager)obj).turnController;
			ToLua.Push(L, turnController);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curveLinePoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject curveLinePoint = ((BloodCardManager)obj).curveLinePoint;
			ToLua.PushSealed(L, curveLinePoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curveLinePoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BezierOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float bezierOffset = ((BloodCardManager)obj).BezierOffset;
			LuaDLL.lua_pushnumber(L, bezierOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BezierOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BezierTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float bezierTime = ((BloodCardManager)obj).BezierTime;
			LuaDLL.lua_pushnumber(L, bezierTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BezierTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stateController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx stateController = ((BloodCardManager)obj).stateController;
			ToLua.PushObject(L, stateController);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stateController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resultStateController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx resultStateController = ((BloodCardManager)obj).resultStateController;
			ToLua.PushObject(L, resultStateController);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultStateController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_turnStateController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx turnStateController = ((BloodCardManager)obj).turnStateController;
			ToLua.PushObject(L, turnStateController);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnStateController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_InitCardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int initCardNum = ((BloodCardManager)obj).InitCardNum;
			LuaDLL.lua_pushinteger(L, initCardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index InitCardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DealCardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int dealCardNum = ((BloodCardManager)obj).DealCardNum;
			LuaDLL.lua_pushinteger(L, dealCardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DealCardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_moveCardAniDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float moveCardAniDuration = ((BloodCardManager)obj).moveCardAniDuration;
			LuaDLL.lua_pushnumber(L, moveCardAniDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index moveCardAniDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stepMoveCardAniDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float stepMoveCardAniDuration = ((BloodCardManager)obj).stepMoveCardAniDuration;
			LuaDLL.lua_pushnumber(L, stepMoveCardAniDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stepMoveCardAniDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_groupIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int groupIndex = ((BloodCardManager)obj).groupIndex;
			LuaDLL.lua_pushinteger(L, groupIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index groupIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handCardIds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> handCardIds = ((BloodCardManager)obj).handCardIds;
			ToLua.PushSealed(L, handCardIds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handCardIds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startGameTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int startGameTimestamp = ((BloodCardManager)obj).startGameTimestamp;
			LuaDLL.lua_pushinteger(L, startGameTimestamp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startGameTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_drawCardTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int drawCardTimestamp = ((BloodCardManager)obj).drawCardTimestamp;
			LuaDLL.lua_pushinteger(L, drawCardTimestamp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drawCardTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPlayerFirst(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPlayerFirst = ((BloodCardManager)obj).isPlayerFirst;
			LuaDLL.lua_pushboolean(L, isPlayerFirst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPlayerFirst on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selfCantPutCard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool selfCantPutCard = ((BloodCardManager)obj).selfCantPutCard;
			LuaDLL.lua_pushboolean(L, selfCantPutCard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selfCantPutCard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playerSufferAniDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playerSufferAniDone = ((BloodCardManager)obj).playerSufferAniDone;
			LuaDLL.lua_pushboolean(L, playerSufferAniDone);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerSufferAniDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playingEffectDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool playingEffectDone = ((BloodCardManager)obj).playingEffectDone;
			LuaDLL.lua_pushboolean(L, playingEffectDone);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playingEffectDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enemyPlaceOverlayCard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enemyPlaceOverlayCard = ((BloodCardManager)obj).enemyPlaceOverlayCard;
			LuaDLL.lua_pushboolean(L, enemyPlaceOverlayCard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyPlaceOverlayCard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isDrawCardDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isDrawCardDone = ((BloodCardManager)obj).isDrawCardDone;
			LuaDLL.lua_pushboolean(L, isDrawCardDone);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDrawCardDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isDealCardDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isDealCardDone = ((BloodCardManager)obj).isDealCardDone;
			LuaDLL.lua_pushboolean(L, isDealCardDone);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDealCardDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isAbandon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAbandon = ((BloodCardManager)obj).isAbandon;
			LuaDLL.lua_pushboolean(L, isAbandon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAbandon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sufferCardIndexs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> sufferCardIndexs = ((BloodCardManager)obj).sufferCardIndexs;
			ToLua.PushSealed(L, sufferCardIndexs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sufferCardIndexs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_placingIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int placingIndex = ((BloodCardManager)obj).placingIndex;
			LuaDLL.lua_pushinteger(L, placingIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index placingIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_guideIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int guideIndex = ((BloodCardManager)obj).guideIndex;
			LuaDLL.lua_pushinteger(L, guideIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guideIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_guideID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int guideID = ((BloodCardManager)obj).guideID;
			LuaDLL.lua_pushinteger(L, guideID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guideID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stepID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stepID = ((BloodCardManager)obj).stepID;
			LuaDLL.lua_pushinteger(L, stepID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stepID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_placingCard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Card placingCard = ((BloodCardManager)obj).placingCard;
			ToLua.Push(L, placingCard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index placingCard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isMultiGame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isMultiGame = ((BloodCardManager)obj).isMultiGame;
			LuaDLL.lua_pushboolean(L, isMultiGame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMultiGame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ObservationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float observationTime = ((BloodCardManager)obj).ObservationTime;
			LuaDLL.lua_pushnumber(L, observationTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ObservationTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Card> handCards = ((BloodCardManager)obj).handCards;
			ToLua.PushSealed(L, handCards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enemyHandCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Card> enemyHandCards = ((BloodCardManager)obj).enemyHandCards;
			ToLua.PushSealed(L, enemyHandCards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyHandCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_changeDeckCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Card> changeDeckCards = ((BloodCardManager)obj).changeDeckCards;
			ToLua.PushSealed(L, changeDeckCards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index changeDeckCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RemainingSufferWatingTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float remainingSufferWatingTime = ((BloodCardManager)obj).RemainingSufferWatingTime;
			LuaDLL.lua_pushnumber(L, remainingSufferWatingTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RemainingSufferWatingTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayerRemainLeftTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float playerRemainLeftTime = ((BloodCardManager)obj).PlayerRemainLeftTime;
			LuaDLL.lua_pushnumber(L, playerRemainLeftTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerRemainLeftTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayerBackupLeftTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float playerBackupLeftTime = ((BloodCardManager)obj).PlayerBackupLeftTime;
			LuaDLL.lua_pushnumber(L, playerBackupLeftTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerBackupLeftTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CurrentStatus(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardEnum.GameStatus currentStatus = ((BloodCardManager)obj).CurrentStatus;
			ToLua.Push(L, currentStatus);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CurrentStatus on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PlayerCardHand(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			PlayerHand playerCardHand = (PlayerHand)ToLua.CheckObject<PlayerHand>(L, 2);
			obj2.PlayerCardHand = playerCardHand;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerCardHand on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_EnemyCardHand(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			EnemyHand enemyCardHand = (EnemyHand)ToLua.CheckObject<EnemyHand>(L, 2);
			obj2.EnemyCardHand = enemyCardHand;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EnemyCardHand on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PlayerCardDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Deck playerCardDeck = (Deck)ToLua.CheckObject<Deck>(L, 2);
			obj2.PlayerCardDeck = playerCardDeck;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerCardDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_EnemyCardDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Deck enemyCardDeck = (Deck)ToLua.CheckObject<Deck>(L, 2);
			obj2.EnemyCardDeck = enemyCardDeck;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EnemyCardDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CardPoolDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Deck cardPoolDeck = (Deck)ToLua.CheckObject<Deck>(L, 2);
			obj2.CardPoolDeck = cardPoolDeck;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardPoolDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ChangeCardDeck(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Deck changeCardDeck = (Deck)ToLua.CheckObject<Deck>(L, 2);
			obj2.ChangeCardDeck = changeCardDeck;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ChangeCardDeck on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ScreenAniRoot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			GameObject screenAniRoot = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.ScreenAniRoot = screenAniRoot;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ScreenAniRoot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Board(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			BloodCardBoard board = (BloodCardBoard)ToLua.CheckObject<BloodCardBoard>(L, 2);
			obj2.Board = board;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Board on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_VisualCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			VisualCardsHandler visualCards = (VisualCardsHandler)ToLua.CheckObject<VisualCardsHandler>(L, 2);
			obj2.VisualCards = visualCards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VisualCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_slotPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			GameObject slotPrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.slotPrefab = slotPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index slotPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_turnGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			GameObject turnGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.turnGo = turnGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_buttonCancel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Button buttonCancel = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.buttonCancel = buttonCancel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buttonCancel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_buttonOk(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Button buttonOk = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.buttonOk = buttonOk;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buttonOk on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_needChangeBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Button needChangeBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.needChangeBtn = needChangeBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index needChangeBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resultMaskBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Button resultMaskBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.resultMaskBtn = resultMaskBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultMaskBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resultYesBtn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Button resultYesBtn = (Button)ToLua.CheckObject<Button>(L, 2);
			obj2.resultYesBtn = resultYesBtn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultYesBtn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Text timeText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.timeText = timeText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ChangeSelectNumText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Text changeSelectNumText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.ChangeSelectNumText = changeSelectNumText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ChangeSelectNumText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_firstPlayerScoreText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Text firstPlayerScoreText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.firstPlayerScoreText = firstPlayerScoreText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index firstPlayerScoreText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastPlayerScoreText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Text lastPlayerScoreText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.lastPlayerScoreText = lastPlayerScoreText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastPlayerScoreText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_controller(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			ControllerExCollection controller = (ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 2);
			obj2.controller = controller;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index controller on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resultController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			ControllerExCollection resultController = (ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 2);
			obj2.resultController = resultController;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_turnController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			ControllerExCollection turnController = (ControllerExCollection)ToLua.CheckObject<ControllerExCollection>(L, 2);
			obj2.turnController = turnController;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curveLinePoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			GameObject curveLinePoint = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.curveLinePoint = curveLinePoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curveLinePoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BezierOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			float bezierOffset = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.BezierOffset = bezierOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BezierOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BezierTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			float bezierTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.BezierTime = bezierTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BezierTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stateController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			ControllerEx stateController = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.stateController = stateController;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stateController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resultStateController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			ControllerEx resultStateController = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.resultStateController = resultStateController;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultStateController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_turnStateController(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			ControllerEx turnStateController = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 2);
			obj2.turnStateController = turnStateController;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turnStateController on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_InitCardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int initCardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.InitCardNum = initCardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index InitCardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_DealCardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int dealCardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.DealCardNum = dealCardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DealCardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_moveCardAniDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			float moveCardAniDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.moveCardAniDuration = moveCardAniDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index moveCardAniDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stepMoveCardAniDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			float stepMoveCardAniDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.stepMoveCardAniDuration = stepMoveCardAniDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stepMoveCardAniDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_groupIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int groupIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.groupIndex = groupIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index groupIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handCardIds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			List<int> handCardIds = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.handCardIds = handCardIds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handCardIds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startGameTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int startGameTimestamp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.startGameTimestamp = startGameTimestamp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startGameTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_drawCardTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int drawCardTimestamp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.drawCardTimestamp = drawCardTimestamp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drawCardTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isPlayerFirst(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool isPlayerFirst = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isPlayerFirst = isPlayerFirst;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPlayerFirst on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selfCantPutCard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool selfCantPutCard = LuaDLL.luaL_checkboolean(L, 2);
			obj2.selfCantPutCard = selfCantPutCard;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selfCantPutCard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playerSufferAniDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool playerSufferAniDone = LuaDLL.luaL_checkboolean(L, 2);
			obj2.playerSufferAniDone = playerSufferAniDone;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerSufferAniDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playingEffectDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool playingEffectDone = LuaDLL.luaL_checkboolean(L, 2);
			obj2.playingEffectDone = playingEffectDone;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playingEffectDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enemyPlaceOverlayCard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool enemyPlaceOverlayCard = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enemyPlaceOverlayCard = enemyPlaceOverlayCard;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyPlaceOverlayCard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isDrawCardDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool isDrawCardDone = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isDrawCardDone = isDrawCardDone;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDrawCardDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isDealCardDone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool isDealCardDone = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isDealCardDone = isDealCardDone;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDealCardDone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isAbandon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool isAbandon = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isAbandon = isAbandon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAbandon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sufferCardIndexs(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			List<int> sufferCardIndexs = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.sufferCardIndexs = sufferCardIndexs;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sufferCardIndexs on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_placingIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int placingIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.placingIndex = placingIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index placingIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_guideIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int guideIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.guideIndex = guideIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guideIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_guideID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int guideID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.guideID = guideID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guideID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stepID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			int stepID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stepID = stepID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stepID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_placingCard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			Card placingCard = (Card)ToLua.CheckObject<Card>(L, 2);
			obj2.placingCard = placingCard;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index placingCard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isMultiGame(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			bool isMultiGame = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isMultiGame = isMultiGame;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMultiGame on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ObservationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			float observationTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.ObservationTime = observationTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ObservationTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			List<Card> handCards = (List<Card>)ToLua.CheckObject(L, 2, typeof(List<Card>));
			obj2.handCards = handCards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enemyHandCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			List<Card> enemyHandCards = (List<Card>)ToLua.CheckObject(L, 2, typeof(List<Card>));
			obj2.enemyHandCards = enemyHandCards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyHandCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_changeDeckCards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			List<Card> changeDeckCards = (List<Card>)ToLua.CheckObject(L, 2, typeof(List<Card>));
			obj2.changeDeckCards = changeDeckCards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index changeDeckCards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_RemainingSufferWatingTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			float remainingSufferWatingTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.RemainingSufferWatingTime = remainingSufferWatingTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RemainingSufferWatingTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PlayerRemainLeftTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			float playerRemainLeftTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.PlayerRemainLeftTime = playerRemainLeftTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerRemainLeftTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PlayerBackupLeftTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BloodCardManager obj2 = (BloodCardManager)obj;
			float playerBackupLeftTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.PlayerBackupLeftTime = playerBackupLeftTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerBackupLeftTime on a nil value");
		}
	}
}
