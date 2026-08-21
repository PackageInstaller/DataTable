using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering;

public class UnityEngine_RendererWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Renderer), typeof(Component));
		L.RegFunction("HasPropertyBlock", HasPropertyBlock);
		L.RegFunction("SetPropertyBlock", SetPropertyBlock);
		L.RegFunction("GetPropertyBlock", GetPropertyBlock);
		L.RegFunction("GetMaterials", GetMaterials);
		L.RegFunction("GetSharedMaterials", GetSharedMaterials);
		L.RegFunction("GetClosestReflectionProbes", GetClosestReflectionProbes);
		L.RegFunction("New", _CreateUnityEngine_Renderer);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("bounds", get_bounds, null);
		L.RegVar("enabled", get_enabled, set_enabled);
		L.RegVar("isVisible", get_isVisible, null);
		L.RegVar("shadowCastingMode", get_shadowCastingMode, set_shadowCastingMode);
		L.RegVar("receiveShadows", get_receiveShadows, set_receiveShadows);
		L.RegVar("motionVectorGenerationMode", get_motionVectorGenerationMode, set_motionVectorGenerationMode);
		L.RegVar("lightProbeUsage", get_lightProbeUsage, set_lightProbeUsage);
		L.RegVar("reflectionProbeUsage", get_reflectionProbeUsage, set_reflectionProbeUsage);
		L.RegVar("renderingLayerMask", get_renderingLayerMask, set_renderingLayerMask);
		L.RegVar("rendererPriority", get_rendererPriority, set_rendererPriority);
		L.RegVar("sortingLayerName", get_sortingLayerName, set_sortingLayerName);
		L.RegVar("sortingLayerID", get_sortingLayerID, set_sortingLayerID);
		L.RegVar("sortingOrder", get_sortingOrder, set_sortingOrder);
		L.RegVar("allowOcclusionWhenDynamic", get_allowOcclusionWhenDynamic, set_allowOcclusionWhenDynamic);
		L.RegVar("isPartOfStaticBatch", get_isPartOfStaticBatch, null);
		L.RegVar("worldToLocalMatrix", get_worldToLocalMatrix, null);
		L.RegVar("localToWorldMatrix", get_localToWorldMatrix, null);
		L.RegVar("lightProbeProxyVolumeOverride", get_lightProbeProxyVolumeOverride, set_lightProbeProxyVolumeOverride);
		L.RegVar("probeAnchor", get_probeAnchor, set_probeAnchor);
		L.RegVar("lightmapIndex", get_lightmapIndex, set_lightmapIndex);
		L.RegVar("realtimeLightmapIndex", get_realtimeLightmapIndex, set_realtimeLightmapIndex);
		L.RegVar("lightmapScaleOffset", get_lightmapScaleOffset, set_lightmapScaleOffset);
		L.RegVar("realtimeLightmapScaleOffset", get_realtimeLightmapScaleOffset, set_realtimeLightmapScaleOffset);
		L.RegVar("materials", get_materials, set_materials);
		L.RegVar("material", get_material, set_material);
		L.RegVar("sharedMaterial", get_sharedMaterial, set_sharedMaterial);
		L.RegVar("sharedMaterials", get_sharedMaterials, set_sharedMaterials);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Renderer(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Renderer obj = new Renderer();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Renderer.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasPropertyBlock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((Renderer)ToLua.CheckObject<Renderer>(L, 1)).HasPropertyBlock();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPropertyBlock(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Renderer obj2 = (Renderer)ToLua.CheckObject<Renderer>(L, 1);
				MaterialPropertyBlock propertyBlock = (MaterialPropertyBlock)ToLua.CheckObject(L, 2, typeof(MaterialPropertyBlock));
				obj2.SetPropertyBlock(propertyBlock);
				return 0;
			}
			case 3:
			{
				Renderer obj = (Renderer)ToLua.CheckObject<Renderer>(L, 1);
				MaterialPropertyBlock properties = (MaterialPropertyBlock)ToLua.CheckObject(L, 2, typeof(MaterialPropertyBlock));
				int materialIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				obj.SetPropertyBlock(properties, materialIndex);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Renderer.SetPropertyBlock");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPropertyBlock(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Renderer obj2 = (Renderer)ToLua.CheckObject<Renderer>(L, 1);
				MaterialPropertyBlock properties2 = (MaterialPropertyBlock)ToLua.CheckObject(L, 2, typeof(MaterialPropertyBlock));
				obj2.GetPropertyBlock(properties2);
				return 0;
			}
			case 3:
			{
				Renderer obj = (Renderer)ToLua.CheckObject<Renderer>(L, 1);
				MaterialPropertyBlock properties = (MaterialPropertyBlock)ToLua.CheckObject(L, 2, typeof(MaterialPropertyBlock));
				int materialIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				obj.GetPropertyBlock(properties, materialIndex);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Renderer.GetPropertyBlock");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMaterials(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Renderer obj = (Renderer)ToLua.CheckObject<Renderer>(L, 1);
			List<Material> m = (List<Material>)ToLua.CheckObject(L, 2, typeof(List<Material>));
			obj.GetMaterials(m);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSharedMaterials(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Renderer obj = (Renderer)ToLua.CheckObject<Renderer>(L, 1);
			List<Material> m = (List<Material>)ToLua.CheckObject(L, 2, typeof(List<Material>));
			obj.GetSharedMaterials(m);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetClosestReflectionProbes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Renderer obj = (Renderer)ToLua.CheckObject<Renderer>(L, 1);
			List<ReflectionProbeBlendInfo> result = (List<ReflectionProbeBlendInfo>)ToLua.CheckObject(L, 2, typeof(List<ReflectionProbeBlendInfo>));
			obj.GetClosestReflectionProbes(result);
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
	private static int get_bounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Bounds bounds = ((Renderer)obj).bounds;
			ToLua.Push(L, bounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enabled = ((Renderer)obj).enabled;
			LuaDLL.lua_pushboolean(L, enabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isVisible(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isVisible = ((Renderer)obj).isVisible;
			LuaDLL.lua_pushboolean(L, isVisible);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isVisible on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shadowCastingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ShadowCastingMode shadowCastingMode = ((Renderer)obj).shadowCastingMode;
			ToLua.Push(L, shadowCastingMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowCastingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_receiveShadows(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool receiveShadows = ((Renderer)obj).receiveShadows;
			LuaDLL.lua_pushboolean(L, receiveShadows);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index receiveShadows on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_motionVectorGenerationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MotionVectorGenerationMode motionVectorGenerationMode = ((Renderer)obj).motionVectorGenerationMode;
			ToLua.Push(L, motionVectorGenerationMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index motionVectorGenerationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lightProbeUsage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LightProbeUsage lightProbeUsage = ((Renderer)obj).lightProbeUsage;
			ToLua.Push(L, lightProbeUsage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightProbeUsage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reflectionProbeUsage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ReflectionProbeUsage reflectionProbeUsage = ((Renderer)obj).reflectionProbeUsage;
			ToLua.Push(L, reflectionProbeUsage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reflectionProbeUsage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_renderingLayerMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint renderingLayerMask = ((Renderer)obj).renderingLayerMask;
			LuaDLL.lua_pushnumber(L, renderingLayerMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderingLayerMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rendererPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rendererPriority = ((Renderer)obj).rendererPriority;
			LuaDLL.lua_pushinteger(L, rendererPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rendererPriority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sortingLayerName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string sortingLayerName = ((Renderer)obj).sortingLayerName;
			LuaDLL.lua_pushstring(L, sortingLayerName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingLayerName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sortingLayerID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sortingLayerID = ((Renderer)obj).sortingLayerID;
			LuaDLL.lua_pushinteger(L, sortingLayerID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingLayerID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sortingOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sortingOrder = ((Renderer)obj).sortingOrder;
			LuaDLL.lua_pushinteger(L, sortingOrder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allowOcclusionWhenDynamic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool allowOcclusionWhenDynamic = ((Renderer)obj).allowOcclusionWhenDynamic;
			LuaDLL.lua_pushboolean(L, allowOcclusionWhenDynamic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowOcclusionWhenDynamic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPartOfStaticBatch(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPartOfStaticBatch = ((Renderer)obj).isPartOfStaticBatch;
			LuaDLL.lua_pushboolean(L, isPartOfStaticBatch);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isPartOfStaticBatch on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_worldToLocalMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 worldToLocalMatrix = ((Renderer)obj).worldToLocalMatrix;
			ToLua.PushValue(L, worldToLocalMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index worldToLocalMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localToWorldMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 localToWorldMatrix = ((Renderer)obj).localToWorldMatrix;
			ToLua.PushValue(L, localToWorldMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localToWorldMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lightProbeProxyVolumeOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject lightProbeProxyVolumeOverride = ((Renderer)obj).lightProbeProxyVolumeOverride;
			ToLua.PushSealed(L, lightProbeProxyVolumeOverride);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightProbeProxyVolumeOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_probeAnchor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform probeAnchor = ((Renderer)obj).probeAnchor;
			ToLua.Push(L, probeAnchor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index probeAnchor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lightmapIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int lightmapIndex = ((Renderer)obj).lightmapIndex;
			LuaDLL.lua_pushinteger(L, lightmapIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightmapIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_realtimeLightmapIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int realtimeLightmapIndex = ((Renderer)obj).realtimeLightmapIndex;
			LuaDLL.lua_pushinteger(L, realtimeLightmapIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realtimeLightmapIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lightmapScaleOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 lightmapScaleOffset = ((Renderer)obj).lightmapScaleOffset;
			ToLua.Push(L, lightmapScaleOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightmapScaleOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_realtimeLightmapScaleOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 realtimeLightmapScaleOffset = ((Renderer)obj).realtimeLightmapScaleOffset;
			ToLua.Push(L, realtimeLightmapScaleOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realtimeLightmapScaleOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_materials(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material[] materials = ((Renderer)obj).materials;
			ToLua.Push(L, materials);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index materials on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_material(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material material = ((Renderer)obj).material;
			ToLua.Push(L, material);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index material on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sharedMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material sharedMaterial = ((Renderer)obj).sharedMaterial;
			ToLua.Push(L, sharedMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sharedMaterials(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material[] sharedMaterials = ((Renderer)obj).sharedMaterials;
			ToLua.Push(L, sharedMaterials);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMaterials on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			bool enabled = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enabled = enabled;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shadowCastingMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			ShadowCastingMode shadowCastingMode = (ShadowCastingMode)ToLua.CheckObject(L, 2, typeof(ShadowCastingMode));
			obj2.shadowCastingMode = shadowCastingMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shadowCastingMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_receiveShadows(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			bool receiveShadows = LuaDLL.luaL_checkboolean(L, 2);
			obj2.receiveShadows = receiveShadows;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index receiveShadows on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_motionVectorGenerationMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			MotionVectorGenerationMode motionVectorGenerationMode = (MotionVectorGenerationMode)ToLua.CheckObject(L, 2, typeof(MotionVectorGenerationMode));
			obj2.motionVectorGenerationMode = motionVectorGenerationMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index motionVectorGenerationMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lightProbeUsage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			LightProbeUsage lightProbeUsage = (LightProbeUsage)ToLua.CheckObject(L, 2, typeof(LightProbeUsage));
			obj2.lightProbeUsage = lightProbeUsage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightProbeUsage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reflectionProbeUsage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			ReflectionProbeUsage reflectionProbeUsage = (ReflectionProbeUsage)ToLua.CheckObject(L, 2, typeof(ReflectionProbeUsage));
			obj2.reflectionProbeUsage = reflectionProbeUsage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index reflectionProbeUsage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_renderingLayerMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			uint renderingLayerMask = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj2.renderingLayerMask = renderingLayerMask;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index renderingLayerMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rendererPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			int rendererPriority = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.rendererPriority = rendererPriority;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rendererPriority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sortingLayerName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			string sortingLayerName = ToLua.CheckString(L, 2);
			obj2.sortingLayerName = sortingLayerName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingLayerName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sortingLayerID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			int sortingLayerID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sortingLayerID = sortingLayerID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingLayerID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sortingOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			int sortingOrder = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sortingOrder = sortingOrder;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sortingOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allowOcclusionWhenDynamic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			bool allowOcclusionWhenDynamic = LuaDLL.luaL_checkboolean(L, 2);
			obj2.allowOcclusionWhenDynamic = allowOcclusionWhenDynamic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowOcclusionWhenDynamic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lightProbeProxyVolumeOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			GameObject lightProbeProxyVolumeOverride = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.lightProbeProxyVolumeOverride = lightProbeProxyVolumeOverride;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightProbeProxyVolumeOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_probeAnchor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			Transform probeAnchor = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.probeAnchor = probeAnchor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index probeAnchor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lightmapIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			int lightmapIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.lightmapIndex = lightmapIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightmapIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_realtimeLightmapIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			int realtimeLightmapIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.realtimeLightmapIndex = realtimeLightmapIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realtimeLightmapIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lightmapScaleOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			Vector4 lightmapScaleOffset = ToLua.ToVector4(L, 2);
			obj2.lightmapScaleOffset = lightmapScaleOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lightmapScaleOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_realtimeLightmapScaleOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			Vector4 realtimeLightmapScaleOffset = ToLua.ToVector4(L, 2);
			obj2.realtimeLightmapScaleOffset = realtimeLightmapScaleOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index realtimeLightmapScaleOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_materials(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			Material[] materials = ToLua.CheckObjectArray<Material>(L, 2);
			obj2.materials = materials;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index materials on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_material(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			Material material = (Material)ToLua.CheckObject<Material>(L, 2);
			obj2.material = material;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index material on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sharedMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			Material sharedMaterial = (Material)ToLua.CheckObject<Material>(L, 2);
			obj2.sharedMaterial = sharedMaterial;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sharedMaterials(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Renderer obj2 = (Renderer)obj;
			Material[] sharedMaterials = ToLua.CheckObjectArray<Material>(L, 2);
			obj2.sharedMaterials = sharedMaterials;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMaterials on a nil value");
		}
	}
}
