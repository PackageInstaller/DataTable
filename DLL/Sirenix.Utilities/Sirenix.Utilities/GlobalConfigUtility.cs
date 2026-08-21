using System;
using UnityEngine;

namespace Sirenix.Utilities;

public static class GlobalConfigUtility<T> where T : ScriptableObject
{
	private static T instance;

	public static bool HasInstanceLoaded => instance != null;

	public static T GetInstance(string defaultAssetFolderPath, string defaultFileNameWithoutExtension = null)
	{
		if (instance == null)
		{
			LoadInstanceIfAssetExists(defaultAssetFolderPath, defaultFileNameWithoutExtension);
			T val = instance;
			if (val == null)
			{
				val = ScriptableObject.CreateInstance<T>();
			}
			instance = val;
			if (instance is IGlobalConfigEvents globalConfigEvents)
			{
				globalConfigEvents.OnConfigInstanceFirstAccessed();
			}
		}
		return instance;
	}

	internal static void LoadInstanceIfAssetExists(string assetPath, string defaultFileNameWithoutExtension = null)
	{
		string text = defaultFileNameWithoutExtension ?? typeof(T).GetNiceName();
		if (StringExtensions.Contains(assetPath, "/resources/", StringComparison.OrdinalIgnoreCase))
		{
			string text2 = assetPath;
			int num = text2.LastIndexOf("/resources/", StringComparison.OrdinalIgnoreCase);
			if (num >= 0)
			{
				text2 = text2.Substring(num + "/resources/".Length);
			}
			string text3 = text;
			instance = Resources.Load<T>(text2 + text3);
		}
	}
}
