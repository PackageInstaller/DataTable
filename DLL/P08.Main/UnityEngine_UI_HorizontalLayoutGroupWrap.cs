using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_UI_HorizontalLayoutGroupWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(HorizontalLayoutGroup), typeof(HorizontalOrVerticalLayoutGroup));
		L.RegFunction("CalculateLayoutInputHorizontal", CalculateLayoutInputHorizontal);
		L.RegFunction("CalculateLayoutInputVertical", CalculateLayoutInputVertical);
		L.RegFunction("SetLayoutHorizontal", SetLayoutHorizontal);
		L.RegFunction("SetLayoutVertical", SetLayoutVertical);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HorizontalLayoutGroup)ToLua.CheckObject<HorizontalLayoutGroup>(L, 1)).CalculateLayoutInputHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HorizontalLayoutGroup)ToLua.CheckObject<HorizontalLayoutGroup>(L, 1)).CalculateLayoutInputVertical();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HorizontalLayoutGroup)ToLua.CheckObject<HorizontalLayoutGroup>(L, 1)).SetLayoutHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((HorizontalLayoutGroup)ToLua.CheckObject<HorizontalLayoutGroup>(L, 1)).SetLayoutVertical();
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
}
