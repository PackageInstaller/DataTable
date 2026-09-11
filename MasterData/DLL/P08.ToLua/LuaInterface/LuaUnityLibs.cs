using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace LuaInterface;

public sealed class LuaUnityLibs
{
	public static void OpenLibs(IntPtr L)
	{
		InitMathf(L);
		InitLayer(L);
	}

	public static void OpenLuaLibs(IntPtr L)
	{
		if (LuaDLL.tolua_openlualibs(L) != 0)
		{
			string msg = LuaDLL.lua_tostring(L, -1);
			LuaDLL.lua_pop(L, 1);
			throw new LuaException(msg);
		}
		SetOutMethods(L, "Vector3", GetOutVector3);
		SetOutMethods(L, "Vector2", GetOutVector2);
		SetOutMethods(L, "Vector4", GetOutVector4);
		SetOutMethods(L, "Color", GetOutColor);
		SetOutMethods(L, "Quaternion", GetOutQuaternion);
		SetOutMethods(L, "Ray", GetOutRay);
		SetOutMethods(L, "Bounds", GetOutBounds);
		SetOutMethods(L, "Touch", GetOutTouch);
		SetOutMethods(L, "RaycastHit", GetOutRaycastHit);
		SetOutMethods(L, "LayerMask", GetOutLayerMask);
	}

	private static void InitMathf(IntPtr L)
	{
		LuaDLL.lua_getglobal(L, "Mathf");
		LuaDLL.lua_pushstring(L, "PerlinNoise");
		LuaDLL.tolua_pushcfunction(L, PerlinNoise);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pop(L, 1);
	}

	private static void InitLayer(IntPtr L)
	{
		LuaDLL.tolua_createtable(L, "Layer");
		for (int i = 0; i < 32; i++)
		{
			string text = LayerMask.LayerToName(i);
			if (!string.IsNullOrEmpty(text))
			{
				LuaDLL.lua_pushstring(L, text);
				LuaDLL.lua_pushinteger(L, i);
				LuaDLL.lua_rawset(L, -3);
			}
		}
		LuaDLL.lua_pop(L, 1);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PerlinNoise(IntPtr L)
	{
		try
		{
			float x = (float)LuaDLL.luaL_checknumber(L, 1);
			float y = (float)LuaDLL.luaL_checknumber(L, 2);
			float num = Mathf.PerlinNoise(x, y);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	private static void SetOutMethods(IntPtr L, string table, LuaCSFunction getOutFunc = null)
	{
		LuaDLL.lua_getglobal(L, table);
		IntPtr functionPointerForDelegate = Marshal.GetFunctionPointerForDelegate(getOutFunc);
		LuaDLL.tolua_variable(L, "out", functionPointerForDelegate, IntPtr.Zero);
		LuaDLL.lua_pop(L, 1);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutVector3(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<Vector3>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutVector2(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<Vector2>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutVector4(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<Vector4>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutColor(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<Color>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutQuaternion(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<Quaternion>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutRay(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<Ray>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutBounds(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<Bounds>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutRaycastHit(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<RaycastHit>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutTouch(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<Touch>());
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetOutLayerMask(IntPtr L)
	{
		ToLua.PushOut(L, new LuaOut<LayerMask>());
		return 1;
	}
}
