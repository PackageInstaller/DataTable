using System;
using LuaInterface;
using UnityEngine;

public class TangramGameBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("TangramGameBridge");
		L.RegFunction("InitGame", InitGame);
		L.RegFunction("StartStage", StartStage);
		L.RegFunction("DisposeStage", DisposeStage);
		L.RegFunction("FinishStage", FinishStage);
		L.RegFunction("FinishStageChip", FinishStageChip);
		L.RegFunction("ResetAllStageChip", ResetAllStageChip);
		L.RegFunction("RotateChip", RotateChip);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TangramGameBridge.InitGame((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TangramDataExchange data = (TangramDataExchange)ToLua.CheckObject<TangramDataExchange>(L, 1);
			string stageID = ToLua.CheckString(L, 2);
			TangramGameBridge.StartStage(data, stageID);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisposeStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			TangramGameBridge.DisposeStage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FinishStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TangramGameBridge.FinishStage(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FinishStageChip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TangramGameBridge.FinishStageChip((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetAllStageChip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			TangramGameBridge.ResetAllStageChip();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateChip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			TangramGameBridge.RotateChip();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
