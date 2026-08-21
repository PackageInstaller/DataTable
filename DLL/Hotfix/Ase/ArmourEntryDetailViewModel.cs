using System.Collections.Generic;

namespace Ase;

public class ArmourEntryDetailViewModel : OptionBase
{
	private List<EntryDetailItemData> entryDetailItemDataList;

	private List<ArmourBaseItemData> armourBaseItemDataList;

	public List<ArmourBaseItemData> ArmourBaseItemDataList => armourBaseItemDataList;

	public List<EntryDetailItemData> EntryDetailItemDataList => entryDetailItemDataList;

	public ArmourEntryDetailViewModel(OptionBase parent, HeroModel heroModel)
	{
		base.parent = parent;
		LoadAllEntry(heroModel);
		CreateArmourBaseItemData(heroModel);
	}

	private void LoadAllEntry(HeroModel heroModel)
	{
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		Dictionary<int, List<EntryData>> dictionary2 = new Dictionary<int, List<EntryData>>();
		heroModel.Armours.TryGetValue(5, out var value);
		int num = 0;
		if (value != null)
		{
			num = value.EntryDataList[0].DrEntry.EntryId;
		}
		foreach (KeyValuePair<int, ArmourData> armour in heroModel.Armours)
		{
			if (armour.Value == null)
			{
				continue;
			}
			if (armour.Value.ArmourEnum == ArmourEnum.Rock)
			{
				dictionary2.Add(armour.Key, armour.Value.AdditionalEntryList);
			}
			else
			{
				dictionary2.Add(armour.Key, armour.Value.GetAllEntry());
			}
			foreach (EntryData item2 in armour.Value.GetAllEntry())
			{
				if (item2.DrEntry.EntryId != num)
				{
					int entryId = item2.DrEntry.EntryId;
					int curLevel = item2.CurLevel;
					if (dictionary.ContainsKey(entryId))
					{
						dictionary[entryId] += curLevel;
					}
					else
					{
						dictionary.Add(entryId, curLevel);
					}
				}
			}
		}
		List<EntryData> list = new List<EntryData>();
		foreach (KeyValuePair<int, int> item3 in dictionary)
		{
			EntryData item = new EntryData(item3.Key, item3.Value);
			list.Add(item);
		}
		CreateEntryDetailItemDataList(list, dictionary2);
	}

	private void CreateArmourBaseItemData(HeroModel heroModel)
	{
		armourBaseItemDataList = new List<ArmourBaseItemData>();
		for (int i = 0; i < 6; i++)
		{
			ArmourBaseItemData item = ((!heroModel.Armours.ContainsKey(i) || heroModel.Armours[i] == null) ? new ArmourBaseItemData(null, isEmpty: true) : new ArmourBaseItemData(heroModel.Armours[i]));
			armourBaseItemDataList.Add(item);
		}
	}

	private void CreateEntryDetailItemDataList(List<EntryData> heroEntryDataList, Dictionary<int, List<EntryData>> armourEntryDic)
	{
		entryDetailItemDataList = new List<EntryDetailItemData>();
		foreach (EntryData heroEntryData in heroEntryDataList)
		{
			List<TabItemNormalData> list = new List<TabItemNormalData>();
			int num = 0;
			for (int i = 0; i < 6; i++)
			{
				int num2 = 0;
				if (armourEntryDic.ContainsKey(i) && armourEntryDic[i] != null)
				{
					num2 = CountEntryLevel(heroEntryData.DrEntry.EntryId, armourEntryDic[i]);
				}
				num += num2;
				string text = ((num2 > 0) ? $"{num2}" : "");
				list.Add(new TabItemNormalData(text));
			}
			EntryDetailItemData item = new EntryDetailItemData(heroEntryData, list, num);
			entryDetailItemDataList.Add(item);
		}
	}

	private int CountEntryLevel(int entryId, List<EntryData> entryDataList)
	{
		int num = 0;
		foreach (EntryData entryData in entryDataList)
		{
			if (entryData.DrEntry.EntryId == entryId)
			{
				num += entryData.CurLevel;
			}
		}
		return num;
	}
}
