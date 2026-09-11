using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.Rendering;

public class UnityEngine_Rendering_VolumeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Volume), typeof(MonoBehaviour));
		L.RegFunction("HasInstantiatedProfile", HasInstantiatedProfile);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("priority", get_priority, set_priority);
		L.RegVar("blendDistance", get_blendDistance, set_blendDistance);
		L.RegVar("weight", get_weight, set_weight);
		L.RegVar("sharedProfile", get_sharedProfile, set_sharedProfile);
		L.RegVar("isGlobal", get_isGlobal, set_isGlobal);
		L.RegVar("profile", get_profile, set_profile);
		L.RegVar("colliders", get_colliders, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasInstantiatedProfile(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((Volume)ToLua.CheckObject<Volume>(L, 1)).HasInstantiatedProfile();
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
	private static int get_priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float priority = ((Volume)obj).priority;
			LuaDLL.lua_pushnumber(L, priority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blendDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float blendDistance = ((Volume)obj).blendDistance;
			LuaDLL.lua_pushnumber(L, blendDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blendDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_weight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float weight = ((Volume)obj).weight;
			LuaDLL.lua_pushnumber(L, weight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sharedProfile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VolumeProfile sharedProfile = ((Volume)obj).sharedProfile;
			ToLua.PushSealed(L, sharedProfile);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedProfile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isGlobal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isGlobal = ((Volume)obj).isGlobal;
			LuaDLL.lua_pushboolean(L, isGlobal);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isGlobal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_profile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			VolumeProfile profile = ((Volume)obj).profile;
			ToLua.PushSealed(L, profile);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index profile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_colliders(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Collider> colliders = ((Volume)obj).colliders;
			ToLua.PushSealed(L, colliders);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index colliders on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_priority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Volume obj2 = (Volume)obj;
			float priority = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.priority = priority;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index priority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blendDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Volume obj2 = (Volume)obj;
			float blendDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.blendDistance = blendDistance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blendDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_weight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Volume obj2 = (Volume)obj;
			float weight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.weight = weight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sharedProfile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Volume obj2 = (Volume)obj;
			VolumeProfile sharedProfile = (VolumeProfile)ToLua.CheckObject(L, 2, typeof(VolumeProfile));
			obj2.sharedProfile = sharedProfile;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedProfile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isGlobal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Volume obj2 = (Volume)obj;
			bool isGlobal = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isGlobal = isGlobal;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isGlobal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_profile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Volume obj2 = (Volume)obj;
			VolumeProfile profile = (VolumeProfile)ToLua.CheckObject(L, 2, typeof(VolumeProfile));
			obj2.profile = profile;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index profile on a nil value");
		}
	}
}
