using System;
using LuaInterface;

public class FloGameLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(FloGameLuaBridge), typeof(object));
		L.RegFunction("GetGameData", GetGameData);
		L.RegFunction("SetGameData", SetGameData);
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("StopGame", StopGame);
		L.RegFunction("New", _CreateFloGameLuaBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateFloGameLuaBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				FloGameLuaBridge o = new FloGameLuaBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: FloGameLuaBridge.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGameData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string gameData = FloGameLuaBridge.GetGameData();
			LuaDLL.lua_pushstring(L, gameData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGameData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			FloGameLuaBridge.SetGameData(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			FloGameLuaBridge.StartGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			FloGameLuaBridge.StopGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
