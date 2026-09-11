using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_SliderWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Slider), typeof(Selectable));
		L.RegFunction("SetValueWithoutNotify", SetValueWithoutNotify);
		L.RegFunction("Rebuild", Rebuild);
		L.RegFunction("LayoutComplete", LayoutComplete);
		L.RegFunction("GraphicUpdateComplete", GraphicUpdateComplete);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnMove", OnMove);
		L.RegFunction("FindSelectableOnLeft", FindSelectableOnLeft);
		L.RegFunction("FindSelectableOnRight", FindSelectableOnRight);
		L.RegFunction("FindSelectableOnUp", FindSelectableOnUp);
		L.RegFunction("FindSelectableOnDown", FindSelectableOnDown);
		L.RegFunction("OnInitializePotentialDrag", OnInitializePotentialDrag);
		L.RegFunction("SetDirection", SetDirection);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("fillRect", get_fillRect, set_fillRect);
		L.RegVar("handleRect", get_handleRect, set_handleRect);
		L.RegVar("direction", get_direction, set_direction);
		L.RegVar("minValue", get_minValue, set_minValue);
		L.RegVar("maxValue", get_maxValue, set_maxValue);
		L.RegVar("wholeNumbers", get_wholeNumbers, set_wholeNumbers);
		L.RegVar("value", get_value, set_value);
		L.RegVar("normalizedValue", get_normalizedValue, set_normalizedValue);
		L.RegVar("onValueChanged", get_onValueChanged, set_onValueChanged);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetValueWithoutNotify(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Slider obj = (Slider)ToLua.CheckObject<Slider>(L, 1);
			float valueWithoutNotify = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetValueWithoutNotify(valueWithoutNotify);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rebuild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Slider obj = (Slider)ToLua.CheckObject<Slider>(L, 1);
			CanvasUpdate executing = (CanvasUpdate)ToLua.CheckObject(L, 2, typeof(CanvasUpdate));
			obj.Rebuild(executing);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LayoutComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Slider)ToLua.CheckObject<Slider>(L, 1)).LayoutComplete();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GraphicUpdateComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Slider)ToLua.CheckObject<Slider>(L, 1)).GraphicUpdateComplete();
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
			Slider obj = (Slider)ToLua.CheckObject<Slider>(L, 1);
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
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Slider obj = (Slider)ToLua.CheckObject<Slider>(L, 1);
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
	private static int OnMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Slider obj = (Slider)ToLua.CheckObject<Slider>(L, 1);
			AxisEventData eventData = (AxisEventData)ToLua.CheckObject<AxisEventData>(L, 2);
			obj.OnMove(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindSelectableOnLeft(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Selectable obj = ((Slider)ToLua.CheckObject<Slider>(L, 1)).FindSelectableOnLeft();
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindSelectableOnRight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Selectable obj = ((Slider)ToLua.CheckObject<Slider>(L, 1)).FindSelectableOnRight();
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindSelectableOnUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Selectable obj = ((Slider)ToLua.CheckObject<Slider>(L, 1)).FindSelectableOnUp();
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindSelectableOnDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Selectable obj = ((Slider)ToLua.CheckObject<Slider>(L, 1)).FindSelectableOnDown();
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnInitializePotentialDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Slider obj = (Slider)ToLua.CheckObject<Slider>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnInitializePotentialDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDirection(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Slider obj = (Slider)ToLua.CheckObject<Slider>(L, 1);
			Slider.Direction direction = (Slider.Direction)ToLua.CheckObject(L, 2, typeof(Slider.Direction));
			bool includeRectLayouts = LuaDLL.luaL_checkboolean(L, 3);
			obj.SetDirection(direction, includeRectLayouts);
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
	private static int get_fillRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform fillRect = ((Slider)obj).fillRect;
			ToLua.PushSealed(L, fillRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handleRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform handleRect = ((Slider)obj).handleRect;
			ToLua.PushSealed(L, handleRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handleRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_direction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider.Direction direction = ((Slider)obj).direction;
			ToLua.Push(L, direction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index direction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minValue = ((Slider)obj).minValue;
			LuaDLL.lua_pushnumber(L, minValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxValue = ((Slider)obj).maxValue;
			LuaDLL.lua_pushnumber(L, maxValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wholeNumbers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool wholeNumbers = ((Slider)obj).wholeNumbers;
			LuaDLL.lua_pushboolean(L, wholeNumbers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wholeNumbers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float value = ((Slider)obj).value;
			LuaDLL.lua_pushnumber(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_normalizedValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float normalizedValue = ((Slider)obj).normalizedValue;
			LuaDLL.lua_pushnumber(L, normalizedValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalizedValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider.SliderEvent onValueChanged = ((Slider)obj).onValueChanged;
			ToLua.PushObject(L, onValueChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fillRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			RectTransform fillRect = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.fillRect = fillRect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fillRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handleRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			RectTransform handleRect = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.handleRect = handleRect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handleRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_direction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			Slider.Direction direction = (Slider.Direction)ToLua.CheckObject(L, 2, typeof(Slider.Direction));
			obj2.direction = direction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index direction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			float minValue = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.minValue = minValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			float maxValue = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxValue = maxValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wholeNumbers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			bool wholeNumbers = LuaDLL.luaL_checkboolean(L, 2);
			obj2.wholeNumbers = wholeNumbers;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wholeNumbers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			float value = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.value = value;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_normalizedValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			float normalizedValue = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.normalizedValue = normalizedValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index normalizedValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider obj2 = (Slider)obj;
			Slider.SliderEvent onValueChanged = (Slider.SliderEvent)ToLua.CheckObject<Slider.SliderEvent>(L, 2);
			obj2.onValueChanged = onValueChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}
}
