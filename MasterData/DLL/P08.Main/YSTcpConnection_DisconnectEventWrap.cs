using System;
using LuaInterface;
using UnityEngine.Events;

public class YSTcpConnection_DisconnectEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(YSTcpConnection.DisconnectEvent), typeof(UnityEvent<string>));
		L.RegFunction("New", _CreateYSTcpConnection_DisconnectEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateYSTcpConnection_DisconnectEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				YSTcpConnection.DisconnectEvent o = new YSTcpConnection.DisconnectEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: YSTcpConnection.DisconnectEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
