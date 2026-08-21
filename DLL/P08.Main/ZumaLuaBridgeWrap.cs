using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class ZumaLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ZumaLuaBridge), typeof(object));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("StartZumaGame", StartZumaGame);
		L.RegFunction("GetCurTime", GetCurTime);
		L.RegFunction("PauseZumaGame", PauseZumaGame);
		L.RegFunction("ReStartZumaGame", ReStartZumaGame);
		L.RegFunction("UseZumaSkill", UseZumaSkill);
		L.RegFunction("SetZumaGameCountdownUI", SetZumaGameCountdownUI);
		L.RegFunction("ReChallengeZumaGame", ReChallengeZumaGame);
		L.RegFunction("New", _CreateZumaLuaBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateZumaLuaBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ZumaLuaBridge o = new ZumaLuaBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ZumaLuaBridge.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ZumaLuaBridge.Launcher((ZumaDataForExchange)ToLua.CheckObject<ZumaDataForExchange>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartZumaGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ZumaLuaBridge.StartZumaGame();
			return 0;
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
			float curTime = ZumaLuaBridge.GetCurTime();
			LuaDLL.lua_pushnumber(L, curTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PauseZumaGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ZumaLuaBridge.PauseZumaGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReStartZumaGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ZumaLuaBridge.ReStartZumaGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UseZumaSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ZumaLuaBridge.UseZumaSkill();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetZumaGameCountdownUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Animator timeAni = (Animator)ToLua.CheckObject<Animator>(L, 1);
			Text timeCountdownUI = (Text)ToLua.CheckObject<Text>(L, 2);
			Text skillCountdownUI = (Text)ToLua.CheckObject<Text>(L, 3);
			Image skillProgressImg = (Image)ToLua.CheckObject<Image>(L, 4);
			ZumaLuaBridge.SetZumaGameCountdownUI(timeAni, timeCountdownUI, skillCountdownUI, skillProgressImg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReChallengeZumaGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ZumaLuaBridge.ReChallengeZumaGame((ZumaDataForExchange)ToLua.CheckObject<ZumaDataForExchange>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
