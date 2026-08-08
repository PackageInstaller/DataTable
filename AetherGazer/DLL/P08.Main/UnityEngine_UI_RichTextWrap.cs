using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_RichTextWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RichText), typeof(Text));
		L.RegFunction("SetVerticesDirty", SetVerticesDirty);
		L.RegFunction("UpdateSpriteList", UpdateSpriteList);
		L.RegFunction("AddSprite", AddSprite);
		L.RegFunction("ClearSprite", ClearSprite);
		L.RegFunction("AddListener", AddListener);
		L.RegFunction("AddEventListUpdateListener", AddEventListUpdateListener);
		L.RegFunction("RemoveAllListeners", RemoveAllListeners);
		L.RegFunction("OnPointerClick", OnPointerClick);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("inspectorSpriteList", get_inspectorSpriteList, set_inspectorSpriteList);
		L.RegVar("preferredHeight", get_preferredHeight, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVerticesDirty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RichText)ToLua.CheckObject<RichText>(L, 1)).SetVerticesDirty();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateSpriteList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RichText)ToLua.CheckObject<RichText>(L, 1)).UpdateSpriteList();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddSprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RichText obj = (RichText)ToLua.CheckObject<RichText>(L, 1);
			string name = ToLua.CheckString(L, 2);
			Sprite sprite = (Sprite)ToLua.CheckObject(L, 3, typeof(Sprite));
			obj.AddSprite(name, sprite);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearSprite(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RichText)ToLua.CheckObject<RichText>(L, 1)).ClearSprite();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddListener(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RichText obj = (RichText)ToLua.CheckObject<RichText>(L, 1);
			Action<string, string> callBack = (Action<string, string>)ToLua.CheckDelegate<Action<string, string>>(L, 2);
			obj.AddListener(callBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddEventListUpdateListener(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RichText obj = (RichText)ToLua.CheckObject<RichText>(L, 1);
			Action<string[], string[]> dlg = (Action<string[], string[]>)ToLua.CheckDelegate<Action<string[], string[]>>(L, 2);
			obj.AddEventListUpdateListener(dlg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAllListeners(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RichText)ToLua.CheckObject<RichText>(L, 1)).RemoveAllListeners();
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
			RichText obj = (RichText)ToLua.CheckObject<RichText>(L, 1);
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
	private static int get_inspectorSpriteList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RichText.SpriteName[] inspectorSpriteList = ((RichText)obj).inspectorSpriteList;
			ToLua.Push(L, inspectorSpriteList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inspectorSpriteList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preferredHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float preferredHeight = ((RichText)obj).preferredHeight;
			LuaDLL.lua_pushnumber(L, preferredHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_inspectorSpriteList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RichText obj2 = (RichText)obj;
			RichText.SpriteName[] inspectorSpriteList = ToLua.CheckStructArray<RichText.SpriteName>(L, 2);
			obj2.inspectorSpriteList = inspectorSpriteList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inspectorSpriteList on a nil value");
		}
	}
}
