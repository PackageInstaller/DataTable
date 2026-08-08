using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class SailGameManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SailGameManager), typeof(MonoBehaviour));
		L.RegFunction("GameStart", GameStart);
		L.RegFunction("GameOver", GameOver);
		L.RegFunction("ShutDown", ShutDown);
		L.RegFunction("SetGamePause", SetGamePause);
		L.RegFunction("SetGamePauseHandler", SetGamePauseHandler);
		L.RegFunction("SetTriggerTipsHandler", SetTriggerTipsHandler);
		L.RegFunction("SetTriggerEventHandler", SetTriggerEventHandler);
		L.RegFunction("IsRunning", IsRunning);
		L.RegFunction("SetExchangeData", SetExchangeData);
		L.RegFunction("UpdateStageIndex", UpdateStageIndex);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("eventTimeList", get_eventTimeList, set_eventTimeList);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameStart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1)).GameStart();
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
			ToLua.CheckArgsCount(L, 1);
			((SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1)).GameOver();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShutDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1)).ShutDown();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGamePause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SailGameManager obj = (SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1);
			bool gamePause = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetGamePause(gamePause);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGamePauseHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SailGameManager obj = (SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1);
			Action<bool> gamePauseHandler = (Action<bool>)ToLua.CheckDelegate<Action<bool>>(L, 2);
			obj.SetGamePauseHandler(gamePauseHandler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTriggerTipsHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SailGameManager obj = (SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1);
			Action<int> triggerTipsHandler = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj.SetTriggerTipsHandler(triggerTipsHandler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTriggerEventHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SailGameManager obj = (SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1);
			Action<int> triggerEventHandler = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj.SetTriggerEventHandler(triggerEventHandler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsRunning(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1)).IsRunning();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetExchangeData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SailGameManager obj = (SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1);
			SailGameDataForExchange exchangeData = (SailGameDataForExchange)ToLua.CheckObject<SailGameDataForExchange>(L, 2);
			obj.SetExchangeData(exchangeData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateStageIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SailGameManager obj = (SailGameManager)ToLua.CheckObject<SailGameManager>(L, 1);
			int stageIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.UpdateStageIndex(stageIndex);
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
	private static int get_eventTimeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> eventTimeList = ((SailGameManager)obj).eventTimeList;
			ToLua.PushSealed(L, eventTimeList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventTimeList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SailGameManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eventTimeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SailGameManager obj2 = (SailGameManager)obj;
			List<int> eventTimeList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.eventTimeList = eventTimeList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventTimeList on a nil value");
		}
	}
}
