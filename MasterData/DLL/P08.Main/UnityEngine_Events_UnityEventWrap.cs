using System;
using LuaInterface;
using UnityEngine.Events;

public class UnityEngine_Events_UnityEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEvent), typeof(UnityEventBase));
		L.RegFunction("AddListener", AddListener);
		L.RegFunction("RemoveListener", RemoveListener);
		L.RegFunction("Invoke", Invoke);
		L.RegFunction("New", _CreateUnityEngine_Events_UnityEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Events_UnityEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				UnityEvent o = new UnityEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Events.UnityEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddListener(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEvent obj = (UnityEvent)ToLua.CheckObject<UnityEvent>(L, 1);
			UnityAction call = (UnityAction)ToLua.CheckDelegate<UnityAction>(L, 2);
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
			UnityEvent obj = (UnityEvent)ToLua.CheckObject<UnityEvent>(L, 1);
			UnityAction call = (UnityAction)ToLua.CheckDelegate<UnityAction>(L, 2);
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
			ToLua.CheckArgsCount(L, 1);
			((UnityEvent)ToLua.CheckObject<UnityEvent>(L, 1)).Invoke();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
