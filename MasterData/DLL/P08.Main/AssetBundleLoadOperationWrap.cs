using System;
using LuaInterface;

public class AssetBundleLoadOperationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AssetBundleLoadOperation), typeof(object));
		L.RegFunction("MoveNext", MoveNext);
		L.RegFunction("Reset", Reset);
		L.RegFunction("Update", Update);
		L.RegFunction("IsDone", IsDone);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("timeout", get_timeout, set_timeout);
		L.RegVar("Current", get_Current, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveNext(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((AssetBundleLoadOperation)ToLua.CheckObject<AssetBundleLoadOperation>(L, 1)).MoveNext();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetBundleLoadOperation)ToLua.CheckObject<AssetBundleLoadOperation>(L, 1)).Reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Update(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((AssetBundleLoadOperation)ToLua.CheckObject<AssetBundleLoadOperation>(L, 1)).Update();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsDone(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((AssetBundleLoadOperation)ToLua.CheckObject<AssetBundleLoadOperation>(L, 1)).IsDone();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float timeout = ((AssetBundleLoadOperation)obj).timeout;
			LuaDLL.lua_pushnumber(L, timeout);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeout on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Current(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object current = ((AssetBundleLoadOperation)obj).Current;
			ToLua.Push(L, current);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Current on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AssetBundleLoadOperation obj2 = (AssetBundleLoadOperation)obj;
			float timeout = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.timeout = timeout;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeout on a nil value");
		}
	}
}
