using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering;

public class UnityEngine_Rendering_GraphicsSettingsWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GraphicsSettings), typeof(UnityEngine.Object));
		L.RegFunction("HasShaderDefine", HasShaderDefine);
		L.RegFunction("GetGraphicsSettings", GetGraphicsSettings);
		L.RegFunction("SetShaderMode", SetShaderMode);
		L.RegFunction("GetShaderMode", GetShaderMode);
		L.RegFunction("SetCustomShader", SetCustomShader);
		L.RegFunction("GetCustomShader", GetCustomShader);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("transparencySortMode", get_transparencySortMode, set_transparencySortMode);
		L.RegVar("transparencySortAxis", get_transparencySortAxis, set_transparencySortAxis);
		L.RegVar("realtimeDirectRectangularAreaLights", get_realtimeDirectRectangularAreaLights, set_realtimeDirectRectangularAreaLights);
		L.RegVar("lightsUseLinearIntensity", get_lightsUseLinearIntensity, set_lightsUseLinearIntensity);
		L.RegVar("lightsUseColorTemperature", get_lightsUseColorTemperature, set_lightsUseColorTemperature);
		L.RegVar("defaultRenderingLayerMask", get_defaultRenderingLayerMask, set_defaultRenderingLayerMask);
		L.RegVar("useScriptableRenderPipelineBatching", get_useScriptableRenderPipelineBatching, set_useScriptableRenderPipelineBatching);
		L.RegVar("logWhenShaderIsCompiled", get_logWhenShaderIsCompiled, set_logWhenShaderIsCompiled);
		L.RegVar("disableBuiltinCustomRenderTextureUpdate", get_disableBuiltinCustomRenderTextureUpdate, set_disableBuiltinCustomRenderTextureUpdate);
		L.RegVar("currentRenderPipeline", get_currentRenderPipeline, null);
		L.RegVar("renderPipelineAsset", get_renderPipelineAsset, set_renderPipelineAsset);
		L.RegVar("defaultRenderPipeline", get_defaultRenderPipeline, set_defaultRenderPipeline);
		L.RegVar("allConfiguredRenderPipelines", get_allConfiguredRenderPipelines, null);
		L.RegVar("cameraRelativeLightCulling", get_cameraRelativeLightCulling, set_cameraRelativeLightCulling);
		L.RegVar("cameraRelativeShadowCulling", get_cameraRelativeShadowCulling, set_cameraRelativeShadowCulling);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasShaderDefine(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = GraphicsSettings.HasShaderDefine((BuiltinShaderDefine)ToLua.CheckObject(L, 1, typeof(BuiltinShaderDefine)));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				GraphicsTier tier = (GraphicsTier)ToLua.CheckObject(L, 1, typeof(GraphicsTier));
				BuiltinShaderDefine defineHash = (BuiltinShaderDefine)ToLua.CheckObject(L, 2, typeof(BuiltinShaderDefine));
				bool value = GraphicsSettings.HasShaderDefine(tier, defineHash);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rendering.GraphicsSettings.HasShaderDefine");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGraphicsSettings(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			UnityEngine.Object graphicsSettings = GraphicsSettings.GetGraphicsSettings();
			ToLua.Push(L, graphicsSettings);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetShaderMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BuiltinShaderType type = (BuiltinShaderType)ToLua.CheckObject(L, 1, typeof(BuiltinShaderType));
			BuiltinShaderMode mode = (BuiltinShaderMode)ToLua.CheckObject(L, 2, typeof(BuiltinShaderMode));
			GraphicsSettings.SetShaderMode(type, mode);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetShaderMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			BuiltinShaderMode shaderMode = GraphicsSettings.GetShaderMode((BuiltinShaderType)ToLua.CheckObject(L, 1, typeof(BuiltinShaderType)));
			ToLua.Push(L, shaderMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCustomShader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BuiltinShaderType type = (BuiltinShaderType)ToLua.CheckObject(L, 1, typeof(BuiltinShaderType));
			Shader shader = (Shader)ToLua.CheckObject(L, 2, typeof(Shader));
			GraphicsSettings.SetCustomShader(type, shader);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCustomShader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Shader customShader = GraphicsSettings.GetCustomShader((BuiltinShaderType)ToLua.CheckObject(L, 1, typeof(BuiltinShaderType)));
			ToLua.PushSealed(L, customShader);
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
	private static int get_transparencySortMode(IntPtr L)
	{
		try
		{
			ToLua.Push(L, GraphicsSettings.transparencySortMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_transparencySortAxis(IntPtr L)
	{
		try
		{
			ToLua.Push(L, GraphicsSettings.transparencySortAxis);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_realtimeDirectRectangularAreaLights(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GraphicsSettings.realtimeDirectRectangularAreaLights);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lightsUseLinearIntensity(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GraphicsSettings.lightsUseLinearIntensity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lightsUseColorTemperature(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GraphicsSettings.lightsUseColorTemperature);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultRenderingLayerMask(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, GraphicsSettings.defaultRenderingLayerMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useScriptableRenderPipelineBatching(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GraphicsSettings.useScriptableRenderPipelineBatching);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_logWhenShaderIsCompiled(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GraphicsSettings.logWhenShaderIsCompiled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_disableBuiltinCustomRenderTextureUpdate(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GraphicsSettings.disableBuiltinCustomRenderTextureUpdate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentRenderPipeline(IntPtr L)
	{
		try
		{
			ToLua.Push(L, GraphicsSettings.currentRenderPipeline);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderPipelineAsset(IntPtr L)
	{
		try
		{
			ToLua.Push(L, GraphicsSettings.renderPipelineAsset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultRenderPipeline(IntPtr L)
	{
		try
		{
			ToLua.Push(L, GraphicsSettings.defaultRenderPipeline);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allConfiguredRenderPipelines(IntPtr L)
	{
		try
		{
			ToLua.Push(L, GraphicsSettings.allConfiguredRenderPipelines);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cameraRelativeLightCulling(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GraphicsSettings.cameraRelativeLightCulling);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cameraRelativeShadowCulling(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GraphicsSettings.cameraRelativeShadowCulling);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_transparencySortMode(IntPtr L)
	{
		try
		{
			GraphicsSettings.transparencySortMode = (TransparencySortMode)ToLua.CheckObject(L, 2, typeof(TransparencySortMode));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_transparencySortAxis(IntPtr L)
	{
		try
		{
			GraphicsSettings.transparencySortAxis = ToLua.ToVector3(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_realtimeDirectRectangularAreaLights(IntPtr L)
	{
		try
		{
			GraphicsSettings.realtimeDirectRectangularAreaLights = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lightsUseLinearIntensity(IntPtr L)
	{
		try
		{
			GraphicsSettings.lightsUseLinearIntensity = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lightsUseColorTemperature(IntPtr L)
	{
		try
		{
			GraphicsSettings.lightsUseColorTemperature = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultRenderingLayerMask(IntPtr L)
	{
		try
		{
			GraphicsSettings.defaultRenderingLayerMask = (uint)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useScriptableRenderPipelineBatching(IntPtr L)
	{
		try
		{
			GraphicsSettings.useScriptableRenderPipelineBatching = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_logWhenShaderIsCompiled(IntPtr L)
	{
		try
		{
			GraphicsSettings.logWhenShaderIsCompiled = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_disableBuiltinCustomRenderTextureUpdate(IntPtr L)
	{
		try
		{
			GraphicsSettings.disableBuiltinCustomRenderTextureUpdate = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderPipelineAsset(IntPtr L)
	{
		try
		{
			GraphicsSettings.renderPipelineAsset = (RenderPipelineAsset)ToLua.CheckObject<RenderPipelineAsset>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultRenderPipeline(IntPtr L)
	{
		try
		{
			GraphicsSettings.defaultRenderPipeline = (RenderPipelineAsset)ToLua.CheckObject<RenderPipelineAsset>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cameraRelativeLightCulling(IntPtr L)
	{
		try
		{
			GraphicsSettings.cameraRelativeLightCulling = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cameraRelativeShadowCulling(IntPtr L)
	{
		try
		{
			GraphicsSettings.cameraRelativeShadowCulling = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
