using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ColliderWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Collider), typeof(Component));
		L.RegFunction("ClosestPoint", ClosestPoint);
		L.RegFunction("Raycast", Raycast);
		L.RegFunction("ClosestPointOnBounds", ClosestPointOnBounds);
		L.RegFunction("New", _CreateUnityEngine_Collider);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("enabled", get_enabled, set_enabled);
		L.RegVar("attachedRigidbody", get_attachedRigidbody, null);
		L.RegVar("isTrigger", get_isTrigger, set_isTrigger);
		L.RegVar("contactOffset", get_contactOffset, set_contactOffset);
		L.RegVar("bounds", get_bounds, null);
		L.RegVar("sharedMaterial", get_sharedMaterial, set_sharedMaterial);
		L.RegVar("material", get_material, set_material);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Collider(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Collider obj = new Collider();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Collider.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClosestPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Collider obj = (Collider)ToLua.CheckObject<Collider>(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 v = obj.ClosestPoint(position);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Raycast(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Collider obj = (Collider)ToLua.CheckObject<Collider>(L, 1);
			Ray ray = ToLua.ToRay(L, 2);
			float maxDistance = (float)LuaDLL.luaL_checknumber(L, 4);
			bool flag = obj.Raycast(ray, out var hitInfo, maxDistance);
			LuaDLL.lua_pushboolean(L, flag);
			if (flag)
			{
				ToLua.Push(L, hitInfo);
			}
			else
			{
				LuaDLL.lua_pushnil(L);
			}
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClosestPointOnBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Collider obj = (Collider)ToLua.CheckObject<Collider>(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 v = obj.ClosestPointOnBounds(position);
			ToLua.Push(L, v);
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
	private static int get_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enabled = ((Collider)obj).enabled;
			LuaDLL.lua_pushboolean(L, enabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enabled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attachedRigidbody(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody attachedRigidbody = ((Collider)obj).attachedRigidbody;
			ToLua.Push(L, attachedRigidbody);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attachedRigidbody on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isTrigger = ((Collider)obj).isTrigger;
			LuaDLL.lua_pushboolean(L, isTrigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_contactOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float contactOffset = ((Collider)obj).contactOffset;
			LuaDLL.lua_pushnumber(L, contactOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index contactOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Bounds bounds = ((Collider)obj).bounds;
			ToLua.Push(L, bounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sharedMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PhysicMaterial sharedMaterial = ((Collider)obj).sharedMaterial;
			ToLua.Push(L, sharedMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_material(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PhysicMaterial material = ((Collider)obj).material;
			ToLua.Push(L, material);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index material on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enabled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider obj2 = (Collider)obj;
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
	private static int set_isTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider obj2 = (Collider)obj;
			bool isTrigger = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isTrigger = isTrigger;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_contactOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider obj2 = (Collider)obj;
			float contactOffset = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.contactOffset = contactOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index contactOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sharedMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider obj2 = (Collider)obj;
			PhysicMaterial sharedMaterial = (PhysicMaterial)ToLua.CheckObject<PhysicMaterial>(L, 2);
			obj2.sharedMaterial = sharedMaterial;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_material(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider obj2 = (Collider)obj;
			PhysicMaterial material = (PhysicMaterial)ToLua.CheckObject<PhysicMaterial>(L, 2);
			obj2.material = material;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index material on a nil value");
		}
	}
}
