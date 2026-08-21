using System;
using LuaInterface;
using UnityEngine;

public class CooperateSkillBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CooperateSkillBridge), typeof(object));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("StartZumaGame", StartZumaGame);
		L.RegFunction("PlayCooperateUniqueSkill", PlayCooperateUniqueSkill);
		L.RegFunction("New", _CreateCooperateSkillBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateCooperateSkillBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				CooperateSkillBridge o = new CooperateSkillBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: CooperateSkillBridge.New");
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
			CooperateSkillBridge.Launcher();
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
			CooperateSkillBridge.StartZumaGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayCooperateUniqueSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string skinID = ToLua.CheckString(L, 1);
			string name = ToLua.CheckString(L, 2);
			GameObject o = CooperateSkillBridge.PlayCooperateUniqueSkill(skinID, name, out var length);
			ToLua.PushSealed(L, o);
			LuaDLL.lua_pushnumber(L, length);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
