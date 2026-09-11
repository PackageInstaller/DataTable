using System;
using LuaInterface;
using UnityEngine.Events;
using UnityEngine.UI;

public class UnityEngine_UI_Toggle_ToggleEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Toggle.ToggleEvent), typeof(UnityEvent<bool>));
		L.RegFunction("New", _CreateUnityEngine_UI_Toggle_ToggleEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_Toggle_ToggleEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Toggle.ToggleEvent o = new Toggle.ToggleEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.Toggle.ToggleEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
