using UnityEngine;

namespace Ase;

public class ActivityHeroTryItemViewModel : SelectItemViewModel
{
	private HeroModel hero;

	private Color rarityColor;

	public string profile;

	public string heroTitle;

	public int id;

	public int copyId;

	public int taskId;

	public int rewardId;

	public string jumpWindow;

	public int jumpConfig;

	public int teamSetId;

	public bool isRed;

	private CopyData copyData;

	private bool isLoadTeamConfig;

	private ActivityTaskItemData rewardItem;

	public Color RarityColor
	{
		get
		{
			return rarityColor;
		}
		set
		{
			Set(ref rarityColor, value, "RarityColor");
		}
	}

	public HeroModel Hero
	{
		get
		{
			return hero;
		}
		private set
		{
			Set(ref hero, value, "Hero");
		}
	}

	public bool IsRed
	{
		get
		{
			return isRed;
		}
		private set
		{
			Set(ref isRed, value, "IsRed");
		}
	}

	public ActivityTaskItemData RewardItem
	{
		get
		{
			return rewardItem;
		}
		set
		{
			rewardItem = value;
		}
	}

	public int JumpConfig => jumpConfig;

	public string JumpWindow => jumpWindow;

	public ActivityHeroTryItemViewModel()
	{
	}

	public ActivityHeroTryItemViewModel(OptionBase parent, DRActivityTry activityTry)
		: base(parent)
	{
		id = activityTry.Id;
		copyId = activityTry.ActivityCopyId;
		taskId = activityTry.ActivityTaskId;
		rewardId = activityTry.RewardId;
		jumpWindow = activityTry.JumpWindow;
		jumpConfig = activityTry.JumpConfig;
		hero = HeroModel.CreatePreview(activityTry.TryHero, null, activityTry.Skin);
		DRHeroFile dataRow = GameEntry.DataTable.GetDataRow((DRHeroFile p) => p.Id == activityTry.TryHero);
		if (activityTry.Skin > 0)
		{
			DRUIHeroSkin dataRow2 = GameEntry.DataTable.GetDataRow((DRUIHeroSkin p) => p.Id == activityTry.Skin);
			if (dataRow2 != null)
			{
				profile = dataRow2.SkinDesc;
				heroTitle = GetTitle(dataRow2.SkinName);
			}
		}
		if (string.IsNullOrEmpty(profile))
		{
			profile = ((dataRow != null) ? dataRow.Profile : "");
		}
		if (string.IsNullOrEmpty(heroTitle))
		{
			DRHeroInfo dataRow3 = GameEntry.DataTable.GetDataRow((DRHeroInfo p) => p.Id == activityTry.TryHero);
			heroTitle = ((dataRow3 != null) ? GetTitle(dataRow3.Title) : "");
		}
		RarityColor = hero.GetColorByRarity(hero.Rarity);
	}

	public void SetRed(bool isRed)
	{
		IsRed = isRed;
	}

	public CopyData GetCopyData()
	{
		if (copyData == null)
		{
			copyData = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetActivityCopyById(copyId);
			if (copyData != null)
			{
				teamSetId = copyData.TeamSeatId;
			}
		}
		return copyData;
	}

	private string GetTitle(string title)
	{
		string text = "";
		for (int i = 0; i < title.Length; i++)
		{
			text += title[i];
			if (i < title.Length - 1)
			{
				text += " - ";
			}
		}
		return text;
	}
}
