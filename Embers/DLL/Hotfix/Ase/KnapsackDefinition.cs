using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace Ase;

public static class KnapsackDefinition
{
	public enum WarehouseTabEnum
	{
		[Description("武魂")]
		Weapon = 1,
		[Description("明饰")]
		Armour,
		[Description("提箱")]
		SuitBox,
		[Description("材料")]
		Material,
		[Description("消耗")]
		Consume,
		[Description("任务")]
		Task
	}

	public enum WarehouseScreenType
	{
		[Description("稀有度排序")]
		Rarity = 1,
		[Description("等级排序")]
		Level,
		[Description("类型排序")]
		Type,
		[Description("RANK排序")]
		Rank
	}

	public enum WarehouseAutoScreenType
	{
		[Description("绿色")]
		Green = 1,
		[Description("蓝色及以下")]
		BelowBlue,
		[Description("紫色及以下")]
		BelowPurple
	}

	public enum WarehouseStateMode
	{
		Normal,
		Decompose
	}

	public enum PropOperationMode
	{
		[Description("合成")]
		Compose = 1,
		[Description("拆解")]
		Decompose
	}

	public static List<PropData> GetWeaponDecomposeProducts(List<WeaponData> weapons)
	{
		int num = 0;
		foreach (WeaponData weapon in weapons)
		{
			num += GameEntry.DataTable.GetDataTable<DRWeaponGrade>().GetDataRow((DRWeaponGrade p) => p.Quality == weapon.Rarity && p.TargetLevel == weapon.Level)?.DevourExp ?? 0;
		}
		return GetDecomposeProductsByUseType(3, num);
	}

	public static List<PropData> GetArmourDecomposeProducts(List<ArmourData> armours)
	{
		int num = 0;
		foreach (ArmourData armour in armours)
		{
			num += GameEntry.DataTable.GetDataTable<DREquipGrade>().GetDataRow((DREquipGrade p) => p.Quality == armour.Rarity && p.TargetLevel == armour.Level && p.Rank == armour.Rank)?.DevourExp ?? 0;
		}
		return GetDecomposeProductsByUseType(2, num);
	}

	public static List<PropData> GetSuitBoxDecomposeProducts(List<ArmourData> suitBoxes)
	{
		List<PropData> list = new List<PropData>();
		foreach (ArmourData suitBox in suitBoxes)
		{
			DRSuitboxDecompose dataRow = GameEntry.DataTable.GetDataTable<DRSuitboxDecompose>().GetDataRow((DRSuitboxDecompose p) => p.Rarity == suitBox.Rarity && p.Rank == suitBox.Rank);
			if (dataRow == null)
			{
				continue;
			}
			for (int num = 0; num < dataRow.Item.Count && dataRow.Num.Count > num; num++)
			{
				DRProp dataRow2 = GameEntry.DataTable.GetDataTable<DRProp>().GetDataRow(dataRow.Item[num]);
				if (dataRow2 != null)
				{
					list.Attach(dataRow2.Id, dataRow.Num[num]);
				}
			}
			int num2 = suitBox.AdditionalEntryList?.Count ?? 0;
			if ((float)num2 * dataRow.Recovery >= 1f)
			{
				int amount = (int)Math.Floor((float)num2 * dataRow.Recovery);
				DRProp dataRow3 = GameEntry.DataTable.GetDataTable<DRProp>().GetDataRow(dataRow.RecoveryItem);
				list.Attach(dataRow3, amount);
			}
		}
		return list;
	}

	public static List<PropData> GetPropDecomposeProducts(List<int> propIds, List<int> propCounts)
	{
		List<PropData> list = new List<PropData>();
		if (propIds == null || propIds.Count <= 0 || propCounts == null || propCounts.Count <= 0)
		{
			return list;
		}
		for (int i = 0; i < propIds.Count && propCounts.Count > i; i++)
		{
			DRDecompose dataRow = GameEntry.DataTable.GetDataTable<DRDecompose>().GetDataRow(propIds[i]);
			if (dataRow != null)
			{
				for (int j = 0; j < dataRow.ProductID.Count && dataRow.ProductNum.Count > j; j++)
				{
					int amount = dataRow.ProductNum[j] * propCounts[i];
					list.Attach(dataRow.ProductID[j], amount);
				}
			}
		}
		return list;
	}

	public static List<PropData> GetDecomposeProductsByUseType(int useType, int devourExp)
	{
		List<PropData> list = new List<PropData>();
		List<DRProp> list2 = GameEntry.DataTable.GetDataTable<DRProp>().GetDataRows((DRProp p) => p.UseType.Contains(useType)).ToList();
		if (list2 == null)
		{
			return list;
		}
		list2.Sort((DRProp x, DRProp y) => -x.EX1.CompareTo(y.EX1));
		for (int num = 0; num < list2.Count; num++)
		{
			if (devourExp <= 0)
			{
				break;
			}
			int num2 = devourExp / list2[num].EX1;
			devourExp -= list2[num].EX1 * num2;
			list.Add(new PropData(list2[num], num2));
		}
		return list;
	}
}
