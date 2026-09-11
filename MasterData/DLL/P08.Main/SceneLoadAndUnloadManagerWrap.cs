using System;
using LuaInterface;
using UnityEngine;

public class SceneLoadAndUnloadManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SceneLoadAndUnloadManager), typeof(MonoBehaviour));
		L.RegFunction("ChangeScene", ChangeScene);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mInstance", get_mInstance, set_mInstance);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			SceneLoadAndUnloadManager obj = (SceneLoadAndUnloadManager)ToLua.CheckObject<SceneLoadAndUnloadManager>(L, 1);
			string fullPath = ToLua.CheckString(L, 2);
			string unloadScene = ToLua.CheckString(L, 3);
			Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
			obj.ChangeScene(fullPath, unloadScene, callBack);
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
	private static int get_mInstance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SceneLoadAndUnloadManager.mInstance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SceneLoadAndUnloadManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mInstance(IntPtr L)
	{
		try
		{
			SceneLoadAndUnloadManager.mInstance = (SceneLoadAndUnloadManager)ToLua.CheckObject<SceneLoadAndUnloadManager>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
