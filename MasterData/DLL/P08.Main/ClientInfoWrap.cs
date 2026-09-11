using System;
using System.Collections.Generic;
using LuaInterface;

public class ClientInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ClientInfo), typeof(object));
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateClientInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("env", get_env, set_env);
		L.RegVar("configS", get_configS, set_configS);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateClientInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ClientInfo o = new ClientInfo();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ClientInfo.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((ClientInfo)ToLua.CheckObject<ClientInfo>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_env(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string env = ((ClientInfo)obj).env;
			LuaDLL.lua_pushstring(L, env);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index env on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_configS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<string, string> configS = ((ClientInfo)obj).configS;
			ToLua.PushSealed(L, configS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index configS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_env(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ClientInfo obj2 = (ClientInfo)obj;
			string env = ToLua.CheckString(L, 2);
			obj2.env = env;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index env on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_configS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ClientInfo obj2 = (ClientInfo)obj;
			Dictionary<string, string> configS = (Dictionary<string, string>)ToLua.CheckObject(L, 2, typeof(Dictionary<string, string>));
			obj2.configS = configS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index configS on a nil value");
		}
	}
}
