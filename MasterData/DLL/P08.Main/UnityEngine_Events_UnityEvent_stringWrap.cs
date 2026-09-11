using System;
using LuaInterface;
using UnityEngine.Events;

public class UnityEngine_Events_UnityEvent_stringWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEvent<string>), typeof(UnityEventBase), "UnityEvent_string");
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
			UnityEvent<string> obj = (UnityEvent<string>)ToLua.CheckObject<UnityEvent<string>>(L, 1);
			UnityAction<string> call = (UnityAction<string>)ToLua.CheckDelegate<UnityAction<string>>(L, 2);
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
			UnityEvent<string> obj = (UnityEvent<string>)ToLua.CheckObject<UnityEvent<string>>(L, 1);
			UnityAction<string> call = (UnityAction<string>)ToLua.CheckDelegate<UnityAction<string>>(L, 2);
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
			UnityEvent<string> obj = (UnityEvent<string>)ToLua.CheckObject<UnityEvent<string>>(L, 1);
			string arg = ToLua.CheckString(L, 2);
			obj.Invoke(arg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
