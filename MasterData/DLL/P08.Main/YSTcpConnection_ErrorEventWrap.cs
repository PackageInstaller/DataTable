using System;
using System.Net.Sockets;
using LuaInterface;
using UnityEngine.Events;

public class YSTcpConnection_ErrorEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(YSTcpConnection.ErrorEvent), typeof(UnityEvent<SocketError>));
		L.RegFunction("New", _CreateYSTcpConnection_ErrorEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateYSTcpConnection_ErrorEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				YSTcpConnection.ErrorEvent o = new YSTcpConnection.ErrorEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: YSTcpConnection.ErrorEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
