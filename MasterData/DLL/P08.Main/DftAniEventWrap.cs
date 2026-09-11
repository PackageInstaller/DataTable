using System;
using LuaInterface;
using UnityEngine;

public class DftAniEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DftAniEvent), typeof(MonoBehaviour));
		L.RegFunction("AddStartEvent", AddStartEvent);
		L.RegFunction("AddTriggerEvent", AddTriggerEvent);
		L.RegFunction("AddEndEvent", AddEndEvent);
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
			DftAniEvent obj = (DftAniEvent)ToLua.CheckObject<DftAniEvent>(L, 1);
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
	private static int AddTriggerEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DftAniEvent obj = (DftAniEvent)ToLua.CheckObject<DftAniEvent>(L, 1);
			Action<UnityEngine.Object> func = (Action<UnityEngine.Object>)ToLua.CheckDelegate<Action<UnityEngine.Object>>(L, 2);
			obj.AddTriggerEvent(func);
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
			DftAniEvent obj = (DftAniEvent)ToLua.CheckObject<DftAniEvent>(L, 1);
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
