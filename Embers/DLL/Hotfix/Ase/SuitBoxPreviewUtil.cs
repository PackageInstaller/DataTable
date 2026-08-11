using System;
using System.Linq;

namespace Ase;

public static class SuitBoxPreviewUtil
{
	public static void FillPreviewEntriesIfEmpty(ArmourData armourData)
	{
		if (armourData == null || armourData.EquipmentEnum != EquipmentEnum.SuitBox || (armourData.EntryDataList != null && armourData.EntryDataList.Count > 0))
		{
			return;
		}
		DRSuitbox drSuitbox = GameEntry.DataTable.GetDataRow<DRSuitbox>(armourData.Id);
		if (drSuitbox == null)
		{
			return;
		}
		DRSuitboxMainStore[] dataRows = GameEntry.DataTable.GetDataRows((DRSuitboxMainStore p) => p.StoreId == drSuitbox.BuffPool);
		if (dataRows == null || dataRows.Length == 0)
		{
			dataRows = GameEntry.DataTable.GetDataRows((DRSuitboxMainStore p) => p.StoreId == drSuitbox.EntryPool);
		}
		DRSuitboxMainStore dRSuitboxMainStore = dataRows?.OrderByDescending((DRSuitboxMainStore p) => p.EntryRate).FirstOrDefault();
		if (dRSuitboxMainStore != null)
		{
			EntryData entryData = new EntryData(dRSuitboxMainStore.EntryId, dRSuitboxMainStore.EntryLv)
			{
				IsFixed = true
			};
			if (entryData.IsRealData)
			{
				armourData.EntryDataList.Add(entryData);
			}
		}
		if (armourData.AdditionalEntryList == null || armourData.AdditionalEntryList.Count > 0)
		{
			return;
		}
		DRSuitboxEntryStore[] dataRows2 = GameEntry.DataTable.GetDataRows((DRSuitboxEntryStore p) => p.StoreId == drSuitbox.EntryPool);
		if (dataRows2 == null || dataRows2.Length == 0)
		{
			return;
		}
		int val = Math.Max(0, drSuitbox.InitialNum - (armourData.EntryDataList?.Count ?? 0));
		val = Math.Min(val, 3);
		if (val <= 0)
		{
			return;
		}
		foreach (DRSuitboxEntryStore item in dataRows2.OrderByDescending((DRSuitboxEntryStore p) => p.EntryRate).Take(val))
		{
			EntryData entryData2 = new EntryData(item.EntryId, item.EntryLv);
			if (entryData2.IsRealData)
			{
				armourData.AdditionalEntryList.Add(entryData2);
			}
		}
	}
}
