using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_RectTransform_AxisWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(RectTransform.Axis));
		L.RegVar("Horizontal", get_Horizontal, null);
		L.RegVar("Vertical", get_Vertical, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<RectTransform.Axis>.Check = CheckType;
		StackTraits<RectTransform.Axis>.Push = Push;
	}

	private static void Push(IntPtr L, RectTransform.Axis arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(RectTransform.Axis), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Horizontal(IntPtr L)
	{
		ToLua.Push(L, RectTransform.Axis.Horizontal);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Vertical(IntPtr L)
	{
		ToLua.Push(L, RectTransform.Axis.Vertical);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		RectTransform.Axis axis = (RectTransform.Axis)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, axis);
		return 1;
	}
}
