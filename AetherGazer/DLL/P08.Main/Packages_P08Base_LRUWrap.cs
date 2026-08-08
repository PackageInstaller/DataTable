using System;
using LuaInterface;
using Packages.P08Base;

public class Packages_P08Base_LRUWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LRU), typeof(object));
		L.RegFunction("SetMaxLength", SetMaxLength);
		L.RegFunction("LimitSize", LimitSize);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreatePackages_P08Base_LRU);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePackages_P08Base_LRU(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 1)
			{
				LRU o = new LRU((int)LuaDLL.luaL_checknumber(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Packages.P08Base.LRU.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMaxLength(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LRU obj = (LRU)ToLua.CheckObject<LRU>(L, 1);
			int maxLength = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetMaxLength(maxLength);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LimitSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((LRU)ToLua.CheckObject<LRU>(L, 1)).LimitSize();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((LRU)ToLua.CheckObject<LRU>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
