using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;

public class UnityEngine_Events_UnityEvent_UnityEngine_Vector2Wrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEvent<Vector2>), typeof(UnityEventBase), "UnityEvent_UnityEngine_Vector2");
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
			UnityEvent<Vector2> obj = (UnityEvent<Vector2>)ToLua.CheckObject<UnityEvent<Vector2>>(L, 1);
			UnityAction<Vector2> call = (UnityAction<Vector2>)ToLua.CheckDelegate<UnityAction<Vector2>>(L, 2);
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
			UnityEvent<Vector2> obj = (UnityEvent<Vector2>)ToLua.CheckObject<UnityEvent<Vector2>>(L, 1);
			UnityAction<Vector2> call = (UnityAction<Vector2>)ToLua.CheckDelegate<UnityAction<Vector2>>(L, 2);
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
			UnityEvent<Vector2> obj = (UnityEvent<Vector2>)ToLua.CheckObject<UnityEvent<Vector2>>(L, 1);
			Vector2 arg = ToLua.ToVector2(L, 2);
			obj.Invoke(arg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
