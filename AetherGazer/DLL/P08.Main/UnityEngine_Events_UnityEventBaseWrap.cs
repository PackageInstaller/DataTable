using System;
using System.Reflection;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;

public class UnityEngine_Events_UnityEventBaseWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEventBase), typeof(object));
		L.RegFunction("GetPersistentEventCount", GetPersistentEventCount);
		L.RegFunction("GetPersistentTarget", GetPersistentTarget);
		L.RegFunction("GetPersistentMethodName", GetPersistentMethodName);
		L.RegFunction("SetPersistentListenerState", SetPersistentListenerState);
		L.RegFunction("RemoveAllListeners", RemoveAllListeners);
		L.RegFunction("ToString", ToString);
		L.RegFunction("GetValidMethodInfo", GetValidMethodInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPersistentEventCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int persistentEventCount = ((UnityEventBase)ToLua.CheckObject<UnityEventBase>(L, 1)).GetPersistentEventCount();
			LuaDLL.lua_pushinteger(L, persistentEventCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPersistentTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEventBase obj = (UnityEventBase)ToLua.CheckObject<UnityEventBase>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			UnityEngine.Object persistentTarget = obj.GetPersistentTarget(index);
			ToLua.Push(L, persistentTarget);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPersistentMethodName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEventBase obj = (UnityEventBase)ToLua.CheckObject<UnityEventBase>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			string persistentMethodName = obj.GetPersistentMethodName(index);
			LuaDLL.lua_pushstring(L, persistentMethodName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPersistentListenerState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UnityEventBase obj = (UnityEventBase)ToLua.CheckObject<UnityEventBase>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			UnityEventCallState state = (UnityEventCallState)ToLua.CheckObject(L, 3, typeof(UnityEventCallState));
			obj.SetPersistentListenerState(index, state);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAllListeners(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UnityEventBase)ToLua.CheckObject<UnityEventBase>(L, 1)).RemoveAllListeners();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((UnityEventBase)ToLua.CheckObject<UnityEventBase>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetValidMethodInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.ToVarObject(L, 1);
			string functionName = ToLua.CheckString(L, 2);
			Type[] argumentTypes = ToLua.CheckObjectArray<Type>(L, 3);
			MethodInfo validMethodInfo = UnityEventBase.GetValidMethodInfo(obj, functionName, argumentTypes);
			ToLua.PushObject(L, validMethodInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
