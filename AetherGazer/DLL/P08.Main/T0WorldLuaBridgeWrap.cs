using System;
using LuaInterface;

public class T0WorldLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("T0WorldLuaBridge");
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("EnterChapterMode", EnterChapterMode);
		L.RegFunction("ChangeCapturePose", ChangeCapturePose);
		L.RegFunction("ChangeCaptureScene", ChangeCaptureScene);
		L.RegFunction("CheckIsHaveExitEventAndDo", CheckIsHaveExitEventAndDo);
		L.RegVar("loadingCharacterID", get_loadingCharacterID, set_loadingCharacterID);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			string sceneName = ToLua.CheckString(L, 1);
			int characterID = (int)LuaDLL.luaL_checknumber(L, 2);
			int sceneID = (int)LuaDLL.luaL_checknumber(L, 3);
			bool todayFirstEnter = LuaDLL.luaL_checkboolean(L, 4);
			T0WorldLuaBridge.Launcher(sceneName, characterID, sceneID, todayFirstEnter);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterChapterMode(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				T0WorldLuaBridge.EnterChapterMode();
				return 0;
			case 1:
				T0WorldLuaBridge.EnterChapterMode(LuaDLL.luaL_checkboolean(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: T0WorldLuaBridge.EnterChapterMode");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeCapturePose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int filterType = (int)LuaDLL.luaL_checknumber(L, 1);
			string poseName = ToLua.CheckString(L, 2);
			T0WorldLuaBridge.ChangeCapturePose(filterType, poseName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeCaptureScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			T0WorldLuaBridge.ChangeCaptureScene((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckIsHaveExitEventAndDo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = T0WorldLuaBridge.CheckIsHaveExitEventAndDo();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loadingCharacterID(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, T0WorldLuaBridge.loadingCharacterID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loadingCharacterID(IntPtr L)
	{
		try
		{
			T0WorldLuaBridge.loadingCharacterID = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
