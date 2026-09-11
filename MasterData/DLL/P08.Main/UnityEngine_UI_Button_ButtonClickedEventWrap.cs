using System;
using LuaInterface;
using UnityEngine.Events;
using UnityEngine.UI;

public class UnityEngine_UI_Button_ButtonClickedEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Button.ButtonClickedEvent), typeof(UnityEvent));
		L.RegFunction("New", _CreateUnityEngine_UI_Button_ButtonClickedEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_Button_ButtonClickedEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Button.ButtonClickedEvent o = new Button.ButtonClickedEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.Button.ButtonClickedEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
