using System;
using LuaInterface;

public class SceneForLuaWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("SceneForLua");
		L.RegVar("clearLuaMemoryHandler", get_clearLuaMemoryHandler, set_clearLuaMemoryHandler);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clearLuaMemoryHandler(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SceneForLua.clearLuaMemoryHandler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clearLuaMemoryHandler(IntPtr L)
	{
		try
		{
			SceneForLua.clearLuaMemoryHandler = (Action)ToLua.CheckDelegate<Action>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
