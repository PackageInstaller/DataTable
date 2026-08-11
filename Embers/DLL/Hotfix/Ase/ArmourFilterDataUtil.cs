using System.Collections.Generic;

namespace Ase;

public static class ArmourFilterDataUtil
{
	public static List<KnapsackItemViewModel> BuildArmourItemsForDecomposeWindow(OptionBase parent, out bool hasDecomposeable, KnapsackDefinition.WarehouseScreenType screenType = KnapsackDefinition.WarehouseScreenType.Rarity, List<long> blockList = null, EquipmentEnum equipmentEnum = EquipmentEnum.Armour)
	{
		hasDecomposeable = false;
		List<KnapsackItemViewModel> list = new List<KnapsackItemViewModel>();
		Dictionary<long, ArmourData> dictionary = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>()?.GetAllArmourData();
		if (dictionary == null)
		{
			return list;
		}
		List<ArmourData> list2 = new List<ArmourData>();
		foreach (ArmourData value in dictionary.Values)
		{
			if (value != null && value.EquipmentEnum == equipmentEnum)
			{
				list2.Add(value);
			}
		}
		list2.Sort((ArmourData x, ArmourData y) => CompareEquipment(x, y, screenType, isDecomposing: true, equipmentEnum));
		for (int num = 0; num < list2.Count; num++)
		{
			ArmourData armourData = list2[num];
			if (blockList == null || !blockList.Contains(armourData.Uid))
			{
				int ownerId = armourData.GetOwnerId();
				bool flag = armourData.CanDecompose();
				ArmourItemData armourItemData = new ArmourItemData(parent, armourData, ownerId, flag);
				armourItemData.IsActive = flag;
				list.Add(armourItemData);
				if (flag)
				{
					hasDecomposeable = true;
				}
			}
		}
		return list;
	}

	public static int CompareEquipment(ArmourData equipX, ArmourData equipY, KnapsackDefinition.WarehouseScreenType screenType, bool isDecomposing, EquipmentEnum equipmentEnum)
	{
		int xCanSelect = 0;
		int yCanSelect = 0;
		if (isDecomposing)
		{
			xCanSelect = (equipX.CanDecompose() ? 1 : (-1));
			yCanSelect = (equipY.CanDecompose() ? 1 : (-1));
		}
		int xEquiped = ((equipX.GetOwnerId() > 0) ? 1 : (-1));
		int yEquiped = ((equipY.GetOwnerId() > 0) ? 1 : (-1));
		if (equipmentEnum == EquipmentEnum.SuitBox)
		{
			return CompareSuitBox(equipX, equipY, screenType, xCanSelect, yCanSelect, xEquiped, yEquiped);
		}
		return CompareArmour(equipX, equipY, screenType, xCanSelect, yCanSelect, xEquiped, yEquiped);
	}

	public static int CompareArmourItems(ArmourItemData x, ArmourItemData y, KnapsackDefinition.WarehouseScreenType screenType, bool compareScreenResult)
	{
		if (compareScreenResult)
		{
			int num = y.ConditionCount.CompareTo(x.ConditionCount);
			if (num != 0)
			{
				return num;
			}
			num = y.Flag.CompareTo(x.Flag);
			if (num != 0)
			{
				return num;
			}
		}
		if (x.Data.EquipmentEnum == EquipmentEnum.SuitBox && y.Data.EquipmentEnum == EquipmentEnum.SuitBox)
		{
			int num2 = CompareSuitBox(x.Data, y.Data, screenType, 0, 0, 0, 0);
			if (num2 == 0)
			{
				return CompareOwnerAndUid(x, y);
			}
			return num2;
		}
		int num3 = CompareArmour(x.Data, y.Data, screenType, 0, 0, 0, 0);
		if (num3 == 0)
		{
			return CompareOwnerAndUid(x, y);
		}
		return num3;
	}

	private static int CompareArmour(ArmourData equipX, ArmourData equipY, KnapsackDefinition.WarehouseScreenType screenType, int xCanSelect, int yCanSelect, int xEquiped, int yEquiped)
	{
		int num = 0;
		switch (screenType)
		{
		case KnapsackDefinition.WarehouseScreenType.Rarity:
			num = CompareDesc(equipX.Rarity, equipY.Rarity);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			num = CompareDesc(equipX.Rank, equipY.Rank);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			num = CompareDesc(equipX.Level, equipY.Level);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			break;
		case KnapsackDefinition.WarehouseScreenType.Level:
			num = CompareDesc(equipX.Level, equipY.Level);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			num = CompareDesc(equipX.Rarity, equipY.Rarity);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			num = CompareDesc(equipX.Rank, equipY.Rank);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			break;
		case KnapsackDefinition.WarehouseScreenType.Rank:
			num = CompareDesc(equipX.Rank, equipY.Rank);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			num = CompareDesc(equipX.Rarity, equipY.Rarity);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			num = CompareDesc(equipX.Level, equipY.Level);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			break;
		}
		num = ApplyPrefixSort(0, xCanSelect, yCanSelect, xEquiped, yEquiped);
		if (num != 0)
		{
			return num;
		}
		num = CompareAsc((int)equipX.ArmourEnum, (int)equipY.ArmourEnum);
		if (num != 0)
		{
			return num;
		}
		num = CompareAsc(GetArmourFixedEntryId(equipX), GetArmourFixedEntryId(equipY));
		if (num != 0)
		{
			return num;
		}
		num = CompareAsc(equipX.Id, equipY.Id);
		if (num != 0)
		{
			return num;
		}
		num = CompareDesc(GetAdditionalEntryCount(equipX), GetAdditionalEntryCount(equipY));
		if (num == 0)
		{
			return equipX.Uid.CompareTo(equipY.Uid);
		}
		return num;
	}

	private static int CompareSuitBox(ArmourData equipX, ArmourData equipY, KnapsackDefinition.WarehouseScreenType screenType, int xCanSelect, int yCanSelect, int xEquiped, int yEquiped)
	{
		int num = 0;
		if (screenType == KnapsackDefinition.WarehouseScreenType.Rank)
		{
			num = CompareDesc(equipX.Rank, equipY.Rank);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			num = CompareDesc(equipX.Rarity, equipY.Rarity);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
		}
		else
		{
			num = CompareDesc(equipX.Rarity, equipY.Rarity);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
			num = CompareDesc(equipX.Rank, equipY.Rank);
			if (num != 0)
			{
				return ApplyPrefixSort(num, xCanSelect, yCanSelect, xEquiped, yEquiped);
			}
		}
		num = ApplyPrefixSort(0, xCanSelect, yCanSelect, xEquiped, yEquiped);
		if (num != 0)
		{
			return num;
		}
		num = CompareSuitBoxEntryCountAndMainEntry(equipX, equipY);
		if (num == 0)
		{
			return equipX.Uid.CompareTo(equipY.Uid);
		}
		return num;
	}

	public static int CompareSuitBoxEntryCountAndMainEntry(ArmourData equipX, ArmourData equipY)
	{
		int additionalEntryCount = GetAdditionalEntryCount(equipX);
		int num = GetAdditionalEntryCount(equipY).CompareTo(additionalEntryCount);
		if (num != 0)
		{
			return num;
		}
		return GetSuitBoxMainEntryId(equipX).CompareTo(GetSuitBoxMainEntryId(equipY));
	}

	private static int GetSuitBoxMainEntryId(ArmourData suitBox)
	{
		if (suitBox?.EntryDataList == null || suitBox.EntryDataList.Count <= 0)
		{
			return 0;
		}
		return (suitBox.EntryDataList[0]?.DrEntry?.EntryId).GetValueOrDefault();
	}

	private static int GetArmourFixedEntryId(ArmourData armour)
	{
		if (armour?.EntryDataList == null || armour.EntryDataList.Count <= 0)
		{
			return 0;
		}
		return (armour.EntryDataList[0]?.DrEntry?.EntryId).GetValueOrDefault();
	}

	private static int GetAdditionalEntryCount(ArmourData armour)
	{
		if (armour?.AdditionalEntryList == null)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < armour.AdditionalEntryList.Count; i++)
		{
			EntryData entryData = armour.AdditionalEntryList[i];
			if (entryData != null && entryData.IsRealData && entryData.DrEntry != null)
			{
				num++;
			}
		}
		return num;
	}

	private static int CompareOwnerAndUid(ArmourItemData x, ArmourItemData y)
	{
		int num = y.OwnerId.CompareTo(x.OwnerId);
		if (num != 0)
		{
			return num;
		}
		return y.Data.Uid.CompareTo(x.Data.Uid);
	}

	private static int ApplyPrefixSort(int result, int xCanSelect, int yCanSelect, int xEquiped, int yEquiped)
	{
		int num = CompareDesc(xCanSelect, yCanSelect);
		if (num != 0)
		{
			return num;
		}
		num = CompareDesc(xEquiped, yEquiped);
		if (num == 0)
		{
			return result;
		}
		return num;
	}

	private static int CompareDesc(int x, int y)
	{
		return y.CompareTo(x);
	}

	private static int CompareAsc(int x, int y)
	{
		return x.CompareTo(y);
	}
}
