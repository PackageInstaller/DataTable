using System;
using LuaInterface;

public class CacheAssetInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CacheAssetInfo), typeof(object));
		L.RegFunction("New", _CreateCacheAssetInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("assetPath", get_assetPath, set_assetPath);
		L.RegVar("num", get_num, set_num);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateCacheAssetInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				CacheAssetInfo o = new CacheAssetInfo();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: CacheAssetInfo.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_assetPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string assetPath = ((CacheAssetInfo)obj).assetPath;
			LuaDLL.lua_pushstring(L, assetPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index assetPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int num = ((CacheAssetInfo)obj).num;
			LuaDLL.lua_pushinteger(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_assetPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CacheAssetInfo obj2 = (CacheAssetInfo)obj;
			string assetPath = ToLua.CheckString(L, 2);
			obj2.assetPath = assetPath;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index assetPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CacheAssetInfo obj2 = (CacheAssetInfo)obj;
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.num = num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index num on a nil value");
		}
	}
}
