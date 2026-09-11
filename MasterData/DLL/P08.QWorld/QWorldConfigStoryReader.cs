using System.Collections.Generic;
using UnityEngine;

public class QWorldConfigStoryReader
{
	private string m_talk_csv_path;

	private Dictionary<string, Dictionary<string, string>> table;

	private const char CSV_QOUTE = '"';

	private const char CSV_SEP = ',';

	public void ImportStoryConfig()
	{
		m_talk_csv_path = Application.dataPath + "/../../config/Source/策划数据源/系统配置/sandplay_story_talk.csv";
		List<Dictionary<string, string>> list = ConvertCsvToJson(m_talk_csv_path);
		table = new Dictionary<string, Dictionary<string, string>>();
		for (int i = 0; i < list.Count; i++)
		{
			table.Add(list[i]["talk_id"], list[i]);
		}
	}

	private static List<Dictionary<string, string>> ConvertCsvToJson(string csvFilePath)
	{
		return new List<Dictionary<string, string>>();
	}

	public Dictionary<string, string> GetConfig(string key)
	{
		if (table.ContainsKey(key))
		{
			return table[key];
		}
		return null;
	}

	private static void ParseCsvLine(string line, string[] values)
	{
		int num = 0;
		int num2 = 0;
		bool flag = false;
		for (int i = 0; i < line.Length; i++)
		{
			char num3 = line[i];
			if (num3 == '"')
			{
				flag = !flag;
			}
			if (num3 == ',' && !flag)
			{
				string text = line.Substring(num2, i - num2);
				if (text.StartsWith('"') && text.EndsWith('"'))
				{
					text = text.Substring(1, text.Length - 2);
				}
				values[num++] = text;
				num2 = i + 1;
			}
		}
		string text2 = line.Substring(num2);
		if (text2.StartsWith('"') && text2.EndsWith('"'))
		{
			text2 = text2.Substring(1, text2.Length - 2);
		}
		values[num] = text2;
	}
}
