using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class AssetPendDownLoadManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AssetPendDownLoadManager), typeof(MonoBehaviour));
		L.RegFunction("SaveKey", SaveKey);
		L.RegFunction("ResavaKeys", ResavaKeys);
		L.RegFunction("SaveSingleAssetName", SaveSingleAssetName);
		L.RegFunction("SaveSingleVoiceName", SaveSingleVoiceName);
		L.RegFunction("SaveDownloadingPendFile", SaveDownloadingPendFile);
		L.RegFunction("CheckAssetPendDownloaded", CheckAssetPendDownloaded);
		L.RegFunction("IsDownloadingQueue", IsDownloadingQueue);
		L.RegFunction("IsPermanentAssetPend", IsPermanentAssetPend);
		L.RegFunction("IsDownloading", IsDownloading);
		L.RegFunction("GetAssetPendList", GetAssetPendList);
		L.RegFunction("GetDownloadingPendList", GetDownloadingPendList);
		L.RegFunction("GetRemoveAssetList", GetRemoveAssetList);
		L.RegFunction("GetDownloadSingleAsset", GetDownloadSingleAsset);
		L.RegFunction("GetRemoveVoiceList", GetRemoveVoiceList);
		L.RegFunction("GetDownloadSingleVoice", GetDownloadSingleVoice);
		L.RegFunction("ContinueDownLoadPackage", ContinueDownLoadPackage);
		L.RegFunction("AddPendList", AddPendList);
		L.RegFunction("AddPend", AddPend);
		L.RegFunction("StartAssetPendDownload", StartAssetPendDownload);
		L.RegFunction("StopAssetPendDownload", StopAssetPendDownload);
		L.RegFunction("CancelAssetPendDownload", CancelAssetPendDownload);
		L.RegFunction("StartNextAssetPendDownload", StartNextAssetPendDownload);
		L.RegFunction("GetAssetPendPath", GetAssetPendPath);
		L.RegFunction("GetSingleAssetPath", GetSingleAssetPath);
		L.RegFunction("GetSingleVoicePath", GetSingleVoicePath);
		L.RegFunction("GetDownloadingPendPath", GetDownloadingPendPath);
		L.RegFunction("GetFormatSizeStr", GetFormatSizeStr);
		L.RegFunction("ConvertSize", ConvertSize);
		L.RegFunction("UpdateAssetPendSize", UpdateAssetPendSize);
		L.RegFunction("GetAssetPendSizeStr", GetAssetPendSizeStr);
		L.RegFunction("GetAssetPendSize", GetAssetPendSize);
		L.RegFunction("GetAssetPendExistSizeStr", GetAssetPendExistSizeStr);
		L.RegFunction("GetAssetPendExistSize", GetAssetPendExistSize);
		L.RegFunction("GetRemoveAssetPendListSize", GetRemoveAssetPendListSize);
		L.RegFunction("GetSingleAssetSize", GetSingleAssetSize);
		L.RegFunction("GetSingleVoiceSize", GetSingleVoiceSize);
		L.RegFunction("GetSingleAssetAndVoiceSize", GetSingleAssetAndVoiceSize);
		L.RegFunction("GetCurOptionKey", GetCurOptionKey);
		L.RegFunction("GetProcess", GetProcess);
		L.RegFunction("GetProcessStr", GetProcessStr);
		L.RegFunction("GetSpeedStr", GetSpeedStr);
		L.RegFunction("ExistAssetBundle", ExistAssetBundle);
		L.RegFunction("ExistVoice", ExistVoice);
		L.RegFunction("RemovePackage", RemovePackage);
		L.RegFunction("GetAssetList", GetAssetList);
		L.RegFunction("GetVoiceList", GetVoiceList);
		L.RegFunction("RemoveAsset", RemoveAsset);
		L.RegFunction("RemoveVoice", RemoveVoice);
		L.RegFunction("DeleteSingleAsset", DeleteSingleAsset);
		L.RegFunction("GetCanRemoveSingleAssetList", GetCanRemoveSingleAssetList);
		L.RegFunction("DeleteSingleVoice", DeleteSingleVoice);
		L.RegFunction("GetCanRemoveSingleVoiceList", GetCanRemoveSingleVoiceList);
		L.RegFunction("DeletFile", DeletFile);
		L.RegFunction("GetVoicePackageSize", GetVoicePackageSize);
		L.RegFunction("CheckSpaceToDownload", CheckSpaceToDownload);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("cur_option", get_cur_option, set_cur_option);
		L.RegVar("downloaded_keys", get_downloaded_keys, set_downloaded_keys);
		L.RegConstant("KB_QUANTITY", 1024.0);
		L.RegConstant("MB_QUANTITY", 1048576.0);
		L.RegConstant("GB_QUANTITY", 1073741824.0);
		L.RegVar("instance", get_instance, null);
		L.RegVar("assetPendDict", get_assetPendDict, null);
		L.RegVar("disable", get_disable, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			obj.SaveKey(key);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResavaKeys(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).ResavaKeys();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveSingleAssetName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string name = ToLua.CheckString(L, 2);
			obj.SaveSingleAssetName(name);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveSingleVoiceName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string name = ToLua.CheckString(L, 2);
			obj.SaveSingleVoiceName(name);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveDownloadingPendFile(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).SaveDownloadingPendFile();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckAssetPendDownloaded(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			PendType pType = (PendType)ToLua.CheckObject(L, 2, typeof(PendType));
			string key = ToLua.CheckString(L, 3);
			bool value = obj.CheckAssetPendDownloaded(pType, key);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsDownloadingQueue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			bool value = obj.IsDownloadingQueue(key);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPermanentAssetPend(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			bool value = obj.IsPermanentAssetPend(key);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			bool value = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).IsDownloading();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAssetPendList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<string> assetPendList = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetAssetPendList();
			ToLua.PushSealed(L, assetPendList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDownloadingPendList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<string> downloadingPendList = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetDownloadingPendList();
			ToLua.PushSealed(L, downloadingPendList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRemoveAssetList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			object[] keyArray = ToLua.CheckObjectArray(L, 2);
			List<string> removeAssetList = obj.GetRemoveAssetList(keyArray);
			ToLua.PushSealed(L, removeAssetList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDownloadSingleAsset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<string> downloadSingleAsset = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetDownloadSingleAsset();
			ToLua.PushSealed(L, downloadSingleAsset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRemoveVoiceList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			object[] keyArray = ToLua.CheckObjectArray(L, 2);
			List<string> removeVoiceList = obj.GetRemoveVoiceList(keyArray);
			ToLua.PushSealed(L, removeVoiceList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDownloadSingleVoice(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<string> downloadSingleVoice = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetDownloadSingleVoice();
			ToLua.PushSealed(L, downloadSingleVoice);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ContinueDownLoadPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).ContinueDownLoadPackage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddPendList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			object[] keyArray = ToLua.CheckObjectArray(L, 2);
			Action<string> onSuccessed = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 3);
			Action<string> onFailed = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 4);
			Action<string> onPause = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 5);
			obj.AddPendList(keyArray, onSuccessed, onFailed, onPause);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddPend(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			PendType pType = (PendType)ToLua.CheckObject(L, 2, typeof(PendType));
			string key = ToLua.CheckString(L, 3);
			Action<string> onSuccessed = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 4);
			Action<string> onFailed = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 5);
			Action<string> onPause = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 6);
			obj.AddPend(pType, key, onSuccessed, onFailed, onPause);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartAssetPendDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			PendType pType = (PendType)ToLua.CheckObject(L, 2, typeof(PendType));
			string key = ToLua.CheckString(L, 3);
			Action onSuccessed = (Action)ToLua.CheckDelegate<Action>(L, 4);
			Action onFailed = (Action)ToLua.CheckDelegate<Action>(L, 5);
			Action onPause = (Action)ToLua.CheckDelegate<Action>(L, 6);
			bool value = obj.StartAssetPendDownload(pType, key, onSuccessed, onFailed, onPause);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopAssetPendDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			bool value = obj.StopAssetPendDownload(key);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CancelAssetPendDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			bool value = obj.CancelAssetPendDownload(key);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartNextAssetPendDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).StartNextAssetPendDownload();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAssetPendPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string assetPendPath = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetAssetPendPath();
			LuaDLL.lua_pushstring(L, assetPendPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSingleAssetPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string singleAssetPath = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetSingleAssetPath();
			LuaDLL.lua_pushstring(L, singleAssetPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSingleVoicePath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string singleVoicePath = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetSingleVoicePath();
			LuaDLL.lua_pushstring(L, singleVoicePath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDownloadingPendPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string downloadingPendPath = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetDownloadingPendPath();
			LuaDLL.lua_pushstring(L, downloadingPendPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFormatSizeStr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			ulong size = LuaDLL.tolua_checkuint64(L, 2);
			string formatSizeStr = obj.GetFormatSizeStr(size);
			LuaDLL.lua_pushstring(L, formatSizeStr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ConvertSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float totalSize = (float)LuaDLL.luaL_checknumber(L, 1);
			string unit = ToLua.CheckString(L, 2);
			float num = AssetPendDownLoadManager.ConvertSize(totalSize, unit);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateAssetPendSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).UpdateAssetPendSize();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAssetPendSizeStr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			string assetPendSizeStr = obj.GetAssetPendSizeStr(key);
			LuaDLL.lua_pushstring(L, assetPendSizeStr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAssetPendSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			ulong assetPendSize = obj.GetAssetPendSize(key);
			LuaDLL.tolua_pushuint64(L, assetPendSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAssetPendExistSizeStr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			string assetPendExistSizeStr = obj.GetAssetPendExistSizeStr(key);
			LuaDLL.lua_pushstring(L, assetPendExistSizeStr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAssetPendExistSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			ulong assetPendExistSize = obj.GetAssetPendExistSize(key);
			LuaDLL.tolua_pushuint64(L, assetPendExistSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRemoveAssetPendListSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			object[] keyArray = ToLua.CheckObjectArray(L, 2);
			float voiceSize = (float)LuaDLL.luaL_checknumber(L, 3);
			string removeAssetPendListSize = obj.GetRemoveAssetPendListSize(keyArray, voiceSize);
			LuaDLL.lua_pushstring(L, removeAssetPendListSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSingleAssetSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ulong singleAssetSize = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetSingleAssetSize();
			LuaDLL.tolua_pushuint64(L, singleAssetSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSingleVoiceSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ulong singleVoiceSize = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetSingleVoiceSize();
			LuaDLL.tolua_pushuint64(L, singleVoiceSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSingleAssetAndVoiceSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string singleAssetAndVoiceSize = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetSingleAssetAndVoiceSize();
			LuaDLL.lua_pushstring(L, singleAssetAndVoiceSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurOptionKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string curOptionKey = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetCurOptionKey();
			LuaDLL.lua_pushstring(L, curOptionKey);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetProcess(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float process = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetProcess();
			LuaDLL.lua_pushnumber(L, process);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetProcessStr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string processStr = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetProcessStr();
			LuaDLL.lua_pushstring(L, processStr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSpeedStr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string speedStr = ((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).GetSpeedStr();
			LuaDLL.lua_pushstring(L, speedStr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExistAssetBundle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string bundleName = ToLua.CheckString(L, 2);
			bool value = obj.ExistAssetBundle(bundleName);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExistVoice(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string voiceName = ToLua.CheckString(L, 2);
			bool value = obj.ExistVoice(voiceName);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemovePackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			obj.RemovePackage(key);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAssetList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			List<string> assetList = obj.GetAssetList(key);
			ToLua.PushSealed(L, assetList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVoiceList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string key = ToLua.CheckString(L, 2);
			List<string> voiceList = obj.GetVoiceList(key);
			ToLua.PushSealed(L, voiceList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAsset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			List<string> assetList = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
			obj.RemoveAsset(assetList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveVoice(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			List<string> voiceList = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
			obj.RemoveVoice(voiceList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteSingleAsset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).DeleteSingleAsset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCanRemoveSingleAssetList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			List<string> assetList = null;
			List<string> keepList = null;
			obj.GetCanRemoveSingleAssetList(out assetList, out keepList);
			ToLua.PushSealed(L, assetList);
			ToLua.PushSealed(L, keepList);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteSingleVoice(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1)).DeleteSingleVoice();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCanRemoveSingleVoiceList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			List<string> voiceList = null;
			List<string> keepList = null;
			obj.GetCanRemoveSingleVoiceList(out voiceList, out keepList);
			ToLua.PushSealed(L, voiceList);
			ToLua.PushSealed(L, keepList);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeletFile(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string filePath = ToLua.CheckString(L, 2);
			obj.DeletFile(filePath);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVoicePackageSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string abbr = ToLua.CheckString(L, 2);
			float voicePackageSize = obj.GetVoicePackageSize(abbr);
			LuaDLL.lua_pushnumber(L, voicePackageSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckSpaceToDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetPendDownLoadManager obj = (AssetPendDownLoadManager)ToLua.CheckObject<AssetPendDownLoadManager>(L, 1);
			string[] keyList = ToLua.CheckStringArray(L, 2);
			long n = obj.CheckSpaceToDownload(keyList);
			LuaDLL.tolua_pushint64(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cur_option(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AssetPendDownLoadOption cur_option = ((AssetPendDownLoadManager)obj).cur_option;
			ToLua.PushObject(L, cur_option);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_option on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_downloaded_keys(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<string> downloaded_keys = ((AssetPendDownLoadManager)obj).downloaded_keys;
			ToLua.PushSealed(L, downloaded_keys);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index downloaded_keys on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, AssetPendDownLoadManager.instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_assetPendDict(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AssetPendDict assetPendDict = ((AssetPendDownLoadManager)obj).assetPendDict;
			ToLua.PushObject(L, assetPendDict);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index assetPendDict on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_disable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool disable = ((AssetPendDownLoadManager)obj).disable;
			LuaDLL.lua_pushboolean(L, disable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cur_option(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AssetPendDownLoadManager obj2 = (AssetPendDownLoadManager)obj;
			AssetPendDownLoadOption cur_option = (AssetPendDownLoadOption)ToLua.CheckObject<AssetPendDownLoadOption>(L, 2);
			obj2.cur_option = cur_option;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_option on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_downloaded_keys(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AssetPendDownLoadManager obj2 = (AssetPendDownLoadManager)obj;
			List<string> downloaded_keys = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
			obj2.downloaded_keys = downloaded_keys;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index downloaded_keys on a nil value");
		}
	}
}
