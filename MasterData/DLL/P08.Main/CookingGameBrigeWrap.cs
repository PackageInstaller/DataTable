using System;
using LuaInterface;

public class CookingGameBrigeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("CookingGameBrige");
		L.RegFunction("LoadGame", LoadGame);
		L.RegFunction("GetCookData", GetCookData);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string stepDataName = ToLua.CheckString(L, 1);
			bool isBattle = LuaDLL.luaL_checkboolean(L, 2);
			CookingGameBrige.LoadGame(stepDataName, isBattle);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCookData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string cookData = CookingGameBrige.GetCookData();
			LuaDLL.lua_pushstring(L, cookData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
