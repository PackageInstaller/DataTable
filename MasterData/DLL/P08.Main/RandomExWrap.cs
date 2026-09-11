using System;
using LuaInterface;

public class RandomExWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RandomEx), typeof(object));
		L.RegFunction("NextInt", NextInt);
		L.RegFunction("NextIntRange", NextIntRange);
		L.RegFunction("Next", Next);
		L.RegFunction("NextDouble", NextDouble);
		L.RegFunction("New", _CreateRandomEx);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRandomEx(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 1)
			{
				RandomEx o = new RandomEx((int)LuaDLL.luaL_checknumber(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RandomEx.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NextInt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RandomEx obj = (RandomEx)ToLua.CheckObject<RandomEx>(L, 1);
			int range = (int)LuaDLL.luaL_checknumber(L, 2);
			int n = obj.NextInt(range);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NextIntRange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RandomEx obj = (RandomEx)ToLua.CheckObject<RandomEx>(L, 1);
			int begin = (int)LuaDLL.luaL_checknumber(L, 2);
			int end = (int)LuaDLL.luaL_checknumber(L, 3);
			int n = obj.NextIntRange(begin, end);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Next(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RandomEx obj = (RandomEx)ToLua.CheckObject<RandomEx>(L, 1);
			int begin = (int)LuaDLL.luaL_checknumber(L, 2);
			int end = (int)LuaDLL.luaL_checknumber(L, 3);
			int n = obj.Next(begin, end);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NextDouble(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			double number = ((RandomEx)ToLua.CheckObject<RandomEx>(L, 1)).NextDouble();
			LuaDLL.lua_pushnumber(L, number);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
