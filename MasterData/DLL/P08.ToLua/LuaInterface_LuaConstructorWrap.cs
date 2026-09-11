using System;
using LuaInterface;

public class LuaInterface_LuaConstructorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaConstructor), typeof(object));
		L.RegFunction("Call", Call);
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Call(IntPtr L)
	{
		try
		{
			return ((LuaConstructor)ToLua.CheckObject(L, 1, typeof(LuaConstructor))).Call(L);
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Destroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LuaConstructor)ToLua.CheckObject(L, 1, typeof(LuaConstructor))).Destroy();
			ToLua.Destroy(L);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
