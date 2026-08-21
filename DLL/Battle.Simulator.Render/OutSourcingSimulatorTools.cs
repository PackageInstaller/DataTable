using System.Collections.Generic;
using System.Text.RegularExpressions;
using NetProcol;
using UnityEngine;

public class OutSourcingSimulatorTools
{
	private static int hero_list_index;

	private static int map_index;

	private static int attribute_factor_index;

	private static int monster_level_index;

	private static int id_index;

	private static int affix_type_index;

	public const string stage_csv_path = "/../../config/Source/策划数据源/系统配置/stage.csv";

	public static RoleDataForExchangeInfo GetNetRoleDataByStandardID(int standardID, string forceMainDamageTypeStr)
	{
		RoleDataForExchangeInSimulator roleDataForExchangeInSimulator = JsonUtility.FromJson<RoleDataForExchangeInSimulator>(JsonUtility.ToJson(LuaHelper.CallFunction("OutSourcing", standardID)[0]));
		RoleDataForExchangeInfo roleDataForExchangeInfo = new RoleDataForExchangeInfo();
		roleDataForExchangeInfo.ID = roleDataForExchangeInSimulator.ID;
		roleDataForExchangeInfo.Level = roleDataForExchangeInSimulator.Level;
		roleDataForExchangeInfo.PlayerLevel = roleDataForExchangeInSimulator.playerLevel;
		if (roleDataForExchangeInSimulator.attributeID != null && roleDataForExchangeInSimulator.attributeValue != null && roleDataForExchangeInSimulator.attributeID.Length == roleDataForExchangeInSimulator.attributeValue.Length)
		{
			for (int i = 0; i < roleDataForExchangeInSimulator.attributeID.Length; i++)
			{
				roleDataForExchangeInfo.AttributeID.Add(roleDataForExchangeInSimulator.attributeID[i]);
				roleDataForExchangeInfo.AttributeValue.Add(roleDataForExchangeInSimulator.attributeValue[i]);
			}
		}
		roleDataForExchangeInfo.AttributeID.Add(2222);
		if (int.TryParse(forceMainDamageTypeStr, out var result))
		{
			roleDataForExchangeInfo.AttributeValue.Add(result);
		}
		else
		{
			roleDataForExchangeInfo.AttributeValue.Add(roleDataForExchangeInSimulator.mainDamageType);
		}
		if (roleDataForExchangeInSimulator.astrolabe != null)
		{
			int[] astrolabe = roleDataForExchangeInSimulator.astrolabe;
			foreach (int item in astrolabe)
			{
				roleDataForExchangeInfo.Astrolabe.Add(item);
			}
		}
		if (roleDataForExchangeInSimulator.equipment != null)
		{
			int[] astrolabe = roleDataForExchangeInSimulator.equipment;
			foreach (int item2 in astrolabe)
			{
				roleDataForExchangeInfo.Equipment.Add(item2);
			}
		}
		if (roleDataForExchangeInSimulator.skillLevel != null)
		{
			int[] astrolabe = roleDataForExchangeInSimulator.skillLevel;
			foreach (int item3 in astrolabe)
			{
				roleDataForExchangeInfo.SkillLevel.Add(item3);
			}
		}
		if (roleDataForExchangeInSimulator.equipSkillID != null)
		{
			int[] astrolabe = roleDataForExchangeInSimulator.equipSkillID;
			foreach (int item4 in astrolabe)
			{
				roleDataForExchangeInfo.EquipmentSkill.Add(item4);
			}
		}
		if (roleDataForExchangeInSimulator.equipSkillLv != null)
		{
			int[] astrolabe = roleDataForExchangeInSimulator.equipSkillLv;
			foreach (int item5 in astrolabe)
			{
				roleDataForExchangeInfo.EquipmentSkillLv.Add(item5);
			}
		}
		roleDataForExchangeInfo.WeaponEffectID = roleDataForExchangeInSimulator.weaponEffectID;
		roleDataForExchangeInfo.WeaponEffectLevel = roleDataForExchangeInSimulator.weaponEffectLevel;
		if (roleDataForExchangeInSimulator.AIChip != null)
		{
			int[] astrolabe = roleDataForExchangeInSimulator.AIChip;
			foreach (int item6 in astrolabe)
			{
				roleDataForExchangeInfo.AIChip.Add(item6);
			}
		}
		return roleDataForExchangeInfo;
	}

	public static int[] GetStandardStageHeroList(int standardStageID)
	{
		int[] array = null;
		List<string> standardStageData = GetStandardStageData(standardStageID);
		if (standardStageData != null)
		{
			string text = standardStageData[hero_list_index];
			if (text != "")
			{
				array = new int[3];
				string[] array2 = text.Replace("[", "").Replace("]", "").Replace("\"", "")
					.Split(",");
				for (int i = 0; i < array2.Length; i++)
				{
					if (i % 2 == 1)
					{
						int num = int.Parse(array2[i]);
						if (num == 1)
						{
							num = 0;
						}
						array[i / 2] = num;
					}
				}
			}
		}
		return array;
	}

	public static void GetStandardStageMapData(int standardStageID, out int[] monster_attribute, out int mapID, out int monsterLevel)
	{
		monster_attribute = new int[3];
		mapID = -1;
		monsterLevel = 1;
		List<string> standardStageData = GetStandardStageData(standardStageID);
		if (standardStageData == null)
		{
			return;
		}
		string text = standardStageData[attribute_factor_index];
		if (text != "")
		{
			string[] array = text.Replace("[", "").Replace("]", "").Replace("\"", "")
				.Split(",");
			for (int i = 0; i < array.Length; i++)
			{
				monster_attribute[i] = int.Parse(array[i]);
			}
		}
		mapID = int.Parse(standardStageData[map_index]);
		monsterLevel = int.Parse(standardStageData[monster_level_index]);
	}

	public static void GetStandardStageAffix(int standardStageID, out int[] affixIDList, out int[] levelIDList, out int[] targetTypeList, out int affixCount)
	{
		affixIDList = new int[5];
		levelIDList = new int[5];
		targetTypeList = new int[5];
		affixCount = 0;
		string text = GetStandardStageData(standardStageID)[affix_type_index];
		if (!(text != ""))
		{
			return;
		}
		text = text.Substring(1, text.Length - 2);
		string pattern = "\\[(?:\\d+(?:,\\d+)*)\\]";
		foreach (Match item in Regex.Matches(text, pattern))
		{
			string[] array = item.Value.Substring(1, item.Value.Length - 2).Split(",");
			affixIDList[affixCount] = int.Parse(array[0]);
			levelIDList[affixCount] = int.Parse(array[1]);
			targetTypeList[affixCount] = int.Parse(array[2]);
			affixCount++;
		}
	}

	public static List<string> GetStandardStageData(int standardStageID)
	{
		List<List<string>> oriCsvData = CsvHelperInSimulator.GetOriCsvData(Application.dataPath + "/../../config/Source/策划数据源/系统配置/stage.csv");
		hero_list_index = oriCsvData[0].IndexOf("hero_list");
		map_index = oriCsvData[0].IndexOf("map");
		attribute_factor_index = oriCsvData[0].IndexOf("attribute_factor");
		monster_level_index = oriCsvData[0].IndexOf("monster_level");
		id_index = oriCsvData[0].IndexOf("id");
		affix_type_index = oriCsvData[0].IndexOf("affix_type");
		List<string> result = null;
		for (int i = 5; i < oriCsvData.Count; i++)
		{
			List<string> list = oriCsvData[i];
			if (list != null && list.Count > hero_list_index)
			{
				string text = list[id_index];
				if (!text.Contains("#") && !string.IsNullOrEmpty(text) && !text.Contains("#") && list[id_index] != null && int.Parse(list[id_index]) == standardStageID)
				{
					result = list;
					break;
				}
			}
		}
		return result;
	}
}
