using System;
using LuaInterface;
using UnityEngine;

public class ShootGameToLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ShootGameToLuaBridge), typeof(MonoBehaviour));
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("GetMaxTime", GetMaxTime);
		L.RegFunction("GetEnemyHit", GetEnemyHit);
		L.RegFunction("GetFriendHit", GetFriendHit);
		L.RegFunction("GetCurTime", GetCurTime);
		L.RegFunction("GetNowCd", GetNowCd);
		L.RegFunction("GetAnger", GetAnger);
		L.RegFunction("GetCostAnger", GetCostAnger);
		L.RegFunction("GetMaxAnger", GetMaxAnger);
		L.RegFunction("PlaySkill", PlaySkill);
		L.RegFunction("GetMaxCd", GetMaxCd);
		L.RegFunction("PauseGame", PauseGame);
		L.RegFunction("ReStartGame", ReStartGame);
		L.RegFunction("Shoot", Shoot);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ShootGameToLuaBridge.StartGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMaxTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float maxTime = ShootGameToLuaBridge.GetMaxTime();
			LuaDLL.lua_pushnumber(L, maxTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEnemyHit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float enemyHit = ShootGameToLuaBridge.GetEnemyHit();
			LuaDLL.lua_pushnumber(L, enemyHit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFriendHit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float friendHit = ShootGameToLuaBridge.GetFriendHit();
			LuaDLL.lua_pushnumber(L, friendHit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float curTime = ShootGameToLuaBridge.GetCurTime();
			LuaDLL.lua_pushnumber(L, curTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNowCd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float nowCd = ShootGameToLuaBridge.GetNowCd();
			LuaDLL.lua_pushnumber(L, nowCd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAnger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float anger = ShootGameToLuaBridge.GetAnger();
			LuaDLL.lua_pushnumber(L, anger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCostAnger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float costAnger = ShootGameToLuaBridge.GetCostAnger();
			LuaDLL.lua_pushnumber(L, costAnger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMaxAnger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float maxAnger = ShootGameToLuaBridge.GetMaxAnger();
			LuaDLL.lua_pushnumber(L, maxAnger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlaySkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ShootGameToLuaBridge.PlaySkill();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMaxCd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float maxCd = ShootGameToLuaBridge.GetMaxCd();
			LuaDLL.lua_pushnumber(L, maxCd);
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
			ToLua.CheckArgsCount(L, 0);
			ShootGameToLuaBridge.PauseGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReStartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ShootGameToLuaBridge.ReStartGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Shoot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ShootGameToLuaBridge.Shoot();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
