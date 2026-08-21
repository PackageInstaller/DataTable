using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class SelfUIScaleImageWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SelfUIScaleImage), typeof(MonoBehaviour));
		L.RegFunction("ResetContent", ResetContent);
		L.RegFunction("OnEnable", OnEnable);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnPointerUp", OnPointerUp);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("scalingRate", get_scalingRate, set_scalingRate);
		L.RegVar("maxScale", get_maxScale, set_maxScale);
		L.RegVar("minScale", get_minScale, set_minScale);
		L.RegVar("Content", get_Content, set_Content);
		L.RegVar("View", get_View, set_View);
		L.RegVar("onValueChanged", get_onValueChanged, set_onValueChanged);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetContent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SelfUIScaleImage)ToLua.CheckObject<SelfUIScaleImage>(L, 1)).ResetContent();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnEnable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SelfUIScaleImage)ToLua.CheckObject<SelfUIScaleImage>(L, 1)).OnEnable();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SelfUIScaleImage obj = (SelfUIScaleImage)ToLua.CheckObject<SelfUIScaleImage>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerDown(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SelfUIScaleImage obj = (SelfUIScaleImage)ToLua.CheckObject<SelfUIScaleImage>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerUp(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SelfUIScaleImage obj = (SelfUIScaleImage)ToLua.CheckObject<SelfUIScaleImage>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnDrag(eventData);
			return 0;
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
	private static int get_scalingRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float scalingRate = ((SelfUIScaleImage)obj).scalingRate;
			LuaDLL.lua_pushnumber(L, scalingRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scalingRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxScale = ((SelfUIScaleImage)obj).maxScale;
			LuaDLL.lua_pushnumber(L, maxScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minScale = ((SelfUIScaleImage)obj).minScale;
			LuaDLL.lua_pushnumber(L, minScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform content = ((SelfUIScaleImage)obj).Content;
			ToLua.PushSealed(L, content);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_View(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform view = ((SelfUIScaleImage)obj).View;
			ToLua.PushSealed(L, view);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index View on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SelfUIScaleImage.ClickedEvent onValueChanged = ((SelfUIScaleImage)obj).onValueChanged;
			ToLua.PushObject(L, onValueChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_scalingRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SelfUIScaleImage obj2 = (SelfUIScaleImage)obj;
			float scalingRate = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.scalingRate = scalingRate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scalingRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SelfUIScaleImage obj2 = (SelfUIScaleImage)obj;
			float maxScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxScale = maxScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SelfUIScaleImage obj2 = (SelfUIScaleImage)obj;
			float minScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.minScale = minScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SelfUIScaleImage obj2 = (SelfUIScaleImage)obj;
			RectTransform content = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.Content = content;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_View(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SelfUIScaleImage obj2 = (SelfUIScaleImage)obj;
			RectTransform view = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.View = view;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index View on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SelfUIScaleImage obj2 = (SelfUIScaleImage)obj;
			SelfUIScaleImage.ClickedEvent onValueChanged = (SelfUIScaleImage.ClickedEvent)ToLua.CheckObject<SelfUIScaleImage.ClickedEvent>(L, 2);
			obj2.onValueChanged = onValueChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}
}
