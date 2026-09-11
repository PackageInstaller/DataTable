using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_NetworkReachabilityWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(NetworkReachability));
		L.RegVar("NotReachable", get_NotReachable, null);
		L.RegVar("ReachableViaCarrierDataNetwork", get_ReachableViaCarrierDataNetwork, null);
		L.RegVar("ReachableViaLocalAreaNetwork", get_ReachableViaLocalAreaNetwork, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<NetworkReachability>.Check = CheckType;
		StackTraits<NetworkReachability>.Push = Push;
	}

	private static void Push(IntPtr L, NetworkReachability arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(NetworkReachability), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NotReachable(IntPtr L)
	{
		ToLua.Push(L, NetworkReachability.NotReachable);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ReachableViaCarrierDataNetwork(IntPtr L)
	{
		ToLua.Push(L, NetworkReachability.ReachableViaCarrierDataNetwork);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ReachableViaLocalAreaNetwork(IntPtr L)
	{
		ToLua.Push(L, NetworkReachability.ReachableViaLocalAreaNetwork);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		NetworkReachability networkReachability = (NetworkReachability)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, networkReachability);
		return 1;
	}
}
