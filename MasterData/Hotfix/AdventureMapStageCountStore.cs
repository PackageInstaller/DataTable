using System.Collections;
using System.Collections.Generic;
using LitJson;
using UnityEngine;

public static class AdventureMapStageCountStore
{
	private static string PREFS_KEY => "MapPerStageCount";

	public static List<AdventureModuleLevelLoadParams.MapGroupStageCount> Parse()
	{
		List<AdventureModuleLevelLoadParams.MapGroupStageCount> list = new List<AdventureModuleLevelLoadParams.MapGroupStageCount>();
		string text = PlayerPrefs.GetString(PREFS_KEY);
		if (string.IsNullOrEmpty(text))
		{
			return list;
		}
		foreach (JsonData item in (IEnumerable)JsonMapper.ToObject(text))
		{
			list.Add(new AdventureModuleLevelLoadParams.MapGroupStageCount(item));
		}
		return list;
	}

	public static void Save(List<AdventureModuleLevelLoadParams.MapGroupStageCount> mapStageCounts)
	{
		JsonData jsonData = new JsonData();
		jsonData.SetJsonType(JsonType.Array);
		for (int i = 0; i < mapStageCounts.Count; i++)
		{
			JsonData value = mapStageCounts.get_Item(i).ToJsonData();
			jsonData.Add(value);
		}
		PlayerPrefs.SetString(PREFS_KEY, jsonData.ToJson());
	}
}
