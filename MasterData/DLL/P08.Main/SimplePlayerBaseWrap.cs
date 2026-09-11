using System;
using LuaInterface;
using UnityEngine;

public class SimplePlayerBaseWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SimplePlayerBase), typeof(MonoBehaviour));
		L.RegFunction("OnGraphStart", OnGraphStart);
		L.RegFunction("OnBehaviourPlay", OnBehaviourPlay);
		L.RegFunction("OnBehaviourPause", OnBehaviourPause);
		L.RegFunction("OnGraphStop", OnGraphStop);
		L.RegFunction("OnPlayableDestroy", OnPlayableDestroy);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnGraphStart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SimplePlayerBase)ToLua.CheckObject<SimplePlayerBase>(L, 1)).OnGraphStart();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnBehaviourPlay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SimplePlayerBase)ToLua.CheckObject<SimplePlayerBase>(L, 1)).OnBehaviourPlay();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnBehaviourPause(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SimplePlayerBase)ToLua.CheckObject<SimplePlayerBase>(L, 1)).OnBehaviourPause();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnGraphStop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SimplePlayerBase)ToLua.CheckObject<SimplePlayerBase>(L, 1)).OnGraphStop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPlayableDestroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SimplePlayerBase)ToLua.CheckObject<SimplePlayerBase>(L, 1)).OnPlayableDestroy();
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
}
