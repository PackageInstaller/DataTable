using System.IO;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CriWare;

public class Common
{
	public struct CpuUsage
	{
		public float last;

		public float average;

		public float peak;
	}

	private const string scriptVersionString = "1.0.0(2.44.49_WinAudioFix)";

	public const bool supportsCriFsInstaller = true;

	public const bool supportsCriFsWebInstaller = true;

	public const string pluginName = "cri_ware_unity";

	public const CallingConvention pluginCallingConvention = CallingConvention.Cdecl;

	public const string engineName = "Unity";

	public const string WINDOW_EDITOR_CRIWARE_ASSET_FOLDER = "CriWareAsset";

	private static GameObject _managerObject;

	public static string streamingAssetsPath
	{
		get
		{
			if (Application.platform == RuntimePlatform.Android)
			{
				return "Android";
			}
			if (Application.platform == RuntimePlatform.WindowsEditor)
			{
				return Application.streamingAssetsPath + "/CriWareAsset";
			}
			if (Application.platform == RuntimePlatform.IPhonePlayer)
			{
				return Application.streamingAssetsPath + "/IOS";
			}
			if (Application.platform == RuntimePlatform.WindowsPlayer)
			{
				return Application.streamingAssetsPath + "/Windows";
			}
			return Application.streamingAssetsPath + "/CriWareAsset";
		}
	}

	public static string persistentDataPath => Platform.GetDownloadPersistentDataPath();

	public static string installTargetPath => Application.persistentDataPath;

	public static string installCachePath => Caching.currentCacheForWriting.path;

	public static GameObject managerObject
	{
		get
		{
			if (_managerObject == null)
			{
				_managerObject = GameObject.Find("/CRIWARE");
				if (_managerObject == null)
				{
					_managerObject = new GameObject("CRIWARE");
				}
				Object.DontDestroyOnLoad(_managerObject);
			}
			return _managerObject;
		}
	}

	public static bool IsStreamingAssetsPath(string path)
	{
		if (!Path.IsPathRooted(path))
		{
			return path.IndexOf(':') < 0;
		}
		return false;
	}

	public static string GetScriptVersionString()
	{
		return "1.0.0(2.44.49_WinAudioFix)";
	}

	public static int GetBinaryVersionNumber()
	{
		return CRIWAREC6309446();
	}

	public static int GetRequiredBinaryVersionNumber()
	{
		return 38019073;
	}

	public static bool CheckBinaryVersionCompatibility()
	{
		if (GetBinaryVersionNumber() == GetRequiredBinaryVersionNumber())
		{
			return true;
		}
		Debug.LogError("CRI runtime library is not compatible. Confirm the version number.");
		return false;
	}

	public static uint GetFsMemoryUsage()
	{
		return CriFsPlugin.CRIWARE73E26CCB();
	}

	public static uint GetAtomMemoryUsage()
	{
		return CriAtomPlugin.CRIWAREF9C76501();
	}

	public static uint GetManaMemoryUsage()
	{
		return CriManaPlugin.CRIWAREDEE99E0C();
	}

	public static CpuUsage GetAtomCpuUsage()
	{
		return CriAtomPlugin.GetCpuUsage();
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern int CRIWAREC6309446();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	public static extern void criWareUnity_SetRenderingEventOffsetForMana(int offset);
}
