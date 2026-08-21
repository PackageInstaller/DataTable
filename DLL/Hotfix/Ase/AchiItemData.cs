using System;

namespace Ase;

public class AchiItemData : OptionBase
{
	private bool isChecked;

	private bool isSelected;

	private int achiId;

	private int achiRank;

	private int achiTag;

	private string achiName;

	private string achiIcon;

	private string achiNameIcon;

	private string achiDesc;

	private int selectAchiIndex;

	private int achiRarity;

	private int achiType;

	private AchievementMedal achievementMedal;

	public int AchiId
	{
		get
		{
			return achiId;
		}
		set
		{
			Set(ref achiId, value, "AchiId");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool IsChecked
	{
		get
		{
			return isChecked;
		}
		set
		{
			Set(ref isChecked, value, "IsChecked");
		}
	}

	public string AchiName
	{
		get
		{
			return achiName;
		}
		set
		{
			Set(ref achiName, value, "AchiName");
		}
	}

	public string AchiIcon
	{
		get
		{
			return achiIcon;
		}
		set
		{
			Set(ref achiIcon, value, "AchiIcon");
		}
	}

	public string AchiNameIcon
	{
		get
		{
			return achiNameIcon;
		}
		set
		{
			Set(ref achiNameIcon, value, "AchiNameIcon");
		}
	}

	public string AchiDesc
	{
		get
		{
			return achiDesc;
		}
		set
		{
			Set(ref achiDesc, value, "AchiDesc");
		}
	}

	public int SelectAchiIndex
	{
		get
		{
			return selectAchiIndex;
		}
		set
		{
			Set(ref selectAchiIndex, value, "SelectAchiIndex");
		}
	}

	public int AchiRank => achiRank;

	public int AchiTag => achiTag;

	public int AchiRarity
	{
		get
		{
			return achiRarity;
		}
		set
		{
			Set(ref achiRarity, value, "AchiRarity");
		}
	}

	public int AchiType => achiType;

	public AchievementMedal AchievementMedal => achievementMedal;

	public AchiItemData(OptionBase parent, int achiId, int rank, int tag)
	{
		base.parent = parent;
		this.achiId = achiId;
		achiRank = rank;
		achiTag = tag;
		InitInfo();
	}

	public AchiItemData(OptionBase parent, AchievementMedal medal)
	{
		base.parent = parent;
		achiId = medal.MedalId;
		achiName = RemoveAfterDotOrMiddleDot(medal.MedalName);
		achiType = medal.AchievementType;
		achiRank = medal.MedalRank;
		achievementMedal = medal;
		InitInfo();
	}

	private void InitInfo()
	{
		DRAchievementMedal[] dataRows = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetDataRows((DRAchievementMedal p) => p.MedalId == achiId);
		for (int num = 0; num < dataRows.Length; num++)
		{
			if (dataRows[num].Rank == achiRank)
			{
				AchiIcon = dataRows[num].MedalIcon;
				AchiRarity = dataRows[num].Rarity;
				achiDesc = dataRows[num].Desc;
			}
		}
	}

	private string RemoveAfterDotOrMiddleDot(string input)
	{
		if (string.IsNullOrEmpty(input))
		{
			return input;
		}
		int num = input.IndexOf('.');
		int num2 = input.IndexOf('·');
		if (num >= 0 && num2 >= 0)
		{
			return input.Substring(0, Math.Min(num, num2));
		}
		if (num >= 0)
		{
			return input.Substring(0, num);
		}
		if (num2 >= 0)
		{
			return input.Substring(0, num2);
		}
		return input;
	}

	public virtual void OnClick()
	{
		parent?.ItemOnClick(this);
	}

	public void SetSelectAchiIndex(int index)
	{
		SelectAchiIndex = index;
	}

	public void SetSelected(bool value)
	{
		IsSelected = value;
	}

	public void SetChecked(bool value)
	{
		IsChecked = value;
	}
}
