using System;
using LuaInterface;
using UnityEngine;

public class ParticleSystemEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ParticleSystemEvent), typeof(MonoBehaviour));
		L.RegFunction("AddStartEvent", AddStartEvent);
		L.RegFunction("SetStartEvent", SetStartEvent);
		L.RegFunction("AddEndEvent", AddEndEvent);
		L.RegFunction("SetEndEvent", SetEndEvent);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddStartEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ParticleSystemEvent obj = (ParticleSystemEvent)ToLua.CheckObject<ParticleSystemEvent>(L, 1);
			Action<UnityEngine.Object> func = (Action<UnityEngine.Object>)ToLua.CheckDelegate<Action<UnityEngine.Object>>(L, 2);
			obj.AddStartEvent(func);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStartEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ParticleSystemEvent obj = (ParticleSystemEvent)ToLua.CheckObject<ParticleSystemEvent>(L, 1);
			Action<UnityEngine.Object> startEvent = (Action<UnityEngine.Object>)ToLua.CheckDelegate<Action<UnityEngine.Object>>(L, 2);
			obj.SetStartEvent(startEvent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddEndEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ParticleSystemEvent obj = (ParticleSystemEvent)ToLua.CheckObject<ParticleSystemEvent>(L, 1);
			Action<UnityEngine.Object> func = (Action<UnityEngine.Object>)ToLua.CheckDelegate<Action<UnityEngine.Object>>(L, 2);
			obj.AddEndEvent(func);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEndEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ParticleSystemEvent obj = (ParticleSystemEvent)ToLua.CheckObject<ParticleSystemEvent>(L, 1);
			Action<UnityEngine.Object> endEvent = (Action<UnityEngine.Object>)ToLua.CheckDelegate<Action<UnityEngine.Object>>(L, 2);
			obj.SetEndEvent(endEvent);
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
