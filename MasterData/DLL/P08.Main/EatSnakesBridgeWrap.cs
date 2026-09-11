using System;
using LuaInterface;

public class EatSnakesBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EatSnakesBridge), typeof(object));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("New", _CreateEatSnakesBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateEatSnakesBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				EatSnakesBridge o = new EatSnakesBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: EatSnakesBridge.New");
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
			ToLua.CheckArgsCount(L, 0);
			EatSnakesBridge.Launcher();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
