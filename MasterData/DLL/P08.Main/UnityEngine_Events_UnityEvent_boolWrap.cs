using System;
using LuaInterface;
using UnityEngine.Events;

public class UnityEngine_Events_UnityEvent_boolWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEvent<bool>), typeof(UnityEventBase), "UnityEvent_bool");
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
			UnityEvent<bool> obj = (UnityEvent<bool>)ToLua.CheckObject<UnityEvent<bool>>(L, 1);
			UnityAction<bool> call = (UnityAction<bool>)ToLua.CheckDelegate<UnityAction<bool>>(L, 2);
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
			UnityEvent<bool> obj = (UnityEvent<bool>)ToLua.CheckObject<UnityEvent<bool>>(L, 1);
			UnityAction<bool> call = (UnityAction<bool>)ToLua.CheckDelegate<UnityAction<bool>>(L, 2);
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
			UnityEvent<bool> obj = (UnityEvent<bool>)ToLua.CheckObject<UnityEvent<bool>>(L, 1);
			bool arg = LuaDLL.luaL_checkboolean(L, 2);
			obj.Invoke(arg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
