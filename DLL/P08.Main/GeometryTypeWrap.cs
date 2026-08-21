using System;
using LuaInterface;

public class GeometryTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(GeometryType));
		L.RegVar("LINE", get_LINE, null);
		L.RegVar("RECT", get_RECT, null);
		L.RegVar("CIRCLE", get_CIRCLE, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<GeometryType>.Check = CheckType;
		StackTraits<GeometryType>.Push = Push;
	}

	private static void Push(IntPtr L, GeometryType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(GeometryType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LINE(IntPtr L)
	{
		ToLua.Push(L, GeometryType.LINE);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RECT(IntPtr L)
	{
		ToLua.Push(L, GeometryType.RECT);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CIRCLE(IntPtr L)
	{
		ToLua.Push(L, GeometryType.CIRCLE);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		GeometryType geometryType = (GeometryType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, geometryType);
		return 1;
	}
}
