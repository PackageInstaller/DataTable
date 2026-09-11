using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class UnityEngine_Pipelines_SimPipeline_Character_ImageEffectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ImageEffect), typeof(EffectBase));
		L.RegFunction("turnOn", turnOn);
		L.RegFunction("turnOff", turnOff);
		L.RegFunction("updateSeperateRT", updateSeperateRT);
		L.RegFunction("New", _CreateUnityEngine_Pipelines_SimPipeline_Character_ImageEffect);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("enabled", get_enabled, null);
		L.RegVar("InteractWithScene", get_InteractWithScene, set_InteractWithScene);
		L.RegVar("color", get_color, set_color);
		L.RegVar("allowAlphaFade", get_allowAlphaFade, set_allowAlphaFade);
		L.RegVar("dispersionScale", get_dispersionScale, set_dispersionScale);
		L.RegVar("noisyScale", get_noisyScale, set_noisyScale);
		L.RegVar("blurScale", get_blurScale, set_blurScale);
		L.RegVar("interferenceStrengthRandom", get_interferenceStrengthRandom, set_interferenceStrengthRandom);
		L.RegVar("interferenceScale", get_interferenceScale, set_interferenceScale);
		L.RegVar("interferenceStrength", get_interferenceStrength, set_interferenceStrength);
		L.RegVar("interferenceSpeed", get_interferenceSpeed, set_interferenceSpeed);
		L.RegVar("silhouetteScale", get_silhouetteScale, set_silhouetteScale);
		L.RegVar("silhouetteMainBody", get_silhouetteMainBody, set_silhouetteMainBody);
		L.RegVar("silhouetteLineColor", get_silhouetteLineColor, set_silhouetteLineColor);
		L.RegVar("silhouetteMainBodyColor", get_silhouetteMainBodyColor, set_silhouetteMainBodyColor);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Pipelines_SimPipeline_Character_ImageEffect(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ImageEffect o = new ImageEffect();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Pipelines.SimPipeline.Character.ImageEffect.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int turnOn(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ImageEffect obj2 = (ImageEffect)ToLua.CheckObject<ImageEffect>(L, 1);
				bool needToInteractWithScene2 = LuaDLL.luaL_checkboolean(L, 2);
				obj2.turnOn(needToInteractWithScene2);
				return 0;
			}
			case 4:
			{
				ImageEffect obj = (ImageEffect)ToLua.CheckObject<ImageEffect>(L, 1);
				bool needToInteractWithScene = LuaDLL.luaL_checkboolean(L, 2);
				int width = (int)LuaDLL.luaL_checknumber(L, 3);
				int height = (int)LuaDLL.luaL_checknumber(L, 4);
				obj.turnOn(needToInteractWithScene, width, height);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Pipelines.SimPipeline.Character.ImageEffect.turnOn");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int turnOff(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ImageEffect)ToLua.CheckObject<ImageEffect>(L, 1)).turnOff();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int updateSeperateRT(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((ImageEffect)ToLua.CheckObject<ImageEffect>(L, 1)).updateSeperateRT();
				return 0;
			case 2:
			{
				ImageEffect obj = (ImageEffect)ToLua.CheckObject<ImageEffect>(L, 1);
				bool isActiveAndEnabled = LuaDLL.luaL_checkboolean(L, 2);
				obj.updateSeperateRT(isActiveAndEnabled);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Pipelines.SimPipeline.Character.ImageEffect.updateSeperateRT");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enabled = ((ImageEffect)obj).enabled;
			LuaDLL.lua_pushboolean(L, enabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_InteractWithScene(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool interactWithScene = ((ImageEffect)obj).InteractWithScene;
			LuaDLL.lua_pushboolean(L, interactWithScene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index InteractWithScene on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_color(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color color = ((ImageEffect)obj).color;
			ToLua.Push(L, color);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index color on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allowAlphaFade(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool allowAlphaFade = ((ImageEffect)obj).allowAlphaFade;
			LuaDLL.lua_pushboolean(L, allowAlphaFade);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowAlphaFade on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dispersionScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float dispersionScale = ((ImageEffect)obj).dispersionScale;
			LuaDLL.lua_pushnumber(L, dispersionScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dispersionScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_noisyScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float noisyScale = ((ImageEffect)obj).noisyScale;
			LuaDLL.lua_pushnumber(L, noisyScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noisyScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blurScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int blurScale = ((ImageEffect)obj).blurScale;
			LuaDLL.lua_pushinteger(L, blurScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blurScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interferenceStrengthRandom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float interferenceStrengthRandom = ((ImageEffect)obj).interferenceStrengthRandom;
			LuaDLL.lua_pushnumber(L, interferenceStrengthRandom);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceStrengthRandom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interferenceScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float interferenceScale = ((ImageEffect)obj).interferenceScale;
			LuaDLL.lua_pushnumber(L, interferenceScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interferenceStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float interferenceStrength = ((ImageEffect)obj).interferenceStrength;
			LuaDLL.lua_pushnumber(L, interferenceStrength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interferenceSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float interferenceSpeed = ((ImageEffect)obj).interferenceSpeed;
			LuaDLL.lua_pushnumber(L, interferenceSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_silhouetteScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float silhouetteScale = ((ImageEffect)obj).silhouetteScale;
			LuaDLL.lua_pushnumber(L, silhouetteScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index silhouetteScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_silhouetteMainBody(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float silhouetteMainBody = ((ImageEffect)obj).silhouetteMainBody;
			LuaDLL.lua_pushnumber(L, silhouetteMainBody);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index silhouetteMainBody on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_silhouetteLineColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color silhouetteLineColor = ((ImageEffect)obj).silhouetteLineColor;
			ToLua.Push(L, silhouetteLineColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index silhouetteLineColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_silhouetteMainBodyColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color silhouetteMainBodyColor = ((ImageEffect)obj).silhouetteMainBodyColor;
			ToLua.Push(L, silhouetteMainBodyColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index silhouetteMainBodyColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_InteractWithScene(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			bool interactWithScene = LuaDLL.luaL_checkboolean(L, 2);
			obj2.InteractWithScene = interactWithScene;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index InteractWithScene on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_color(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			Color color = ToLua.ToColor(L, 2);
			obj2.color = color;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index color on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allowAlphaFade(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			bool allowAlphaFade = LuaDLL.luaL_checkboolean(L, 2);
			obj2.allowAlphaFade = allowAlphaFade;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowAlphaFade on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dispersionScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			float dispersionScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.dispersionScale = dispersionScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dispersionScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_noisyScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			float noisyScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.noisyScale = noisyScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index noisyScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blurScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			int blurScale = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.blurScale = blurScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blurScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interferenceStrengthRandom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			float interferenceStrengthRandom = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.interferenceStrengthRandom = interferenceStrengthRandom;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceStrengthRandom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interferenceScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			float interferenceScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.interferenceScale = interferenceScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interferenceStrength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			float interferenceStrength = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.interferenceStrength = interferenceStrength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceStrength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interferenceSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			float interferenceSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.interferenceSpeed = interferenceSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interferenceSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_silhouetteScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			float silhouetteScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.silhouetteScale = silhouetteScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index silhouetteScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_silhouetteMainBody(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			float silhouetteMainBody = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.silhouetteMainBody = silhouetteMainBody;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index silhouetteMainBody on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_silhouetteLineColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			Color silhouetteLineColor = ToLua.ToColor(L, 2);
			obj2.silhouetteLineColor = silhouetteLineColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index silhouetteLineColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_silhouetteMainBodyColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ImageEffect obj2 = (ImageEffect)obj;
			Color silhouetteMainBodyColor = ToLua.ToColor(L, 2);
			obj2.silhouetteMainBodyColor = silhouetteMainBodyColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index silhouetteMainBodyColor on a nil value");
		}
	}
}
