using System;
using LuaInterface;

public class LuaInterface_LuaMethodWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaMethod), typeof(object));
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("Call", Call);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Destroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LuaMethod)ToLua.CheckObject(L, 1, typeof(LuaMethod))).Destroy();
			ToLua.Destroy(L);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Call(IntPtr L)
	{
		try
		{
			return ((LuaMethod)ToLua.CheckObject(L, 1, typeof(LuaMethod))).Call(L);
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
