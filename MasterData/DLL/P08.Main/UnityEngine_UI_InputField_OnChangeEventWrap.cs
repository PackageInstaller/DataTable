using System;
using LuaInterface;
using UnityEngine.Events;
using UnityEngine.UI;

public class UnityEngine_UI_InputField_OnChangeEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(InputField.OnChangeEvent), typeof(UnityEvent<string>));
		L.RegFunction("New", _CreateUnityEngine_UI_InputField_OnChangeEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_InputField_OnChangeEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				InputField.OnChangeEvent o = new InputField.OnChangeEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.InputField.OnChangeEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
