using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_BehaviourWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Behaviour), typeof(Component));
		L.RegFunction("New", _CreateUnityEngine_Behaviour);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("enabled", get_enabled, set_enabled);
		L.RegVar("isActiveAndEnabled", get_isActiveAndEnabled, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Behaviour(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Behaviour obj = new Behaviour();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Behaviour.New");
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
	private static int get_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enabled = ((Behaviour)obj).enabled;
			LuaDLL.lua_pushboolean(L, enabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isActiveAndEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isActiveAndEnabled = ((Behaviour)obj).isActiveAndEnabled;
			LuaDLL.lua_pushboolean(L, isActiveAndEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isActiveAndEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Behaviour obj2 = (Behaviour)obj;
			bool enabled = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enabled = enabled;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enabled on a nil value");
		}
	}
}
