using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.SceneManagement;

public class UnityEngine_SceneManagement_SceneWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Scene), null);
		L.RegFunction("IsValid", IsValid);
		L.RegFunction("GetRootGameObjects", GetRootGameObjects);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("Equals", Equals);
		L.RegFunction("New", _CreateUnityEngine_SceneManagement_Scene);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("handle", get_handle, null);
		L.RegVar("path", get_path, null);
		L.RegVar("name", get_name, set_name);
		L.RegVar("isLoaded", get_isLoaded, null);
		L.RegVar("buildIndex", get_buildIndex, null);
		L.RegVar("isDirty", get_isDirty, null);
		L.RegVar("rootCount", get_rootCount, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_SceneManagement_Scene(IntPtr L)
	{
		ToLua.PushValue(L, default(Scene));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsValid(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Scene scene = (Scene)ToLua.CheckObject(L, 1, typeof(Scene));
			bool value = scene.IsValid();
			LuaDLL.lua_pushboolean(L, value);
			ToLua.SetBack(L, 1, scene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRootGameObjects(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Scene scene2 = (Scene)ToLua.CheckObject(L, 1, typeof(Scene));
				GameObject[] rootGameObjects2 = scene2.GetRootGameObjects();
				ToLua.Push(L, rootGameObjects2);
				ToLua.SetBack(L, 1, scene2);
				return 1;
			}
			case 2:
			{
				Scene scene = (Scene)ToLua.CheckObject(L, 1, typeof(Scene));
				List<GameObject> rootGameObjects = (List<GameObject>)ToLua.CheckObject(L, 2, typeof(List<GameObject>));
				scene.GetRootGameObjects(rootGameObjects);
				ToLua.SetBack(L, 1, scene);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.SceneManagement.Scene.GetRootGameObjects");
			}
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
			Scene scene = StackTraits<Scene>.To(L, 1);
			Scene scene2 = StackTraits<Scene>.To(L, 2);
			bool value = scene == scene2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHashCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Scene scene = (Scene)ToLua.CheckObject(L, 1, typeof(Scene));
			int hashCode = scene.GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			ToLua.SetBack(L, 1, scene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Equals(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Scene scene = (Scene)ToLua.CheckObject(L, 1, typeof(Scene));
			object obj = ToLua.ToVarObject(L, 2);
			bool value = scene.Equals(obj);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.SetBack(L, 1, scene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int handle = ((Scene)obj).handle;
			LuaDLL.lua_pushinteger(L, handle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_path(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string path = ((Scene)obj).path;
			LuaDLL.lua_pushstring(L, path);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index path on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string name = ((Scene)obj).name;
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLoaded(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLoaded = ((Scene)obj).isLoaded;
			LuaDLL.lua_pushboolean(L, isLoaded);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLoaded on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_buildIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int buildIndex = ((Scene)obj).buildIndex;
			LuaDLL.lua_pushinteger(L, buildIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buildIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isDirty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isDirty = ((Scene)obj).isDirty;
			LuaDLL.lua_pushboolean(L, isDirty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDirty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rootCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rootCount = ((Scene)obj).rootCount;
			LuaDLL.lua_pushinteger(L, rootCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Scene scene = (Scene)obj;
			string name = ToLua.CheckString(L, 2);
			scene.name = name;
			ToLua.SetBack(L, 1, scene);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}
}
