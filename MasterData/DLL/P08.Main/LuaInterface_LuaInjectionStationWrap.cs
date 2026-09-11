using System;
using LuaInterface;

public class LuaInterface_LuaInjectionStationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaInjectionStation), typeof(object));
		L.RegFunction("CacheInjectFunction", CacheInjectFunction);
		L.RegFunction("Clear", Clear);
		L.RegFunction("New", _CreateLuaInterface_LuaInjectionStation);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegConstant("NOT_INJECTION_FLAG", 0.0);
		L.RegConstant("INVALID_INJECTION_FLAG", 255.0);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateLuaInterface_LuaInjectionStation(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LuaInjectionStation o = new LuaInjectionStation();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LuaInterface.LuaInjectionStation.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CacheInjectFunction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int index = (int)LuaDLL.luaL_checknumber(L, 1);
			byte injectFlag = (byte)LuaDLL.luaL_checknumber(L, 2);
			LuaFunction func = ToLua.CheckLuaFunction(L, 3);
			LuaInjectionStation.CacheInjectFunction(index, injectFlag, func);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaInjectionStation.Clear();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
