using System;
using LuaInterface;
using UI_Shader_Wrap;
using UnityEngine;
using UnityEngine.UI;

public class UI_Shader_Wrap_UIImageGlitchWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIImageGlitch), typeof(MonoBehaviour));
		L.RegFunction("GetModifiedMaterial", GetModifiedMaterial);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("_MainTex_ST", get__MainTex_ST, set__MainTex_ST);
		L.RegVar("_Color", get__Color, set__Color);
		L.RegVar("_ColorMask", get__ColorMask, set__ColorMask);
		L.RegVar("mainPlusTex_ST", get_mainPlusTex_ST, set_mainPlusTex_ST);
		L.RegVar("mainPlusRotation", get_mainPlusRotation, set_mainPlusRotation);
		L.RegVar("colorPlus", get_colorPlus, set_colorPlus);
		L.RegVar("colorPlusIntensity", get_colorPlusIntensity, set_colorPlusIntensity);
		L.RegVar("mainPlusStrength", get_mainPlusStrength, set_mainPlusStrength);
		L.RegVar("_UseUIAlphaClip", get__UseUIAlphaClip, set__UseUIAlphaClip);
		L.RegVar("_NoiseStrength", get__NoiseStrength, set__NoiseStrength);
		L.RegVar("_NoiseSeed", get__NoiseSeed, set__NoiseSeed);
		L.RegVar("_Segment", get__Segment, set__Segment);
		L.RegVar("_AbberationIntensity", get__AbberationIntensity, set__AbberationIntensity);
		L.RegVar("_AbberationRotation", get__AbberationRotation, set__AbberationRotation);
		L.RegVar("_AbberationColor1", get__AbberationColor1, set__AbberationColor1);
		L.RegVar("_AbberationColor2", get__AbberationColor2, set__AbberationColor2);
		L.RegVar("_BlurSize", get__BlurSize, set__BlurSize);
		L.RegVar("_BlurAngle", get__BlurAngle, set__BlurAngle);
		L.RegVar("_AlphaStrength", get__AlphaStrength, set__AlphaStrength);
		L.RegVar("_ColorIntensity", get__ColorIntensity, set__ColorIntensity);
		L.RegVar("graphic", get_graphic, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetModifiedMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIImageGlitch obj = (UIImageGlitch)ToLua.CheckObject<UIImageGlitch>(L, 1);
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
			Vector4 mainTex_ST = ((UIImageGlitch)obj)._MainTex_ST;
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
			Color color = ((UIImageGlitch)obj)._Color;
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
			float colorMask = ((UIImageGlitch)obj)._ColorMask;
			LuaDLL.lua_pushnumber(L, colorMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _ColorMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainPlusTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 mainPlusTex_ST = ((UIImageGlitch)obj).mainPlusTex_ST;
			ToLua.Push(L, mainPlusTex_ST);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainPlusTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainPlusRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mainPlusRotation = ((UIImageGlitch)obj).mainPlusRotation;
			LuaDLL.lua_pushnumber(L, mainPlusRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainPlusRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colorPlus(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color colorPlus = ((UIImageGlitch)obj).colorPlus;
			ToLua.Push(L, colorPlus);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorPlus on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colorPlusIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float colorPlusIntensity = ((UIImageGlitch)obj).colorPlusIntensity;
			LuaDLL.lua_pushnumber(L, colorPlusIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorPlusIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainPlusStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mainPlusStrength = ((UIImageGlitch)obj).mainPlusStrength;
			LuaDLL.lua_pushnumber(L, mainPlusStrength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainPlusStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__UseUIAlphaClip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float useUIAlphaClip = ((UIImageGlitch)obj)._UseUIAlphaClip;
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
			float noiseStrength = ((UIImageGlitch)obj)._NoiseStrength;
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
			float noiseSeed = ((UIImageGlitch)obj)._NoiseSeed;
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
			float segment = ((UIImageGlitch)obj)._Segment;
			LuaDLL.lua_pushnumber(L, segment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Segment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__AbberationIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float abberationIntensity = ((UIImageGlitch)obj)._AbberationIntensity;
			LuaDLL.lua_pushnumber(L, abberationIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AbberationIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__AbberationRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float abberationRotation = ((UIImageGlitch)obj)._AbberationRotation;
			LuaDLL.lua_pushnumber(L, abberationRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AbberationRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__AbberationColor1(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color abberationColor = ((UIImageGlitch)obj)._AbberationColor1;
			ToLua.Push(L, abberationColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AbberationColor1 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__AbberationColor2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color abberationColor = ((UIImageGlitch)obj)._AbberationColor2;
			ToLua.Push(L, abberationColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AbberationColor2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__BlurSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float blurSize = ((UIImageGlitch)obj)._BlurSize;
			LuaDLL.lua_pushnumber(L, blurSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _BlurSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__BlurAngle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float blurAngle = ((UIImageGlitch)obj)._BlurAngle;
			LuaDLL.lua_pushnumber(L, blurAngle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _BlurAngle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__AlphaStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float alphaStrength = ((UIImageGlitch)obj)._AlphaStrength;
			LuaDLL.lua_pushnumber(L, alphaStrength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AlphaStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__ColorIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float colorIntensity = ((UIImageGlitch)obj)._ColorIntensity;
			LuaDLL.lua_pushnumber(L, colorIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _ColorIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_graphic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Graphic graphic = ((UIImageGlitch)obj).graphic;
			ToLua.Push(L, graphic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index graphic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__MainTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
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
			UIImageGlitch obj2 = (UIImageGlitch)obj;
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
			UIImageGlitch obj2 = (UIImageGlitch)obj;
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
	private static int set_mainPlusTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			Vector4 mainPlusTex_ST = ToLua.ToVector4(L, 2);
			obj2.mainPlusTex_ST = mainPlusTex_ST;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainPlusTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mainPlusRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float mainPlusRotation = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.mainPlusRotation = mainPlusRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainPlusRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_colorPlus(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			Color colorPlus = ToLua.ToColor(L, 2);
			obj2.colorPlus = colorPlus;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorPlus on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_colorPlusIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float colorPlusIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.colorPlusIntensity = colorPlusIntensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colorPlusIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mainPlusStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float mainPlusStrength = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.mainPlusStrength = mainPlusStrength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainPlusStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__UseUIAlphaClip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
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
			UIImageGlitch obj2 = (UIImageGlitch)obj;
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
			UIImageGlitch obj2 = (UIImageGlitch)obj;
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
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float segment = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._Segment = segment;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Segment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__AbberationIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float abberationIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._AbberationIntensity = abberationIntensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AbberationIntensity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__AbberationRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float abberationRotation = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._AbberationRotation = abberationRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AbberationRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__AbberationColor1(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			Color abberationColor = ToLua.ToColor(L, 2);
			obj2._AbberationColor1 = abberationColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AbberationColor1 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__AbberationColor2(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			Color abberationColor = ToLua.ToColor(L, 2);
			obj2._AbberationColor2 = abberationColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AbberationColor2 on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__BlurSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float blurSize = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._BlurSize = blurSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _BlurSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__BlurAngle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float blurAngle = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._BlurAngle = blurAngle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _BlurAngle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__AlphaStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float alphaStrength = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._AlphaStrength = alphaStrength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _AlphaStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__ColorIntensity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIImageGlitch obj2 = (UIImageGlitch)obj;
			float colorIntensity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._ColorIntensity = colorIntensity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _ColorIntensity on a nil value");
		}
	}
}
