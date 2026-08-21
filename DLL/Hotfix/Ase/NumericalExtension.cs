using System;
using System.Collections.Generic;
using System.Globalization;

namespace Ase;

public static class NumericalExtension
{
	public static string GetOuterDisplayValue(double rawValue)
	{
		return Math.Ceiling(rawValue).ToString(CultureInfo.CurrentCulture);
	}

	public static string GetOuterDisplayPercentValue(double rawValue)
	{
		decimal num = Math.Ceiling((decimal)rawValue * 10000m) / 100m;
		return $"{num:N2}%";
	}

	public static string GetOuterDisplayPercentValue(float rawValue)
	{
		decimal num = Math.Ceiling((decimal)rawValue * 10000m) / 100m;
		return $"{num:N2}%";
	}

	public static NumericalProperty Attach(NumericalBase owner, List<EntryData> entryList)
	{
		NumericalProperty numericalProperty = new NumericalProperty(owner);
		if (entryList != null)
		{
			foreach (EntryData entry in entryList)
			{
				numericalProperty.Attach(entry.NumericalProperty);
			}
		}
		return numericalProperty;
	}

	public static List<EntryData> Attach(this List<EntryData> list1, List<EntryData> list2)
	{
		List<EntryData> list3 = new List<EntryData>();
		if (list1 != null)
		{
			foreach (EntryData entry in list1)
			{
				if (entry.DrEntry != null)
				{
					int num = list3.FindIndex((EntryData p) => p.DrEntry.EntryId.Equals(entry.DrEntry.EntryId));
					if (num < 0)
					{
						list3.Add(entry);
					}
					else
					{
						list3[num] = new EntryData(entry.DrEntry.EntryId, list3[num].CurLevel + entry.CurLevel);
					}
				}
			}
		}
		if (list2 != null)
		{
			foreach (EntryData entry2 in list2)
			{
				if (entry2.DrEntry != null)
				{
					int num2 = list3.FindIndex((EntryData p) => p.DrEntry.EntryId.Equals(entry2.DrEntry.EntryId));
					if (num2 < 0)
					{
						list3.Add(entry2);
					}
					else
					{
						list3[num2] = new EntryData(entry2.DrEntry.EntryId, list3[num2].CurLevel + entry2.CurLevel);
					}
				}
			}
		}
		return list3;
	}

	public static List<DREntry> GetAllBuff(this List<EntryData> entryList)
	{
		List<DREntry> list = new List<DREntry>();
		if (entryList != null)
		{
			foreach (EntryData entry in entryList)
			{
				if (entry.DrEntry.EntryType == 3)
				{
					list.Add(entry.DrEntry);
				}
			}
		}
		return list;
	}
}
