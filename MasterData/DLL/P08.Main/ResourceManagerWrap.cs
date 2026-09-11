using System;
using LuaInterface;
using UnityEngine;

public class ResourceManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ResourceManager), typeof(MonoBehaviour));
		L.RegFunction("Init", Init);
		L.RegFunction("Load", Load);
		L.RegFunction("LoadBundle", LoadBundle);
		L.RegFunction("LoadAsset", LoadAsset);
		L.RegFunction("Retain", Retain);
		L.RegFunction("Release", Release);
		L.RegFunction("UnloadUnusedBundles", UnloadUnusedBundles);
		L.RegFunction("LoadSync", LoadSync);
		L.RegFunction("LoadAssetBundleSyncWithCache", LoadAssetBundleSyncWithCache);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("inst", get_inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1)).Init();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Load(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				ResourceManager obj2 = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath2 = ToLua.CheckString(L, 2);
				string assetName2 = ToLua.CheckString(L, 3);
				Type type2 = ToLua.CheckMonoType(L, 4);
				bool async2 = LuaDLL.luaL_checkboolean(L, 5);
				obj2.Load(bundlePath2, assetName2, type2, async2);
				return 0;
			}
			case 6:
			{
				ResourceManager obj = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath = ToLua.CheckString(L, 2);
				string assetName = ToLua.CheckString(L, 3);
				Type type = ToLua.CheckMonoType(L, 4);
				bool async = LuaDLL.luaL_checkboolean(L, 5);
				Action<UnityEngine.Object> callback = (Action<UnityEngine.Object>)ToLua.CheckDelegate<Action<UnityEngine.Object>>(L, 6);
				obj.Load(bundlePath, assetName, type, async, callback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ResourceManager.Load");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadBundle(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				ResourceManager obj3 = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath3 = ToLua.CheckString(L, 2);
				bool async3 = LuaDLL.luaL_checkboolean(L, 3);
				obj3.LoadBundle(bundlePath3, async3);
				return 0;
			}
			case 4:
			{
				ResourceManager obj2 = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath2 = ToLua.CheckString(L, 2);
				bool async2 = LuaDLL.luaL_checkboolean(L, 3);
				int refCount2 = (int)LuaDLL.luaL_checknumber(L, 4);
				obj2.LoadBundle(bundlePath2, async2, refCount2);
				return 0;
			}
			case 5:
			{
				ResourceManager obj = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath = ToLua.CheckString(L, 2);
				bool async = LuaDLL.luaL_checkboolean(L, 3);
				int refCount = (int)LuaDLL.luaL_checknumber(L, 4);
				Action<UnityEngine.Object> callback = (Action<UnityEngine.Object>)ToLua.CheckDelegate<Action<UnityEngine.Object>>(L, 5);
				obj.LoadBundle(bundlePath, async, refCount, callback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ResourceManager.LoadBundle");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAsset(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				ResourceManager obj2 = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				AssetBundle bundle2 = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 2);
				string assetName2 = ToLua.CheckString(L, 3);
				Type type2 = ToLua.CheckMonoType(L, 4);
				bool async2 = LuaDLL.luaL_checkboolean(L, 5);
				obj2.LoadAsset(bundle2, assetName2, type2, async2);
				return 0;
			}
			case 6:
			{
				ResourceManager obj = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				AssetBundle bundle = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 2);
				string assetName = ToLua.CheckString(L, 3);
				Type type = ToLua.CheckMonoType(L, 4);
				bool async = LuaDLL.luaL_checkboolean(L, 5);
				Action<UnityEngine.Object> callback = (Action<UnityEngine.Object>)ToLua.CheckDelegate<Action<UnityEngine.Object>>(L, 6);
				obj.LoadAsset(bundle, assetName, type, async, callback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ResourceManager.LoadAsset");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Retain(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ResourceManager obj3 = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath3 = ToLua.CheckString(L, 2);
				obj3.Retain(bundlePath3);
				return 0;
			}
			case 3:
			{
				ResourceManager obj2 = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath2 = ToLua.CheckString(L, 2);
				AssetBundle bundle2 = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 3);
				obj2.Retain(bundlePath2, bundle2);
				return 0;
			}
			case 4:
			{
				ResourceManager obj = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath = ToLua.CheckString(L, 2);
				AssetBundle bundle = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 3);
				int refCount = (int)LuaDLL.luaL_checknumber(L, 4);
				obj.Retain(bundlePath, bundle, refCount);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ResourceManager.Retain");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Release(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ResourceManager obj2 = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath2 = ToLua.CheckString(L, 2);
				obj2.Release(bundlePath2);
				return 0;
			}
			case 3:
			{
				ResourceManager obj = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
				string bundlePath = ToLua.CheckString(L, 2);
				bool unloadBundle = LuaDLL.luaL_checkboolean(L, 3);
				obj.Release(bundlePath, unloadBundle);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ResourceManager.Release");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadUnusedBundles(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1)).UnloadUnusedBundles();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadSync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			ResourceManager obj = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
			string bundlePath = ToLua.CheckString(L, 2);
			string assetName = ToLua.CheckString(L, 3);
			Type type = ToLua.CheckMonoType(L, 4);
			UnityEngine.Object obj2 = obj.LoadSync(bundlePath, assetName, type);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAssetBundleSyncWithCache(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ResourceManager obj = (ResourceManager)ToLua.CheckObject<ResourceManager>(L, 1);
			string bundlePath = ToLua.CheckString(L, 2);
			AssetBundle obj2 = obj.LoadAssetBundleSyncWithCache(bundlePath);
			ToLua.Push(L, obj2);
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
	private static int get_inst(IntPtr L)
	{
		try
		{
			ToLua.Push(L, ResourceManager.inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
