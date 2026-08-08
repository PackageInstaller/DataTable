using System;
using LuaInterface;
using UnityEngine;

public class PinballLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("PinballLuaBridge");
		L.RegFunction("InitTurnBasedPinballGame", InitTurnBasedPinballGame);
		L.RegFunction("GameRestart", GameRestart);
		L.RegFunction("InterruptExitGame", InterruptExitGame);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitTurnBasedPinballGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject turnBasedGameGo = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			PinballDataForExchange data = (PinballDataForExchange)ToLua.CheckObject<PinballDataForExchange>(L, 2);
			PinballLuaBridge.InitTurnBasedPinballGame(turnBasedGameGo, data);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameRestart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			PinballLuaBridge.GameRestart();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InterruptExitGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			PinballLuaBridge.InterruptExitGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
