using System;
using LuaInterface;
using UnityEngine;

public class FuncTimerManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(FuncTimerManager), typeof(MonoBehaviour));
		L.RegFunction("CreateFuncTimer", CreateFuncTimer);
		L.RegFunction("CreateFuncFrameTimer", CreateFuncFrameTimer);
		L.RegFunction("StartFuncTimer", StartFuncTimer);
		L.RegFunction("ResetFuncTimer", ResetFuncTimer);
		L.RegFunction("StopFuncTimer", StopFuncTimer);
		L.RegFunction("RemoveFuncTimer", RemoveFuncTimer);
		L.RegFunction("QueryTotalTime", QueryTotalTime);
		L.RegFunction("ClearAll", ClearAll);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isRunning", get_isRunning, set_isRunning);
		L.RegVar("inst", get_inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateFuncTimer(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				FuncTimerManager obj3 = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
				Action func3 = (Action)ToLua.CheckDelegate<Action>(L, 2);
				float interval3 = (float)LuaDLL.luaL_checknumber(L, 3);
				int n3 = obj3.CreateFuncTimer(func3, interval3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 4:
			{
				FuncTimerManager obj2 = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
				Action func2 = (Action)ToLua.CheckDelegate<Action>(L, 2);
				float interval2 = (float)LuaDLL.luaL_checknumber(L, 3);
				int times2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int n2 = obj2.CreateFuncTimer(func2, interval2, times2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 5:
			{
				FuncTimerManager obj = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 2);
				float interval = (float)LuaDLL.luaL_checknumber(L, 3);
				int times = (int)LuaDLL.luaL_checknumber(L, 4);
				bool autoStart = LuaDLL.luaL_checkboolean(L, 5);
				int n = obj.CreateFuncTimer(func, interval, times, autoStart);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: FuncTimerManager.CreateFuncTimer");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateFuncFrameTimer(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				FuncTimerManager obj3 = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
				Action func3 = (Action)ToLua.CheckDelegate<Action>(L, 2);
				int n3 = obj3.CreateFuncFrameTimer(func3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				FuncTimerManager obj2 = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
				Action func2 = (Action)ToLua.CheckDelegate<Action>(L, 2);
				int times2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int n2 = obj2.CreateFuncFrameTimer(func2, times2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				FuncTimerManager obj = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 2);
				int times = (int)LuaDLL.luaL_checknumber(L, 3);
				bool autoStart = LuaDLL.luaL_checkboolean(L, 4);
				int n = obj.CreateFuncFrameTimer(func, times, autoStart);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: FuncTimerManager.CreateFuncFrameTimer");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartFuncTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FuncTimerManager obj = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
			int timerId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.StartFuncTimer(timerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetFuncTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FuncTimerManager obj = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
			int timerId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ResetFuncTimer(timerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopFuncTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FuncTimerManager obj = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
			int timerId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.StopFuncTimer(timerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveFuncTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FuncTimerManager obj = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
			int timerId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.RemoveFuncTimer(timerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryTotalTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FuncTimerManager obj = (FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1);
			int timerId = (int)LuaDLL.luaL_checknumber(L, 2);
			float num = obj.QueryTotalTime(timerId);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((FuncTimerManager)ToLua.CheckObject<FuncTimerManager>(L, 1)).ClearAll();
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
	private static int get_isRunning(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isRunning = ((FuncTimerManager)obj).isRunning;
			LuaDLL.lua_pushboolean(L, isRunning);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isRunning on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inst(IntPtr L)
	{
		try
		{
			ToLua.Push(L, FuncTimerManager.inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isRunning(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			FuncTimerManager obj2 = (FuncTimerManager)obj;
			bool isRunning = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isRunning = isRunning;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isRunning on a nil value");
		}
	}
}
