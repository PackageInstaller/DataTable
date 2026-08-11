using System.Collections.Generic;
using Ase;

public static class PropExtension
{
	public static List<PropDataBase> Attach(List<PropDataBase> rawProps, PropDataBase newProp)
	{
		PropDataBase propDataBase = rawProps.FindLast((PropDataBase p) => p.Id == newProp.Id);
		if (propDataBase != null)
		{
			propDataBase.Amount += newProp.Amount;
		}
		else
		{
			rawProps.Add(newProp);
		}
		return rawProps;
	}

	public static List<PropData> Attach(this List<PropData> rawProps, int id, int amount)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataTable<DRProp>().GetDataRow(id);
		if (dataRow != null)
		{
			return rawProps.Attach(dataRow, amount);
		}
		return rawProps;
	}

	public static List<PropData> Attach(this List<PropData> rawProps, DRProp drProp, int amount)
	{
		PropData propData = rawProps.FindLast((PropData p) => p.Id == drProp.Id);
		if (propData != null)
		{
			propData.Amount += amount;
		}
		else
		{
			rawProps.Add(new PropData(drProp, amount));
		}
		return rawProps;
	}

	public static List<PropData> Attach(this List<PropData> rawProps, PropData newProp)
	{
		PropData propData = rawProps.FindLast((PropData p) => p.Id == newProp.Id);
		if (propData != null)
		{
			propData.Amount += newProp.Amount;
		}
		else
		{
			rawProps.Add(newProp);
		}
		return rawProps;
	}

	public static List<PropData> Attach(this List<PropData> rawProps, List<PropData> newProps)
	{
		if (newProps != null)
		{
			foreach (PropData newProp in newProps)
			{
				rawProps.Attach(newProp);
			}
		}
		return rawProps;
	}

	public static List<PropData> ClearZeroAmount(this List<PropData> rawProps)
	{
		rawProps.RemoveAll((PropData p) => p.Amount == 0);
		return rawProps;
	}
}
