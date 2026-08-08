using System;
using LuaInterface;

public class TangramDataExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TangramDataExchange), typeof(object));
		L.RegFunction("New", _CreateTangramDataExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("finfishList", get_finfishList, set_finfishList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateTangramDataExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				TangramDataExchange o = new TangramDataExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: TangramDataExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_finfishList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] finfishList = ((TangramDataExchange)obj).finfishList;
			ToLua.Push(L, finfishList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index finfishList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_finfishList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TangramDataExchange obj2 = (TangramDataExchange)obj;
			int[] finfishList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.finfishList = finfishList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index finfishList on a nil value");
		}
	}
}
