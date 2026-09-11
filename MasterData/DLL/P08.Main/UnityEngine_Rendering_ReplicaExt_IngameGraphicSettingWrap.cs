using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering.ReplicaExt;

public class UnityEngine_Rendering_ReplicaExt_IngameGraphicSettingWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(IngameGraphicSetting), typeof(MonoBehaviour));
		L.RegFunction("ChangeVerticalSync", ChangeVerticalSync);
		L.RegFunction("ChangeDof", ChangeDof);
		L.RegFunction("UpdateDof", UpdateDof);
		L.RegFunction("ChangeFurQuality", ChangeFurQuality);
		L.RegFunction("ChangeShadowQuality", ChangeShadowQuality);
		L.RegFunction("ChangePostProcessQuality", ChangePostProcessQuality);
		L.RegFunction("ChangeRenderScale", ChangeRenderScale);
		L.RegFunction("OnEnable", OnEnable);
		L.RegFunction("OnValidate", OnValidate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mInstance", get_mInstance, set_mInstance);
		L.RegVar("Instance", get_Instance, null);
		L.RegVar("DepthOfFieldEnabled", get_DepthOfFieldEnabled, set_DepthOfFieldEnabled);
		L.RegVar("furQuality", get_furQuality, set_furQuality);
		L.RegVar("shadowQuality", get_shadowQuality, set_shadowQuality);
		L.RegVar("postProcessQuality", get_postProcessQuality, set_postProcessQuality);
		L.RegVar("renderScale", get_renderScale, set_renderScale);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeVerticalSync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IngameGraphicSetting obj = (IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1);
			bool isSync = LuaDLL.luaL_checkboolean(L, 2);
			obj.ChangeVerticalSync(isSync);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeDof(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IngameGraphicSetting obj = (IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1);
			bool value = LuaDLL.luaL_checkboolean(L, 2);
			obj.ChangeDof(value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateDof(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1)).UpdateDof();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeFurQuality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IngameGraphicSetting obj = (IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1);
			int level = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ChangeFurQuality(level);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeShadowQuality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IngameGraphicSetting obj = (IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1);
			int level = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ChangeShadowQuality(level);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangePostProcessQuality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IngameGraphicSetting obj = (IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1);
			int level = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ChangePostProcessQuality(level);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeRenderScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IngameGraphicSetting obj = (IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1);
			float level = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.ChangeRenderScale(level);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnEnable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1)).OnEnable();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnValidate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 1)).OnValidate();
			return 0;
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
	private static int get_mInstance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, IngameGraphicSetting.mInstance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, IngameGraphicSetting.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DepthOfFieldEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool depthOfFieldEnabled = ((IngameGraphicSetting)obj).DepthOfFieldEnabled;
			LuaDLL.lua_pushboolean(L, depthOfFieldEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DepthOfFieldEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_furQuality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IngameGraphicSetting.FurQuality furQuality = ((IngameGraphicSetting)obj).furQuality;
			ToLua.Push(L, furQuality);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index furQuality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shadowQuality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IngameGraphicSetting.ShadowQuality shadowQuality = ((IngameGraphicSetting)obj).shadowQuality;
			ToLua.Push(L, shadowQuality);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowQuality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_postProcessQuality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IngameGraphicSetting.PostProcessQuality postProcessQuality = ((IngameGraphicSetting)obj).postProcessQuality;
			ToLua.Push(L, postProcessQuality);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index postProcessQuality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float renderScale = ((IngameGraphicSetting)obj).renderScale;
			LuaDLL.lua_pushnumber(L, renderScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mInstance(IntPtr L)
	{
		try
		{
			IngameGraphicSetting.mInstance = (IngameGraphicSetting)ToLua.CheckObject<IngameGraphicSetting>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_DepthOfFieldEnabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IngameGraphicSetting obj2 = (IngameGraphicSetting)obj;
			bool depthOfFieldEnabled = LuaDLL.luaL_checkboolean(L, 2);
			obj2.DepthOfFieldEnabled = depthOfFieldEnabled;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DepthOfFieldEnabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_furQuality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IngameGraphicSetting obj2 = (IngameGraphicSetting)obj;
			IngameGraphicSetting.FurQuality furQuality = (IngameGraphicSetting.FurQuality)ToLua.CheckObject(L, 2, typeof(IngameGraphicSetting.FurQuality));
			obj2.furQuality = furQuality;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index furQuality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shadowQuality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IngameGraphicSetting obj2 = (IngameGraphicSetting)obj;
			IngameGraphicSetting.ShadowQuality shadowQuality = (IngameGraphicSetting.ShadowQuality)ToLua.CheckObject(L, 2, typeof(IngameGraphicSetting.ShadowQuality));
			obj2.shadowQuality = shadowQuality;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowQuality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_postProcessQuality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IngameGraphicSetting obj2 = (IngameGraphicSetting)obj;
			IngameGraphicSetting.PostProcessQuality postProcessQuality = (IngameGraphicSetting.PostProcessQuality)ToLua.CheckObject(L, 2, typeof(IngameGraphicSetting.PostProcessQuality));
			obj2.postProcessQuality = postProcessQuality;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index postProcessQuality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			IngameGraphicSetting obj2 = (IngameGraphicSetting)obj;
			float renderScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.renderScale = renderScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderScale on a nil value");
		}
	}
}
