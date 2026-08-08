using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AnimatorStateInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AnimatorStateInfo), null);
		L.RegFunction("IsName", IsName);
		L.RegFunction("IsTag", IsTag);
		L.RegFunction("New", _CreateUnityEngine_AnimatorStateInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("fullPathHash", get_fullPathHash, null);
		L.RegVar("shortNameHash", get_shortNameHash, null);
		L.RegVar("normalizedTime", get_normalizedTime, null);
		L.RegVar("length", get_length, null);
		L.RegVar("speed", get_speed, null);
		L.RegVar("speedMultiplier", get_speedMultiplier, null);
		L.RegVar("tagHash", get_tagHash, null);
		L.RegVar("loop", get_loop, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_AnimatorStateInfo(IntPtr L)
	{
		ToLua.PushValue(L, default(AnimatorStateInfo));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimatorStateInfo animatorStateInfo = (AnimatorStateInfo)ToLua.CheckObject(L, 1, typeof(AnimatorStateInfo));
			string name = ToLua.CheckString(L, 2);
			bool value = animatorStateInfo.IsName(name);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.SetBack(L, 1, animatorStateInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AnimatorStateInfo animatorStateInfo = (AnimatorStateInfo)ToLua.CheckObject(L, 1, typeof(AnimatorStateInfo));
			string tag = ToLua.CheckString(L, 2);
			bool value = animatorStateInfo.IsTag(tag);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.SetBack(L, 1, animatorStateInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fullPathHash(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int fullPathHash = ((AnimatorStateInfo)obj).fullPathHash;
			LuaDLL.lua_pushinteger(L, fullPathHash);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fullPathHash on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shortNameHash(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int shortNameHash = ((AnimatorStateInfo)obj).shortNameHash;
			LuaDLL.lua_pushinteger(L, shortNameHash);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shortNameHash on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_normalizedTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float normalizedTime = ((AnimatorStateInfo)obj).normalizedTime;
			LuaDLL.lua_pushnumber(L, normalizedTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalizedTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_length(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float length = ((AnimatorStateInfo)obj).length;
			LuaDLL.lua_pushnumber(L, length);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index length on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float speed = ((AnimatorStateInfo)obj).speed;
			LuaDLL.lua_pushnumber(L, speed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_speedMultiplier(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float speedMultiplier = ((AnimatorStateInfo)obj).speedMultiplier;
			LuaDLL.lua_pushnumber(L, speedMultiplier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speedMultiplier on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tagHash(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int tagHash = ((AnimatorStateInfo)obj).tagHash;
			LuaDLL.lua_pushinteger(L, tagHash);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tagHash on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool loop = ((AnimatorStateInfo)obj).loop;
			LuaDLL.lua_pushboolean(L, loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}
}
