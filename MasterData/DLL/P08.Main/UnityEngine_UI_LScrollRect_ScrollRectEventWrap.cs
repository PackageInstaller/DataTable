using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class UnityEngine_UI_LScrollRect_ScrollRectEventWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LScrollRect.ScrollRectEvent), typeof(UnityEvent<Vector2>));
		L.RegFunction("New", _CreateUnityEngine_UI_LScrollRect_ScrollRectEvent);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_LScrollRect_ScrollRectEvent(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LScrollRect.ScrollRectEvent o = new LScrollRect.ScrollRectEvent();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.LScrollRect.ScrollRectEvent.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
