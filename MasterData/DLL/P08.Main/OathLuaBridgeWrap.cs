using System;
using LuaInterface;

public class OathLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("OathLuaBridge");
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("ChangeCapturePose", ChangeCapturePose);
		L.RegFunction("InvokeSkip", InvokeSkip);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string sceneName = ToLua.CheckString(L, 1);
			int oathCharacterID = (int)LuaDLL.luaL_checknumber(L, 2);
			int sceneMode = (int)LuaDLL.luaL_checknumber(L, 3);
			OathLuaBridge.Launcher(sceneName, oathCharacterID, sceneMode);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeCapturePose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int filterType = (int)LuaDLL.luaL_checknumber(L, 1);
			string poseName = ToLua.CheckString(L, 2);
			OathLuaBridge.ChangeCapturePose(filterType, poseName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InvokeSkip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			OathLuaBridge.InvokeSkip();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
