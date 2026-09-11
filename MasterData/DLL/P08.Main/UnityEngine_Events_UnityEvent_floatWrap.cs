using System;
using LuaInterface;
using UnityEngine.Events;

public class UnityEngine_Events_UnityEvent_floatWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEvent<float>), typeof(UnityEventBase), "UnityEvent_float");
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
			UnityEvent<float> obj = (UnityEvent<float>)ToLua.CheckObject<UnityEvent<float>>(L, 1);
			UnityAction<float> call = (UnityAction<float>)ToLua.CheckDelegate<UnityAction<float>>(L, 2);
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
			UnityEvent<float> obj = (UnityEvent<float>)ToLua.CheckObject<UnityEvent<float>>(L, 1);
			UnityAction<float> call = (UnityAction<float>)ToLua.CheckDelegate<UnityAction<float>>(L, 2);
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
			UnityEvent<float> obj = (UnityEvent<float>)ToLua.CheckObject<UnityEvent<float>>(L, 1);
			float arg = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.Invoke(arg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
