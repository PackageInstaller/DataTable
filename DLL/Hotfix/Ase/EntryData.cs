#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;

namespace Ase;

public class EntryData : NumericalBase
{
	private DREntry _drEntry;

	public bool IsRealData = true;

	private string name;

	private int maxLevel;

	private string iconPath;

	private int curLevel;

	private bool isSpecial;

	private bool isFixed;

	public int MaxLevel => maxLevel;

	public int CurLevel => curLevel;

	public string IconPath => iconPath;

	public DREntry DrEntry
	{
		get
		{
			return _drEntry;
		}
		private set
		{
			Set(ref _drEntry, value, "DrEntry");
			Name = value?.Name;
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public bool IsSpecial
	{
		get
		{
			return isSpecial;
		}
		set
		{
			Set(ref isSpecial, value, "IsSpecial");
		}
	}

	public bool IsFixed
	{
		get
		{
			return isFixed;
		}
		set
		{
			Set(ref isFixed, value, "IsFixed");
		}
	}

	public EntryData(int entryId, int level)
	{
		if (entryId == 0)
		{
			SetEmptyEntry();
			return;
		}
		curLevel = level;
		SetEntryData(entryId, level);
	}

	public EntryData(DREntry drEntry)
	{
		SetEntryData(drEntry);
		curLevel = drEntry.Level;
	}

	private void SetEntryData(int entryId, int level)
	{
		try
		{
			DREntry[] dataRows = GameEntry.DataTable.GetDataTable<DREntry>().GetDataRows((DREntry p) => p.EntryId == entryId);
			DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(Constant.ConstantConfig.MaxEntryLevel);
			int num = 9;
			if (dataRow != null)
			{
				num = (int)dataRow.Value;
			}
			if (dataRows != null && dataRows.Length > 0)
			{
				int num2;
				if (dataRows[dataRows.Length - 1].Level > num)
				{
					num2 = num;
				}
				else
				{
					num2 = dataRows[dataRows.Length - 1].Level;
				}
				maxLevel = num2;
			}
			level = ((level > maxLevel) ? maxLevel : level);
			DREntry dataRow2 = GameEntry.DataTable.GetDataTable<DREntry>().GetDataRow((DREntry p) => p.EntryId == entryId && p.Level == level);
			if (dataRow2 == null)
			{
				Log.Error($"词条Id:{entryId}--{level}配置错误");
				IsRealData = false;
			}
			else
			{
				IsSpecial = dataRow2.SpecialEntry == 1;
				SetEntryData(dataRow2);
			}
		}
		catch (Exception ex)
		{
			Log.Error("添加明饰数据错误，发生异常！" + ex.Message + " / " + ex.StackTrace);
			throw;
		}
	}

	private void SetEntryData(DREntry drEntry)
	{
		if (drEntry == null)
		{
			Toast.ShowError("DREntry数据为空");
			IsRealData = false;
			return;
		}
		DrEntry = drEntry;
		DRAttributeTotal dataRow = GameEntry.DataTable.GetDataTable<DRAttributeTotal>().GetDataRow((DRAttributeTotal p) => p.Uid == drEntry.EntryId);
		if (dataRow != null)
		{
			iconPath = dataRow.EntryIcon;
		}
		else
		{
			Toast.ShowInfo($"{DrEntry.EntryId}词条的图标未找到!");
		}
		UpdateProperty();
	}

	private void SetEmptyEntry()
	{
		IsRealData = false;
		iconPath = "empty";
		maxLevel = 0;
		curLevel = 0;
	}

	private void UpdateProperty()
	{
		numericalProperty.Clear();
		if (DrEntry.EntryType != 1)
		{
			return;
		}
		for (int i = 0; i < DrEntry.EntryKey.Count && DrEntry.EntryValue.Count > i; i++)
		{
			DRAffix dataRow = GameEntry.DataTable.GetDataRow<DRAffix>(DrEntry.EntryKey[i]);
			if (dataRow != null)
			{
				numericalProperty.AddProperty(dataRow.AffixKey, DrEntry.EntryValue[i]);
			}
		}
	}

	public EntryData(EntryData entryData)
	{
		_drEntry = entryData.DrEntry;
		IsRealData = entryData.IsRealData;
		maxLevel = entryData.MaxLevel;
		iconPath = entryData.IconPath;
		curLevel = entryData.CurLevel;
		UpdateProperty();
	}
}
