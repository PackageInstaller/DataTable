using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ResourcesWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Resources");
		L.RegFunction("FindObjectsOfTypeAll", FindObjectsOfTypeAll);
		L.RegFunction("Load", Load);
		L.RegFunction("LoadAsync", LoadAsync);
		L.RegFunction("LoadAll", LoadAll);
		L.RegFunction("GetBuiltinResource", GetBuiltinResource);
		L.RegFunction("UnloadAsset", UnloadAsset);
		L.RegFunction("UnloadUnusedAssets", UnloadUnusedAssets);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindObjectsOfTypeAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			UnityEngine.Object[] array = Resources.FindObjectsOfTypeAll(ToLua.CheckMonoType(L, 1));
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Load(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				UnityEngine.Object obj2 = Resources.Load(ToLua.CheckString(L, 1));
				ToLua.Push(L, obj2);
				return 1;
			}
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				Type systemTypeInstance = ToLua.CheckMonoType(L, 2);
				UnityEngine.Object obj = Resources.Load(path, systemTypeInstance);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Resources.Load");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				ResourceRequest o2 = Resources.LoadAsync(ToLua.CheckString(L, 1));
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				Type type = ToLua.CheckMonoType(L, 2);
				ResourceRequest o = Resources.LoadAsync(path, type);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Resources.LoadAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				UnityEngine.Object[] array2 = Resources.LoadAll(ToLua.CheckString(L, 1));
				ToLua.Push(L, array2);
				return 1;
			}
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				Type systemTypeInstance = ToLua.CheckMonoType(L, 2);
				UnityEngine.Object[] array = Resources.LoadAll(path, systemTypeInstance);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Resources.LoadAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBuiltinResource(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type type = ToLua.CheckMonoType(L, 1);
			string path = ToLua.CheckString(L, 2);
			UnityEngine.Object builtinResource = Resources.GetBuiltinResource(type, path);
			ToLua.Push(L, builtinResource);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadAsset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Resources.UnloadAsset((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadUnusedAssets(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			AsyncOperation o = Resources.UnloadUnusedAssets();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
