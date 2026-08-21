using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class UnityEngine_UI_ScrollRect_ScrollRectEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ScrollRect.ScrollRectEvent), typeof(UnityEvent<Vector2>));
		L.RegFunction("New", _CreateUnityEngine_UI_ScrollRect_ScrollRectEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_ScrollRect_ScrollRectEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ScrollRect.ScrollRectEvent o = new ScrollRect.ScrollRectEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.ScrollRect.ScrollRectEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
