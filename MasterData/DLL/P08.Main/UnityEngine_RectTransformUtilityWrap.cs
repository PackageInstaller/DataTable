using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_RectTransformUtilityWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RectTransformUtility), typeof(object));
		L.RegFunction("PixelAdjustPoint", PixelAdjustPoint);
		L.RegFunction("PixelAdjustRect", PixelAdjustRect);
		L.RegFunction("RectangleContainsScreenPoint", RectangleContainsScreenPoint);
		L.RegFunction("ScreenPointToWorldPointInRectangle", ScreenPointToWorldPointInRectangle);
		L.RegFunction("ScreenPointToLocalPointInRectangle", ScreenPointToLocalPointInRectangle);
		L.RegFunction("ScreenPointToRay", ScreenPointToRay);
		L.RegFunction("WorldToScreenPoint", WorldToScreenPoint);
		L.RegFunction("CalculateRelativeRectTransformBounds", CalculateRelativeRectTransformBounds);
		L.RegFunction("FlipLayoutOnAxis", FlipLayoutOnAxis);
		L.RegFunction("FlipLayoutAxes", FlipLayoutAxes);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PixelAdjustPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Vector2 point = ToLua.ToVector2(L, 1);
			Transform elementTransform = (Transform)ToLua.CheckObject<Transform>(L, 2);
			Canvas canvas = (Canvas)ToLua.CheckObject(L, 3, typeof(Canvas));
			Vector2 v = RectTransformUtility.PixelAdjustPoint(point, elementTransform, canvas);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PixelAdjustRect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform rectTransform = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Canvas canvas = (Canvas)ToLua.CheckObject(L, 2, typeof(Canvas));
			Rect v = RectTransformUtility.PixelAdjustRect(rectTransform, canvas);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RectangleContainsScreenPoint(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				RectTransform rect3 = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				Vector2 screenPoint3 = ToLua.ToVector2(L, 2);
				bool value3 = RectTransformUtility.RectangleContainsScreenPoint(rect3, screenPoint3);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 3:
			{
				RectTransform rect2 = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				Vector2 screenPoint2 = ToLua.ToVector2(L, 2);
				Camera cam2 = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
				bool value2 = RectTransformUtility.RectangleContainsScreenPoint(rect2, screenPoint2, cam2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
			{
				RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				Vector2 screenPoint = ToLua.ToVector2(L, 2);
				Camera cam = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
				Vector4 offset = ToLua.ToVector4(L, 4);
				bool value = RectTransformUtility.RectangleContainsScreenPoint(rect, screenPoint, cam, offset);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.RectTransformUtility.RectangleContainsScreenPoint");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenPointToWorldPointInRectangle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector2 screenPoint = ToLua.ToVector2(L, 2);
			Camera cam = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
			bool value = RectTransformUtility.ScreenPointToWorldPointInRectangle(rect, screenPoint, cam, out var worldPoint);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.Push(L, worldPoint);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenPointToLocalPointInRectangle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector2 screenPoint = ToLua.ToVector2(L, 2);
			Camera cam = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
			bool value = RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, screenPoint, cam, out var localPoint);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.Push(L, localPoint);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenPointToRay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera cam = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Vector2 screenPos = ToLua.ToVector2(L, 2);
			Ray ray = RectTransformUtility.ScreenPointToRay(cam, screenPos);
			ToLua.Push(L, ray);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WorldToScreenPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Camera cam = (Camera)ToLua.CheckObject(L, 1, typeof(Camera));
			Vector3 worldPoint = ToLua.ToVector3(L, 2);
			Vector2 v = RectTransformUtility.WorldToScreenPoint(cam, worldPoint);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateRelativeRectTransformBounds(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Bounds bound2 = RectTransformUtility.CalculateRelativeRectTransformBounds((Transform)ToLua.CheckObject<Transform>(L, 1));
				ToLua.Push(L, bound2);
				return 1;
			}
			case 2:
			{
				Transform root = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform child = (Transform)ToLua.CheckObject<Transform>(L, 2);
				Bounds bound = RectTransformUtility.CalculateRelativeRectTransformBounds(root, child);
				ToLua.Push(L, bound);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.RectTransformUtility.CalculateRelativeRectTransformBounds");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FlipLayoutOnAxis(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			int axis = (int)LuaDLL.luaL_checknumber(L, 2);
			bool keepPositioning = LuaDLL.luaL_checkboolean(L, 3);
			bool recursive = LuaDLL.luaL_checkboolean(L, 4);
			RectTransformUtility.FlipLayoutOnAxis(rect, axis, keepPositioning, recursive);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FlipLayoutAxes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			bool keepPositioning = LuaDLL.luaL_checkboolean(L, 2);
			bool recursive = LuaDLL.luaL_checkboolean(L, 3);
			RectTransformUtility.FlipLayoutAxes(rect, keepPositioning, recursive);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
