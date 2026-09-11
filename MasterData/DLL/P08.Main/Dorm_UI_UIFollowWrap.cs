using System;
using Dorm.UI;
using LuaInterface;
using UnityEngine;

public class Dorm_UI_UIFollowWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIFollow), typeof(MonoBehaviour));
		L.RegFunction("UpdatePos", UpdatePos);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("origin", get_origin, set_origin);
		L.RegVar("canvas", get_canvas, set_canvas);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdatePos(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((UIFollow)ToLua.CheckObject<UIFollow>(L, 1)).UpdatePos();
				return 0;
			case 3:
			{
				RectTransform ui = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				Transform origin = (Transform)ToLua.CheckObject<Transform>(L, 2);
				Camera cam = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
				UIFollow.UpdatePos(ui, origin, cam);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.UI.UIFollow.UpdatePos");
			}
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

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_origin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform origin = ((UIFollow)obj).origin;
			ToLua.Push(L, origin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index origin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Canvas canvas = ((UIFollow)obj).canvas;
			ToLua.PushSealed(L, canvas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_origin(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIFollow obj2 = (UIFollow)obj;
			Transform origin = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.origin = origin;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index origin on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIFollow obj2 = (UIFollow)obj;
			Canvas canvas = (Canvas)ToLua.CheckObject(L, 2, typeof(Canvas));
			obj2.canvas = canvas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvas on a nil value");
		}
	}
}
