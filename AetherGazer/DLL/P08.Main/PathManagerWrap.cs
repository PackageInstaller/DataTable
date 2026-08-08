using System;
using LuaInterface;

public class PathManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PathManager), typeof(object));
		L.RegFunction("Init", Init);
		L.RegFunction("GetLuaBundle", GetLuaBundle);
		L.RegFunction("GetAssetBundle", GetAssetBundle);
		L.RegFunction("GetShortAssetBundle", GetShortAssetBundle);
		L.RegFunction("GetStreamingAsset", GetStreamingAsset);
		L.RegFunction("GetPlatformName", GetPlatformName);
		L.RegFunction("New", _CreatePathManager);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("inst", get_inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePathManager(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				PathManager o = new PathManager();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: PathManager.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PathManager)ToLua.CheckObject<PathManager>(L, 1)).Init();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLuaBundle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string luaBundle = ((PathManager)ToLua.CheckObject<PathManager>(L, 1)).GetLuaBundle();
			LuaDLL.lua_pushstring(L, luaBundle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAssetBundle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PathManager obj = (PathManager)ToLua.CheckObject<PathManager>(L, 1);
			string path = ToLua.CheckString(L, 2);
			string assetBundle = obj.GetAssetBundle(path);
			LuaDLL.lua_pushstring(L, assetBundle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetShortAssetBundle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PathManager obj = (PathManager)ToLua.CheckObject<PathManager>(L, 1);
			string absPath = ToLua.CheckString(L, 2);
			string shortAssetBundle = obj.GetShortAssetBundle(absPath);
			LuaDLL.lua_pushstring(L, shortAssetBundle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStreamingAsset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PathManager obj = (PathManager)ToLua.CheckObject<PathManager>(L, 1);
			string path = ToLua.CheckString(L, 2);
			string streamingAsset = obj.GetStreamingAsset(path);
			LuaDLL.lua_pushstring(L, streamingAsset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlatformName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string platformName = PathManager.GetPlatformName();
			LuaDLL.lua_pushstring(L, platformName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inst(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, PathManager.inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
