using System;
using System.IO;
using UnityEngine;

public class UAndroid
{
	private static AndroidJavaClass uAndroid;

	public static void Init()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			uAndroid = new AndroidJavaClass("com.mmr.uandroid.AndroidPluginTools");
		}
	}

	public static byte[] LoadStreamingAsset(string path)
	{
		byte[] result = null;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<byte[]>("LoadSteamingAssetFile", new object[1] { path });
		}
		return result;
	}

	public static bool HasObb()
	{
		bool result = false;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<bool>("hasObb", Array.Empty<object>());
		}
		return result;
	}

	public static bool HasObb(long lastModified)
	{
		bool result = false;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<bool>("hasObb", new object[1] { lastModified });
		}
		return result;
	}

	public static void CallObbDownload()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			uAndroid.CallStatic("CallObbDownload");
		}
	}

	public static string[] GetAPKExpansionFiles()
	{
		string[] result = null;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<string[]>("getAPKExpansionFiles", Array.Empty<object>());
		}
		return result;
	}

	public static bool IsObbMounted()
	{
		bool result = false;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<bool>("IsObbMounted", Array.Empty<object>());
		}
		return result;
	}

	public static byte[] LoadObbAsset(string path)
	{
		byte[] result = null;
		if (Application.platform == RuntimePlatform.Android)
		{
			return File.ReadAllBytes(Application.persistentDataPath + "/" + path);
		}
		return result;
	}

	public static void UnzipObbFile(string outputPath)
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			uAndroid.CallStatic("UnzipObbFile", outputPath);
		}
	}

	public static string GetObbName()
	{
		string result = string.Empty;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<string>("getObbFileName", Array.Empty<object>());
		}
		return result;
	}

	public static int GetVersionCode()
	{
		int result = 0;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<int>("GetVersionCode", Array.Empty<object>());
		}
		return result;
	}

	public static int GetObbUnzipProgress()
	{
		int result = 0;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<int>("GetObbUnzipProgress", Array.Empty<object>());
		}
		return result;
	}

	public static bool GetObbUnzipFailed()
	{
		bool result = false;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<bool>("GetObbUnzipFailed", Array.Empty<object>());
		}
		return result;
	}

	public static long GetObbLastModified()
	{
		long result = 0L;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<long>("GetObbLastModified", Array.Empty<object>());
		}
		return result;
	}

	public static bool HasUnzipObbFile(string outputPath)
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			return uAndroid.CallStatic<bool>("checkObbUnpacked", new object[1] { outputPath });
		}
		return false;
	}

	public static bool ExistSDCard()
	{
		bool result = false;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<bool>("ExistSDCard", Array.Empty<object>());
		}
		return result;
	}

	public static long GetSDFreeSize()
	{
		long result = 0L;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<long>("getSDFreeSize", Array.Empty<object>());
		}
		return result;
	}

	public static long GetSDTotalSize()
	{
		long result = 0L;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<long>("getSDAllSize", Array.Empty<object>());
		}
		return result;
	}

	public static long GetTotalRomSize()
	{
		long result = 0L;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<long>("getTotolRomSpace", Array.Empty<object>());
		}
		return result;
	}

	public static long GetFreeRomSize()
	{
		long result = 0L;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<long>("getRomSpace", Array.Empty<object>());
		}
		return result;
	}

	public static void StartAppSettings()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			uAndroid.CallStatic("StartAppSettings");
		}
	}

	public static bool CheckSelfPermission(string permissionName)
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			return uAndroid.CallStatic<bool>("CheckSelfPermission", new object[1] { permissionName });
		}
		return false;
	}

	public static string GetMetaData(string metaName)
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			return uAndroid.CallStatic<string>("GetMetaData", new object[1] { metaName });
		}
		return null;
	}

	public static string[] GetFilesFromDir(string dirPath)
	{
		string[] result = null;
		if (Application.platform == RuntimePlatform.Android)
		{
			result = uAndroid.CallStatic<string[]>("getFilesFromDir", new object[1] { dirPath });
		}
		return result;
	}

	public static void DebugTest()
	{
		if (Application.platform != RuntimePlatform.Android)
		{
			return;
		}
		Init();
		Debug.Log("ExistSDCard == " + ExistSDCard());
		Debug.Log("GetSDTotalSize == " + GetSDTotalSize());
		Debug.Log("GetSDFreeSize == " + GetSDFreeSize());
		Debug.Log("GetTotalRomSize == " + GetTotalRomSize());
		Debug.Log("GetFreeRomSize == " + GetFreeRomSize());
		Debug.Log("是否存在OBB == " + HasObb());
		Debug.Log("OBB是否挂载成功 == " + IsObbMounted());
		string[] aPKExpansionFiles = GetAPKExpansionFiles();
		if (aPKExpansionFiles != null)
		{
			for (int i = 0; i < aPKExpansionFiles.Length; i++)
			{
				Debug.Log("OBB == " + aPKExpansionFiles[i]);
			}
		}
	}
}
