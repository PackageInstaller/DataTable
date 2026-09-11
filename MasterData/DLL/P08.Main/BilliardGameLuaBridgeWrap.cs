using System;
using BilliardGame;
using BilliardGame.Runtime;
using LuaInterface;
using UnityEngine;

public class BilliardGameLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("BilliardGameLuaBridge");
		L.RegFunction("EntraceLauncher", EntraceLauncher);
		L.RegFunction("BindBilliardGameUI", BindBilliardGameUI);
		L.RegFunction("GetStageData", GetStageData);
		L.RegFunction("GetRoundNum", GetRoundNum);
		L.RegFunction("CheckDrag", CheckDrag);
		L.RegFunction("SetGuideInfo", SetGuideInfo);
		L.RegFunction("GetTrigger", GetTrigger);
		L.RegFunction("GetExchangeData", GetExchangeData);
		L.RegFunction("SaveMergeGroup", SaveMergeGroup);
		L.RegFunction("RemoveBuff", RemoveBuff);
		L.RegFunction("AddBuff", AddBuff);
		L.RegFunction("SetSelectBuffOver", SetSelectBuffOver);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EntraceLauncher(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int stageId2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int heroId = (int)LuaDLL.luaL_checknumber(L, 2);
				BilliardGameLuaBridge.EntraceLauncher(stageId2, heroId);
				return 0;
			}
			case 4:
			{
				int stageId = (int)LuaDLL.luaL_checknumber(L, 1);
				int hero = (int)LuaDLL.luaL_checknumber(L, 2);
				int hero2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int hero3 = (int)LuaDLL.luaL_checknumber(L, 4);
				BilliardGameLuaBridge.EntraceLauncher(stageId, hero, hero2, hero3);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: BilliardGameLuaBridge.EntraceLauncher");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BindBilliardGameUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			BilliardGameLuaBridge.BindBilliardGameUI((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStageData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			StageData stageData = BilliardGameLuaBridge.GetStageData();
			ToLua.Push(L, stageData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRoundNum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int roundNum = BilliardGameLuaBridge.GetRoundNum();
			LuaDLL.lua_pushinteger(L, roundNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float x = (float)LuaDLL.luaL_checknumber(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			bool value = BilliardGameLuaBridge.CheckDrag(x, y);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			ToLua.CheckArgsCount(L, 2);
			float x = (float)LuaDLL.luaL_checknumber(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			BilliardGameLuaBridge.SetGuideInfo(x, y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTrigger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			BilliardGameEventTrigger trigger = BilliardGameLuaBridge.GetTrigger();
			ToLua.Push(L, trigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetExchangeData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			BilliardGameExchangeData exchangeData = BilliardGameLuaBridge.GetExchangeData();
			ToLua.PushObject(L, exchangeData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveMergeGroup(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int[] buffIdList = ToLua.CheckNumberArray<int>(L, 1);
			int playerId = (int)LuaDLL.luaL_checknumber(L, 2);
			BilliardGameLuaBridge.SaveMergeGroup(buffIdList, playerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveBuff(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int buffId = (int)LuaDLL.luaL_checknumber(L, 1);
			int playerId = (int)LuaDLL.luaL_checknumber(L, 2);
			BilliardGameLuaBridge.RemoveBuff(buffId, playerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddBuff(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int buffId = (int)LuaDLL.luaL_checknumber(L, 1);
			int playerId = (int)LuaDLL.luaL_checknumber(L, 2);
			BilliardGameLuaBridge.AddBuff(buffId, playerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectBuffOver(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			BilliardGameLuaBridge.SetSelectBuffOver(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
