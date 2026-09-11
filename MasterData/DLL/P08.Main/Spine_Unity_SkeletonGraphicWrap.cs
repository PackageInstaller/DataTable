using System;
using System.Collections.Generic;
using LuaInterface;
using Spine;
using Spine.Unity;
using UnityEngine;
using UnityEngine.UI;

public class Spine_Unity_SkeletonGraphicWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SkeletonGraphic), typeof(MaskableGraphic));
		L.RegFunction("NewSkeletonGraphicGameObject", NewSkeletonGraphicGameObject);
		L.RegFunction("AddSkeletonGraphicComponent", AddSkeletonGraphicComponent);
		L.RegFunction("Rebuild", Rebuild);
		L.RegFunction("Update", Update);
		L.RegFunction("LateUpdate", LateUpdate);
		L.RegFunction("OnBecameVisible", OnBecameVisible);
		L.RegFunction("OnBecameInvisible", OnBecameInvisible);
		L.RegFunction("ReapplySeparatorSlotNames", ReapplySeparatorSlotNames);
		L.RegFunction("GetLastMesh", GetLastMesh);
		L.RegFunction("MatchRectTransformWithBounds", MatchRectTransformWithBounds);
		L.RegFunction("Clear", Clear);
		L.RegFunction("TrimRenderers", TrimRenderers);
		L.RegFunction("Initialize", Initialize);
		L.RegFunction("UpdateMesh", UpdateMesh);
		L.RegFunction("HasMultipleSubmeshInstructions", HasMultipleSubmeshInstructions);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("skeletonDataAsset", get_skeletonDataAsset, set_skeletonDataAsset);
		L.RegVar("initialSkinName", get_initialSkinName, set_initialSkinName);
		L.RegVar("initialFlipX", get_initialFlipX, set_initialFlipX);
		L.RegVar("initialFlipY", get_initialFlipY, set_initialFlipY);
		L.RegVar("startingAnimation", get_startingAnimation, set_startingAnimation);
		L.RegVar("startingLoop", get_startingLoop, set_startingLoop);
		L.RegVar("timeScale", get_timeScale, set_timeScale);
		L.RegVar("freeze", get_freeze, set_freeze);
		L.RegVar("updateWhenInvisible", get_updateWhenInvisible, set_updateWhenInvisible);
		L.RegVar("unscaledTime", get_unscaledTime, set_unscaledTime);
		L.RegVar("allowMultipleCanvasRenderers", get_allowMultipleCanvasRenderers, set_allowMultipleCanvasRenderers);
		L.RegVar("canvasRenderers", get_canvasRenderers, set_canvasRenderers);
		L.RegVar("SeparatorPartGameObjectName", get_SeparatorPartGameObjectName, null);
		L.RegVar("separatorSlots", get_separatorSlots, null);
		L.RegVar("enableSeparatorSlots", get_enableSeparatorSlots, set_enableSeparatorSlots);
		L.RegVar("updateSeparatorPartLocation", get_updateSeparatorPartLocation, set_updateSeparatorPartLocation);
		L.RegVar("SkeletonDataAsset", get_SkeletonDataAsset, null);
		L.RegVar("UpdateMode", get_UpdateMode, set_UpdateMode);
		L.RegVar("SeparatorParts", get_SeparatorParts, null);
		L.RegVar("CustomTextureOverride", get_CustomTextureOverride, null);
		L.RegVar("CustomMaterialOverride", get_CustomMaterialOverride, null);
		L.RegVar("OverrideTexture", get_OverrideTexture, set_OverrideTexture);
		L.RegVar("mainTexture", get_mainTexture, null);
		L.RegVar("Skeleton", get_Skeleton, set_Skeleton);
		L.RegVar("SkeletonData", get_SkeletonData, null);
		L.RegVar("IsValid", get_IsValid, null);
		L.RegVar("AnimationState", get_AnimationState, null);
		L.RegVar("MeshGenerator", get_MeshGenerator, null);
		L.RegVar("OnRebuild", get_OnRebuild, set_OnRebuild);
		L.RegVar("OnMeshAndMaterialsUpdated", get_OnMeshAndMaterialsUpdated, set_OnMeshAndMaterialsUpdated);
		L.RegVar("BeforeApply", get_BeforeApply, set_BeforeApply);
		L.RegVar("UpdateLocal", get_UpdateLocal, set_UpdateLocal);
		L.RegVar("UpdateWorld", get_UpdateWorld, set_UpdateWorld);
		L.RegVar("UpdateComplete", get_UpdateComplete, set_UpdateComplete);
		L.RegVar("OnPostProcessVertices", get_OnPostProcessVertices, set_OnPostProcessVertices);
		L.RegFunction("SkeletonRendererDelegate", Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NewSkeletonGraphicGameObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			SkeletonDataAsset skeletonDataAsset = (SkeletonDataAsset)ToLua.CheckObject<SkeletonDataAsset>(L, 1);
			Transform parent = (Transform)ToLua.CheckObject<Transform>(L, 2);
			Material material = (Material)ToLua.CheckObject<Material>(L, 3);
			SkeletonGraphic obj = SkeletonGraphic.NewSkeletonGraphicGameObject(skeletonDataAsset, parent, material);
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddSkeletonGraphicComponent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			SkeletonDataAsset skeletonDataAsset = (SkeletonDataAsset)ToLua.CheckObject<SkeletonDataAsset>(L, 2);
			Material material = (Material)ToLua.CheckObject<Material>(L, 3);
			SkeletonGraphic obj = SkeletonGraphic.AddSkeletonGraphicComponent(gameObject, skeletonDataAsset, material);
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rebuild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SkeletonGraphic obj = (SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1);
			CanvasUpdate update = (CanvasUpdate)ToLua.CheckObject(L, 2, typeof(CanvasUpdate));
			obj.Rebuild(update);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Update(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).Update();
				return 0;
			case 2:
			{
				SkeletonGraphic obj = (SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1);
				float deltaTime = (float)LuaDLL.luaL_checknumber(L, 2);
				obj.Update(deltaTime);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.Unity.SkeletonGraphic.Update");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LateUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).LateUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnBecameVisible(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).OnBecameVisible();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnBecameInvisible(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).OnBecameInvisible();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReapplySeparatorSlotNames(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).ReapplySeparatorSlotNames();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLastMesh(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Mesh lastMesh = ((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).GetLastMesh();
			ToLua.PushSealed(L, lastMesh);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MatchRectTransformWithBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).MatchRectTransformWithBounds();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).Clear();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TrimRenderers(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).TrimRenderers();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Initialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SkeletonGraphic obj = (SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1);
			bool overwrite = LuaDLL.luaL_checkboolean(L, 2);
			obj.Initialize(overwrite);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateMesh(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).UpdateMesh();
				return 0;
			case 2:
			{
				SkeletonGraphic obj = (SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1);
				bool keepRendererCount = LuaDLL.luaL_checkboolean(L, 2);
				obj.UpdateMesh(keepRendererCount);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.Unity.SkeletonGraphic.UpdateMesh");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasMultipleSubmeshInstructions(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((SkeletonGraphic)ToLua.CheckObject<SkeletonGraphic>(L, 1)).HasMultipleSubmeshInstructions();
			LuaDLL.lua_pushboolean(L, value);
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
	private static int get_skeletonDataAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonDataAsset skeletonDataAsset = ((SkeletonGraphic)obj).skeletonDataAsset;
			ToLua.Push(L, skeletonDataAsset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skeletonDataAsset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_initialSkinName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string initialSkinName = ((SkeletonGraphic)obj).initialSkinName;
			LuaDLL.lua_pushstring(L, initialSkinName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialSkinName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_initialFlipX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool initialFlipX = ((SkeletonGraphic)obj).initialFlipX;
			LuaDLL.lua_pushboolean(L, initialFlipX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialFlipX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_initialFlipY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool initialFlipY = ((SkeletonGraphic)obj).initialFlipY;
			LuaDLL.lua_pushboolean(L, initialFlipY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialFlipY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startingAnimation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string startingAnimation = ((SkeletonGraphic)obj).startingAnimation;
			LuaDLL.lua_pushstring(L, startingAnimation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startingAnimation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startingLoop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool startingLoop = ((SkeletonGraphic)obj).startingLoop;
			LuaDLL.lua_pushboolean(L, startingLoop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startingLoop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float timeScale = ((SkeletonGraphic)obj).timeScale;
			LuaDLL.lua_pushnumber(L, timeScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_freeze(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool freeze = ((SkeletonGraphic)obj).freeze;
			LuaDLL.lua_pushboolean(L, freeze);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freeze on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_updateWhenInvisible(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UpdateMode updateWhenInvisible = ((SkeletonGraphic)obj).updateWhenInvisible;
			ToLua.Push(L, updateWhenInvisible);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateWhenInvisible on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_unscaledTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool unscaledTime = ((SkeletonGraphic)obj).unscaledTime;
			LuaDLL.lua_pushboolean(L, unscaledTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index unscaledTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_allowMultipleCanvasRenderers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool allowMultipleCanvasRenderers = ((SkeletonGraphic)obj).allowMultipleCanvasRenderers;
			LuaDLL.lua_pushboolean(L, allowMultipleCanvasRenderers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowMultipleCanvasRenderers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canvasRenderers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CanvasRenderer> canvasRenderers = ((SkeletonGraphic)obj).canvasRenderers;
			ToLua.PushSealed(L, canvasRenderers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvasRenderers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SeparatorPartGameObjectName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "Part");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_separatorSlots(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Slot> separatorSlots = ((SkeletonGraphic)obj).separatorSlots;
			ToLua.PushSealed(L, separatorSlots);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index separatorSlots on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enableSeparatorSlots(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enableSeparatorSlots = ((SkeletonGraphic)obj).enableSeparatorSlots;
			LuaDLL.lua_pushboolean(L, enableSeparatorSlots);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableSeparatorSlots on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_updateSeparatorPartLocation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool updateSeparatorPartLocation = ((SkeletonGraphic)obj).updateSeparatorPartLocation;
			LuaDLL.lua_pushboolean(L, updateSeparatorPartLocation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateSeparatorPartLocation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SkeletonDataAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonDataAsset skeletonDataAsset = ((SkeletonGraphic)obj).SkeletonDataAsset;
			ToLua.Push(L, skeletonDataAsset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SkeletonDataAsset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UpdateMode updateMode = ((SkeletonGraphic)obj).UpdateMode;
			ToLua.Push(L, updateMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SeparatorParts(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Transform> separatorParts = ((SkeletonGraphic)obj).SeparatorParts;
			ToLua.PushSealed(L, separatorParts);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SeparatorParts on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CustomTextureOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<Texture, Texture> customTextureOverride = ((SkeletonGraphic)obj).CustomTextureOverride;
			ToLua.PushSealed(L, customTextureOverride);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CustomTextureOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CustomMaterialOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<Texture, Material> customMaterialOverride = ((SkeletonGraphic)obj).CustomMaterialOverride;
			ToLua.PushSealed(L, customMaterialOverride);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CustomMaterialOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OverrideTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture overrideTexture = ((SkeletonGraphic)obj).OverrideTexture;
			ToLua.Push(L, overrideTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OverrideTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture mainTexture = ((SkeletonGraphic)obj).mainTexture;
			ToLua.Push(L, mainTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Skeleton(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Skeleton skeleton = ((SkeletonGraphic)obj).Skeleton;
			ToLua.PushObject(L, skeleton);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Skeleton on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SkeletonData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonData skeletonData = ((SkeletonGraphic)obj).SkeletonData;
			ToLua.PushObject(L, skeletonData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SkeletonData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsValid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isValid = ((SkeletonGraphic)obj).IsValid;
			LuaDLL.lua_pushboolean(L, isValid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsValid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AnimationState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Spine.AnimationState animationState = ((SkeletonGraphic)obj).AnimationState;
			ToLua.PushObject(L, animationState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MeshGenerator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MeshGenerator meshGenerator = ((SkeletonGraphic)obj).MeshGenerator;
			ToLua.PushObject(L, meshGenerator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MeshGenerator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnRebuild(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(SkeletonGraphic.SkeletonRendererDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnMeshAndMaterialsUpdated(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(SkeletonGraphic.SkeletonRendererDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BeforeApply(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UpdateBonesDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateLocal(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UpdateBonesDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateWorld(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UpdateBonesDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateComplete(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UpdateBonesDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnPostProcessVertices(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(MeshGeneratorDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skeletonDataAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			SkeletonDataAsset skeletonDataAsset = (SkeletonDataAsset)ToLua.CheckObject<SkeletonDataAsset>(L, 2);
			obj2.skeletonDataAsset = skeletonDataAsset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skeletonDataAsset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_initialSkinName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			string initialSkinName = ToLua.CheckString(L, 2);
			obj2.initialSkinName = initialSkinName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialSkinName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_initialFlipX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			bool initialFlipX = LuaDLL.luaL_checkboolean(L, 2);
			obj2.initialFlipX = initialFlipX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialFlipX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_initialFlipY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			bool initialFlipY = LuaDLL.luaL_checkboolean(L, 2);
			obj2.initialFlipY = initialFlipY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialFlipY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startingAnimation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			string startingAnimation = ToLua.CheckString(L, 2);
			obj2.startingAnimation = startingAnimation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startingAnimation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startingLoop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			bool startingLoop = LuaDLL.luaL_checkboolean(L, 2);
			obj2.startingLoop = startingLoop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startingLoop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			float timeScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.timeScale = timeScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_freeze(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			bool freeze = LuaDLL.luaL_checkboolean(L, 2);
			obj2.freeze = freeze;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freeze on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_updateWhenInvisible(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			UpdateMode updateWhenInvisible = (UpdateMode)ToLua.CheckObject(L, 2, typeof(UpdateMode));
			obj2.updateWhenInvisible = updateWhenInvisible;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateWhenInvisible on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_unscaledTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			bool unscaledTime = LuaDLL.luaL_checkboolean(L, 2);
			obj2.unscaledTime = unscaledTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index unscaledTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_allowMultipleCanvasRenderers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			bool allowMultipleCanvasRenderers = LuaDLL.luaL_checkboolean(L, 2);
			obj2.allowMultipleCanvasRenderers = allowMultipleCanvasRenderers;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index allowMultipleCanvasRenderers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canvasRenderers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			List<CanvasRenderer> canvasRenderers = (List<CanvasRenderer>)ToLua.CheckObject(L, 2, typeof(List<CanvasRenderer>));
			obj2.canvasRenderers = canvasRenderers;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvasRenderers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enableSeparatorSlots(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			bool enableSeparatorSlots = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enableSeparatorSlots = enableSeparatorSlots;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableSeparatorSlots on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_updateSeparatorPartLocation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			bool updateSeparatorPartLocation = LuaDLL.luaL_checkboolean(L, 2);
			obj2.updateSeparatorPartLocation = updateSeparatorPartLocation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateSeparatorPartLocation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			UpdateMode updateMode = (UpdateMode)ToLua.CheckObject(L, 2, typeof(UpdateMode));
			obj2.UpdateMode = updateMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OverrideTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			Texture overrideTexture = (Texture)ToLua.CheckObject<Texture>(L, 2);
			obj2.OverrideTexture = overrideTexture;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OverrideTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Skeleton(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonGraphic obj2 = (SkeletonGraphic)obj;
			Skeleton skeleton = (Skeleton)ToLua.CheckObject<Skeleton>(L, 2);
			obj2.Skeleton = skeleton;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Skeleton on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnRebuild(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ToLua.CheckObject(L, 1, typeof(SkeletonGraphic));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					SkeletonGraphic.SkeletonRendererDelegate value = (SkeletonGraphic.SkeletonRendererDelegate)eventObject.func;
					skeletonGraphic.OnRebuild += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					SkeletonGraphic.SkeletonRendererDelegate value2 = (SkeletonGraphic.SkeletonRendererDelegate)eventObject.func;
					skeletonGraphic.OnRebuild -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonGraphic.OnRebuild' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonGraphic'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnMeshAndMaterialsUpdated(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ToLua.CheckObject(L, 1, typeof(SkeletonGraphic));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					SkeletonGraphic.SkeletonRendererDelegate value = (SkeletonGraphic.SkeletonRendererDelegate)eventObject.func;
					skeletonGraphic.OnMeshAndMaterialsUpdated += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					SkeletonGraphic.SkeletonRendererDelegate value2 = (SkeletonGraphic.SkeletonRendererDelegate)eventObject.func;
					skeletonGraphic.OnMeshAndMaterialsUpdated -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonGraphic.OnMeshAndMaterialsUpdated' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonGraphic'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BeforeApply(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ToLua.CheckObject(L, 1, typeof(SkeletonGraphic));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					UpdateBonesDelegate value = (UpdateBonesDelegate)eventObject.func;
					skeletonGraphic.BeforeApply += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					UpdateBonesDelegate value2 = (UpdateBonesDelegate)eventObject.func;
					skeletonGraphic.BeforeApply -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonGraphic.BeforeApply' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonGraphic'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UpdateLocal(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ToLua.CheckObject(L, 1, typeof(SkeletonGraphic));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					UpdateBonesDelegate value = (UpdateBonesDelegate)eventObject.func;
					skeletonGraphic.UpdateLocal += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					UpdateBonesDelegate value2 = (UpdateBonesDelegate)eventObject.func;
					skeletonGraphic.UpdateLocal -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonGraphic.UpdateLocal' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonGraphic'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UpdateWorld(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ToLua.CheckObject(L, 1, typeof(SkeletonGraphic));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					UpdateBonesDelegate value = (UpdateBonesDelegate)eventObject.func;
					skeletonGraphic.UpdateWorld += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					UpdateBonesDelegate value2 = (UpdateBonesDelegate)eventObject.func;
					skeletonGraphic.UpdateWorld -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonGraphic.UpdateWorld' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonGraphic'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UpdateComplete(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ToLua.CheckObject(L, 1, typeof(SkeletonGraphic));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					UpdateBonesDelegate value = (UpdateBonesDelegate)eventObject.func;
					skeletonGraphic.UpdateComplete += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					UpdateBonesDelegate value2 = (UpdateBonesDelegate)eventObject.func;
					skeletonGraphic.UpdateComplete -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonGraphic.UpdateComplete' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonGraphic'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnPostProcessVertices(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ToLua.CheckObject(L, 1, typeof(SkeletonGraphic));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					MeshGeneratorDelegate value = (MeshGeneratorDelegate)eventObject.func;
					skeletonGraphic.OnPostProcessVertices += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					MeshGeneratorDelegate value2 = (MeshGeneratorDelegate)eventObject.func;
					skeletonGraphic.OnPostProcessVertices -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonGraphic.OnPostProcessVertices' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonGraphic'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<SkeletonGraphic.SkeletonRendererDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<SkeletonGraphic.SkeletonRendererDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
