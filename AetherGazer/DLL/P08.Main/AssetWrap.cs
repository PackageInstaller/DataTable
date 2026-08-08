using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

public class AssetWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Asset");
		L.RegFunction("GetReady", GetReady);
		L.RegFunction("Initialize", Initialize);
		L.RegFunction("ClearPool", ClearPool);
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("StartDownload", StartDownload);
		L.RegFunction("StartDownloadWitchCache", StartDownloadWitchCache);
		L.RegFunction("IsDownloading", IsDownloading);
		L.RegFunction("GetWWW", GetWWW);
		L.RegFunction("GetDownloadError", GetDownloadError);
		L.RegFunction("StopDownload", StopDownload);
		L.RegFunction("StopAllDownload", StopAllDownload);
		L.RegFunction("Cache", Cache);
		L.RegFunction("Instantiate", Instantiate);
		L.RegFunction("InstantiateAutoUnloadWhileDestroy", InstantiateAutoUnloadWhileDestroy);
		L.RegFunction("InstantiateWithoutCache", InstantiateWithoutCache);
		L.RegFunction("MoveToDontDestroyCache", MoveToDontDestroyCache);
		L.RegFunction("Load", Load);
		L.RegFunction("Unload", Unload);
		L.RegFunction("UnloadWithReturn", UnloadWithReturn);
		L.RegFunction("UnloadBundle", UnloadBundle);
		L.RegFunction("UnloadAllAssetBundles", UnloadAllAssetBundles);
		L.RegFunction("StopAsyncLoading", StopAsyncLoading);
		L.RegFunction("LoadAsync", LoadAsync);
		L.RegFunction("LoadLevelAsync", LoadLevelAsync);
		L.RegFunction("LoadLevelSync", LoadLevelSync);
		L.RegFunction("UnloadLevelSync", UnloadLevelSync);
		L.RegFunction("DontDestroyBundle", DontDestroyBundle);
		L.RegFunction("DontDestroyAssetbundle", DontDestroyAssetbundle);
		L.RegFunction("RemapVariantPath", RemapVariantPath);
		L.RegVar("pool", get_pool, set_pool);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetReady(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool ready = Asset.GetReady();
			LuaDLL.lua_pushboolean(L, ready);
			return 1;
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
			case 0:
				Asset.Initialize();
				return 0;
			case 1:
				Asset.Initialize((AssetHashManifest)ToLua.CheckObject<AssetHashManifest>(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.Initialize");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearPool(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Asset.ClearPool();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Destroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Asset.Destroy();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartDownload(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				DownloadRequest o2 = Asset.StartDownload(ToLua.CheckString(L, 1));
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 2:
			{
				string url = ToLua.CheckString(L, 1);
				object userData = ToLua.ToVarObject(L, 2);
				DownloadRequest o = Asset.StartDownload(url, userData);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.StartDownload");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartDownloadWitchCache(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				string url3 = ToLua.CheckString(L, 1);
				string localCachePath3 = ToLua.CheckString(L, 2);
				DownloadRequest o3 = Asset.StartDownloadWitchCache(url3, localCachePath3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			case 3:
			{
				string url2 = ToLua.CheckString(L, 1);
				string localCachePath2 = ToLua.CheckString(L, 2);
				UnityAction<DownloadRequest> callback2 = (UnityAction<DownloadRequest>)ToLua.CheckDelegate<UnityAction<DownloadRequest>>(L, 3);
				DownloadRequest o2 = Asset.StartDownloadWitchCache(url2, localCachePath2, callback2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 4:
			{
				string url = ToLua.CheckString(L, 1);
				string localCachePath = ToLua.CheckString(L, 2);
				UnityAction<DownloadRequest> callback = (UnityAction<DownloadRequest>)ToLua.CheckDelegate<UnityAction<DownloadRequest>>(L, 3);
				bool forceDownload = LuaDLL.luaL_checkboolean(L, 4);
				DownloadRequest o = Asset.StartDownloadWitchCache(url, localCachePath, callback, forceDownload);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.StartDownloadWitchCache");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsDownloading(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = Asset.IsDownloading(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetWWW(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DownloadRequest wWW = Asset.GetWWW(ToLua.CheckString(L, 1));
			ToLua.PushObject(L, wWW);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDownloadError(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string downloadError = Asset.GetDownloadError(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, downloadError);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Asset.StopDownload(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopAllDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Asset.StopAllDownload();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cache(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Asset.Cache(ToLua.ToString(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<GameObject>(L, 1))
			{
				Asset.Cache((GameObject)ToLua.ToObject(L, 1));
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, int>(L, 1))
			{
				string path = ToLua.ToString(L, 1);
				int size = (int)LuaDLL.lua_tonumber(L, 2);
				Asset.Cache(path, size);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<GameObject, int>(L, 1))
			{
				GameObject prefab = (GameObject)ToLua.ToObject(L, 1);
				int size2 = (int)LuaDLL.lua_tonumber(L, 2);
				Asset.Cache(prefab, size2);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, GameObject>(L, 1))
			{
				string path2 = ToLua.ToString(L, 1);
				GameObject prefab2 = (GameObject)ToLua.ToObject(L, 2);
				Asset.Cache(path2, prefab2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, int, bool>(L, 1))
			{
				string path3 = ToLua.ToString(L, 1);
				int size3 = (int)LuaDLL.lua_tonumber(L, 2);
				bool dontDestroy = LuaDLL.lua_toboolean(L, 3);
				Asset.Cache(path3, size3, dontDestroy);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<GameObject, int, bool>(L, 1))
			{
				GameObject prefab3 = (GameObject)ToLua.ToObject(L, 1);
				int size4 = (int)LuaDLL.lua_tonumber(L, 2);
				bool dontDestroy2 = LuaDLL.lua_toboolean(L, 3);
				Asset.Cache(prefab3, size4, dontDestroy2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<string, GameObject, int>(L, 1))
			{
				string path4 = ToLua.ToString(L, 1);
				GameObject prefab4 = (GameObject)ToLua.ToObject(L, 2);
				int size5 = (int)LuaDLL.lua_tonumber(L, 3);
				Asset.Cache(path4, prefab4, size5);
				return 0;
			}
			if (num == 4)
			{
				string path5 = ToLua.CheckString(L, 1);
				GameObject prefab5 = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				int size6 = (int)LuaDLL.luaL_checknumber(L, 3);
				bool dontDestroy3 = LuaDLL.luaL_checkboolean(L, 4);
				Asset.Cache(path5, prefab5, size6, dontDestroy3);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.Cache");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Instantiate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				GameObject o = Asset.Instantiate(ToLua.ToString(L, 1));
				ToLua.PushSealed(L, o);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<GameObject>(L, 1))
			{
				GameObject o2 = Asset.Instantiate((GameObject)ToLua.ToObject(L, 1));
				ToLua.PushSealed(L, o2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, bool>(L, 1))
			{
				string path = ToLua.ToString(L, 1);
				bool dontDestroy = LuaDLL.lua_toboolean(L, 2);
				GameObject o3 = Asset.Instantiate(path, dontDestroy);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<GameObject, bool>(L, 1))
			{
				GameObject prefab = (GameObject)ToLua.ToObject(L, 1);
				bool dontDestroy2 = LuaDLL.lua_toboolean(L, 2);
				GameObject o4 = Asset.Instantiate(prefab, dontDestroy2);
				ToLua.PushSealed(L, o4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.Instantiate");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InstantiateAutoUnloadWhileDestroy(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				GameObject o2 = Asset.InstantiateAutoUnloadWhileDestroy(ToLua.CheckString(L, 1));
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				bool dontDestroy = LuaDLL.luaL_checkboolean(L, 2);
				GameObject o = Asset.InstantiateAutoUnloadWhileDestroy(path, dontDestroy);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.InstantiateAutoUnloadWhileDestroy");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InstantiateWithoutCache(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
			{
				GameObject o2 = Asset.InstantiateWithoutCache(ToLua.CheckString(L, 1));
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 2:
				if (TypeChecker.CheckTypes<bool>(L, 2))
				{
					string path = ToLua.CheckString(L, 1);
					bool dontDestroy = LuaDLL.lua_toboolean(L, 2);
					GameObject o = Asset.InstantiateWithoutCache(path, dontDestroy);
					ToLua.PushSealed(L, o);
					return 1;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<Transform>(L, 2))
			{
				string path2 = ToLua.CheckString(L, 1);
				Transform parent = (Transform)ToLua.ToObject(L, 2);
				GameObject o3 = Asset.InstantiateWithoutCache(path2, parent);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			switch (num)
			{
			case 3:
			{
				string path4 = ToLua.CheckString(L, 1);
				Transform parent3 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				bool worldPositionStays2 = LuaDLL.luaL_checkboolean(L, 3);
				GameObject o5 = Asset.InstantiateWithoutCache(path4, parent3, worldPositionStays2);
				ToLua.PushSealed(L, o5);
				return 1;
			}
			case 4:
			{
				string path3 = ToLua.CheckString(L, 1);
				Transform parent2 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				bool worldPositionStays = LuaDLL.luaL_checkboolean(L, 3);
				bool dontDestroy2 = LuaDLL.luaL_checkboolean(L, 4);
				GameObject o4 = Asset.InstantiateWithoutCache(path3, parent2, worldPositionStays, dontDestroy2);
				ToLua.PushSealed(L, o4);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.InstantiateWithoutCache");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveToDontDestroyCache(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Asset.MoveToDontDestroyCache(ToLua.CheckString(L, 1));
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
			case 1:
			{
				UnityEngine.Object obj2 = Asset.Load(ToLua.CheckString(L, 1));
				ToLua.Push(L, obj2);
				return 1;
			}
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				bool isDontDestroy = LuaDLL.luaL_checkboolean(L, 2);
				UnityEngine.Object obj = Asset.Load(path, isDontDestroy);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.Load");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Unload(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				Asset.Unload(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				bool isDontDestroy = LuaDLL.luaL_checkboolean(L, 2);
				Asset.Unload(path, isDontDestroy);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.Unload");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadWithReturn(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = Asset.UnloadWithReturn(ToLua.CheckString(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				bool isDontDestroy = LuaDLL.luaL_checkboolean(L, 2);
				bool value = Asset.UnloadWithReturn(path, isDontDestroy);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.UnloadWithReturn");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadBundle(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				Asset.UnloadBundle(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string bundleName = ToLua.CheckString(L, 1);
				bool isDontDestroy = LuaDLL.luaL_checkboolean(L, 2);
				Asset.UnloadBundle(bundleName, isDontDestroy);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.UnloadBundle");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadAllAssetBundles(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Asset.UnloadAllAssetBundles();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopAsyncLoading(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Asset.StopAsyncLoading();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				Asset.LoadAsync(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string path = ToLua.CheckString(L, 1);
				OnVoidHandler<UnityEngine.Object> callback = (OnVoidHandler<UnityEngine.Object>)ToLua.CheckDelegate<OnVoidHandler<UnityEngine.Object>>(L, 2);
				Asset.LoadAsync(path, callback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.LoadAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadLevelAsync(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<LoadSceneMode>(L, 2))
			{
				string path = ToLua.CheckString(L, 1);
				LoadSceneMode mode = (LoadSceneMode)ToLua.ToObject(L, 2);
				AssetBundleLoadOperation o = Asset.LoadLevelAsync(path, mode);
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<bool>(L, 2))
			{
				string path2 = ToLua.CheckString(L, 1);
				bool isAddtive = LuaDLL.lua_toboolean(L, 2);
				AssetBundleLoadOperation o2 = Asset.LoadLevelAsync(path2, isAddtive);
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<LoadSceneMode, bool>(L, 2))
			{
				string path3 = ToLua.CheckString(L, 1);
				LoadSceneMode mode2 = (LoadSceneMode)ToLua.ToObject(L, 2);
				bool allowSceneActivation = LuaDLL.lua_toboolean(L, 3);
				AssetBundleLoadOperation o3 = Asset.LoadLevelAsync(path3, mode2, allowSceneActivation);
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<bool, bool>(L, 2))
			{
				string path4 = ToLua.CheckString(L, 1);
				bool isAddtive2 = LuaDLL.lua_toboolean(L, 2);
				bool allowSceneActivation2 = LuaDLL.lua_toboolean(L, 3);
				AssetBundleLoadOperation o4 = Asset.LoadLevelAsync(path4, isAddtive2, allowSceneActivation2);
				ToLua.PushObject(L, o4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Asset.LoadLevelAsync");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadLevelSync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string path = ToLua.CheckString(L, 1);
			bool isAddtive = LuaDLL.luaL_checkboolean(L, 2);
			Asset.LoadLevelSync(path, isAddtive);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadLevelSync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Asset.UnloadLevelSync(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DontDestroyBundle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string bundleName = ToLua.CheckString(L, 1);
			bool isDontDestroy = LuaDLL.luaL_checkboolean(L, 2);
			Asset.DontDestroyBundle(bundleName, isDontDestroy);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DontDestroyAssetbundle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string path = ToLua.CheckString(L, 1);
			bool isDontDestroy = LuaDLL.luaL_checkboolean(L, 2);
			Asset.DontDestroyAssetbundle(path, isDontDestroy);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemapVariantPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = Asset.RemapVariantPath(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pool(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, Asset.pool);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pool(IntPtr L)
	{
		try
		{
			Asset.pool = (AssetObjectPool)ToLua.CheckObject<AssetObjectPool>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
