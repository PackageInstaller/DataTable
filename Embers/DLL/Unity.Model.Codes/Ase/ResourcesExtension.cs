using GameFramework;
using UnityEngine;

namespace Ase;

public static class ResourcesExtension
{
	public static string[] ResourcePackages = new string[6] { "DefaultPackage", "Paradoxs", "DataTables", "HotCode", "Scenes", "Story" };

	public static string[] AudioResourcePackages = new string[1] { "Audio" };

	public static string GetPlatformPath(RuntimePlatform platform)
	{
		return "Android";
	}

	public static string GetAssetRemoteURL(string packageName)
	{
		string text = "PC";
		text = GetPlatformPath(Application.platform);
		return Utility.Path.GetRemotePath(GameEntry.BuiltinData.OssPath, text, packageName, GameEntry.Resource.GetResourceVersion(packageName));
	}

	public static string GetAssetFallbackURL(string packageName)
	{
		string text = "PC";
		text = GetPlatformPath(Application.platform);
		return Utility.Path.GetRemotePath(GameEntry.BuiltinData.OssPath_Fallback, text, packageName, GameEntry.Resource.GetResourceVersion(packageName));
	}
}
