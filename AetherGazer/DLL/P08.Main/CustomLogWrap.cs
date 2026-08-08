using System;
using LuaInterface;

public class CustomLogWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("CustomLog");
		L.RegFunction("SetUserID", SetUserID);
		L.RegFunction("SetSceneID", SetSceneID);
		L.RegFunction("SetSceneData", SetSceneData);
		L.RegFunction("Log", Log);
		L.RegFunction("LogError", LogError);
		L.RegFunction("LogWarning", LogWarning);
		L.RegVar("overrideSetUserID", get_overrideSetUserID, set_overrideSetUserID);
		L.RegVar("overrideSetSceneID", get_overrideSetSceneID, set_overrideSetSceneID);
		L.RegVar("overrideSetSceneData", get_overrideSetSceneData, set_overrideSetSceneData);
		L.RegVar("overrideLog", get_overrideLog, set_overrideLog);
		L.RegVar("overrideLogWarning", get_overrideLogWarning, set_overrideLogWarning);
		L.RegVar("overrideLogError", get_overrideLogError, set_overrideLogError);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetUserID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CustomLog.SetUserID(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSceneID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CustomLog.SetSceneID((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSceneData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object key = ToLua.ToVarObject(L, 1);
			object value = ToLua.ToVarObject(L, 2);
			CustomLog.SetSceneData(key, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Log(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CustomLog.Log(ToLua.ToVarObject(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LogError(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CustomLog.LogError(ToLua.ToVarObject(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LogWarning(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CustomLog.LogWarning(ToLua.ToVarObject(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overrideSetUserID(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CustomLog.overrideSetUserID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overrideSetSceneID(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CustomLog.overrideSetSceneID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overrideSetSceneData(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CustomLog.overrideSetSceneData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overrideLog(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CustomLog.overrideLog);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overrideLogWarning(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CustomLog.overrideLogWarning);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overrideLogError(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CustomLog.overrideLogError);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overrideSetUserID(IntPtr L)
	{
		try
		{
			CustomLog.overrideSetUserID = (OnVoidHandler<string>)ToLua.CheckDelegate<OnVoidHandler<string>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overrideSetSceneID(IntPtr L)
	{
		try
		{
			CustomLog.overrideSetSceneID = (OnVoidHandler<int>)ToLua.CheckDelegate<OnVoidHandler<int>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overrideSetSceneData(IntPtr L)
	{
		try
		{
			CustomLog.overrideSetSceneData = (OnVoidHandler<object, object>)ToLua.CheckDelegate<OnVoidHandler<object, object>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overrideLog(IntPtr L)
	{
		try
		{
			CustomLog.overrideLog = (OnVoidHandler<object>)ToLua.CheckDelegate<OnVoidHandler<object>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overrideLogWarning(IntPtr L)
	{
		try
		{
			CustomLog.overrideLogWarning = (OnVoidHandler<object>)ToLua.CheckDelegate<OnVoidHandler<object>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overrideLogError(IntPtr L)
	{
		try
		{
			CustomLog.overrideLogError = (OnVoidHandler<object>)ToLua.CheckDelegate<OnVoidHandler<object>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
