using System;
using LuaInterface;
using UnityEngine;

public class GuildActivityLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivityLuaBridge), typeof(MonoBehaviour));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("StartGuildActivity", StartGuildActivity);
		L.RegFunction("GetManager", GetManager);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GuildActivityDataForExchange musicDataForExchange = (GuildActivityDataForExchange)ToLua.CheckObject<GuildActivityDataForExchange>(L, 1);
			Action onStart = (Action)ToLua.CheckDelegate<Action>(L, 2);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 3);
			GuildActivityLuaBridge.Launcher(musicDataForExchange, onStart, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGuildActivity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GuildActivityLuaBridge.StartGuildActivity((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetManager(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GuildActivityManager manager = GuildActivityLuaBridge.GetManager();
			ToLua.Push(L, manager);
			return 1;
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
