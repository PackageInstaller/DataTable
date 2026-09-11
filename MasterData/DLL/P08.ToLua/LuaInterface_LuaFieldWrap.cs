using System;
using LuaInterface;

public class LuaInterface_LuaFieldWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaField), typeof(object));
		L.RegFunction("Get", Get);
		L.RegFunction("Set", Set);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Get(IntPtr L)
	{
		try
		{
			return ((LuaField)ToLua.CheckObject(L, 1, typeof(LuaField))).Get(L);
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Set(IntPtr L)
	{
		try
		{
			return ((LuaField)ToLua.CheckObject(L, 1, typeof(LuaField))).Set(L);
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
