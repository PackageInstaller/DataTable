using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_DropdownWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Dropdown), typeof(Selectable));
		L.RegFunction("SetValueWithoutNotify", SetValueWithoutNotify);
		L.RegFunction("RefreshShownValue", RefreshShownValue);
		L.RegFunction("AddOptions", AddOptions);
		L.RegFunction("ClearOptions", ClearOptions);
		L.RegFunction("OnPointerClick", OnPointerClick);
		L.RegFunction("OnSubmit", OnSubmit);
		L.RegFunction("OnCancel", OnCancel);
		L.RegFunction("Show", Show);
		L.RegFunction("Hide", Hide);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("template", get_template, set_template);
		L.RegVar("captionText", get_captionText, set_captionText);
		L.RegVar("captionImage", get_captionImage, set_captionImage);
		L.RegVar("itemText", get_itemText, set_itemText);
		L.RegVar("itemImage", get_itemImage, set_itemImage);
		L.RegVar("options", get_options, set_options);
		L.RegVar("onValueChanged", get_onValueChanged, set_onValueChanged);
		L.RegVar("alphaFadeSpeed", get_alphaFadeSpeed, set_alphaFadeSpeed);
		L.RegVar("value", get_value, set_value);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetValueWithoutNotify(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Dropdown obj = (Dropdown)ToLua.CheckObject<Dropdown>(L, 1);
			int valueWithoutNotify = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetValueWithoutNotify(valueWithoutNotify);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshShownValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Dropdown)ToLua.CheckObject<Dropdown>(L, 1)).RefreshShownValue();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddOptions(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<List<Dropdown.OptionData>>(L, 2))
			{
				Dropdown obj = (Dropdown)ToLua.CheckObject<Dropdown>(L, 1);
				List<Dropdown.OptionData> options = (List<Dropdown.OptionData>)ToLua.ToObject(L, 2);
				obj.AddOptions(options);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<List<string>>(L, 2))
			{
				Dropdown obj2 = (Dropdown)ToLua.CheckObject<Dropdown>(L, 1);
				List<string> options2 = (List<string>)ToLua.ToObject(L, 2);
				obj2.AddOptions(options2);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<List<Sprite>>(L, 2))
			{
				Dropdown obj3 = (Dropdown)ToLua.CheckObject<Dropdown>(L, 1);
				List<Sprite> options3 = (List<Sprite>)ToLua.ToObject(L, 2);
				obj3.AddOptions(options3);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.UI.Dropdown.AddOptions");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearOptions(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Dropdown)ToLua.CheckObject<Dropdown>(L, 1)).ClearOptions();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Dropdown obj = (Dropdown)ToLua.CheckObject<Dropdown>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerClick(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnSubmit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Dropdown obj = (Dropdown)ToLua.CheckObject<Dropdown>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnSubmit(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnCancel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Dropdown obj = (Dropdown)ToLua.CheckObject<Dropdown>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnCancel(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Show(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Dropdown)ToLua.CheckObject<Dropdown>(L, 1)).Show();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Hide(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Dropdown)ToLua.CheckObject<Dropdown>(L, 1)).Hide();
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
	private static int get_template(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform template = ((Dropdown)obj).template;
			ToLua.PushSealed(L, template);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index template on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_captionText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text captionText = ((Dropdown)obj).captionText;
			ToLua.Push(L, captionText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index captionText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_captionImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image captionImage = ((Dropdown)obj).captionImage;
			ToLua.Push(L, captionImage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index captionImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_itemText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text itemText = ((Dropdown)obj).itemText;
			ToLua.Push(L, itemText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index itemText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_itemImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image itemImage = ((Dropdown)obj).itemImage;
			ToLua.Push(L, itemImage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index itemImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_options(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Dropdown.OptionData> options = ((Dropdown)obj).options;
			ToLua.PushSealed(L, options);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index options on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown.DropdownEvent onValueChanged = ((Dropdown)obj).onValueChanged;
			ToLua.PushObject(L, onValueChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_alphaFadeSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float alphaFadeSpeed = ((Dropdown)obj).alphaFadeSpeed;
			LuaDLL.lua_pushnumber(L, alphaFadeSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alphaFadeSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int value = ((Dropdown)obj).value;
			LuaDLL.lua_pushinteger(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_template(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			RectTransform template = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.template = template;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index template on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_captionText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			Text captionText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.captionText = captionText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index captionText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_captionImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			Image captionImage = (Image)ToLua.CheckObject<Image>(L, 2);
			obj2.captionImage = captionImage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index captionImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_itemText(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			Text itemText = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.itemText = itemText;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index itemText on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_itemImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			Image itemImage = (Image)ToLua.CheckObject<Image>(L, 2);
			obj2.itemImage = itemImage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index itemImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_options(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			List<Dropdown.OptionData> options = (List<Dropdown.OptionData>)ToLua.CheckObject(L, 2, typeof(List<Dropdown.OptionData>));
			obj2.options = options;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index options on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			Dropdown.DropdownEvent onValueChanged = (Dropdown.DropdownEvent)ToLua.CheckObject<Dropdown.DropdownEvent>(L, 2);
			obj2.onValueChanged = onValueChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_alphaFadeSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			float alphaFadeSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.alphaFadeSpeed = alphaFadeSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alphaFadeSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown obj2 = (Dropdown)obj;
			int value = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.value = value;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index value on a nil value");
		}
	}
}
