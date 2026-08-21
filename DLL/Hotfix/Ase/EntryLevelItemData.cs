namespace Ase;

public class EntryLevelItemData : OptionBase
{
	private EntryData entryData;

	private string entryIcon;

	private string entryName;

	private string entryLevelText;

	private bool isShowWarningItem;

	private string exLevelText;

	private float bgFillAmount;

	private float fillAmount;

	private float maxFillAmount;

	private int curLevel;

	private bool selected;

	private bool showLevel;

	private string entryName2;

	private bool isMax;

	public EntryData EntryData
	{
		get
		{
			return entryData;
		}
		private set
		{
			Set(ref entryData, value, "EntryData");
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

	public string EntryLevelText
	{
		get
		{
			return entryLevelText;
		}
		private set
		{
			Set(ref entryLevelText, value, "EntryLevelText");
		}
	}

	public bool IsShowWarningItem
	{
		get
		{
			return isShowWarningItem;
		}
		private set
		{
			Set(ref isShowWarningItem, value, "IsShowWarningItem");
		}
	}

	public string ExLevelText
	{
		get
		{
			return exLevelText;
		}
		private set
		{
			Set(ref exLevelText, value, "ExLevelText");
		}
	}

	public float FillAmount
	{
		get
		{
			return fillAmount;
		}
		private set
		{
			Set(ref fillAmount, value, "FillAmount");
		}
	}

	public float BgFillAmount
	{
		get
		{
			return bgFillAmount;
		}
		private set
		{
			Set(ref bgFillAmount, value, "BgFillAmount");
		}
	}

	public float MaxFillAmount
	{
		get
		{
			return maxFillAmount;
		}
		private set
		{
			Set(ref maxFillAmount, value, "MaxFillAmount");
		}
	}

	public bool Selected
	{
		get
		{
			return selected;
		}
		set
		{
			Set(ref selected, value, "Selected");
		}
	}

	public int CurLevel
	{
		get
		{
			return curLevel;
		}
		set
		{
			curLevel = value;
		}
	}

	public bool ShowLevel
	{
		get
		{
			return showLevel;
		}
		private set
		{
			Set(ref showLevel, value, "ShowLevel");
		}
	}

	public string EntryName2
	{
		get
		{
			return entryName2;
		}
		private set
		{
			Set(ref entryName2, value, "EntryName2");
		}
	}

	public bool IsMax
	{
		get
		{
			return isMax;
		}
		private set
		{
			Set(ref isMax, value, "IsMax");
		}
	}

	public EntryLevelItemData()
	{
	}

	public EntryLevelItemData(OptionBase parent, EntryData entryData, int curLevel, bool showLevel = true)
	{
		base.parent = parent;
		this.entryData = entryData;
		SetEntryData(entryData, curLevel);
		ShowLevel = showLevel;
		if (!ShowLevel)
		{
			EntryName2 = entryData.DrEntry.Name;
		}
	}

	public void OpenEntryPanel(EntryLevelItem entryLevelItem)
	{
		parent?.ItemOnClick(new OptionArg(entryLevelItem, "OpenEntryPanelLevel"));
	}

	private void SetEntryData(EntryData entryData, int curLevel)
	{
		this.entryData = entryData;
		entryIcon = entryData.IconPath;
		entryName = entryData.DrEntry.Name;
		IsMax = entryData.MaxLevel <= curLevel;
		entryLevelText = (IsMax ? "<color=#FE8B79>Lv.Max</color>" : $"<color=#FFFFFF>Lv.{curLevel}</color>");
		int constantConfigInt = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.MaxEntryLevel, 8);
		bgFillAmount = (float)entryData.MaxLevel / (float)constantConfigInt;
		fillAmount = (((float)curLevel / (float)constantConfigInt > bgFillAmount) ? bgFillAmount : ((float)curLevel / (float)constantConfigInt));
		if (curLevel >= entryData.MaxLevel)
		{
			fillAmount = 0f;
			maxFillAmount = (((float)curLevel / (float)constantConfigInt > bgFillAmount) ? bgFillAmount : ((float)curLevel / (float)constantConfigInt));
		}
		CurLevel = curLevel;
		isShowWarningItem = curLevel > entryData.MaxLevel;
		exLevelText = $"+{curLevel - entryData.MaxLevel}";
	}
}
