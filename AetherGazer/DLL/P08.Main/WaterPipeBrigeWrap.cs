using System;
using LuaInterface;
using UnityEngine;

public class WaterPipeBrigeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("WaterPipeBrige");
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("PauseGame", PauseGame);
		L.RegFunction("ExitGame", ExitGame);
		L.RegFunction("DisposeGame", DisposeGame);
		L.RegFunction("PlayHeroBeginMove", PlayHeroBeginMove);
		L.RegFunction("GetUseTimes", GetUseTimes);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int stageID = (int)LuaDLL.luaL_checknumber(L, 1);
			int[] eventOrderSort = ToLua.CheckNumberArray<int>(L, 2);
			GameObject stagePrefab = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
			WaterPipeBrige.StartGame(stageID, eventOrderSort, stagePrefab);
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
			WaterPipeBrige.PauseGame(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			WaterPipeBrige.ExitGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisposeGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			WaterPipeBrige.DisposeGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayHeroBeginMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			WaterPipeBrige.PlayHeroBeginMove();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUseTimes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float useTimes = WaterPipeBrige.GetUseTimes();
			LuaDLL.lua_pushnumber(L, useTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
