using System;
using System.Net.Sockets;
using LuaInterface;
using UnityEngine.Events;

public class YSTcpConnection_ConnectEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(YSTcpConnection.ConnectEvent), typeof(UnityEvent<SocketError>));
		L.RegFunction("New", _CreateYSTcpConnection_ConnectEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateYSTcpConnection_ConnectEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				YSTcpConnection.ConnectEvent o = new YSTcpConnection.ConnectEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: YSTcpConnection.ConnectEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
