using System;
using LuaInterface;
using UnityEngine;

public class SkuldPuzzleBrigeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("SkuldPuzzleBrige");
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("OpenStoryMode", OpenStoryMode);
		L.RegFunction("ResetGame", ResetGame);
		L.RegFunction("ExitGame", ExitGame);
		L.RegFunction("GetUseTimes", GetUseTimes);
		L.RegFunction("PauseGame", PauseGame);
		L.RegFunction("CheckIsHaveDragging", CheckIsHaveDragging);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string stageID = ToLua.CheckString(L, 1);
			GameObject stagePrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			SkuldPuzzleConditionDataList conditonList = (SkuldPuzzleConditionDataList)ToLua.CheckObject<SkuldPuzzleConditionDataList>(L, 3);
			SkuldPuzzleBrige.StartGame(stageID, stagePrefab, conditonList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenStoryMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			SkuldPuzzleBrige.OpenStoryMode(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			SkuldPuzzleBrige.ResetGame();
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
			SkuldPuzzleBrige.ExitGame();
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
			float useTimes = SkuldPuzzleBrige.GetUseTimes();
			LuaDLL.lua_pushnumber(L, useTimes);
			return 1;
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
			SkuldPuzzleBrige.PauseGame(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckIsHaveDragging(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = SkuldPuzzleBrige.CheckIsHaveDragging();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
