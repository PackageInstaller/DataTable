using System;
using LuaInterface;
using UnityEngine;

public class EffectHelperWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EffectHelper), typeof(MonoBehaviour));
		L.RegFunction("InitHelper", InitHelper);
		L.RegFunction("Stop", Stop);
		L.RegFunction("Revert", Revert);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("LifeTime", get_LifeTime, set_LifeTime);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitHelper(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((EffectHelper)ToLua.CheckObject<EffectHelper>(L, 1)).InitHelper();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Stop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((EffectHelper)ToLua.CheckObject<EffectHelper>(L, 1)).Stop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Revert(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((EffectHelper)ToLua.CheckObject<EffectHelper>(L, 1)).Revert();
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
	private static int get_LifeTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float lifeTime = ((EffectHelper)obj).LifeTime;
			LuaDLL.lua_pushnumber(L, lifeTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LifeTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_LifeTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EffectHelper obj2 = (EffectHelper)obj;
			float lifeTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.LifeTime = lifeTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LifeTime on a nil value");
		}
	}
}
