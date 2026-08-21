using System;
using LuaInterface;

public class TugGameToLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("TugGameToLuaBridge");
		L.RegFunction("LoadConfig", LoadConfig);
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("EndGame", EndGame);
		L.RegFunction("PauseGame", PauseGame);
		L.RegFunction("SetTugGameObjectPosition", SetTugGameObjectPosition);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadConfig(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TugGameData obj = TugGameToLuaBridge.LoadConfig(ToLua.CheckString(L, 1));
			ToLua.Push(L, obj);
			return 1;
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string stageID2 = ToLua.CheckString(L, 1);
				string stagePrefabPath2 = ToLua.CheckString(L, 2);
				TugGameToLuaBridge.StartGame(stageID2, stagePrefabPath2);
				return 0;
			}
			case 3:
			{
				string stageID = ToLua.CheckString(L, 1);
				string stagePrefabPath = ToLua.CheckString(L, 2);
				int roundChipNum = (int)LuaDLL.luaL_checknumber(L, 3);
				TugGameToLuaBridge.StartGame(stageID, stagePrefabPath, roundChipNum);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: TugGameToLuaBridge.StartGame");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			TugGameToLuaBridge.EndGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PauseGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TugGameToLuaBridge.PauseGame(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTugGameObjectPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			TugGameToLuaBridge.SetTugGameObjectPosition();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
