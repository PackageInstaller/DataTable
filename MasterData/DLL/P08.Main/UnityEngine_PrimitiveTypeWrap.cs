using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_PrimitiveTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(PrimitiveType));
		L.RegVar("Sphere", get_Sphere, null);
		L.RegVar("Capsule", get_Capsule, null);
		L.RegVar("Cylinder", get_Cylinder, null);
		L.RegVar("Cube", get_Cube, null);
		L.RegVar("Plane", get_Plane, null);
		L.RegVar("Quad", get_Quad, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<PrimitiveType>.Check = CheckType;
		StackTraits<PrimitiveType>.Push = Push;
	}

	private static void Push(IntPtr L, PrimitiveType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(PrimitiveType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sphere(IntPtr L)
	{
		ToLua.Push(L, PrimitiveType.Sphere);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Capsule(IntPtr L)
	{
		ToLua.Push(L, PrimitiveType.Capsule);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Cylinder(IntPtr L)
	{
		ToLua.Push(L, PrimitiveType.Cylinder);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Cube(IntPtr L)
	{
		ToLua.Push(L, PrimitiveType.Cube);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Plane(IntPtr L)
	{
		ToLua.Push(L, PrimitiveType.Plane);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Quad(IntPtr L)
	{
		ToLua.Push(L, PrimitiveType.Quad);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		PrimitiveType primitiveType = (PrimitiveType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, primitiveType);
		return 1;
	}
}
