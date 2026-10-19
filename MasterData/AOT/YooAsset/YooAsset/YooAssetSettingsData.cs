using System.IO;
using UnityEngine;

namespace YooAsset;

public static class YooAssetSettingsData
{
	private static YooAssetSettings _setting;

	internal static YooAssetSettings Setting
	{
		get
		{
			if (_setting == null)
			{
				LoadSettingData();
			}
			return _setting;
		}
	}

	private static void LoadSettingData()
	{
		_setting = Resources.Load<YooAssetSettings>("YooAssetSettings");
		if (_setting == null)
		{
			_setting = ScriptableObject.CreateInstance<YooAssetSettings>();
		}
	}

	public static string GetDefaultYooFolderName()
	{
		return Setting.DefaultYooFolderName;
	}

	public static string GetBuildReportFileName(string packageName, string packageVersion)
	{
		if (string.IsNullOrEmpty(Setting.PackageManifestPrefix))
		{
			return packageName + "_" + packageVersion + ".report";
		}
		return Setting.PackageManifestPrefix + "_" + packageName + "_" + packageVersion + ".report";
	}

	public static string GetManifestBinaryFileName(string packageName, string packageVersion)
	{
		if (string.IsNullOrEmpty(Setting.PackageManifestPrefix))
		{
			return packageName + "_" + packageVersion + ".bytes";
		}
		return Setting.PackageManifestPrefix + "_" + packageName + "_" + packageVersion + ".bytes";
	}

	public static string GetManifestJsonFileName(string packageName, string packageVersion)
	{
		if (string.IsNullOrEmpty(Setting.PackageManifestPrefix))
		{
			return packageName + "_" + packageVersion + ".json";
		}
		return Setting.PackageManifestPrefix + "_" + packageName + "_" + packageVersion + ".json";
	}

	public static string GetPackageHashFileName(string packageName, string packageVersion)
	{
		if (string.IsNullOrEmpty(Setting.PackageManifestPrefix))
		{
			return packageName + "_" + packageVersion + ".hash";
		}
		return Setting.PackageManifestPrefix + "_" + packageName + "_" + packageVersion + ".hash";
	}

	public static string GetPackageVersionFileName(string packageName)
	{
		if (string.IsNullOrEmpty(Setting.PackageManifestPrefix))
		{
			return packageName + ".version";
		}
		return Setting.PackageManifestPrefix + "_" + packageName + ".version";
	}

	internal static string GetYooEditorCacheRoot()
	{
		if (string.IsNullOrEmpty(Setting.DefaultYooFolderName))
		{
			return PathUtility.RegularPath(Path.GetDirectoryName(Application.dataPath));
		}
		return PathUtility.Combine(PathUtility.RegularPath(Path.GetDirectoryName(Application.dataPath)), Setting.DefaultYooFolderName);
	}

	internal static string GetYooStandaloneWinCacheRoot()
	{
		if (string.IsNullOrEmpty(Setting.DefaultYooFolderName))
		{
			return Application.dataPath;
		}
		return PathUtility.Combine(Application.dataPath, Setting.DefaultYooFolderName);
	}

	internal static string GetYooStandaloneLinuxCacheRoot()
	{
		if (string.IsNullOrEmpty(Setting.DefaultYooFolderName))
		{
			return Application.dataPath;
		}
		return PathUtility.Combine(Application.dataPath, Setting.DefaultYooFolderName);
	}

	internal static string GetYooStandaloneMacCacheRoot()
	{
		if (string.IsNullOrEmpty(Setting.DefaultYooFolderName))
		{
			return Application.persistentDataPath;
		}
		return PathUtility.Combine(Application.persistentDataPath, Setting.DefaultYooFolderName);
	}

	internal static string GetYooMobileCacheRoot()
	{
		if (string.IsNullOrEmpty(Setting.DefaultYooFolderName))
		{
			return Application.persistentDataPath;
		}
		return PathUtility.Combine(Application.persistentDataPath, Setting.DefaultYooFolderName);
	}

	public static string GetYooDefaultCacheRoot()
	{
		return GetYooMobileCacheRoot();
	}

	internal static string GetYooDefaultBuildinRoot()
	{
		if (string.IsNullOrEmpty(Setting.DefaultYooFolderName))
		{
			return Application.streamingAssetsPath;
		}
		return PathUtility.Combine(Application.streamingAssetsPath, Setting.DefaultYooFolderName);
	}
}
