using System;
using System.Collections.Generic;
using LuaInterface;
using Spine;
using Spine.Unity;
using UnityEngine;
using UnityEngine.Rendering;

public class Spine_Unity_SkeletonRendererWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SkeletonRenderer), typeof(MonoBehaviour));
		L.RegFunction("SetMeshSettings", SetMeshSettings);
		L.RegFunction("Awake", Awake);
		L.RegFunction("ClearState", ClearState);
		L.RegFunction("EnsureMeshGeneratorCapacity", EnsureMeshGeneratorCapacity);
		L.RegFunction("Initialize", Initialize);
		L.RegFunction("LateUpdate", LateUpdate);
		L.RegFunction("OnBecameVisible", OnBecameVisible);
		L.RegFunction("OnBecameInvisible", OnBecameInvisible);
		L.RegFunction("FindAndApplySeparatorSlots", FindAndApplySeparatorSlots);
		L.RegFunction("ReapplySeparatorSlotNames", ReapplySeparatorSlotNames);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("skeletonDataAsset", get_skeletonDataAsset, set_skeletonDataAsset);
		L.RegVar("initialSkinName", get_initialSkinName, set_initialSkinName);
		L.RegVar("initialFlipX", get_initialFlipX, set_initialFlipX);
		L.RegVar("initialFlipY", get_initialFlipY, set_initialFlipY);
		L.RegVar("updateWhenInvisible", get_updateWhenInvisible, set_updateWhenInvisible);
		L.RegVar("separatorSlots", get_separatorSlots, null);
		L.RegVar("zSpacing", get_zSpacing, set_zSpacing);
		L.RegVar("useClipping", get_useClipping, set_useClipping);
		L.RegVar("immutableTriangles", get_immutableTriangles, set_immutableTriangles);
		L.RegVar("pmaVertexColors", get_pmaVertexColors, set_pmaVertexColors);
		L.RegVar("clearStateOnDisable", get_clearStateOnDisable, set_clearStateOnDisable);
		L.RegVar("tintBlack", get_tintBlack, set_tintBlack);
		L.RegVar("singleSubmesh", get_singleSubmesh, set_singleSubmesh);
		L.RegVar("fixDrawOrder", get_fixDrawOrder, set_fixDrawOrder);
		L.RegVar("addNormals", get_addNormals, set_addNormals);
		L.RegVar("calculateTangents", get_calculateTangents, set_calculateTangents);
		L.RegVar("maskInteraction", get_maskInteraction, set_maskInteraction);
		L.RegVar("maskMaterials", get_maskMaterials, set_maskMaterials);
		L.RegVar("STENCIL_COMP_PARAM_ID", get_STENCIL_COMP_PARAM_ID, null);
		L.RegVar("STENCIL_COMP_MASKINTERACTION_NONE", get_STENCIL_COMP_MASKINTERACTION_NONE, null);
		L.RegVar("STENCIL_COMP_MASKINTERACTION_VISIBLE_INSIDE", get_STENCIL_COMP_MASKINTERACTION_VISIBLE_INSIDE, null);
		L.RegVar("STENCIL_COMP_MASKINTERACTION_VISIBLE_OUTSIDE", get_STENCIL_COMP_MASKINTERACTION_VISIBLE_OUTSIDE, null);
		L.RegVar("disableRenderingOnOverride", get_disableRenderingOnOverride, set_disableRenderingOnOverride);
		L.RegVar("valid", get_valid, set_valid);
		L.RegVar("skeleton", get_skeleton, set_skeleton);
		L.RegVar("SUBMESH_DUMMY_PARAM_ID", get_SUBMESH_DUMMY_PARAM_ID, null);
		L.RegVar("UpdateMode", get_UpdateMode, set_UpdateMode);
		L.RegVar("CustomMaterialOverride", get_CustomMaterialOverride, null);
		L.RegVar("CustomSlotMaterials", get_CustomSlotMaterials, null);
		L.RegVar("Skeleton", get_Skeleton, null);
		L.RegVar("SkeletonDataAsset", get_SkeletonDataAsset, null);
		L.RegVar("GenerateMeshOverride", get_GenerateMeshOverride, set_GenerateMeshOverride);
		L.RegVar("OnPostProcessVertices", get_OnPostProcessVertices, set_OnPostProcessVertices);
		L.RegVar("OnRebuild", get_OnRebuild, set_OnRebuild);
		L.RegVar("OnMeshAndMaterialsUpdated", get_OnMeshAndMaterialsUpdated, set_OnMeshAndMaterialsUpdated);
		L.RegFunction("SkeletonRendererDelegate", Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate);
		L.RegFunction("InstructionDelegate", Spine_Unity_SkeletonRenderer_InstructionDelegate);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMeshSettings(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SkeletonRenderer obj = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
			MeshGenerator.Settings meshSettings = StackTraits<MeshGenerator.Settings>.Check(L, 2);
			obj.SetMeshSettings(meshSettings);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Awake(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1)).Awake();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1)).ClearState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnsureMeshGeneratorCapacity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SkeletonRenderer obj = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
			int minimumVertexCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.EnsureMeshGeneratorCapacity(minimumVertexCount);
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				SkeletonRenderer obj2 = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
				bool overwrite2 = LuaDLL.luaL_checkboolean(L, 2);
				obj2.Initialize(overwrite2);
				return 0;
			}
			case 3:
			{
				SkeletonRenderer obj = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
				bool overwrite = LuaDLL.luaL_checkboolean(L, 2);
				bool quiet = LuaDLL.luaL_checkboolean(L, 3);
				obj.Initialize(overwrite, quiet);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.Unity.SkeletonRenderer.Initialize");
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
			((SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1)).LateUpdate();
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
			((SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1)).OnBecameVisible();
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
			((SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1)).OnBecameInvisible();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindAndApplySeparatorSlots(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				SkeletonRenderer obj = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
				string startsWith = ToLua.ToString(L, 2);
				obj.FindAndApplySeparatorSlots(startsWith);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Func<string, bool>>(L, 2))
			{
				SkeletonRenderer obj2 = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
				Func<string, bool> slotNamePredicate = (Func<string, bool>)ToLua.ToObject(L, 2);
				obj2.FindAndApplySeparatorSlots(slotNamePredicate);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, bool>(L, 2))
			{
				SkeletonRenderer obj3 = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
				string startsWith2 = ToLua.ToString(L, 2);
				bool clearExistingSeparators = LuaDLL.lua_toboolean(L, 3);
				obj3.FindAndApplySeparatorSlots(startsWith2, clearExistingSeparators);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Func<string, bool>, bool>(L, 2))
			{
				SkeletonRenderer obj4 = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
				Func<string, bool> slotNamePredicate2 = (Func<string, bool>)ToLua.ToObject(L, 2);
				bool clearExistingSeparators2 = LuaDLL.lua_toboolean(L, 3);
				obj4.FindAndApplySeparatorSlots(slotNamePredicate2, clearExistingSeparators2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<string, bool, bool>(L, 2))
			{
				SkeletonRenderer obj5 = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
				string startsWith3 = ToLua.ToString(L, 2);
				bool clearExistingSeparators3 = LuaDLL.lua_toboolean(L, 3);
				bool updateStringArray = LuaDLL.lua_toboolean(L, 4);
				obj5.FindAndApplySeparatorSlots(startsWith3, clearExistingSeparators3, updateStringArray);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<Func<string, bool>, bool, bool>(L, 2))
			{
				SkeletonRenderer obj6 = (SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1);
				Func<string, bool> slotNamePredicate3 = (Func<string, bool>)ToLua.ToObject(L, 2);
				bool clearExistingSeparators4 = LuaDLL.lua_toboolean(L, 3);
				bool updateStringArray2 = LuaDLL.lua_toboolean(L, 4);
				obj6.FindAndApplySeparatorSlots(slotNamePredicate3, clearExistingSeparators4, updateStringArray2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.Unity.SkeletonRenderer.FindAndApplySeparatorSlots");
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
			((SkeletonRenderer)ToLua.CheckObject<SkeletonRenderer>(L, 1)).ReapplySeparatorSlotNames();
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
	private static int get_skeletonDataAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonDataAsset skeletonDataAsset = ((SkeletonRenderer)obj).skeletonDataAsset;
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
			string initialSkinName = ((SkeletonRenderer)obj).initialSkinName;
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
			bool initialFlipX = ((SkeletonRenderer)obj).initialFlipX;
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
			bool initialFlipY = ((SkeletonRenderer)obj).initialFlipY;
			LuaDLL.lua_pushboolean(L, initialFlipY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initialFlipY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_updateWhenInvisible(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UpdateMode updateWhenInvisible = ((SkeletonRenderer)obj).updateWhenInvisible;
			ToLua.Push(L, updateWhenInvisible);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateWhenInvisible on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_separatorSlots(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Slot> separatorSlots = ((SkeletonRenderer)obj).separatorSlots;
			ToLua.PushSealed(L, separatorSlots);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index separatorSlots on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_zSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float zSpacing = ((SkeletonRenderer)obj).zSpacing;
			LuaDLL.lua_pushnumber(L, zSpacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index zSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useClipping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useClipping = ((SkeletonRenderer)obj).useClipping;
			LuaDLL.lua_pushboolean(L, useClipping);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useClipping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_immutableTriangles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool immutableTriangles = ((SkeletonRenderer)obj).immutableTriangles;
			LuaDLL.lua_pushboolean(L, immutableTriangles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index immutableTriangles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pmaVertexColors(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool pmaVertexColors = ((SkeletonRenderer)obj).pmaVertexColors;
			LuaDLL.lua_pushboolean(L, pmaVertexColors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pmaVertexColors on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clearStateOnDisable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool clearStateOnDisable = ((SkeletonRenderer)obj).clearStateOnDisable;
			LuaDLL.lua_pushboolean(L, clearStateOnDisable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clearStateOnDisable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tintBlack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool tintBlack = ((SkeletonRenderer)obj).tintBlack;
			LuaDLL.lua_pushboolean(L, tintBlack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tintBlack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_singleSubmesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool singleSubmesh = ((SkeletonRenderer)obj).singleSubmesh;
			LuaDLL.lua_pushboolean(L, singleSubmesh);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index singleSubmesh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fixDrawOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool fixDrawOrder = ((SkeletonRenderer)obj).fixDrawOrder;
			LuaDLL.lua_pushboolean(L, fixDrawOrder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fixDrawOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_addNormals(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool addNormals = ((SkeletonRenderer)obj).addNormals;
			LuaDLL.lua_pushboolean(L, addNormals);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index addNormals on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_calculateTangents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool calculateTangents = ((SkeletonRenderer)obj).calculateTangents;
			LuaDLL.lua_pushboolean(L, calculateTangents);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index calculateTangents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maskInteraction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteMaskInteraction maskInteraction = ((SkeletonRenderer)obj).maskInteraction;
			ToLua.Push(L, maskInteraction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maskInteraction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maskMaterials(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer.SpriteMaskInteractionMaterials maskMaterials = ((SkeletonRenderer)obj).maskMaterials;
			ToLua.PushObject(L, maskMaterials);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maskMaterials on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_STENCIL_COMP_PARAM_ID(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SkeletonRenderer.STENCIL_COMP_PARAM_ID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_STENCIL_COMP_MASKINTERACTION_NONE(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CompareFunction.Always);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_STENCIL_COMP_MASKINTERACTION_VISIBLE_INSIDE(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CompareFunction.LessEqual);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_STENCIL_COMP_MASKINTERACTION_VISIBLE_OUTSIDE(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CompareFunction.Greater);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_disableRenderingOnOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool disableRenderingOnOverride = ((SkeletonRenderer)obj).disableRenderingOnOverride;
			LuaDLL.lua_pushboolean(L, disableRenderingOnOverride);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disableRenderingOnOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_valid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool valid = ((SkeletonRenderer)obj).valid;
			LuaDLL.lua_pushboolean(L, valid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index valid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skeleton(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Skeleton skeleton = ((SkeletonRenderer)obj).skeleton;
			ToLua.PushObject(L, skeleton);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skeleton on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SUBMESH_DUMMY_PARAM_ID(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SkeletonRenderer.SUBMESH_DUMMY_PARAM_ID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UpdateMode updateMode = ((SkeletonRenderer)obj).UpdateMode;
			ToLua.Push(L, updateMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UpdateMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CustomMaterialOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<Material, Material> customMaterialOverride = ((SkeletonRenderer)obj).CustomMaterialOverride;
			ToLua.PushSealed(L, customMaterialOverride);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CustomMaterialOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CustomSlotMaterials(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<Slot, Material> customSlotMaterials = ((SkeletonRenderer)obj).CustomSlotMaterials;
			ToLua.PushSealed(L, customSlotMaterials);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index CustomSlotMaterials on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Skeleton(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Skeleton skeleton = ((SkeletonRenderer)obj).Skeleton;
			ToLua.PushObject(L, skeleton);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Skeleton on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SkeletonDataAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonDataAsset skeletonDataAsset = ((SkeletonRenderer)obj).SkeletonDataAsset;
			ToLua.Push(L, skeletonDataAsset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index SkeletonDataAsset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GenerateMeshOverride(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(SkeletonRenderer.InstructionDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnPostProcessVertices(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(MeshGeneratorDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnRebuild(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(SkeletonRenderer.SkeletonRendererDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnMeshAndMaterialsUpdated(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(SkeletonRenderer.SkeletonRendererDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skeletonDataAsset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
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
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
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
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
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
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
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
	private static int set_updateWhenInvisible(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
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
	private static int set_zSpacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			float zSpacing = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.zSpacing = zSpacing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index zSpacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useClipping(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool useClipping = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useClipping = useClipping;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useClipping on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_immutableTriangles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool immutableTriangles = LuaDLL.luaL_checkboolean(L, 2);
			obj2.immutableTriangles = immutableTriangles;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index immutableTriangles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pmaVertexColors(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool pmaVertexColors = LuaDLL.luaL_checkboolean(L, 2);
			obj2.pmaVertexColors = pmaVertexColors;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pmaVertexColors on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clearStateOnDisable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool clearStateOnDisable = LuaDLL.luaL_checkboolean(L, 2);
			obj2.clearStateOnDisable = clearStateOnDisable;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clearStateOnDisable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tintBlack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool tintBlack = LuaDLL.luaL_checkboolean(L, 2);
			obj2.tintBlack = tintBlack;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tintBlack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_singleSubmesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool singleSubmesh = LuaDLL.luaL_checkboolean(L, 2);
			obj2.singleSubmesh = singleSubmesh;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index singleSubmesh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fixDrawOrder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool fixDrawOrder = LuaDLL.luaL_checkboolean(L, 2);
			obj2.fixDrawOrder = fixDrawOrder;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fixDrawOrder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_addNormals(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool addNormals = LuaDLL.luaL_checkboolean(L, 2);
			obj2.addNormals = addNormals;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index addNormals on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_calculateTangents(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool calculateTangents = LuaDLL.luaL_checkboolean(L, 2);
			obj2.calculateTangents = calculateTangents;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index calculateTangents on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maskInteraction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			SpriteMaskInteraction maskInteraction = (SpriteMaskInteraction)ToLua.CheckObject(L, 2, typeof(SpriteMaskInteraction));
			obj2.maskInteraction = maskInteraction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maskInteraction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maskMaterials(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			SkeletonRenderer.SpriteMaskInteractionMaterials maskMaterials = (SkeletonRenderer.SpriteMaskInteractionMaterials)ToLua.CheckObject<SkeletonRenderer.SpriteMaskInteractionMaterials>(L, 2);
			obj2.maskMaterials = maskMaterials;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maskMaterials on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_disableRenderingOnOverride(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool disableRenderingOnOverride = LuaDLL.luaL_checkboolean(L, 2);
			obj2.disableRenderingOnOverride = disableRenderingOnOverride;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disableRenderingOnOverride on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_valid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			bool valid = LuaDLL.luaL_checkboolean(L, 2);
			obj2.valid = valid;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index valid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skeleton(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
			Skeleton skeleton = (Skeleton)ToLua.CheckObject<Skeleton>(L, 2);
			obj2.skeleton = skeleton;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skeleton on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UpdateMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonRenderer obj2 = (SkeletonRenderer)obj;
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
	private static int set_GenerateMeshOverride(IntPtr L)
	{
		try
		{
			SkeletonRenderer skeletonRenderer = (SkeletonRenderer)ToLua.CheckObject(L, 1, typeof(SkeletonRenderer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					SkeletonRenderer.InstructionDelegate value = (SkeletonRenderer.InstructionDelegate)eventObject.func;
					skeletonRenderer.GenerateMeshOverride += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					SkeletonRenderer.InstructionDelegate value2 = (SkeletonRenderer.InstructionDelegate)eventObject.func;
					skeletonRenderer.GenerateMeshOverride -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonRenderer.GenerateMeshOverride' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonRenderer'");
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
			SkeletonRenderer skeletonRenderer = (SkeletonRenderer)ToLua.CheckObject(L, 1, typeof(SkeletonRenderer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					MeshGeneratorDelegate value = (MeshGeneratorDelegate)eventObject.func;
					skeletonRenderer.OnPostProcessVertices += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					MeshGeneratorDelegate value2 = (MeshGeneratorDelegate)eventObject.func;
					skeletonRenderer.OnPostProcessVertices -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonRenderer.OnPostProcessVertices' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonRenderer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnRebuild(IntPtr L)
	{
		try
		{
			SkeletonRenderer skeletonRenderer = (SkeletonRenderer)ToLua.CheckObject(L, 1, typeof(SkeletonRenderer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					SkeletonRenderer.SkeletonRendererDelegate value = (SkeletonRenderer.SkeletonRendererDelegate)eventObject.func;
					skeletonRenderer.OnRebuild += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					SkeletonRenderer.SkeletonRendererDelegate value2 = (SkeletonRenderer.SkeletonRendererDelegate)eventObject.func;
					skeletonRenderer.OnRebuild -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonRenderer.OnRebuild' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonRenderer'");
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
			SkeletonRenderer skeletonRenderer = (SkeletonRenderer)ToLua.CheckObject(L, 1, typeof(SkeletonRenderer));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					SkeletonRenderer.SkeletonRendererDelegate value = (SkeletonRenderer.SkeletonRendererDelegate)eventObject.func;
					skeletonRenderer.OnMeshAndMaterialsUpdated += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					SkeletonRenderer.SkeletonRendererDelegate value2 = (SkeletonRenderer.SkeletonRendererDelegate)eventObject.func;
					skeletonRenderer.OnMeshAndMaterialsUpdated -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonRenderer.OnMeshAndMaterialsUpdated' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonRenderer'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<SkeletonRenderer.SkeletonRendererDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<SkeletonRenderer.SkeletonRendererDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_Unity_SkeletonRenderer_InstructionDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<SkeletonRenderer.InstructionDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<SkeletonRenderer.InstructionDelegate>.Create(func, self);
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
