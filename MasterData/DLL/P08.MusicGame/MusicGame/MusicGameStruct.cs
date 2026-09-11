using System.Collections.Generic;
using LitJson;

namespace MusicGame;

public struct MusicGameStruct
{
	public List<List<List<int>>> trackList;

	public List<List<double>> timing;

	public List<List<int>> specialEffectList;

	public int GetTrackNum()
	{
		int num = 0;
		foreach (List<List<int>> track in trackList)
		{
			if (track != null && track.Count > 0)
			{
				num++;
			}
		}
		return num;
	}

	public static MusicGameStruct LoadFromFile(string path)
	{
		MusicGameStruct result = default(MusicGameStruct);
		IDictionary<string, JsonData> dictionary = JsonMapper.ToObject(AssetEx.LoadText(path)).toDict();
		if (dictionary.ContainsKey("timing"))
		{
			IList<JsonData> list = dictionary["timing"].toArray();
			result.timing = new List<List<double>>(list.Count);
			for (int i = 0; i < list.Count; i++)
			{
				IList<JsonData> list2 = list[i].toArray();
				result.timing.Add(new List<double>());
				for (int j = 0; j < list2.Count; j++)
				{
					double item = double.Parse(list2[j].ToString());
					result.timing[i].Add(item);
				}
			}
		}
		else
		{
			result.timing = new List<List<double>>(1);
			for (int k = 0; k < 1; k++)
			{
				result.timing.Add(new List<double>());
				result.timing[k].Add(0.0);
				result.timing[k].Add(1.0);
			}
		}
		if (result.specialEffectList == null)
		{
			result.specialEffectList = new List<List<int>>();
		}
		result.specialEffectList.Clear();
		if (dictionary.ContainsKey("specialEffect"))
		{
			IList<JsonData> list3 = dictionary["specialEffect"].toArray();
			for (int l = 0; l < list3.Count; l++)
			{
				result.specialEffectList.Add(new List<int>());
				IList<JsonData> list4 = list3[l].toArray();
				for (int m = 0; m < list4.Count; m++)
				{
					int item2 = int.Parse(list4[m].ToString());
					result.specialEffectList[l].Add(item2);
				}
			}
		}
		if (result.trackList == null)
		{
			result.trackList = new List<List<List<int>>>();
		}
		result.trackList.Clear();
		string text = "track";
		for (int n = 1; n <= 8; n++)
		{
			string key = text + n;
			if (!dictionary.ContainsKey(key))
			{
				continue;
			}
			IList<JsonData> list5 = dictionary[key].toArray();
			List<List<int>> list6 = new List<List<int>>();
			for (int num = 0; num < list5.Count; num++)
			{
				IList<JsonData> list7 = list5[num].toArray();
				list6.Add(new List<int>());
				for (int num2 = 0; num2 < list7.Count; num2++)
				{
					int item3 = int.Parse(list7[num2].ToString());
					list6[num].Add(item3);
				}
			}
			result.trackList.Add(list6);
		}
		return result;
	}
}
