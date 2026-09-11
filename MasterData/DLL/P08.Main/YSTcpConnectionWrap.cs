using System;
using LuaInterface;

public class YSTcpConnectionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(YSTcpConnection), typeof(object));
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("AsyncUpdate", AsyncUpdate);
		L.RegFunction("Connect", Connect);
		L.RegFunction("Send", Send);
		L.RegFunction("Disconnect", Disconnect);
		L.RegFunction("GetDelayTime", GetDelayTime);
		L.RegFunction("New", _CreateYSTcpConnection);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("onConnected", get_onConnected, null);
		L.RegVar("onDisconnected", get_onDisconnected, null);
		L.RegVar("onData", get_onData, null);
		L.RegVar("onError", get_onError, null);
		L.RegVar("onSendFinish", get_onSendFinish, null);
		L.RegVar("host", get_host, set_host);
		L.RegVar("port", get_port, set_port);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateYSTcpConnection(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 2)
			{
				string host = ToLua.CheckString(L, 1);
				int port = (int)LuaDLL.luaL_checknumber(L, 2);
				YSTcpConnection o = new YSTcpConnection(host, port);
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: YSTcpConnection.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Dispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((YSTcpConnection)ToLua.CheckObject<YSTcpConnection>(L, 1)).Dispose();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AsyncUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((YSTcpConnection)ToLua.CheckObject<YSTcpConnection>(L, 1)).AsyncUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Connect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((YSTcpConnection)ToLua.CheckObject<YSTcpConnection>(L, 1)).Connect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Send(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			YSTcpConnection obj = (YSTcpConnection)ToLua.CheckObject<YSTcpConnection>(L, 1);
			byte[] bytes = ToLua.CheckByteBuffer(L, 2);
			obj.Send(bytes);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Disconnect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((YSTcpConnection)ToLua.CheckObject<YSTcpConnection>(L, 1)).Disconnect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDelayTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int delayTime = ((YSTcpConnection)ToLua.CheckObject<YSTcpConnection>(L, 1)).GetDelayTime();
			LuaDLL.lua_pushinteger(L, delayTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onConnected(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			YSTcpConnection.ConnectEvent onConnected = ((YSTcpConnection)obj).onConnected;
			ToLua.PushObject(L, onConnected);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onConnected on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onDisconnected(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			YSTcpConnection.DisconnectEvent onDisconnected = ((YSTcpConnection)obj).onDisconnected;
			ToLua.PushObject(L, onDisconnected);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onDisconnected on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			YSTcpConnection.PacketEvent onData = ((YSTcpConnection)obj).onData;
			ToLua.PushObject(L, onData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onError(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			YSTcpConnection.ErrorEvent onError = ((YSTcpConnection)obj).onError;
			ToLua.PushObject(L, onError);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onError on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onSendFinish(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			YSTcpConnection.ErrorEvent onSendFinish = ((YSTcpConnection)obj).onSendFinish;
			ToLua.PushObject(L, onSendFinish);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onSendFinish on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_host(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string host = ((YSTcpConnection)obj).host;
			LuaDLL.lua_pushstring(L, host);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index host on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_port(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int port = ((YSTcpConnection)obj).port;
			LuaDLL.lua_pushinteger(L, port);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index port on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_host(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			YSTcpConnection obj2 = (YSTcpConnection)obj;
			string host = ToLua.CheckString(L, 2);
			obj2.host = host;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index host on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_port(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			YSTcpConnection obj2 = (YSTcpConnection)obj;
			int port = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.port = port;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index port on a nil value");
		}
	}
}
