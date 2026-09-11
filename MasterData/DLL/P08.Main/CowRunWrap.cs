using System;
using LuaInterface;
using UnityEngine;

public class CowRunWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CowRun), typeof(MonoBehaviour));
		L.RegFunction("SetSpeed", SetSpeed);
		L.RegFunction("SetPause", SetPause);
		L.RegFunction("SetStop", SetStop);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("speed", get_speed, set_speed);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CowRun obj = (CowRun)ToLua.CheckObject<CowRun>(L, 1);
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetSpeed(speed);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CowRun obj = (CowRun)ToLua.CheckObject<CowRun>(L, 1);
			bool pause = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetPause(pause);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CowRun obj = (CowRun)ToLua.CheckObject<CowRun>(L, 1);
			bool stop = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetStop(stop);
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
	private static int get_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float speed = ((CowRun)obj).speed;
			LuaDLL.lua_pushnumber(L, speed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CowRun obj2 = (CowRun)obj;
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.speed = speed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}
}
