namespace Ase;

public static class EquipmentFilterDefinition
{
	public static bool ContainsScene(DREquipmentFilterType filterType, EquipmentFilterScene scene)
	{
		if (filterType == null)
		{
			return false;
		}
		return filterType.FilterScene?.Contains((int)scene) ?? false;
	}

	public static EquipmentFilterScene GetWarehouseScene(EquipmentEnum equipmentEnum)
	{
		if (equipmentEnum != EquipmentEnum.SuitBox)
		{
			return EquipmentFilterScene.WarehouseArmour;
		}
		return EquipmentFilterScene.WarehouseSuitBox;
	}

	public static EquipmentFilterLogic GetFilterLogic(DREquipmentFilterType filterType)
	{
		if (filterType == null)
		{
			return EquipmentFilterLogic.None;
		}
		if (filterType.FilterLogic > 0)
		{
			return (EquipmentFilterLogic)filterType.FilterLogic;
		}
		return GetDefaultFilterLogic(filterType.Id);
	}

	public static EquipmentFilterLogic GetDefaultFilterLogic(int filterTypeId)
	{
		return filterTypeId switch
		{
			1 => EquipmentFilterLogic.Rarity, 
			2 => EquipmentFilterLogic.Rank, 
			3 => EquipmentFilterLogic.Part, 
			4 => EquipmentFilterLogic.MainAttribute, 
			5 => EquipmentFilterLogic.SubAttribute, 
			6 => EquipmentFilterLogic.FixedEntry, 
			7 => EquipmentFilterLogic.OtherEntry, 
			_ => EquipmentFilterLogic.None, 
		};
	}

	public static bool IsEntryFilterLogic(EquipmentFilterLogic filterLogic)
	{
		if (filterLogic != EquipmentFilterLogic.FixedEntry && filterLogic != EquipmentFilterLogic.OtherEntry)
		{
			return filterLogic == EquipmentFilterLogic.MainEntry;
		}
		return true;
	}
}
