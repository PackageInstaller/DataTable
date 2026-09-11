using System;
using LuaInterface;
using UnityEngine.Events;

public class UnityEngine_Events_UnityEvent_PacketWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEvent<Packet>), typeof(UnityEventBase), "UnityEvent_Packet");
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
			UnityEvent<Packet> obj = (UnityEvent<Packet>)ToLua.CheckObject<UnityEvent<Packet>>(L, 1);
			UnityAction<Packet> call = (UnityAction<Packet>)ToLua.CheckDelegate<UnityAction<Packet>>(L, 2);
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
			UnityEvent<Packet> obj = (UnityEvent<Packet>)ToLua.CheckObject<UnityEvent<Packet>>(L, 1);
			UnityAction<Packet> call = (UnityAction<Packet>)ToLua.CheckDelegate<UnityAction<Packet>>(L, 2);
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
			UnityEvent<Packet> obj = (UnityEvent<Packet>)ToLua.CheckObject<UnityEvent<Packet>>(L, 1);
			Packet arg = (Packet)ToLua.CheckObject<Packet>(L, 2);
			obj.Invoke(arg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
