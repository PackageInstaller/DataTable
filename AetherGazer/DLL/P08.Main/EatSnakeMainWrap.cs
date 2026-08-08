using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class EatSnakeMainWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EatSnakeMain), typeof(MonoBehaviour));
		L.RegFunction("LoadGame", LoadGame);
		L.RegFunction("CalculateSnakePartCount", CalculateSnakePartCount);
		L.RegFunction("ClearAllBlockStatus", ClearAllBlockStatus);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("step", get_step, set_step);
		L.RegVar("snakeHeadGo", get_snakeHeadGo, set_snakeHeadGo);
		L.RegVar("snakeHead", get_snakeHead, set_snakeHead);
		L.RegVar("bodyPrefab", get_bodyPrefab, set_bodyPrefab);
		L.RegVar("snakeTail", get_snakeTail, set_snakeTail);
		L.RegVar("foodParent", get_foodParent, set_foodParent);
		L.RegVar("eatSnakeBlocks", get_eatSnakeBlocks, set_eatSnakeBlocks);
		L.RegVar("time", get_time, set_time);
		L.RegVar("normalTimer", get_normalTimer, set_normalTimer);
		L.RegVar("rushTimer", get_rushTimer, set_rushTimer);
		L.RegVar("nowMoveTimer", get_nowMoveTimer, set_nowMoveTimer);
		L.RegVar("haveWall", get_haveWall, set_haveWall);
		L.RegVar("isLock", get_isLock, set_isLock);
		L.RegVar("shiftX", get_shiftX, set_shiftX);
		L.RegVar("shiftY", get_shiftY, set_shiftY);
		L.RegVar("showTime", get_showTime, set_showTime);
		L.RegVar("snakeParts", get_snakeParts, set_snakeParts);
		L.RegVar("gamePause", get_gamePause, set_gamePause);
		L.RegVar("init", get_init, set_init);
		L.RegVar("foodPrefab", get_foodPrefab, set_foodPrefab);
		L.RegVar("foodLifeTime", get_foodLifeTime, set_foodLifeTime);
		L.RegVar("lastx", get_lastx, set_lastx);
		L.RegVar("lasty", get_lasty, set_lasty);
		L.RegVar("bodyParent", get_bodyParent, set_bodyParent);
		L.RegVar("currentIndex", get_currentIndex, set_currentIndex);
		L.RegVar("reinforcementDic", get_reinforcementDic, set_reinforcementDic);
		L.RegVar("eatSnakeUI", get_eatSnakeUI, set_eatSnakeUI);
		L.RegVar("winGameAction", get_winGameAction, set_winGameAction);
		L.RegVar("failGameAction", get_failGameAction, set_failGameAction);
		L.RegVar("redCount", get_redCount, set_redCount);
		L.RegVar("oriangeCount", get_oriangeCount, set_oriangeCount);
		L.RegVar("blueCount", get_blueCount, set_blueCount);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EatSnakeMain obj = (EatSnakeMain)ToLua.CheckObject<EatSnakeMain>(L, 1);
			string mapId = ToLua.CheckString(L, 2);
			obj.LoadGame(mapId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateSnakePartCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int[] array = ((EatSnakeMain)ToLua.CheckObject<EatSnakeMain>(L, 1)).CalculateSnakePartCount();
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearAllBlockStatus(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((EatSnakeMain)ToLua.CheckObject<EatSnakeMain>(L, 1)).ClearAllBlockStatus();
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
	private static int get_step(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int step = ((EatSnakeMain)obj).step;
			LuaDLL.lua_pushinteger(L, step);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index step on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_snakeHeadGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject snakeHeadGo = ((EatSnakeMain)obj).snakeHeadGo;
			ToLua.PushSealed(L, snakeHeadGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index snakeHeadGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_snakeHead(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeHead snakeHead = ((EatSnakeMain)obj).snakeHead;
			ToLua.Push(L, snakeHead);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index snakeHead on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bodyPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject bodyPrefab = ((EatSnakeMain)obj).bodyPrefab;
			ToLua.PushSealed(L, bodyPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_snakeTail(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeHead snakeTail = ((EatSnakeMain)obj).snakeTail;
			ToLua.Push(L, snakeTail);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index snakeTail on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_foodParent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject foodParent = ((EatSnakeMain)obj).foodParent;
			ToLua.PushSealed(L, foodParent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index foodParent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eatSnakeBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeBlock[,] eatSnakeBlocks = ((EatSnakeMain)obj).eatSnakeBlocks;
			ToLua.Push(L, eatSnakeBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eatSnakeBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float time = ((EatSnakeMain)obj).time;
			LuaDLL.lua_pushnumber(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_normalTimer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float normalTimer = ((EatSnakeMain)obj).normalTimer;
			LuaDLL.lua_pushnumber(L, normalTimer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalTimer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rushTimer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rushTimer = ((EatSnakeMain)obj).rushTimer;
			LuaDLL.lua_pushnumber(L, rushTimer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rushTimer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nowMoveTimer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float nowMoveTimer = ((EatSnakeMain)obj).nowMoveTimer;
			LuaDLL.lua_pushnumber(L, nowMoveTimer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nowMoveTimer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_haveWall(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool haveWall = ((EatSnakeMain)obj).haveWall;
			LuaDLL.lua_pushboolean(L, haveWall);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index haveWall on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLock(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLock = ((EatSnakeMain)obj).isLock;
			LuaDLL.lua_pushboolean(L, isLock);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLock on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shiftX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int shiftX = ((EatSnakeMain)obj).shiftX;
			LuaDLL.lua_pushinteger(L, shiftX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shiftX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shiftY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int shiftY = ((EatSnakeMain)obj).shiftY;
			LuaDLL.lua_pushinteger(L, shiftY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shiftY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_showTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float showTime = ((EatSnakeMain)obj).showTime;
			LuaDLL.lua_pushnumber(L, showTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index showTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_snakeParts(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<EatSnakeBody> snakeParts = ((EatSnakeMain)obj).snakeParts;
			ToLua.PushSealed(L, snakeParts);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index snakeParts on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gamePause(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool gamePause = ((EatSnakeMain)obj).gamePause;
			LuaDLL.lua_pushboolean(L, gamePause);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gamePause on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_init(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool init = ((EatSnakeMain)obj).init;
			LuaDLL.lua_pushboolean(L, init);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index init on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_foodPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject foodPrefab = ((EatSnakeMain)obj).foodPrefab;
			ToLua.PushSealed(L, foodPrefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index foodPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_foodLifeTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float foodLifeTime = ((EatSnakeMain)obj).foodLifeTime;
			LuaDLL.lua_pushnumber(L, foodLifeTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index foodLifeTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int lastx = ((EatSnakeMain)obj).lastx;
			LuaDLL.lua_pushinteger(L, lastx);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lasty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int lasty = ((EatSnakeMain)obj).lasty;
			LuaDLL.lua_pushinteger(L, lasty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lasty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bodyParent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject bodyParent = ((EatSnakeMain)obj).bodyParent;
			ToLua.PushSealed(L, bodyParent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyParent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int currentIndex = ((EatSnakeMain)obj).currentIndex;
			LuaDLL.lua_pushinteger(L, currentIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reinforcementDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, EatSnakeBlock> reinforcementDic = ((EatSnakeMain)obj).reinforcementDic;
			ToLua.PushSealed(L, reinforcementDic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reinforcementDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eatSnakeUI(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeUI eatSnakeUI = ((EatSnakeMain)obj).eatSnakeUI;
			ToLua.Push(L, eatSnakeUI);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eatSnakeUI on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_winGameAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action winGameAction = ((EatSnakeMain)obj).winGameAction;
			ToLua.Push(L, winGameAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index winGameAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_failGameAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action failGameAction = ((EatSnakeMain)obj).failGameAction;
			ToLua.Push(L, failGameAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index failGameAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_redCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int redCount = ((EatSnakeMain)obj).redCount;
			LuaDLL.lua_pushinteger(L, redCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index redCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_oriangeCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int oriangeCount = ((EatSnakeMain)obj).oriangeCount;
			LuaDLL.lua_pushinteger(L, oriangeCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index oriangeCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blueCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int blueCount = ((EatSnakeMain)obj).blueCount;
			LuaDLL.lua_pushinteger(L, blueCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blueCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, EatSnakeMain.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_step(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int step = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.step = step;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index step on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_snakeHeadGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			GameObject snakeHeadGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.snakeHeadGo = snakeHeadGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index snakeHeadGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_snakeHead(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			EatSnakeHead snakeHead = (EatSnakeHead)ToLua.CheckObject<EatSnakeHead>(L, 2);
			obj2.snakeHead = snakeHead;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index snakeHead on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bodyPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			GameObject bodyPrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.bodyPrefab = bodyPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_snakeTail(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			EatSnakeHead snakeTail = (EatSnakeHead)ToLua.CheckObject<EatSnakeHead>(L, 2);
			obj2.snakeTail = snakeTail;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index snakeTail on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_foodParent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			GameObject foodParent = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.foodParent = foodParent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index foodParent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eatSnakeBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			EatSnakeBlock[,] eatSnakeBlocks = (EatSnakeBlock[,])ToLua.CheckObject(L, 2, typeof(EatSnakeBlock[,]));
			obj2.eatSnakeBlocks = eatSnakeBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eatSnakeBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.time = time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_normalTimer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			float normalTimer = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.normalTimer = normalTimer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalTimer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rushTimer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			float rushTimer = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rushTimer = rushTimer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rushTimer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nowMoveTimer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			float nowMoveTimer = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.nowMoveTimer = nowMoveTimer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nowMoveTimer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_haveWall(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			bool haveWall = LuaDLL.luaL_checkboolean(L, 2);
			obj2.haveWall = haveWall;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index haveWall on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isLock(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			bool isLock = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isLock = isLock;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLock on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shiftX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int shiftX = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.shiftX = shiftX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shiftX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shiftY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int shiftY = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.shiftY = shiftY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shiftY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_showTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			float showTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.showTime = showTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index showTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_snakeParts(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			List<EatSnakeBody> snakeParts = (List<EatSnakeBody>)ToLua.CheckObject(L, 2, typeof(List<EatSnakeBody>));
			obj2.snakeParts = snakeParts;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index snakeParts on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gamePause(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			bool gamePause = LuaDLL.luaL_checkboolean(L, 2);
			obj2.gamePause = gamePause;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gamePause on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_init(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			bool init = LuaDLL.luaL_checkboolean(L, 2);
			obj2.init = init;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index init on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_foodPrefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			GameObject foodPrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.foodPrefab = foodPrefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index foodPrefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_foodLifeTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			float foodLifeTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.foodLifeTime = foodLifeTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index foodLifeTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int lastx = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.lastx = lastx;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lasty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int lasty = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.lasty = lasty;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lasty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bodyParent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			GameObject bodyParent = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.bodyParent = bodyParent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bodyParent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_currentIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int currentIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.currentIndex = currentIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reinforcementDic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			Dictionary<int, EatSnakeBlock> reinforcementDic = (Dictionary<int, EatSnakeBlock>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, EatSnakeBlock>));
			obj2.reinforcementDic = reinforcementDic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reinforcementDic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eatSnakeUI(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			EatSnakeUI eatSnakeUI = (EatSnakeUI)ToLua.CheckObject<EatSnakeUI>(L, 2);
			obj2.eatSnakeUI = eatSnakeUI;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eatSnakeUI on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_winGameAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			Action winGameAction = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.winGameAction = winGameAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index winGameAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_failGameAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			Action failGameAction = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.failGameAction = failGameAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index failGameAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_redCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int redCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.redCount = redCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index redCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_oriangeCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int oriangeCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.oriangeCount = oriangeCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index oriangeCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blueCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EatSnakeMain obj2 = (EatSnakeMain)obj;
			int blueCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.blueCount = blueCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blueCount on a nil value");
		}
	}
}
