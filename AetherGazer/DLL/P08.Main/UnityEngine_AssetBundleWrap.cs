using System;
using System.Collections.Generic;
using System.IO;
using LuaInterface;
using UnityEngine;

public class UnityEngine_AssetBundleWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AssetBundle), typeof(UnityEngine.Object));
		L.RegFunction("UnloadAllAssetBundles", UnloadAllAssetBundles);
		L.RegFunction("GetAllLoadedAssetBundles", GetAllLoadedAssetBundles);
		L.RegFunction("LoadFromFileAsync", LoadFromFileAsync);
		L.RegFunction("LoadFromFile", LoadFromFile);
		L.RegFunction("LoadFromMemoryAsync", LoadFromMemoryAsync);
		L.RegFunction("LoadFromMemory", LoadFromMemory);
		L.RegFunction("LoadFromStreamAsync", LoadFromStreamAsync);
		L.RegFunction("LoadFromStream", LoadFromStream);
		L.RegFunction("Contains", Contains);
		L.RegFunction("LoadAsset", LoadAsset);
		L.RegFunction("LoadAssetAsync", LoadAssetAsync);
		L.RegFunction("LoadAssetWithSubAssets", LoadAssetWithSubAssets);
		L.RegFunction("LoadAssetWithSubAssetsAsync", LoadAssetWithSubAssetsAsync);
		L.RegFunction("LoadAllAssets", LoadAllAssets);
		L.RegFunction("LoadAllAssetsAsync", LoadAllAssetsAsync);
		L.RegFunction("Unload", Unload);
		L.RegFunction("GetAllAssetNames", GetAllAssetNames);
		L.RegFunction("GetAllScenePaths", GetAllScenePaths);
		L.RegFunction("RecompressAssetBundleAsync", RecompressAssetBundleAsync);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("isStreamedSceneAssetBundle", get_isStreamedSceneAssetBundle, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadAllAssetBundles(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			AssetBundle.UnloadAllAssetBundles(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAllLoadedAssetBundles(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			IEnumerable<AssetBundle> allLoadedAssetBundles = AssetBundle.GetAllLoadedAssetBundles();
			ToLua.PushObject(L, allLoadedAssetBundles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadFromFileAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				AssetBundleCreateRequest o3 = AssetBundle.LoadFromFileAsync(ToLua.CheckString(L, 1));
				ToLua.PushObject(L, o3);
				return 1;
			}
			case 2:
			{
				string path2 = ToLua.CheckString(L, 1);
				uint crc2 = (uint)LuaDLL.luaL_checknumber(L, 2);
				AssetBundleCreateRequest o2 = AssetBundle.LoadFromFileAsync(path2, crc2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 3:
			{
				string path = ToLua.CheckString(L, 1);
				uint crc = (uint)LuaDLL.luaL_checknumber(L, 2);
				ulong offset = LuaDLL.tolua_checkuint64(L, 3);
				AssetBundleCreateRequest o = AssetBundle.LoadFromFileAsync(path, crc, offset);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadFromFileAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadFromFile(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				AssetBundle obj3 = AssetBundle.LoadFromFile(ToLua.CheckString(L, 1));
				ToLua.Push(L, obj3);
				return 1;
			}
			case 2:
			{
				string path2 = ToLua.CheckString(L, 1);
				uint crc2 = (uint)LuaDLL.luaL_checknumber(L, 2);
				AssetBundle obj2 = AssetBundle.LoadFromFile(path2, crc2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 3:
			{
				string path = ToLua.CheckString(L, 1);
				uint crc = (uint)LuaDLL.luaL_checknumber(L, 2);
				ulong offset = LuaDLL.tolua_checkuint64(L, 3);
				AssetBundle obj = AssetBundle.LoadFromFile(path, crc, offset);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadFromFile");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadFromMemoryAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				AssetBundleCreateRequest o2 = AssetBundle.LoadFromMemoryAsync(ToLua.CheckByteBuffer(L, 1));
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 2:
			{
				byte[] binary = ToLua.CheckByteBuffer(L, 1);
				uint crc = (uint)LuaDLL.luaL_checknumber(L, 2);
				AssetBundleCreateRequest o = AssetBundle.LoadFromMemoryAsync(binary, crc);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadFromMemoryAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadFromMemory(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				AssetBundle obj2 = AssetBundle.LoadFromMemory(ToLua.CheckByteBuffer(L, 1));
				ToLua.Push(L, obj2);
				return 1;
			}
			case 2:
			{
				byte[] binary = ToLua.CheckByteBuffer(L, 1);
				uint crc = (uint)LuaDLL.luaL_checknumber(L, 2);
				AssetBundle obj = AssetBundle.LoadFromMemory(binary, crc);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadFromMemory");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadFromStreamAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				AssetBundleCreateRequest o3 = AssetBundle.LoadFromStreamAsync((Stream)ToLua.CheckObject<Stream>(L, 1));
				ToLua.PushObject(L, o3);
				return 1;
			}
			case 2:
			{
				Stream stream2 = (Stream)ToLua.CheckObject<Stream>(L, 1);
				uint crc2 = (uint)LuaDLL.luaL_checknumber(L, 2);
				AssetBundleCreateRequest o2 = AssetBundle.LoadFromStreamAsync(stream2, crc2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 3:
			{
				Stream stream = (Stream)ToLua.CheckObject<Stream>(L, 1);
				uint crc = (uint)LuaDLL.luaL_checknumber(L, 2);
				uint managedReadBufferSize = (uint)LuaDLL.luaL_checknumber(L, 3);
				AssetBundleCreateRequest o = AssetBundle.LoadFromStreamAsync(stream, crc, managedReadBufferSize);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadFromStreamAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadFromStream(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				AssetBundle obj3 = AssetBundle.LoadFromStream((Stream)ToLua.CheckObject<Stream>(L, 1));
				ToLua.Push(L, obj3);
				return 1;
			}
			case 2:
			{
				Stream stream2 = (Stream)ToLua.CheckObject<Stream>(L, 1);
				uint crc2 = (uint)LuaDLL.luaL_checknumber(L, 2);
				AssetBundle obj2 = AssetBundle.LoadFromStream(stream2, crc2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 3:
			{
				Stream stream = (Stream)ToLua.CheckObject<Stream>(L, 1);
				uint crc = (uint)LuaDLL.luaL_checknumber(L, 2);
				uint managedReadBufferSize = (uint)LuaDLL.luaL_checknumber(L, 3);
				AssetBundle obj = AssetBundle.LoadFromStream(stream, crc, managedReadBufferSize);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadFromStream");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Contains(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetBundle obj = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
			string name = ToLua.CheckString(L, 2);
			bool value = obj.Contains(name);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			case 2:
			{
				AssetBundle obj3 = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				string name2 = ToLua.CheckString(L, 2);
				UnityEngine.Object obj4 = obj3.LoadAsset(name2);
				ToLua.Push(L, obj4);
				return 1;
			}
			case 3:
			{
				AssetBundle obj = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				string name = ToLua.CheckString(L, 2);
				Type type = ToLua.CheckMonoType(L, 3);
				UnityEngine.Object obj2 = obj.LoadAsset(name, type);
				ToLua.Push(L, obj2);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadAsset");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAssetAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				AssetBundle obj2 = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				string name2 = ToLua.CheckString(L, 2);
				AssetBundleRequest o2 = obj2.LoadAssetAsync(name2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 3:
			{
				AssetBundle obj = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				string name = ToLua.CheckString(L, 2);
				Type type = ToLua.CheckMonoType(L, 3);
				AssetBundleRequest o = obj.LoadAssetAsync(name, type);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadAssetAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAssetWithSubAssets(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				AssetBundle obj2 = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				string name2 = ToLua.CheckString(L, 2);
				UnityEngine.Object[] array2 = obj2.LoadAssetWithSubAssets(name2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 3:
			{
				AssetBundle obj = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				string name = ToLua.CheckString(L, 2);
				Type type = ToLua.CheckMonoType(L, 3);
				UnityEngine.Object[] array = obj.LoadAssetWithSubAssets(name, type);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadAssetWithSubAssets");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAssetWithSubAssetsAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				AssetBundle obj2 = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				string name2 = ToLua.CheckString(L, 2);
				AssetBundleRequest o2 = obj2.LoadAssetWithSubAssetsAsync(name2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 3:
			{
				AssetBundle obj = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				string name = ToLua.CheckString(L, 2);
				Type type = ToLua.CheckMonoType(L, 3);
				AssetBundleRequest o = obj.LoadAssetWithSubAssetsAsync(name, type);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadAssetWithSubAssetsAsync");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAllAssets(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				UnityEngine.Object[] array2 = ((AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1)).LoadAllAssets();
				ToLua.Push(L, array2);
				return 1;
			}
			case 2:
			{
				AssetBundle obj = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				Type type = ToLua.CheckMonoType(L, 2);
				UnityEngine.Object[] array = obj.LoadAllAssets(type);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadAllAssets");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAllAssetsAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				AssetBundleRequest o2 = ((AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1)).LoadAllAssetsAsync();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 2:
			{
				AssetBundle obj = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
				Type type = ToLua.CheckMonoType(L, 2);
				AssetBundleRequest o = obj.LoadAllAssetsAsync(type);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.LoadAllAssetsAsync");
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
			ToLua.CheckArgsCount(L, 2);
			AssetBundle obj = (AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1);
			bool unloadAllLoadedObjects = LuaDLL.luaL_checkboolean(L, 2);
			obj.Unload(unloadAllLoadedObjects);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAllAssetNames(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] allAssetNames = ((AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1)).GetAllAssetNames();
			ToLua.Push(L, allAssetNames);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAllScenePaths(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] allScenePaths = ((AssetBundle)ToLua.CheckObject<AssetBundle>(L, 1)).GetAllScenePaths();
			ToLua.Push(L, allScenePaths);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecompressAssetBundleAsync(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				string inputPath3 = ToLua.CheckString(L, 1);
				string outputPath3 = ToLua.CheckString(L, 2);
				BuildCompression method3 = StackTraits<BuildCompression>.Check(L, 3);
				AssetBundleRecompressOperation o3 = AssetBundle.RecompressAssetBundleAsync(inputPath3, outputPath3, method3);
				ToLua.PushObject(L, o3);
				return 1;
			}
			case 4:
			{
				string inputPath2 = ToLua.CheckString(L, 1);
				string outputPath2 = ToLua.CheckString(L, 2);
				BuildCompression method2 = StackTraits<BuildCompression>.Check(L, 3);
				uint expectedCRC2 = (uint)LuaDLL.luaL_checknumber(L, 4);
				AssetBundleRecompressOperation o2 = AssetBundle.RecompressAssetBundleAsync(inputPath2, outputPath2, method2, expectedCRC2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 5:
			{
				string inputPath = ToLua.CheckString(L, 1);
				string outputPath = ToLua.CheckString(L, 2);
				BuildCompression method = StackTraits<BuildCompression>.Check(L, 3);
				uint expectedCRC = (uint)LuaDLL.luaL_checknumber(L, 4);
				ThreadPriority priority = (ThreadPriority)ToLua.CheckObject(L, 5, typeof(ThreadPriority));
				AssetBundleRecompressOperation o = AssetBundle.RecompressAssetBundleAsync(inputPath, outputPath, method, expectedCRC, priority);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.AssetBundle.RecompressAssetBundleAsync");
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
	private static int get_isStreamedSceneAssetBundle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isStreamedSceneAssetBundle = ((AssetBundle)obj).isStreamedSceneAssetBundle;
			LuaDLL.lua_pushboolean(L, isStreamedSceneAssetBundle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isStreamedSceneAssetBundle on a nil value");
		}
	}
}
