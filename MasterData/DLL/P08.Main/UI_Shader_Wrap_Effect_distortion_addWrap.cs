using System;
using LuaInterface;
using UI_Shader_Wrap;
using UnityEngine;

public class UI_Shader_Wrap_Effect_distortion_addWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Effect_distortion_add), typeof(MonoBehaviour));
		L.RegFunction("GetModifiedMaterial", GetModifiedMaterial);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("_Brightness", get__Brightness, set__Brightness);
		L.RegVar("_Contrast", get__Contrast, set__Contrast);
		L.RegVar("_MainColor", get__MainColor, set__MainColor);
		L.RegVar("_MainTex_ST", get__MainTex_ST, set__MainTex_ST);
		L.RegVar("_MainPannerX", get__MainPannerX, set__MainPannerX);
		L.RegVar("_MainPannerY", get__MainPannerY, set__MainPannerY);
		L.RegVar("_TurbulenceTex_ST", get__TurbulenceTex_ST, set__TurbulenceTex_ST);
		L.RegVar("_MaskTex_ST", get__MaskTex_ST, set__MaskTex_ST);
		L.RegVar("_DistortPower", get__DistortPower, set__DistortPower);
		L.RegVar("_PowerX", get__PowerX, set__PowerX);
		L.RegVar("_PowerY", get__PowerY, set__PowerY);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetModifiedMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Effect_distortion_add obj = (Effect_distortion_add)ToLua.CheckObject<Effect_distortion_add>(L, 1);
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
	private static int get__Brightness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float brightness = ((Effect_distortion_add)obj)._Brightness;
			LuaDLL.lua_pushnumber(L, brightness);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Brightness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__Contrast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float contrast = ((Effect_distortion_add)obj)._Contrast;
			LuaDLL.lua_pushnumber(L, contrast);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Contrast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__MainColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color mainColor = ((Effect_distortion_add)obj)._MainColor;
			ToLua.Push(L, mainColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__MainTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 mainTex_ST = ((Effect_distortion_add)obj)._MainTex_ST;
			ToLua.Push(L, mainTex_ST);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__MainPannerX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mainPannerX = ((Effect_distortion_add)obj)._MainPannerX;
			LuaDLL.lua_pushnumber(L, mainPannerX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainPannerX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__MainPannerY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mainPannerY = ((Effect_distortion_add)obj)._MainPannerY;
			LuaDLL.lua_pushnumber(L, mainPannerY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainPannerY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__TurbulenceTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 turbulenceTex_ST = ((Effect_distortion_add)obj)._TurbulenceTex_ST;
			ToLua.Push(L, turbulenceTex_ST);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _TurbulenceTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__MaskTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 maskTex_ST = ((Effect_distortion_add)obj)._MaskTex_ST;
			ToLua.Push(L, maskTex_ST);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MaskTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__DistortPower(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float distortPower = ((Effect_distortion_add)obj)._DistortPower;
			LuaDLL.lua_pushnumber(L, distortPower);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _DistortPower on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__PowerX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float powerX = ((Effect_distortion_add)obj)._PowerX;
			LuaDLL.lua_pushnumber(L, powerX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _PowerX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__PowerY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float powerY = ((Effect_distortion_add)obj)._PowerY;
			LuaDLL.lua_pushnumber(L, powerY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _PowerY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__Brightness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			float brightness = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._Brightness = brightness;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Brightness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__Contrast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			float contrast = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._Contrast = contrast;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _Contrast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__MainColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			Color mainColor = ToLua.ToColor(L, 2);
			obj2._MainColor = mainColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__MainTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
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
	private static int set__MainPannerX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			float mainPannerX = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._MainPannerX = mainPannerX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainPannerX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__MainPannerY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			float mainPannerY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._MainPannerY = mainPannerY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MainPannerY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__TurbulenceTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			Vector4 turbulenceTex_ST = ToLua.ToVector4(L, 2);
			obj2._TurbulenceTex_ST = turbulenceTex_ST;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _TurbulenceTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__MaskTex_ST(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			Vector4 maskTex_ST = ToLua.ToVector4(L, 2);
			obj2._MaskTex_ST = maskTex_ST;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _MaskTex_ST on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__DistortPower(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			float distortPower = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._DistortPower = distortPower;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _DistortPower on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__PowerX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			float powerX = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._PowerX = powerX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _PowerX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__PowerY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Effect_distortion_add obj2 = (Effect_distortion_add)obj;
			float powerY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2._PowerY = powerY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _PowerY on a nil value");
		}
	}
}
