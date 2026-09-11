using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_RenderTextureFormatWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(RenderTextureFormat));
		L.RegVar("ARGB32", get_ARGB32, null);
		L.RegVar("Depth", get_Depth, null);
		L.RegVar("ARGBHalf", get_ARGBHalf, null);
		L.RegVar("Shadowmap", get_Shadowmap, null);
		L.RegVar("RGB565", get_RGB565, null);
		L.RegVar("ARGB4444", get_ARGB4444, null);
		L.RegVar("ARGB1555", get_ARGB1555, null);
		L.RegVar("Default", get_Default, null);
		L.RegVar("ARGB2101010", get_ARGB2101010, null);
		L.RegVar("DefaultHDR", get_DefaultHDR, null);
		L.RegVar("ARGB64", get_ARGB64, null);
		L.RegVar("ARGBFloat", get_ARGBFloat, null);
		L.RegVar("RGFloat", get_RGFloat, null);
		L.RegVar("RGHalf", get_RGHalf, null);
		L.RegVar("RFloat", get_RFloat, null);
		L.RegVar("RHalf", get_RHalf, null);
		L.RegVar("R8", get_R8, null);
		L.RegVar("ARGBInt", get_ARGBInt, null);
		L.RegVar("RGInt", get_RGInt, null);
		L.RegVar("RInt", get_RInt, null);
		L.RegVar("BGRA32", get_BGRA32, null);
		L.RegVar("RGB111110Float", get_RGB111110Float, null);
		L.RegVar("RG32", get_RG32, null);
		L.RegVar("RGBAUShort", get_RGBAUShort, null);
		L.RegVar("RG16", get_RG16, null);
		L.RegVar("BGRA10101010_XR", get_BGRA10101010_XR, null);
		L.RegVar("BGR101010_XR", get_BGR101010_XR, null);
		L.RegVar("R16", get_R16, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<RenderTextureFormat>.Check = CheckType;
		StackTraits<RenderTextureFormat>.Push = Push;
	}

	private static void Push(IntPtr L, RenderTextureFormat arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(RenderTextureFormat), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ARGB32(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.ARGB32);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Depth(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.Depth);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ARGBHalf(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.ARGBHalf);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Shadowmap(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.Shadowmap);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RGB565(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RGB565);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ARGB4444(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.ARGB4444);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ARGB1555(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.ARGB1555);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Default(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.Default);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ARGB2101010(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.ARGB2101010);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DefaultHDR(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.DefaultHDR);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ARGB64(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.ARGB64);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ARGBFloat(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.ARGBFloat);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RGFloat(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RGFloat);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RGHalf(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RGHalf);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RFloat(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RFloat);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RHalf(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RHalf);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_R8(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.R8);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ARGBInt(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.ARGBInt);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RGInt(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RGInt);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RInt(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RInt);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BGRA32(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.BGRA32);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RGB111110Float(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RGB111110Float);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RG32(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RG32);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RGBAUShort(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RGBAUShort);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RG16(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.RG16);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BGRA10101010_XR(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.BGRA10101010_XR);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BGR101010_XR(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.BGR101010_XR);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_R16(IntPtr L)
	{
		ToLua.Push(L, RenderTextureFormat.R16);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		RenderTextureFormat renderTextureFormat = (RenderTextureFormat)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, renderTextureFormat);
		return 1;
	}
}
