using System;
using LuaInterface;

public class LuaInterface_DebuggerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Debugger");
		L.RegFunction("Log", Log);
		L.RegFunction("LogWarning", LogWarning);
		L.RegFunction("LogError", LogError);
		L.RegFunction("LogException", LogException);
		L.RegVar("useLog", get_useLog, set_useLog);
		L.RegVar("threadStack", get_threadStack, set_threadStack);
		L.RegVar("logger", get_logger, set_logger);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Log(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Debugger.Log(ToLua.ToString(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<object>(L, 1))
			{
				Debugger.Log(ToLua.ToVarObject(L, 1));
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, object>(L, 1))
			{
				string str = ToLua.ToString(L, 1);
				object arg = ToLua.ToVarObject(L, 2);
				Debugger.Log(str, arg);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, object, object>(L, 1))
			{
				string str2 = ToLua.ToString(L, 1);
				object arg2 = ToLua.ToVarObject(L, 2);
				object arg3 = ToLua.ToVarObject(L, 3);
				Debugger.Log(str2, arg2, arg3);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, object, object, object>(L, 1))
			{
				string str3 = ToLua.ToString(L, 1);
				object arg4 = ToLua.ToVarObject(L, 2);
				object arg5 = ToLua.ToVarObject(L, 3);
				object arg6 = ToLua.ToVarObject(L, 4);
				Debugger.Log(str3, arg4, arg5, arg6);
				return 0;
			}
			if (TypeChecker.CheckTypes<string>(L, 1) && TypeChecker.CheckParamsType<object>(L, 2, num - 1))
			{
				string str4 = ToLua.ToString(L, 1);
				object[] param = ToLua.ToParamsObject(L, 2, num - 1);
				Debugger.Log(str4, param);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaInterface.Debugger.Log");
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
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Debugger.LogWarning(ToLua.ToString(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<object>(L, 1))
			{
				Debugger.LogWarning(ToLua.ToVarObject(L, 1));
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, object>(L, 1))
			{
				string str = ToLua.ToString(L, 1);
				object arg = ToLua.ToVarObject(L, 2);
				Debugger.LogWarning(str, arg);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, object, object>(L, 1))
			{
				string str2 = ToLua.ToString(L, 1);
				object arg2 = ToLua.ToVarObject(L, 2);
				object arg3 = ToLua.ToVarObject(L, 3);
				Debugger.LogWarning(str2, arg2, arg3);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, object, object, object>(L, 1))
			{
				string str3 = ToLua.ToString(L, 1);
				object arg4 = ToLua.ToVarObject(L, 2);
				object arg5 = ToLua.ToVarObject(L, 3);
				object arg6 = ToLua.ToVarObject(L, 4);
				Debugger.LogWarning(str3, arg4, arg5, arg6);
				return 0;
			}
			if (TypeChecker.CheckTypes<string>(L, 1) && TypeChecker.CheckParamsType<object>(L, 2, num - 1))
			{
				string str4 = ToLua.ToString(L, 1);
				object[] param = ToLua.ToParamsObject(L, 2, num - 1);
				Debugger.LogWarning(str4, param);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaInterface.Debugger.LogWarning");
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
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Debugger.LogError(ToLua.ToString(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<object>(L, 1))
			{
				Debugger.LogError(ToLua.ToVarObject(L, 1));
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, object>(L, 1))
			{
				string str = ToLua.ToString(L, 1);
				object arg = ToLua.ToVarObject(L, 2);
				Debugger.LogError(str, arg);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, object, object>(L, 1))
			{
				string str2 = ToLua.ToString(L, 1);
				object arg2 = ToLua.ToVarObject(L, 2);
				object arg3 = ToLua.ToVarObject(L, 3);
				Debugger.LogError(str2, arg2, arg3);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, object, object, object>(L, 1))
			{
				string str3 = ToLua.ToString(L, 1);
				object arg4 = ToLua.ToVarObject(L, 2);
				object arg5 = ToLua.ToVarObject(L, 3);
				object arg6 = ToLua.ToVarObject(L, 4);
				Debugger.LogError(str3, arg4, arg5, arg6);
				return 0;
			}
			if (TypeChecker.CheckTypes<string>(L, 1) && TypeChecker.CheckParamsType<object>(L, 2, num - 1))
			{
				string str4 = ToLua.ToString(L, 1);
				object[] param = ToLua.ToParamsObject(L, 2, num - 1);
				Debugger.LogError(str4, param);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaInterface.Debugger.LogError");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LogException(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				Debugger.LogException((Exception)ToLua.CheckObject<Exception>(L, 1));
				return 0;
			case 2:
			{
				string str = ToLua.CheckString(L, 1);
				Exception e = (Exception)ToLua.CheckObject<Exception>(L, 2);
				Debugger.LogException(str, e);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaInterface.Debugger.LogException");
			}
		}
		catch (Exception e2)
		{
			return LuaDLL.toluaL_exception(L, e2);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useLog(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Debugger.useLog);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_threadStack(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Debugger.threadStack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_logger(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, Debugger.logger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useLog(IntPtr L)
	{
		try
		{
			Debugger.useLog = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_threadStack(IntPtr L)
	{
		try
		{
			Debugger.threadStack = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_logger(IntPtr L)
	{
		try
		{
			Debugger.logger = (ILogger)ToLua.CheckObject<ILogger>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
