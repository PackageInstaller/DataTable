using System;
using LuaInterface;
using UnityEngine.Events;
using UnityEngine.UI;

public class UnityEngine_UI_Scrollbar_ScrollEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Scrollbar.ScrollEvent), typeof(UnityEvent<float>));
		L.RegFunction("New", _CreateUnityEngine_UI_Scrollbar_ScrollEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_Scrollbar_ScrollEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Scrollbar.ScrollEvent o = new Scrollbar.ScrollEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.Scrollbar.ScrollEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
