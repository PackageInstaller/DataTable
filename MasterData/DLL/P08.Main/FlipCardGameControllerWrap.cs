using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class FlipCardGameControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(FlipCardGameController), typeof(MonoBehaviour));
		L.RegFunction("StarCheckCardFace", StarCheckCardFace);
		L.RegFunction("ChangeStatus", ChangeStatus);
		L.RegFunction("InitGame", InitGame);
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("CheckMatch", CheckMatch);
		L.RegFunction("GameOver", GameOver);
		L.RegFunction("GetGameState", GetGameState);
		L.RegFunction("GetIsSuccess", GetIsSuccess);
		L.RegFunction("GiveUp", GiveUp);
		L.RegFunction("ResetGame", ResetGame);
		L.RegFunction("StopObservingCards", StopObservingCards);
		L.RegFunction("GetCardFace", GetCardFace);
		L.RegFunction("GetCarFaceBack", GetCarFaceBack);
		L.RegFunction("SetCardFaces", SetCardFaces);
		L.RegFunction("SetCardFaceBack", SetCardFaceBack);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegConstant("ROW_COUNT", 3.0);
		L.RegVar("Instance", get_Instance, null);
		L.RegVar("RowCount", get_RowCount, set_RowCount);
		L.RegVar("ColmnCount", get_ColmnCount, set_ColmnCount);
		L.RegVar("CardTypeCount", get_CardTypeCount, set_CardTypeCount);
		L.RegVar("CardPrefab", get_CardPrefab, set_CardPrefab);
		L.RegVar("CardFaces", get_CardFaces, set_CardFaces);
		L.RegVar("CardFaceBack", get_CardFaceBack, set_CardFaceBack);
		L.RegVar("ColumnSpacing", get_ColumnSpacing, set_ColumnSpacing);
		L.RegVar("RowSpacing", get_RowSpacing, set_RowSpacing);
		L.RegVar("AniDuration", get_AniDuration, set_AniDuration);
		L.RegVar("ObservationTime", get_ObservationTime, set_ObservationTime);
		L.RegVar("TimerDuration", get_TimerDuration, set_TimerDuration);
		L.RegVar("FlipBackDuration", get_FlipBackDuration, set_FlipBackDuration);
		L.RegVar("RemainingObservationTime", get_RemainingObservationTime, set_RemainingObservationTime);
		L.RegVar("CurrentTimeValue", get_CurrentTimeValue, set_CurrentTimeValue);
		L.RegVar("GameState", get_GameState, set_GameState);
		L.RegVar("FlipCardCount", get_FlipCardCount, set_FlipCardCount);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StarCheckCardFace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1)).StarCheckCardFace();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeStatus(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<FlipCardGameController.GameStatus>(L, 2))
			{
				FlipCardGameController obj = (FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1);
				FlipCardGameController.GameStatus newStatus = (FlipCardGameController.GameStatus)ToLua.ToObject(L, 2);
				obj.ChangeStatus(newStatus);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				FlipCardGameController obj2 = (FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1);
				int state = (int)LuaDLL.lua_tonumber(L, 2);
				obj2.ChangeStatus(state);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: FlipCardGameController.ChangeStatus");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1)).InitGame();
			return 0;
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
			ToLua.CheckArgsCount(L, 1);
			((FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1)).StartGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckMatch(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FlipCardGameController obj = (FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1);
			CardController card = (CardController)ToLua.CheckObject<CardController>(L, 2);
			obj.CheckMatch(card);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameOver(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FlipCardGameController obj = (FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1);
			bool isSuccess = LuaDLL.luaL_checkboolean(L, 2);
			obj.GameOver(isSuccess);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGameState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int gameState = ((FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1)).GetGameState();
			LuaDLL.lua_pushinteger(L, gameState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIsSuccess(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool isSuccess = ((FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1)).GetIsSuccess();
			LuaDLL.lua_pushboolean(L, isSuccess);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GiveUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1)).GiveUp();
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
			((FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1)).ResetGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopObservingCards(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1)).StopObservingCards();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCardFace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FlipCardGameController obj = (FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1);
			int cardType = (int)LuaDLL.luaL_checknumber(L, 2);
			Sprite cardFace = obj.GetCardFace(cardType);
			ToLua.PushSealed(L, cardFace);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCarFaceBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FlipCardGameController obj = (FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1);
			bool isSpecial = LuaDLL.luaL_checkboolean(L, 2);
			Sprite carFaceBack = obj.GetCarFaceBack(isSpecial);
			ToLua.PushSealed(L, carFaceBack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCardFaces(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			FlipCardGameController obj = (FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1);
			string assetPath = ToLua.CheckString(L, 2);
			int cardIndex = (int)LuaDLL.luaL_checknumber(L, 3);
			bool isSpecial = LuaDLL.luaL_checkboolean(L, 4);
			obj.SetCardFaces(assetPath, cardIndex, isSpecial);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCardFaceBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			FlipCardGameController obj = (FlipCardGameController)ToLua.CheckObject<FlipCardGameController>(L, 1);
			string atlasName = ToLua.CheckString(L, 2);
			string iconName = ToLua.CheckString(L, 3);
			bool isAtlas = LuaDLL.luaL_checkboolean(L, 4);
			obj.SetCardFaceBack(atlasName, iconName, isAtlas);
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
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, FlipCardGameController.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RowCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rowCount = ((FlipCardGameController)obj).RowCount;
			LuaDLL.lua_pushinteger(L, rowCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RowCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ColmnCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int colmnCount = ((FlipCardGameController)obj).ColmnCount;
			LuaDLL.lua_pushinteger(L, colmnCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ColmnCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CardTypeCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cardTypeCount = ((FlipCardGameController)obj).CardTypeCount;
			LuaDLL.lua_pushinteger(L, cardTypeCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardTypeCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CardPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject cardPrefab = ((FlipCardGameController)obj).CardPrefab;
			ToLua.PushSealed(L, cardPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CardFaces(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Sprite> cardFaces = ((FlipCardGameController)obj).CardFaces;
			ToLua.PushSealed(L, cardFaces);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardFaces on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CardFaceBack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Sprite> cardFaceBack = ((FlipCardGameController)obj).CardFaceBack;
			ToLua.PushSealed(L, cardFaceBack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardFaceBack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ColumnSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float columnSpacing = ((FlipCardGameController)obj).ColumnSpacing;
			LuaDLL.lua_pushnumber(L, columnSpacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ColumnSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RowSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rowSpacing = ((FlipCardGameController)obj).RowSpacing;
			LuaDLL.lua_pushnumber(L, rowSpacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RowSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AniDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float aniDuration = ((FlipCardGameController)obj).AniDuration;
			LuaDLL.lua_pushnumber(L, aniDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AniDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ObservationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float observationTime = ((FlipCardGameController)obj).ObservationTime;
			LuaDLL.lua_pushnumber(L, observationTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ObservationTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TimerDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float timerDuration = ((FlipCardGameController)obj).TimerDuration;
			LuaDLL.lua_pushnumber(L, timerDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TimerDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FlipBackDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float flipBackDuration = ((FlipCardGameController)obj).FlipBackDuration;
			LuaDLL.lua_pushnumber(L, flipBackDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FlipBackDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RemainingObservationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float remainingObservationTime = ((FlipCardGameController)obj).RemainingObservationTime;
			LuaDLL.lua_pushnumber(L, remainingObservationTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RemainingObservationTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CurrentTimeValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float currentTimeValue = ((FlipCardGameController)obj).CurrentTimeValue;
			LuaDLL.lua_pushnumber(L, currentTimeValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CurrentTimeValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GameState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController.GameStatus gameState = ((FlipCardGameController)obj).GameState;
			ToLua.Push(L, gameState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GameState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FlipCardCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int flipCardCount = ((FlipCardGameController)obj).FlipCardCount;
			LuaDLL.lua_pushinteger(L, flipCardCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FlipCardCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_RowCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			int rowCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.RowCount = rowCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RowCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ColmnCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			int colmnCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.ColmnCount = colmnCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ColmnCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CardTypeCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			int cardTypeCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.CardTypeCount = cardTypeCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardTypeCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CardPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			GameObject cardPrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.CardPrefab = cardPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CardFaces(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			List<Sprite> cardFaces = (List<Sprite>)ToLua.CheckObject(L, 2, typeof(List<Sprite>));
			obj2.CardFaces = cardFaces;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardFaces on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CardFaceBack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			List<Sprite> cardFaceBack = (List<Sprite>)ToLua.CheckObject(L, 2, typeof(List<Sprite>));
			obj2.CardFaceBack = cardFaceBack;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CardFaceBack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ColumnSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			float columnSpacing = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.ColumnSpacing = columnSpacing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ColumnSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_RowSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			float rowSpacing = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.RowSpacing = rowSpacing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RowSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AniDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			float aniDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.AniDuration = aniDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AniDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ObservationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
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
	private static int set_TimerDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			float timerDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.TimerDuration = timerDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TimerDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_FlipBackDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			float flipBackDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.FlipBackDuration = flipBackDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FlipBackDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_RemainingObservationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			float remainingObservationTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.RemainingObservationTime = remainingObservationTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index RemainingObservationTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CurrentTimeValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			float currentTimeValue = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.CurrentTimeValue = currentTimeValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CurrentTimeValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_GameState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			FlipCardGameController.GameStatus gameState = (FlipCardGameController.GameStatus)ToLua.CheckObject(L, 2, typeof(FlipCardGameController.GameStatus));
			obj2.GameState = gameState;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GameState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_FlipCardCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FlipCardGameController obj2 = (FlipCardGameController)obj;
			int flipCardCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.FlipCardCount = flipCardCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FlipCardCount on a nil value");
		}
	}
}
