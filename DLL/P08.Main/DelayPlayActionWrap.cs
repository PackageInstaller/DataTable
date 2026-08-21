using System;
using LuaInterface;
using UnityEngine;

public class DelayPlayActionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DelayPlayAction), typeof(MonoBehaviour));
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("delayTime", get_delayTime, set_delayTime);
		L.RegVar("PauseAction", get_PauseAction, set_PauseAction);
		L.EndClass();
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
	private static int get_delayTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float delayTime = ((DelayPlayAction)obj).delayTime;
			LuaDLL.lua_pushnumber(L, delayTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index delayTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PauseAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool pauseAction = ((DelayPlayAction)obj).PauseAction;
			LuaDLL.lua_pushboolean(L, pauseAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PauseAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_delayTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DelayPlayAction obj2 = (DelayPlayAction)obj;
			float delayTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.delayTime = delayTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index delayTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PauseAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DelayPlayAction obj2 = (DelayPlayAction)obj;
			bool pauseAction = LuaDLL.luaL_checkboolean(L, 2);
			obj2.PauseAction = pauseAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PauseAction on a nil value");
		}
	}
}
