using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UIPolygonWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIPolygon), typeof(Image));
		L.RegFunction("IsRaycastLocationValid", IsRaycastLocationValid);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsRaycastLocationValid(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UIPolygon obj = (UIPolygon)ToLua.CheckObject<UIPolygon>(L, 1);
			Vector2 screenPoint = ToLua.ToVector2(L, 2);
			Camera eventCamera = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
			bool value = obj.IsRaycastLocationValid(screenPoint, eventCamera);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
