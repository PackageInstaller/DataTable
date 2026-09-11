using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_MotionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Motion), typeof(UnityEngine.Object));
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("averageDuration", get_averageDuration, null);
		L.RegVar("averageAngularSpeed", get_averageAngularSpeed, null);
		L.RegVar("averageSpeed", get_averageSpeed, null);
		L.RegVar("apparentSpeed", get_apparentSpeed, null);
		L.RegVar("isLooping", get_isLooping, null);
		L.RegVar("legacy", get_legacy, null);
		L.RegVar("isHumanMotion", get_isHumanMotion, null);
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
	private static int get_averageDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float averageDuration = ((Motion)obj).averageDuration;
			LuaDLL.lua_pushnumber(L, averageDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index averageDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_averageAngularSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float averageAngularSpeed = ((Motion)obj).averageAngularSpeed;
			LuaDLL.lua_pushnumber(L, averageAngularSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index averageAngularSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_averageSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 averageSpeed = ((Motion)obj).averageSpeed;
			ToLua.Push(L, averageSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index averageSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_apparentSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float apparentSpeed = ((Motion)obj).apparentSpeed;
			LuaDLL.lua_pushnumber(L, apparentSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index apparentSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLooping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLooping = ((Motion)obj).isLooping;
			LuaDLL.lua_pushboolean(L, isLooping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLooping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_legacy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool legacy = ((Motion)obj).legacy;
			LuaDLL.lua_pushboolean(L, legacy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index legacy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isHumanMotion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isHumanMotion = ((Motion)obj).isHumanMotion;
			LuaDLL.lua_pushboolean(L, isHumanMotion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isHumanMotion on a nil value");
		}
	}
}
