using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_SelectableWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Selectable), typeof(UIBehaviour));
		L.RegFunction("IsInteractable", IsInteractable);
		L.RegFunction("FindSelectable", FindSelectable);
		L.RegFunction("FindSelectableOnLeft", FindSelectableOnLeft);
		L.RegFunction("FindSelectableOnRight", FindSelectableOnRight);
		L.RegFunction("FindSelectableOnUp", FindSelectableOnUp);
		L.RegFunction("FindSelectableOnDown", FindSelectableOnDown);
		L.RegFunction("OnMove", OnMove);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnPointerUp", OnPointerUp);
		L.RegFunction("OnPointerEnter", OnPointerEnter);
		L.RegFunction("OnPointerExit", OnPointerExit);
		L.RegFunction("OnSelect", OnSelect);
		L.RegFunction("OnDeselect", OnDeselect);
		L.RegFunction("Select", Select);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("allSelectables", get_allSelectables, null);
		L.RegVar("navigation", get_navigation, set_navigation);
		L.RegVar("transition", get_transition, set_transition);
		L.RegVar("colors", get_colors, set_colors);
		L.RegVar("spriteState", get_spriteState, set_spriteState);
		L.RegVar("animationTriggers", get_animationTriggers, set_animationTriggers);
		L.RegVar("targetGraphic", get_targetGraphic, set_targetGraphic);
		L.RegVar("interactable", get_interactable, set_interactable);
		L.RegVar("image", get_image, set_image);
		L.RegVar("animator", get_animator, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsInteractable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((Selectable)ToLua.CheckObject<Selectable>(L, 1)).IsInteractable();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindSelectable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Selectable obj = (Selectable)ToLua.CheckObject<Selectable>(L, 1);
			Vector3 dir = ToLua.ToVector3(L, 2);
			Selectable obj2 = obj.FindSelectable(dir);
			ToLua.Push(L, obj2);
			return 1;
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
			Selectable obj = ((Selectable)ToLua.CheckObject<Selectable>(L, 1)).FindSelectableOnLeft();
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
			Selectable obj = ((Selectable)ToLua.CheckObject<Selectable>(L, 1)).FindSelectableOnRight();
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
			Selectable obj = ((Selectable)ToLua.CheckObject<Selectable>(L, 1)).FindSelectableOnUp();
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
			Selectable obj = ((Selectable)ToLua.CheckObject<Selectable>(L, 1)).FindSelectableOnDown();
			ToLua.Push(L, obj);
			return 1;
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
			Selectable obj = (Selectable)ToLua.CheckObject<Selectable>(L, 1);
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
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Selectable obj = (Selectable)ToLua.CheckObject<Selectable>(L, 1);
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
			Selectable obj = (Selectable)ToLua.CheckObject<Selectable>(L, 1);
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
	private static int OnPointerEnter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Selectable obj = (Selectable)ToLua.CheckObject<Selectable>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerEnter(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerExit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Selectable obj = (Selectable)ToLua.CheckObject<Selectable>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerExit(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Selectable obj = (Selectable)ToLua.CheckObject<Selectable>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnSelect(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDeselect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Selectable obj = (Selectable)ToLua.CheckObject<Selectable>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnDeselect(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Select(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Selectable)ToLua.CheckObject<Selectable>(L, 1)).Select();
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
	private static int get_allSelectables(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, Selectable.allSelectables);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_navigation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Navigation navigation = ((Selectable)obj).navigation;
			ToLua.PushValue(L, navigation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index navigation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_transition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable.Transition transition = ((Selectable)obj).transition;
			ToLua.Push(L, transition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colors(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ColorBlock colors = ((Selectable)obj).colors;
			ToLua.PushValue(L, colors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colors on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spriteState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteState spriteState = ((Selectable)obj).spriteState;
			ToLua.PushValue(L, spriteState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animationTriggers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AnimationTriggers animationTriggers = ((Selectable)obj).animationTriggers;
			ToLua.PushObject(L, animationTriggers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animationTriggers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetGraphic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Graphic targetGraphic = ((Selectable)obj).targetGraphic;
			ToLua.Push(L, targetGraphic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetGraphic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interactable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool interactable = ((Selectable)obj).interactable;
			LuaDLL.lua_pushboolean(L, interactable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interactable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_image(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image image = ((Selectable)obj).image;
			ToLua.Push(L, image);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index image on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_animator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator animator = ((Selectable)obj).animator;
			ToLua.Push(L, animator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_navigation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable obj2 = (Selectable)obj;
			Navigation navigation = StackTraits<Navigation>.Check(L, 2);
			obj2.navigation = navigation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index navigation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_transition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable obj2 = (Selectable)obj;
			Selectable.Transition transition = (Selectable.Transition)ToLua.CheckObject(L, 2, typeof(Selectable.Transition));
			obj2.transition = transition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_colors(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable obj2 = (Selectable)obj;
			ColorBlock colors = StackTraits<ColorBlock>.Check(L, 2);
			obj2.colors = colors;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colors on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spriteState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable obj2 = (Selectable)obj;
			SpriteState spriteState = StackTraits<SpriteState>.Check(L, 2);
			obj2.spriteState = spriteState;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_animationTriggers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable obj2 = (Selectable)obj;
			AnimationTriggers animationTriggers = (AnimationTriggers)ToLua.CheckObject<AnimationTriggers>(L, 2);
			obj2.animationTriggers = animationTriggers;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index animationTriggers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetGraphic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable obj2 = (Selectable)obj;
			Graphic targetGraphic = (Graphic)ToLua.CheckObject<Graphic>(L, 2);
			obj2.targetGraphic = targetGraphic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetGraphic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interactable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable obj2 = (Selectable)obj;
			bool interactable = LuaDLL.luaL_checkboolean(L, 2);
			obj2.interactable = interactable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interactable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_image(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Selectable obj2 = (Selectable)obj;
			Image image = (Image)ToLua.CheckObject<Image>(L, 2);
			obj2.image = image;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index image on a nil value");
		}
	}
}
