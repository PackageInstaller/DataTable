using System;
using System.Collections.Generic;
using LitJson;
using UnityEngine;

public class NaiveAngleConfigManager
{
	public const string NAIVE_ANGLE_MODE_KEY = "naive_angle_mode_key";

	public const string NAIVE_ANGLE_MODE_POSTFIX = "naive";

	public const string NAIVE_ANGLE_CONFIG_FILR_NAME = "NaiveAngleConfig";

	private const string NAIVE_ANGLE_CONFIG_FILR_HOTFIX_INDEX_NAME = "NaiveAngleConfigIndex";

	private const string prefabPath = "Assets/ABResources";

	private const string prefabPath_comChar = "Assets/ComChar/ABResources";

	private const string prefabPath_comCharQ = "Assets/ComCharQ/ABResources";

	private const string prefabPath_comEffect = "Assets/ComEffect/ABResources";

	private const string prefabPath_comScene = "Assets/ComScene/ABResources";

	private const string prefabPath_comSceneQ = "Assets/ComSceneQ/ABResources";

	private const string prefabPath_comSingle = "Assets/ComSingle/ABResources";

	private const string texturePath_comSingle = "Assets/ComSingle/ABResources/TextureConfig";

	public static Dictionary<string, List<string>> assetPathMap;

	private static bool ready;

	public static bool GetReady()
	{
		return ready;
	}

	public static void Initialize()
	{
		if (!ready)
		{
			InitNaiveAngleConfig();
			ready = true;
		}
	}

	private static void InitNaiveAngleConfig()
	{
		assetPathMap = new Dictionary<string, List<string>>();
		List<string> configPathsFromIndex = GetConfigPathsFromIndex();
		configPathsFromIndex.Add("Assets/ABResources/NaiveAngleConfig.json");
		configPathsFromIndex.Add("Assets/ComChar/ABResources/" + GetNaiveNameConfigWithPrefix("Assets/ComChar/ABResources") + ".json");
		configPathsFromIndex.Add("Assets/ComCharQ/ABResources/" + GetNaiveNameConfigWithPrefix("Assets/ComCharQ/ABResources") + ".json");
		configPathsFromIndex.Add("Assets/ComEffect/ABResources/" + GetNaiveNameConfigWithPrefix("Assets/ComEffect/ABResources") + ".json");
		configPathsFromIndex.Add("Assets/ComScene/ABResources/" + GetNaiveNameConfigWithPrefix("Assets/ComScene/ABResources") + ".json");
		configPathsFromIndex.Add("Assets/ComSceneQ/ABResources/" + GetNaiveNameConfigWithPrefix("Assets/ComSceneQ/ABResources") + ".json");
		configPathsFromIndex.Add("Assets/ComSingle/ABResources/" + GetNaiveNameConfigWithPrefix("Assets/ComSingle/ABResources") + ".json");
		foreach (string item in configPathsFromIndex)
		{
			TextAsset textAsset = Asset.Load<TextAsset>(GetNaiveNameConfigWithPrefix(item));
			if (!(textAsset != null))
			{
				continue;
			}
			foreach (KeyValuePair<string, List<string>> item2 in JsonMapper.ToObject<Dictionary<string, List<string>>>(textAsset.text))
			{
				if (assetPathMap.ContainsKey(item2.Key))
				{
					assetPathMap[item2.Key].AddRange(item2.Value);
				}
				else
				{
					assetPathMap[item2.Key] = new List<string>(item2.Value);
				}
			}
		}
	}

	private static string GetNaiveNameConfigWithPrefix(string path)
	{
		string[] array = path.Split('/');
		foreach (string text in array)
		{
			if (text == "ABResources")
			{
				break;
			}
			if (text != "Assets")
			{
				return text + "NaiveAngleConfig";
			}
		}
		return "NaiveAngleConfig";
	}

	private static List<string> GetConfigPathsFromIndex()
	{
		List<string> list = new List<string>();
		try
		{
			string text = "Assets/ABResources/NaiveAngleConfigIndex.json";
			TextAsset textAsset = Asset.Load<TextAsset>("NaiveAngleConfigIndex");
			if (textAsset == null)
			{
				Debug.LogWarning("配置索引文件不存在: " + text);
				return list;
			}
			Dictionary<string, List<string>> dictionary = JsonMapper.ToObject<Dictionary<string, List<string>>>(textAsset.text);
			foreach (KeyValuePair<string, List<string>> item in dictionary)
			{
				list.Add(item.Value[0]);
			}
			Debug.Log($"从索引加载 {dictionary.Count} 个新增热更分库配置");
		}
		catch (Exception ex)
		{
			Debug.LogError("加载配置索引失败: " + ex.Message);
		}
		return list;
	}

	public static string GetNiveModePathOrName(string assetPath)
	{
		if (GetReady() && assetPathMap != null && assetPathMap.ContainsKey(assetPath))
		{
			List<string> list = assetPathMap[assetPath];
			string text = PlayerPrefs.GetString("naive_angle_mode_key", "naive");
			if (string.IsNullOrEmpty(text))
			{
				return assetPath;
			}
			if (list.Contains(text))
			{
				return assetPath + "$" + text;
			}
			if (list.Count > 0)
			{
				return assetPath + "$" + list[0];
			}
		}
		return assetPath;
	}
}
