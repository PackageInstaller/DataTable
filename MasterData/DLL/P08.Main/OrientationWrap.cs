using System;
using LuaInterface;

public class OrientationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(Orientation));
		L.RegVar("Horizontal", get_Horizontal, null);
		L.RegVar("Vertical", get_Vertical, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<Orientation>.Check = CheckType;
		StackTraits<Orientation>.Push = Push;
	}

	private static void Push(IntPtr L, Orientation arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(Orientation), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Horizontal(IntPtr L)
	{
		ToLua.Push(L, Orientation.Horizontal);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Vertical(IntPtr L)
	{
		ToLua.Push(L, Orientation.Vertical);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		Orientation orientation = (Orientation)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, orientation);
		return 1;
	}
}
