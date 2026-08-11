namespace Ase;

public class RockDevelopEntryItemData : OptionBase
{
	private EntryData entryData;

	private string entryName;

	private string entryLevel;

	private string entryIcon;

	private bool isNewEntry;

	private int oldLevel;

	private int newLevel;

	private bool isDismiss;

	private bool isMainEntry;

	public string EntryName
	{
		get
		{
			return entryName;
		}
		private set
		{
			Set(ref entryName, value, "EntryName");
		}
	}

	public string EntryLevel
	{
		get
		{
			return entryLevel;
		}
		private set
		{
			Set(ref entryLevel, value, "EntryLevel");
		}
	}

	public string EntryIcon
	{
		get
		{
			return entryIcon;
		}
		private set
		{
			Set(ref entryIcon, value, "EntryIcon");
		}
	}

	public bool IsNewEntry
	{
		get
		{
			return isNewEntry;
		}
		private set
		{
			Set(ref isNewEntry, value, "IsNewEntry");
		}
	}

	public bool IsDismiss
	{
		get
		{
			return isDismiss;
		}
		private set
		{
			Set(ref isDismiss, value, "IsDismiss");
		}
	}

	public int OldLevel
	{
		get
		{
			return oldLevel;
		}
		private set
		{
			Set(ref oldLevel, value, "OldLevel");
		}
	}

	public int NewLevel
	{
		get
		{
			return newLevel;
		}
		private set
		{
			Set(ref newLevel, value, "NewLevel");
		}
	}

	public EntryData EntryData => entryData;

	public bool IsMainEntry => isMainEntry;

	public RockDevelopEntryItemData()
	{
	}

	public RockDevelopEntryItemData(OptionBase parent, EntryData entryData)
	{
		base.parent = parent;
		this.entryData = entryData;
		entryName = entryData.DrEntry.Name;
		entryLevel = $"Lv.{entryData.CurLevel}";
		entryIcon = entryData.IconPath;
		newLevel = entryData.CurLevel;
	}

	public void SetEntryTextType(int index)
	{
		switch (index)
		{
		case 1:
			EntryName = "<color=#FFFFFF><size=36>" + EntryName + "</size></color>";
			EntryLevel = "";
			isMainEntry = true;
			break;
		case 2:
			EntryName = "<color=#FFFFFF>" + EntryName + "</color>";
			EntryLevel = "<color=#00FF00>" + EntryLevel + "</color>";
			break;
		case 3:
			EntryLevel = "<color=#00FF00>" + EntryLevel + "</color>";
			break;
		case 4:
			EntryLevel = "<color=#FF0000>" + EntryLevel + "</color>";
			break;
		}
	}

	public void SetIsNew(bool isNew, int oldLevel)
	{
		IsNewEntry = isNew;
		OldLevel = oldLevel;
		if (IsNewEntry)
		{
			SetEntryTextType(2);
		}
		if (newLevel > oldLevel)
		{
			SetEntryTextType(3);
		}
		if (oldLevel > newLevel)
		{
			SetEntryTextType(4);
		}
	}

	public void SetDisMiss(bool isMiss, int oldLevel)
	{
		IsDismiss = isMiss;
		OldLevel = oldLevel;
	}

	public void OpenEntryPanel()
	{
		EntryItemData entryItemData = new EntryItemData(null, entryData);
		entryItemData.IsMainEntry = isMainEntry;
		parent?.ItemOnClick(new OptionArg(entryItemData, "OnShowEntryPanel"));
	}
}
