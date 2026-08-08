using System;
using System.Collections.Generic;
using UnityEngine;

public class I18NRuntimeManager
{
	public struct FileIdDataEntry
	{
		public ulong hash1;

		public ulong hash2;

		public string translateFileName;

		public int translateIndex;
	}

	private static I18NRuntimeManager sInstance;

	private static string curTextLanguage = "zh_cn";

	private const string translateDataPath = "I18NTranslate/Translate/";

	private const string translateFileIdPath = "I18NTranslate/";

	private const string TEXT_LANGUAGE_KEY = "text_language";

	public Dictionary<string, List<string>> translateFileDataDic;

	public Dictionary<ulong, Dictionary<ulong, FileIdDataEntry>> translateFileIdMap;

	public static I18NRuntimeManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new I18NRuntimeManager();
				sInstance.Init();
			}
			return sInstance;
		}
	}

	public void Init()
	{
		if (translateFileDataDic == null)
		{
			translateFileDataDic = new Dictionary<string, List<string>>();
		}
		translateFileIdMap = new Dictionary<ulong, Dictionary<ulong, FileIdDataEntry>>();
		LoadDefaultLanguage();
		InitFileIdData();
	}

	public void Clear()
	{
		translateFileDataDic.Clear();
		translateFileIdMap.Clear();
		GC.Collect();
	}

	public void ClearTranslate()
	{
		translateFileDataDic.Clear();
	}

	public void LoadDefaultLanguage()
	{
		string value = PlayerPrefs.GetString("text_language");
		if (!string.IsNullOrEmpty(value))
		{
			curTextLanguage = value;
		}
	}

	public void ChangeLanguage(string languageKey)
	{
		if (!curTextLanguage.Equals(languageKey))
		{
			ClearTranslate();
		}
		curTextLanguage = languageKey;
	}

	public string GetI18NText(string i18nKey)
	{
		if (string.IsNullOrEmpty(i18nKey))
		{
			return i18nKey;
		}
		if (I18NTools.SplitI18NKeyToUlongs(i18nKey, out var hash, out var hash2) && translateFileIdMap.ContainsKey(hash) && translateFileIdMap[hash].ContainsKey(hash2))
		{
			FileIdDataEntry fileIdDataEntry = translateFileIdMap[hash][hash2];
			InitTranslateFile(fileIdDataEntry.translateFileName);
			if (fileIdDataEntry.translateIndex >= translateFileDataDic[fileIdDataEntry.translateFileName].Count)
			{
				return null;
			}
			return translateFileDataDic[fileIdDataEntry.translateFileName][fileIdDataEntry.translateIndex];
		}
		return null;
	}

	public void InitFileIdData()
	{
		string path = "I18NTranslate/FileIdData" + "/file_id_data";
		I18NFileIdDataList i18NFileIdDataList = Asset.Load<I18NFileIdDataList>(path);
		if (i18NFileIdDataList != null)
		{
			int count = i18NFileIdDataList.keyToTranslateFileIdData.Count;
			for (int i = 0; i < count; i++)
			{
				KeyToTranslateFileIdData keyToTranslateFileIdData = i18NFileIdDataList.keyToTranslateFileIdData[i];
				ulong hash = keyToTranslateFileIdData.hash1;
				ulong hash2 = keyToTranslateFileIdData.hash2;
				string translateFileName = keyToTranslateFileIdData.translateFileName;
				int translateIndex = keyToTranslateFileIdData.translateIndex;
				FileIdDataEntry value = new FileIdDataEntry
				{
					hash1 = hash,
					hash2 = hash2,
					translateFileName = translateFileName,
					translateIndex = translateIndex
				};
				if (!translateFileIdMap.ContainsKey(hash))
				{
					translateFileIdMap.Add(hash, new Dictionary<ulong, FileIdDataEntry>());
				}
				if (!translateFileIdMap[hash].ContainsKey(hash2))
				{
					translateFileIdMap[hash].Add(hash2, value);
				}
				else
				{
					translateFileIdMap[hash][hash2] = value;
				}
			}
		}
		Asset.Unload(path);
	}

	public void InitTranslateFile(string translateFileName)
	{
		if (translateFileDataDic.ContainsKey(translateFileName))
		{
			return;
		}
		translateFileDataDic.Add(translateFileName, new List<string>());
		I18NTranslateFileData i18NTranslateFileData = Asset.Load<I18NTranslateFileData>(string.Concat("I18NTranslate/Translate/" + curTextLanguage, "/", translateFileName));
		if (i18NTranslateFileData != null)
		{
			I18NTranslateFileData i18NTranslateFileData2 = UnityEngine.Object.Instantiate(i18NTranslateFileData);
			int count = i18NTranslateFileData2.translates.Count;
			for (int i = 0; i < count; i++)
			{
				string item = i18NTranslateFileData2.translates[i];
				translateFileDataDic[translateFileName].Add(item);
			}
			UnityEngine.Object.Destroy(i18NTranslateFileData2);
		}
	}
}
