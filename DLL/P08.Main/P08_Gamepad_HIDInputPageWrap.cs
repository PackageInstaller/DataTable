using System;
using System.Collections.Generic;
using LuaInterface;
using P08.Gamepad;
using UnityEngine;

public class P08_Gamepad_HIDInputPageWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(HIDInputPage), typeof(MonoBehaviour));
		L.RegFunction("EnablePage", EnablePage);
		L.RegFunction("DisablePage", DisablePage);
		L.RegFunction("EnablePageIfNeed", EnablePageIfNeed);
		L.RegFunction("DisablePageIfNeed", DisablePageIfNeed);
		L.RegFunction("RebindActions", RebindActions);
		L.RegFunction("AddAction", AddAction);
		L.RegFunction("RemoveAction", RemoveAction);
		L.RegFunction("SetRemapVisibility", SetRemapVisibility);
		L.RegFunction("UpdateRemapVisibility", UpdateRemapVisibility);
		L.RegFunction("AddBindingNoticeGo", AddBindingNoticeGo);
		L.RegFunction("ReplaceButtonType", ReplaceButtonType);
		L.RegFunction("ReplaceButtonTypeIndex", ReplaceButtonTypeIndex);
		L.RegFunction("ReplaceNumButtonType", ReplaceNumButtonType);
		L.RegFunction("RevertButtonType", RevertButtonType);
		L.RegFunction("RefreshActionUI", RefreshActionUI);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("actionBindings", get_actionBindings, set_actionBindings);
		L.RegVar("noHidButton", get_noHidButton, set_noHidButton);
		L.RegVar("shouldReusePage", get_shouldReusePage, set_shouldReusePage);
		L.RegVar("pageName", get_pageName, null);
		L.RegVar("page", get_page, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnablePage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1)).EnablePage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisablePage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1)).DisablePage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnablePageIfNeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1)).EnablePageIfNeed();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisablePageIfNeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1)).DisablePageIfNeed();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RebindActions(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1)).RebindActions();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HIDInputPage obj = (HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1);
			HIDInputPage.ActionBinding actionBinding = StackTraits<HIDInputPage.ActionBinding>.Check(L, 2);
			obj.AddAction(actionBinding);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HIDInputPage obj = (HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1);
			HIDInputPage.ActionBinding actionBinding = StackTraits<HIDInputPage.ActionBinding>.Check(L, 2);
			obj.RemoveAction(actionBinding);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRemapVisibility(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HIDInputPage obj = (HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1);
			bool remapVisibility = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetRemapVisibility(remapVisibility);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateRemapVisibility(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HIDInputPage obj = (HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1);
			bool visible = LuaDLL.luaL_checkboolean(L, 2);
			obj.UpdateRemapVisibility(visible);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddBindingNoticeGo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Transform obj = HIDInputPage.AddBindingNoticeGo((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReplaceButtonType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HIDInputPage obj = (HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1);
			En_ButtonType buttonType = (En_ButtonType)ToLua.CheckObject(L, 2, typeof(En_ButtonType));
			obj.ReplaceButtonType(buttonType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReplaceButtonTypeIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HIDInputPage obj = (HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1);
			int buttonIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ReplaceButtonTypeIndex(buttonIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReplaceNumButtonType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			HIDInputPage obj = (HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ReplaceNumButtonType(num);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RevertButtonType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1)).RevertButtonType();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshActionUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HIDInputPage)ToLua.CheckObject<HIDInputPage>(L, 1)).RefreshActionUI();
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
	private static int get_actionBindings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<HIDInputPage.ActionBinding> actionBindings = ((HIDInputPage)obj).actionBindings;
			ToLua.PushSealed(L, actionBindings);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index actionBindings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_noHidButton(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool noHidButton = ((HIDInputPage)obj).noHidButton;
			LuaDLL.lua_pushboolean(L, noHidButton);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noHidButton on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shouldReusePage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool shouldReusePage = ((HIDInputPage)obj).shouldReusePage;
			LuaDLL.lua_pushboolean(L, shouldReusePage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shouldReusePage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pageName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string pageName = ((HIDInputPage)obj).pageName;
			LuaDLL.lua_pushstring(L, pageName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pageName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_page(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PageInputActionRes page = ((HIDInputPage)obj).page;
			ToLua.Push(L, page);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index page on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_actionBindings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HIDInputPage obj2 = (HIDInputPage)obj;
			List<HIDInputPage.ActionBinding> actionBindings = (List<HIDInputPage.ActionBinding>)ToLua.CheckObject(L, 2, typeof(List<HIDInputPage.ActionBinding>));
			obj2.actionBindings = actionBindings;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index actionBindings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_noHidButton(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HIDInputPage obj2 = (HIDInputPage)obj;
			bool noHidButton = LuaDLL.luaL_checkboolean(L, 2);
			obj2.noHidButton = noHidButton;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noHidButton on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shouldReusePage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HIDInputPage obj2 = (HIDInputPage)obj;
			bool shouldReusePage = LuaDLL.luaL_checkboolean(L, 2);
			obj2.shouldReusePage = shouldReusePage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shouldReusePage on a nil value");
		}
	}
}
