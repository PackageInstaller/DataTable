using System;
using System.Net.Sockets;
using LuaInterface;
using UnityEngine.Events;

public class UnityEngine_Events_UnityEvent_System_Net_Sockets_SocketErrorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEvent<SocketError>), typeof(UnityEventBase), "UnityEvent_System_Net_Sockets_SocketError");
		L.RegFunction("AddListener", AddListener);
		L.RegFunction("RemoveListener", RemoveListener);
		L.RegFunction("Invoke", Invoke);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddListener(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEvent<SocketError> obj = (UnityEvent<SocketError>)ToLua.CheckObject<UnityEvent<SocketError>>(L, 1);
			UnityAction<SocketError> call = (UnityAction<SocketError>)ToLua.CheckDelegate<UnityAction<SocketError>>(L, 2);
			obj.AddListener(call);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveListener(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEvent<SocketError> obj = (UnityEvent<SocketError>)ToLua.CheckObject<UnityEvent<SocketError>>(L, 1);
			UnityAction<SocketError> call = (UnityAction<SocketError>)ToLua.CheckDelegate<UnityAction<SocketError>>(L, 2);
			obj.RemoveListener(call);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Invoke(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEvent<SocketError> obj = (UnityEvent<SocketError>)ToLua.CheckObject<UnityEvent<SocketError>>(L, 1);
			SocketError arg = (SocketError)ToLua.CheckObject(L, 2, typeof(SocketError));
			obj.Invoke(arg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
