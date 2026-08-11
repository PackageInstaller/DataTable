using UnityEngine;

namespace Ase;

public class AchievementMedalItemData : OptionBase
{
	private int medalRarity;

	private string medalIcon;

	private Color color;

	private string title;

	private string desc;

	private int curstar;

	private int maxStar;

	private string rate;

	private bool isComplete;

	private bool isLock;

	private bool showRedPoint;

	public AchievementMedal achievementMedal;

	public int MedalRarity
	{
		get
		{
			return medalRarity;
		}
		set
		{
			Set(ref medalRarity, value, "MedalRarity");
		}
	}

	public string MedalIcon
	{
		get
		{
			return medalIcon;
		}
		set
		{
			Set(ref medalIcon, value, "MedalIcon");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public int Curstar
	{
		get
		{
			return curstar;
		}
		set
		{
			Set(ref curstar, value, "Curstar");
		}
	}

	public int MaxStar
	{
		get
		{
			return maxStar;
		}
		set
		{
			Set(ref maxStar, value, "MaxStar");
		}
	}

	public string Rate
	{
		get
		{
			return rate;
		}
		set
		{
			Set(ref rate, value, "Rate");
		}
	}

	public bool IsComplete
	{
		get
		{
			return isComplete;
		}
		set
		{
			Set(ref isComplete, value, "IsComplete");
		}
	}

	public bool ShowRedPoint
	{
		get
		{
			return showRedPoint;
		}
		set
		{
			Set(ref showRedPoint, value, "ShowRedPoint");
		}
	}

	public Color Color
	{
		get
		{
			return color;
		}
		set
		{
			Set(ref color, value, "Color");
		}
	}

	public AchievementMedalItemData(OptionBase parent, AchievementMedal achievementMedal)
	{
		base.parent = parent;
		SetMedal(achievementMedal);
		CountStar(achievementMedal.MedalId, achievementMedal.MedalNum);
	}

	private void SetMedal(AchievementMedal achievementMedal)
	{
		MedalRarity = achievementMedal.MedalRarity;
		MedalIcon = achievementMedal.MedalIcon;
		Title = achievementMedal.MedalName;
		Desc = achievementMedal.MedalDesc;
		this.achievementMedal = achievementMedal;
	}

	private void CountStar(int medalId, int medalNum)
	{
		DRAchievementMedal[] dataRows = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetDataRows((DRAchievementMedal p) => p.MedalId == medalId);
		maxStar = dataRows.Length;
		int rank = achievementMedal.MedalRank + 1;
		DRAchievementMedal dataRow = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetDataRow((DRAchievementMedal p) => p.MedalId == medalId && p.Rank == rank);
		Curstar = achievementMedal.CurRank;
		Color = ((Curstar == 0) ? new Color(1f, 1f, 1f, 0.6f) : Color.white);
		Rate = "";
		if (dataRow != null)
		{
			if (dataRow.Flag == 1)
			{
				Rate = ((achievementMedal.CurRank > achievementMedal.MedalRank) ? "1/1" : "0/1");
			}
			else
			{
				Rate = ((achievementMedal.MedalRank == maxStar) ? "" : $"{medalNum}/{dataRow.Value}");
			}
		}
		IsComplete = achievementMedal.MedalRank == maxStar;
		ShowRedPoint = curstar > achievementMedal.MedalRank;
	}

	public void ResetMedal()
	{
		AchievementMedal achievementMedalById = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementMedalById(achievementMedal.MedalId);
		SetMedal(achievementMedalById);
		CountStar(achievementMedalById.MedalId, achievementMedalById.MedalNum);
	}

	public void OpenAchievementStageWindow()
	{
		if (achievementMedal.MedalRank < curstar)
		{
			parent?.ItemOnClick(new OptionArg(this, "GetReward"));
		}
		else
		{
			parent?.ItemOnClick(new OptionArg(this, "OpenAchievementStageWindow"));
		}
	}
}
