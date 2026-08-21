using System.Collections.Generic;
using LitJson;
using UnityEngine;

public class I18NConfigManager
{
	private static bool ready = false;

	public static Dictionary<string, List<string>> assetPathMap;

	public static Dictionary<string, List<string>> assetPathMap_ComBattle;

	public const string TEXT_LANGUAGE_KEY = "text_language";

	public static int MAX_NUMBER_OF_SPLIT_TRANSLATE_DATA = 1024;

	public static bool GetReady()
	{
		return ready;
	}

	public static void Initialize()
	{
		if (!ready)
		{
			InitI18NConfig();
			ready = true;
		}
	}

	public static void InitI18NConfig()
	{
		assetPathMap = JsonMapper.ToObject<Dictionary<string, List<string>>>(Asset.Load<TextAsset>("I18NInfo").text);
		TextAsset textAsset = Asset.Load<TextAsset>("I18NInfo_ComBattle");
		if (!(textAsset != null))
		{
			return;
		}
		assetPathMap_ComBattle = JsonMapper.ToObject<Dictionary<string, List<string>>>(textAsset.text);
		foreach (KeyValuePair<string, List<string>> item in assetPathMap_ComBattle)
		{
			if (!assetPathMap.ContainsKey(item.Key))
			{
				assetPathMap.Add(item.Key, item.Value);
			}
		}
	}

	public static string GetI18NPathOrName(string assetPath)
	{
		if (GetReady() && assetPathMap.ContainsKey(assetPath))
		{
			List<string> list = assetPathMap[assetPath];
			string text = PlayerPrefs.GetString("text_language");
			if (list.Contains(text))
			{
				return assetPath + "@" + text;
			}
			if (assetPath.StartsWith("Fonts"))
			{
				return assetPath;
			}
			if (list.Contains("zh_cn"))
			{
				return assetPath + "@zh_cn";
			}
		}
		return assetPath;
	}

	public static Sprite GetSprite(SPRITE_ASSET_TYPE spriteType, string spriteAssetPath, string spriteName)
	{
		if (spriteType == SPRITE_ASSET_TYPE.TEXTURE)
		{
			return Asset.Load<Sprite>(spriteAssetPath);
		}
		Debug.LogError($"I18NConfig GetSprite, Undefind spriteType, spriteType: {spriteType}, spriteAssetPath: {spriteAssetPath}");
		return null;
	}
}
