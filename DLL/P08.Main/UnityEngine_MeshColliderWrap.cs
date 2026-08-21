using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_MeshColliderWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MeshCollider), typeof(Collider));
		L.RegFunction("New", _CreateUnityEngine_MeshCollider);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sharedMesh", get_sharedMesh, set_sharedMesh);
		L.RegVar("convex", get_convex, set_convex);
		L.RegVar("cookingOptions", get_cookingOptions, set_cookingOptions);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_MeshCollider(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				MeshCollider obj = new MeshCollider();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.MeshCollider.New");
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
	private static int get_sharedMesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh sharedMesh = ((MeshCollider)obj).sharedMesh;
			ToLua.PushSealed(L, sharedMesh);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMesh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_convex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool convex = ((MeshCollider)obj).convex;
			LuaDLL.lua_pushboolean(L, convex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index convex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cookingOptions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MeshColliderCookingOptions cookingOptions = ((MeshCollider)obj).cookingOptions;
			ToLua.Push(L, cookingOptions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cookingOptions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sharedMesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MeshCollider obj2 = (MeshCollider)obj;
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
	private static int set_convex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MeshCollider obj2 = (MeshCollider)obj;
			bool convex = LuaDLL.luaL_checkboolean(L, 2);
			obj2.convex = convex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index convex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cookingOptions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MeshCollider obj2 = (MeshCollider)obj;
			MeshColliderCookingOptions cookingOptions = (MeshColliderCookingOptions)ToLua.CheckObject(L, 2, typeof(MeshColliderCookingOptions));
			obj2.cookingOptions = cookingOptions;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cookingOptions on a nil value");
		}
	}
}
