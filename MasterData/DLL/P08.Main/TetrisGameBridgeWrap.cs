using System;
using LuaInterface;
using UnityEngine;

public class TetrisGameBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("TetrisGameBridge");
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("SetSkillInfo", SetSkillInfo);
		L.RegFunction("SetGuideInfo", SetGuideInfo);
		L.RegFunction("RefreshAllWaitChip", RefreshAllWaitChip);
		L.RegFunction("CheckNeedRefreshAllWaitChip", CheckNeedRefreshAllWaitChip);
		L.RegFunction("CheckCanPlaceWaitChip", CheckCanPlaceWaitChip);
		L.RegFunction("PauseGame", PauseGame);
		L.RegFunction("ExitGame", ExitGame);
		L.RegFunction("OverGameEnd", OverGameEnd);
		L.RegFunction("CheckIsHaveDragging", CheckIsHaveDragging);
		L.RegFunction("RefreshSpecificChip", RefreshSpecificChip);
		L.RegFunction("RotateChip", RotateChip);
		L.RegFunction("SetMachineInfoState", SetMachineInfoState);
		L.RegFunction("SetLockChip", SetLockChip);
		L.EndStaticLibs();
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
				GameObject stagePrefab2 = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				TetrisGameBridge.StartGame(stageID2, stagePrefab2);
				return 0;
			}
			case 3:
			{
				string stageID = ToLua.CheckString(L, 1);
				GameObject stagePrefab = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				int roundChipNum = (int)LuaDLL.luaL_checknumber(L, 3);
				TetrisGameBridge.StartGame(stageID, stagePrefab, roundChipNum);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: TetrisGameBridge.StartGame");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSkillInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TetrisGameBridge.SetSkillInfo((TetrisGameExchange)ToLua.CheckObject<TetrisGameExchange>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGuideInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TetrisGameBridge.SetGuideInfo((TetrisGameGuideInfo)ToLua.CheckObject<TetrisGameGuideInfo>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshAllWaitChip(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				bool value2 = TetrisGameBridge.RefreshAllWaitChip();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 1:
			{
				bool value = TetrisGameBridge.RefreshAllWaitChip(LuaDLL.luaL_checkboolean(L, 1));
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: TetrisGameBridge.RefreshAllWaitChip");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckNeedRefreshAllWaitChip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = TetrisGameBridge.CheckNeedRefreshAllWaitChip();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckCanPlaceWaitChip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = TetrisGameBridge.CheckCanPlaceWaitChip();
			LuaDLL.lua_pushboolean(L, value);
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
			TetrisGameBridge.PauseGame(LuaDLL.luaL_checkboolean(L, 1));
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
			TetrisGameBridge.ExitGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverGameEnd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			TetrisGameBridge.OverGameEnd();
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
			bool value = TetrisGameBridge.CheckIsHaveDragging();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshSpecificChip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TetrisGameBridge.RefreshSpecificChip(ToLua.CheckNumberArray<int>(L, 1));
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
			ToLua.CheckArgsCount(L, 1);
			TetrisGameBridge.RotateChip((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMachineInfoState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TetrisGameBridge.SetMachineInfoState(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLockChip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TetrisGameBridge.SetLockChip((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
