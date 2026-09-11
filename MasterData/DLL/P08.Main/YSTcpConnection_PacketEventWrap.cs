using System;
using LuaInterface;
using UnityEngine.Events;

public class YSTcpConnection_PacketEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(YSTcpConnection.PacketEvent), typeof(UnityEvent<Packet>));
		L.RegFunction("New", _CreateYSTcpConnection_PacketEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateYSTcpConnection_PacketEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				YSTcpConnection.PacketEvent o = new YSTcpConnection.PacketEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: YSTcpConnection.PacketEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
