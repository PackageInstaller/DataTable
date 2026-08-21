using System;
using LuaInterface;
using UI_Shader_Wrap;
using UnityEngine;

public class UI_Shader_Wrap_NiuQuGlitchWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(NiuQuGlitch), typeof(MonoBehaviour));
		L.RegFunction("GetModifiedMaterial", GetModifiedMaterial);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("_MainTex_ST", get__MainTex_ST, set__MainTex_ST);
		L.RegVar("_Color", get__Color, set__Color);
		L.RegVar("_ColorMask", get__ColorMask, set__ColorMask);
		L.RegVar("_UseUIAlphaClip", get__UseUIAlphaClip, set__UseUIAlphaClip);
		L.RegVar("_NoiseStrength", get__NoiseStrength, set__NoiseStrength);
		L.RegVar("_NoiseSeed", get__NoiseSeed, set__NoiseSeed);
		L.RegVar("_Segment", get__Segment, set__Segment);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetModifiedMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			NiuQuGlitch obj = (NiuQuGlitch)ToLua.CheckObject<NiuQuGlitch>(L, 1);
			Material baseMaterial = (Material)ToLua.CheckObject<Material>(L, 2);
			Material modifiedMaterial = obj.GetModifiedMaterial(baseMaterial);
			ToLua.Push(L, modifiedMaterial);
			return 1;
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
	private static int get__MainTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 mainTex_ST = ((NiuQuGlitch)obj)._MainTex_ST;
			ToLua.Push(L, mainTex_ST);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__Color(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color color = ((NiuQuGlitch)obj)._Color;
			ToLua.Push(L, color);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Color on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__ColorMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float colorMask = ((NiuQuGlitch)obj)._ColorMask;
			LuaDLL.lua_pushnumber(L, colorMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _ColorMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__UseUIAlphaClip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float useUIAlphaClip = ((NiuQuGlitch)obj)._UseUIAlphaClip;
			LuaDLL.lua_pushnumber(L, useUIAlphaClip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _UseUIAlphaClip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__NoiseStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float noiseStrength = ((NiuQuGlitch)obj)._NoiseStrength;
			LuaDLL.lua_pushnumber(L, noiseStrength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _NoiseStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__NoiseSeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float noiseSeed = ((NiuQuGlitch)obj)._NoiseSeed;
			LuaDLL.lua_pushnumber(L, noiseSeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _NoiseSeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__Segment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float segment = ((NiuQuGlitch)obj)._Segment;
			LuaDLL.lua_pushnumber(L, segment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Segment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__MainTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NiuQuGlitch obj2 = (NiuQuGlitch)obj;
			Vector4 mainTex_ST = ToLua.ToVector4(L, 2);
			obj2._MainTex_ST = mainTex_ST;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__Color(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NiuQuGlitch obj2 = (NiuQuGlitch)obj;
			Color color = ToLua.ToColor(L, 2);
			obj2._Color = color;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Color on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__ColorMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NiuQuGlitch obj2 = (NiuQuGlitch)obj;
			float colorMask = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._ColorMask = colorMask;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _ColorMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__UseUIAlphaClip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NiuQuGlitch obj2 = (NiuQuGlitch)obj;
			float useUIAlphaClip = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._UseUIAlphaClip = useUIAlphaClip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _UseUIAlphaClip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__NoiseStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NiuQuGlitch obj2 = (NiuQuGlitch)obj;
			float noiseStrength = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._NoiseStrength = noiseStrength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _NoiseStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__NoiseSeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NiuQuGlitch obj2 = (NiuQuGlitch)obj;
			float noiseSeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._NoiseSeed = noiseSeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _NoiseSeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__Segment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NiuQuGlitch obj2 = (NiuQuGlitch)obj;
			float segment = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._Segment = segment;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Segment on a nil value");
		}
	}
}
