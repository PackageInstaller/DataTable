using System;
using LuaInterface;

public class BlisterGameLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BlisterGameLuaBridge), typeof(object));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("GetCurTime", GetCurTime);
		L.RegFunction("PauseGame", PauseGame);
		L.RegFunction("ReStartGame", ReStartGame);
		L.RegFunction("IsInAnim", IsInAnim);
		L.RegFunction("New", _CreateBlisterGameLuaBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBlisterGameLuaBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				BlisterGameLuaBridge o = new BlisterGameLuaBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BlisterGameLuaBridge.New");
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
			BlisterGameLuaBridge.Launcher(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			BlisterGameLuaBridge.StartGame();
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
			float curTime = BlisterGameLuaBridge.GetCurTime();
			LuaDLL.lua_pushnumber(L, curTime);
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
			BlisterGameLuaBridge.PauseGame();
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
			BlisterGameLuaBridge.ReStartGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsInAnim(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = BlisterGameLuaBridge.IsInAnim();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
