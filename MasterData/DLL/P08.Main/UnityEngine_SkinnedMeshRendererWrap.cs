using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_SkinnedMeshRendererWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SkinnedMeshRenderer), typeof(Renderer));
		L.RegFunction("GetBlendShapeWeight", GetBlendShapeWeight);
		L.RegFunction("SetBlendShapeWeight", SetBlendShapeWeight);
		L.RegFunction("BakeMesh", BakeMesh);
		L.RegFunction("New", _CreateUnityEngine_SkinnedMeshRenderer);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("quality", get_quality, set_quality);
		L.RegVar("updateWhenOffscreen", get_updateWhenOffscreen, set_updateWhenOffscreen);
		L.RegVar("forceMatrixRecalculationPerRender", get_forceMatrixRecalculationPerRender, set_forceMatrixRecalculationPerRender);
		L.RegVar("rootBone", get_rootBone, set_rootBone);
		L.RegVar("bones", get_bones, set_bones);
		L.RegVar("sharedMesh", get_sharedMesh, set_sharedMesh);
		L.RegVar("skinnedMotionVectors", get_skinnedMotionVectors, set_skinnedMotionVectors);
		L.RegVar("localBounds", get_localBounds, set_localBounds);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_SkinnedMeshRenderer(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SkinnedMeshRenderer obj = new SkinnedMeshRenderer();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.SkinnedMeshRenderer.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBlendShapeWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SkinnedMeshRenderer obj = (SkinnedMeshRenderer)ToLua.CheckObject<SkinnedMeshRenderer>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			float blendShapeWeight = obj.GetBlendShapeWeight(index);
			LuaDLL.lua_pushnumber(L, blendShapeWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBlendShapeWeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			SkinnedMeshRenderer obj = (SkinnedMeshRenderer)ToLua.CheckObject<SkinnedMeshRenderer>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			float value = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetBlendShapeWeight(index, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BakeMesh(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SkinnedMeshRenderer obj = (SkinnedMeshRenderer)ToLua.CheckObject<SkinnedMeshRenderer>(L, 1);
			Mesh mesh = (Mesh)ToLua.CheckObject(L, 2, typeof(Mesh));
			obj.BakeMesh(mesh);
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
	private static int get_quality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinQuality quality = ((SkinnedMeshRenderer)obj).quality;
			ToLua.Push(L, quality);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index quality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_updateWhenOffscreen(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool updateWhenOffscreen = ((SkinnedMeshRenderer)obj).updateWhenOffscreen;
			LuaDLL.lua_pushboolean(L, updateWhenOffscreen);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateWhenOffscreen on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_forceMatrixRecalculationPerRender(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool forceMatrixRecalculationPerRender = ((SkinnedMeshRenderer)obj).forceMatrixRecalculationPerRender;
			LuaDLL.lua_pushboolean(L, forceMatrixRecalculationPerRender);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index forceMatrixRecalculationPerRender on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rootBone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform rootBone = ((SkinnedMeshRenderer)obj).rootBone;
			ToLua.Push(L, rootBone);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootBone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bones(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform[] bones = ((SkinnedMeshRenderer)obj).bones;
			ToLua.Push(L, bones);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bones on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sharedMesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh sharedMesh = ((SkinnedMeshRenderer)obj).sharedMesh;
			ToLua.PushSealed(L, sharedMesh);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMesh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skinnedMotionVectors(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool skinnedMotionVectors = ((SkinnedMeshRenderer)obj).skinnedMotionVectors;
			LuaDLL.lua_pushboolean(L, skinnedMotionVectors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skinnedMotionVectors on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localBounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Bounds localBounds = ((SkinnedMeshRenderer)obj).localBounds;
			ToLua.Push(L, localBounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localBounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_quality(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinnedMeshRenderer obj2 = (SkinnedMeshRenderer)obj;
			SkinQuality quality = (SkinQuality)ToLua.CheckObject(L, 2, typeof(SkinQuality));
			obj2.quality = quality;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index quality on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_updateWhenOffscreen(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinnedMeshRenderer obj2 = (SkinnedMeshRenderer)obj;
			bool updateWhenOffscreen = LuaDLL.luaL_checkboolean(L, 2);
			obj2.updateWhenOffscreen = updateWhenOffscreen;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index updateWhenOffscreen on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_forceMatrixRecalculationPerRender(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinnedMeshRenderer obj2 = (SkinnedMeshRenderer)obj;
			bool forceMatrixRecalculationPerRender = LuaDLL.luaL_checkboolean(L, 2);
			obj2.forceMatrixRecalculationPerRender = forceMatrixRecalculationPerRender;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index forceMatrixRecalculationPerRender on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rootBone(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinnedMeshRenderer obj2 = (SkinnedMeshRenderer)obj;
			Transform rootBone = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.rootBone = rootBone;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rootBone on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bones(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinnedMeshRenderer obj2 = (SkinnedMeshRenderer)obj;
			Transform[] bones = ToLua.CheckObjectArray<Transform>(L, 2);
			obj2.bones = bones;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bones on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sharedMesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinnedMeshRenderer obj2 = (SkinnedMeshRenderer)obj;
			Mesh sharedMesh = (Mesh)ToLua.CheckObject(L, 2, typeof(Mesh));
			obj2.sharedMesh = sharedMesh;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMesh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skinnedMotionVectors(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinnedMeshRenderer obj2 = (SkinnedMeshRenderer)obj;
			bool skinnedMotionVectors = LuaDLL.luaL_checkboolean(L, 2);
			obj2.skinnedMotionVectors = skinnedMotionVectors;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skinnedMotionVectors on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_localBounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkinnedMeshRenderer obj2 = (SkinnedMeshRenderer)obj;
			Bounds localBounds = ToLua.ToBounds(L, 2);
			obj2.localBounds = localBounds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localBounds on a nil value");
		}
	}
}
