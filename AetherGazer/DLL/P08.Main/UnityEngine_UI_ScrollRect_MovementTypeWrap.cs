using System;
using LuaInterface;
using UnityEngine.UI;

public class UnityEngine_UI_ScrollRect_MovementTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(ScrollRect.MovementType));
		L.RegVar("Unrestricted", get_Unrestricted, null);
		L.RegVar("Elastic", get_Elastic, null);
		L.RegVar("Clamped", get_Clamped, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<ScrollRect.MovementType>.Check = CheckType;
		StackTraits<ScrollRect.MovementType>.Push = Push;
	}

	private static void Push(IntPtr L, ScrollRect.MovementType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(ScrollRect.MovementType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Unrestricted(IntPtr L)
	{
		ToLua.Push(L, ScrollRect.MovementType.Unrestricted);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Elastic(IntPtr L)
	{
		ToLua.Push(L, ScrollRect.MovementType.Elastic);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Clamped(IntPtr L)
	{
		ToLua.Push(L, ScrollRect.MovementType.Clamped);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		ScrollRect.MovementType movementType = (ScrollRect.MovementType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, movementType);
		return 1;
	}
}
