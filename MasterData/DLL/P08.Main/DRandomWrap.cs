using System;
using LuaInterface;

public class DRandomWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DRandom), typeof(object));
		L.RegFunction("fRandom", fRandom);
		L.RegFunction("GetSeed", GetSeed);
		L.RegFunction("Random", Random);
		L.RegFunction("ResetSeed", ResetSeed);
		L.RegFunction("New", _CreateDRandom);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("callNum", get_callNum, set_callNum);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateDRandom(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				DRandom o = new DRandom();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: DRandom.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int fRandom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			float num = DRandom.fRandom();
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int seed = DRandom.GetSeed();
			LuaDLL.lua_pushinteger(L, seed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Random(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			uint num = DRandom.Random((uint)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetSeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DRandom.ResetSeed((uint)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_callNum(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, DRandom.callNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_callNum(IntPtr L)
	{
		try
		{
			DRandom.callNum = (uint)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
