using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class PooledAssetWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PooledAsset), typeof(MonoBehaviour));
		L.RegFunction("SetActive", SetActive);
		L.RegFunction("Stop", Stop);
		L.RegFunction("Return", Return);
		L.RegFunction("DestroyOrReturn", DestroyOrReturn);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mDontDestroy", get_mDontDestroy, set_mDontDestroy);
		L.RegVar("mLinkCache", get_mLinkCache, set_mLinkCache);
		L.RegVar("mPoolTable", get_mPoolTable, set_mPoolTable);
		L.RegVar("mSimulatorTime", get_mSimulatorTime, set_mSimulatorTime);
		L.RegVar("mIsRunning", get_mIsRunning, set_mIsRunning);
		L.RegVar("mReuseOldestGameobject", get_mReuseOldestGameobject, set_mReuseOldestGameobject);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PooledAsset obj = (PooledAsset)ToLua.CheckObject<PooledAsset>(L, 1);
			bool active = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetActive(active);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Stop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PooledAsset)ToLua.CheckObject<PooledAsset>(L, 1)).Stop();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Return(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((PooledAsset)ToLua.CheckObject<PooledAsset>(L, 1)).Return();
				return 0;
			case 2:
			{
				PooledAsset obj = (PooledAsset)ToLua.CheckObject<PooledAsset>(L, 1);
				float duringTime = (float)LuaDLL.luaL_checknumber(L, 2);
				obj.Return(duringTime);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: PooledAsset.Return");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DestroyOrReturn(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				PooledAsset.DestroyOrReturn((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
				return 0;
			case 2:
			{
				GameObject go = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				float time = (float)LuaDLL.luaL_checknumber(L, 2);
				PooledAsset.DestroyOrReturn(go, time);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: PooledAsset.DestroyOrReturn");
			}
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
	private static int get_mDontDestroy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool mDontDestroy = ((PooledAsset)obj).mDontDestroy;
			LuaDLL.lua_pushboolean(L, mDontDestroy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mDontDestroy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mLinkCache(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ResourceCache mLinkCache = ((PooledAsset)obj).mLinkCache;
			ToLua.PushObject(L, mLinkCache);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mLinkCache on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mPoolTable(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, PooledAsset.mPoolTable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mSimulatorTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mSimulatorTime = ((PooledAsset)obj).mSimulatorTime;
			LuaDLL.lua_pushnumber(L, mSimulatorTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mSimulatorTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mIsRunning(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool mIsRunning = ((PooledAsset)obj).mIsRunning;
			LuaDLL.lua_pushboolean(L, mIsRunning);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mIsRunning on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mReuseOldestGameobject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool mReuseOldestGameobject = ((PooledAsset)obj).mReuseOldestGameobject;
			LuaDLL.lua_pushboolean(L, mReuseOldestGameobject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mReuseOldestGameobject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mDontDestroy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PooledAsset obj2 = (PooledAsset)obj;
			bool mDontDestroy = LuaDLL.luaL_checkboolean(L, 2);
			obj2.mDontDestroy = mDontDestroy;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mDontDestroy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mLinkCache(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PooledAsset obj2 = (PooledAsset)obj;
			ResourceCache mLinkCache = (ResourceCache)ToLua.CheckObject<ResourceCache>(L, 2);
			obj2.mLinkCache = mLinkCache;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mLinkCache on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mPoolTable(IntPtr L)
	{
		try
		{
			PooledAsset.mPoolTable = (Dictionary<GameObject, PooledAsset>)ToLua.CheckObject(L, 2, typeof(Dictionary<GameObject, PooledAsset>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mSimulatorTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PooledAsset obj2 = (PooledAsset)obj;
			float mSimulatorTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.mSimulatorTime = mSimulatorTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mSimulatorTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mIsRunning(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PooledAsset obj2 = (PooledAsset)obj;
			bool mIsRunning = LuaDLL.luaL_checkboolean(L, 2);
			obj2.mIsRunning = mIsRunning;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mIsRunning on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mReuseOldestGameobject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PooledAsset obj2 = (PooledAsset)obj;
			bool mReuseOldestGameobject = LuaDLL.luaL_checkboolean(L, 2);
			obj2.mReuseOldestGameobject = mReuseOldestGameobject;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mReuseOldestGameobject on a nil value");
		}
	}
}
