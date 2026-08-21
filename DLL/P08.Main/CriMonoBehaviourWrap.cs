using System;
using LuaInterface;
using UnityEngine;

public class CriMonoBehaviourWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CriMonoBehaviour), typeof(MonoBehaviour));
		L.RegFunction("CriInternalUpdate", CriInternalUpdate);
		L.RegFunction("CriInternalLateUpdate", CriInternalLateUpdate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("guid", get_guid, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriInternalUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriMonoBehaviour)ToLua.CheckObject<CriMonoBehaviour>(L, 1)).CriInternalUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriInternalLateUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriMonoBehaviour)ToLua.CheckObject<CriMonoBehaviour>(L, 1)).CriInternalLateUpdate();
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
	private static int get_guid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Guid guid = ((CriMonoBehaviour)obj).guid;
			ToLua.PushValue(L, guid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guid on a nil value");
		}
	}
}
