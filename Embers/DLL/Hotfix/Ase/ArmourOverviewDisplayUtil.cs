using System.Collections.Generic;

namespace Ase;

public static class ArmourOverviewDisplayUtil
{
	private const string FixHpKey = "FixHp";

	private const string FixDefenceKey = "FixDefence";

	private const string FixAttackKey = "FixAttack";

	public static List<AttributeItemData> BuildAttributeItems(Dictionary<int, ArmourData> armours, bool addCharacter = true)
	{
		return BuildAttributeItems(CollectAttributeValues(armours), addCharacter);
	}

	public static List<StatusAttrItemViewModel> BuildStatusAttrItems(List<ArmourData> armours)
	{
		return BuildStatusAttrItems(CollectAttributeValues(armours));
	}

	public static List<EntryLevelItemData> BuildEntryItems(OptionBase parent, Dictionary<int, ArmourData> armours)
	{
		ArmourData armour = GetArmour(armours, 5);
		List<EntryData> list = new List<EntryData>();
		if (armours != null)
		{
			foreach (KeyValuePair<int, ArmourData> armour2 in armours)
			{
				if (armour2.Value != null)
				{
					list.AddRange(armour2.Value.GetAllEntry());
				}
			}
		}
		return BuildEntryItems(parent, armour, list);
	}

	public static List<EntryLevelItemData> BuildEntryItems(OptionBase parent, List<ArmourData> armours)
	{
		ArmourData suitBoxData = null;
		List<EntryData> list = new List<EntryData>();
		if (armours != null)
		{
			for (int i = 0; i < armours.Count; i++)
			{
				ArmourData armourData = armours[i];
				if (armourData != null)
				{
					if (armourData.ArmourEnum == ArmourEnum.Rock)
					{
						suitBoxData = armourData;
					}
					list.AddRange(armourData.GetAllEntry());
				}
			}
		}
		return BuildEntryItems(parent, suitBoxData, list);
	}

	public static int CompareEntryItems(EntryLevelItemData x, EntryLevelItemData y)
	{
		if (x == null || y == null)
		{
			if (x != null)
			{
				return -1;
			}
			if (y != null)
			{
				return 1;
			}
			return 0;
		}
		if (x.ShowLevel.CompareTo(y.ShowLevel) != 0)
		{
			return x.ShowLevel.CompareTo(y.ShowLevel);
		}
		if (x.EntryData.IsSpecial.CompareTo(y.EntryData.IsSpecial) != 0)
		{
			return y.EntryData.IsSpecial.CompareTo(x.EntryData.IsSpecial);
		}
		if (x.IsMax.CompareTo(y.IsMax) != 0)
		{
			return y.IsMax.CompareTo(x.IsMax);
		}
		return y.CurLevel.CompareTo(x.CurLevel);
	}

	private static List<AttributeItemData> BuildAttributeItems(Dictionary<string, float> attributeValues, bool addCharacter)
	{
		List<AttributeItemData> list = new List<AttributeItemData>();
		AddFixedAttributeItem(list, attributeValues, "FixHp", addCharacter);
		AddFixedAttributeItem(list, attributeValues, "FixDefence", addCharacter);
		AddFixedAttributeItem(list, attributeValues, "FixAttack", addCharacter);
		List<AttributeItemData> list2 = new List<AttributeItemData>();
		foreach (KeyValuePair<string, float> attributeValue in attributeValues)
		{
			if (!IsFixedAttribute(attributeValue.Key))
			{
				DRAffix drAffix = GetDrAffix(attributeValue.Key);
				if (drAffix != null)
				{
					list2.Add(new AttributeItemData(new EquipAttribute(drAffix, attributeValue.Value), addCharacter));
				}
			}
		}
		list2.Sort((AttributeItemData x, AttributeItemData y) => x.AttributeId.CompareTo(y.AttributeId));
		list.AddRange(list2);
		return list;
	}

	private static List<StatusAttrItemViewModel> BuildStatusAttrItems(Dictionary<string, float> attributeValues)
	{
		List<StatusAttrItemViewModel> list = new List<StatusAttrItemViewModel>();
		List<AttributeItemData> list2 = BuildAttributeItems(attributeValues, addCharacter: false);
		for (int i = 0; i < list2.Count; i++)
		{
			AttributeItemData attributeItemData = list2[i];
			list.Add(StatusAttrItemViewModel.CreateBasic(attributeItemData.AttributeName, attributeItemData.ShowValue, attributeItemData.IconPath, i));
		}
		return list;
	}

	private static void AddFixedAttributeItem(List<AttributeItemData> result, Dictionary<string, float> attributeValues, string affixKey, bool addCharacter)
	{
		attributeValues.TryGetValue(affixKey, out var value);
		DRAffix drAffix = GetDrAffix(affixKey);
		if (drAffix != null)
		{
			result.Add(new AttributeItemData(new EquipAttribute(drAffix, value), addCharacter));
		}
	}

	private static Dictionary<string, float> CollectAttributeValues(Dictionary<int, ArmourData> armours)
	{
		List<ArmourData> list = new List<ArmourData>();
		if (armours != null)
		{
			foreach (KeyValuePair<int, ArmourData> armour in armours)
			{
				list.Add(armour.Value);
			}
		}
		return CollectAttributeValues(list);
	}

	private static Dictionary<string, float> CollectAttributeValues(List<ArmourData> armours)
	{
		Dictionary<string, float> dictionary = new Dictionary<string, float>();
		if (armours == null)
		{
			return dictionary;
		}
		for (int i = 0; i < armours.Count; i++)
		{
			ArmourData armourData = armours[i];
			if (armourData?.EquipAttributeList == null)
			{
				continue;
			}
			for (int j = 0; j < armourData.EquipAttributeList.Count; j++)
			{
				EquipAttribute equipAttribute = armourData.EquipAttributeList[j];
				if (equipAttribute != null && !string.IsNullOrEmpty(equipAttribute.AffixKey))
				{
					if (dictionary.ContainsKey(equipAttribute.AffixKey))
					{
						dictionary[equipAttribute.AffixKey] += equipAttribute.BaseValue;
					}
					else
					{
						dictionary.Add(equipAttribute.AffixKey, equipAttribute.BaseValue);
					}
				}
			}
		}
		return dictionary;
	}

	private static List<EntryLevelItemData> BuildEntryItems(OptionBase parent, ArmourData suitBoxData, List<EntryData> entries)
	{
		List<EntryLevelItemData> list = new List<EntryLevelItemData>();
		EntryData mainEntry = GetMainEntry(suitBoxData);
		int num = mainEntry?.DrEntry.EntryId ?? 0;
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		if (num != 0)
		{
			dictionary.Add(num, mainEntry.CurLevel);
		}
		if (entries != null)
		{
			for (int i = 0; i < entries.Count; i++)
			{
				EntryData entryData = entries[i];
				if (entryData?.DrEntry == null)
				{
					continue;
				}
				int entryId = entryData.DrEntry.EntryId;
				if (entryId != num)
				{
					if (dictionary.ContainsKey(entryId))
					{
						dictionary[entryId] += entryData.CurLevel;
					}
					else
					{
						dictionary.Add(entryId, entryData.CurLevel);
					}
				}
			}
		}
		foreach (KeyValuePair<int, int> item in dictionary)
		{
			EntryData entryData2 = new EntryData(item.Key, item.Value);
			bool showLevel = item.Key != num;
			list.Add(new EntryLevelItemData(parent, entryData2, item.Value, showLevel));
		}
		list.Sort(CompareEntryItems);
		return list;
	}

	private static EntryData GetMainEntry(ArmourData suitBoxData)
	{
		if (suitBoxData?.EntryDataList == null || suitBoxData.EntryDataList.Count == 0)
		{
			return null;
		}
		if (suitBoxData.EntryDataList[0]?.DrEntry != null)
		{
			return suitBoxData.EntryDataList[0];
		}
		return null;
	}

	private static ArmourData GetArmour(Dictionary<int, ArmourData> armours, int position)
	{
		if (armours == null)
		{
			return null;
		}
		armours.TryGetValue(position, out var value);
		return value;
	}

	private static bool IsFixedAttribute(string affixKey)
	{
		if (!"FixHp".Equals(affixKey) && !"FixDefence".Equals(affixKey))
		{
			return "FixAttack".Equals(affixKey);
		}
		return true;
	}

	private static DRAffix GetDrAffix(string affixKey)
	{
		if (string.IsNullOrEmpty(affixKey))
		{
			return null;
		}
		return GameEntry.DataTable.GetDataTable<DRAffix>().GetDataRow((DRAffix p) => p.AffixKey.Equals(affixKey));
	}
}
