using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class CriManaExMultipleVedioWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CriManaExMultipleVedio), typeof(MonoBehaviour));
		L.RegFunction("PlayUntilLoop", PlayUntilLoop);
		L.RegFunction("PlayByIndex", PlayByIndex);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("m_maxDataSize", get_m_maxDataSize, set_m_maxDataSize);
		L.RegVar("m_manaPlayer", get_m_manaPlayer, set_m_manaPlayer);
		L.RegVar("m_paths", get_m_paths, set_m_paths);
		L.RegVar("m_isLoop", get_m_isLoop, set_m_isLoop);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayUntilLoop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CriManaExMultipleVedio)ToLua.CheckObject<CriManaExMultipleVedio>(L, 1)).PlayUntilLoop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayByIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CriManaExMultipleVedio obj = (CriManaExMultipleVedio)ToLua.CheckObject<CriManaExMultipleVedio>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.PlayByIndex(index);
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
	private static int get_m_maxDataSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint maxDataSize = ((CriManaExMultipleVedio)obj).m_maxDataSize;
			LuaDLL.lua_pushnumber(L, maxDataSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_maxDataSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_manaPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaMovieMaterial manaPlayer = ((CriManaExMultipleVedio)obj).m_manaPlayer;
			ToLua.Push(L, manaPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_manaPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_paths(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<string> paths = ((CriManaExMultipleVedio)obj).m_paths;
			ToLua.PushSealed(L, paths);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_paths on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_isLoop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<bool> isLoop = ((CriManaExMultipleVedio)obj).m_isLoop;
			ToLua.PushSealed(L, isLoop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_isLoop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_maxDataSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaExMultipleVedio obj2 = (CriManaExMultipleVedio)obj;
			uint maxDataSize = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj2.m_maxDataSize = maxDataSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_maxDataSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_manaPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaExMultipleVedio obj2 = (CriManaExMultipleVedio)obj;
			CriManaMovieControllerForUI manaPlayer = (CriManaMovieControllerForUI)ToLua.CheckObject<CriManaMovieControllerForUI>(L, 2);
			obj2.m_manaPlayer = manaPlayer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_manaPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_paths(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaExMultipleVedio obj2 = (CriManaExMultipleVedio)obj;
			List<string> paths = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
			obj2.m_paths = paths;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_paths on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_isLoop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CriManaExMultipleVedio obj2 = (CriManaExMultipleVedio)obj;
			List<bool> isLoop = (List<bool>)ToLua.CheckObject(L, 2, typeof(List<bool>));
			obj2.m_isLoop = isLoop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_isLoop on a nil value");
		}
	}
}
