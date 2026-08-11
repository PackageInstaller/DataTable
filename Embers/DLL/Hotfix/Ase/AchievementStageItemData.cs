using System.Collections.Generic;

namespace Ase;

public class AchievementStageItemData : OptionBase
{
	private bool canReceived;

	private string medalName;

	private string medalDesc;

	private string medalIcon;

	private int medalRarity;

	private string rate;

	private int state;

	private List<AchievementRewardItemData> achievementRewardItemDataList;

	public string MedalName
	{
		get
		{
			return medalName;
		}
		set
		{
			Set(ref medalName, value, "MedalName");
		}
	}

	public string MedalDesc
	{
		get
		{
			return medalDesc;
		}
		set
		{
			Set(ref medalDesc, value, "MedalDesc");
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

	public List<AchievementRewardItemData> AchievementRewardItemDataList
	{
		get
		{
			return achievementRewardItemDataList;
		}
		set
		{
			Set(ref achievementRewardItemDataList, value, "AchievementRewardItemDataList");
		}
	}

	public int State => state;

	public AchievementStageItemData(OptionBase parent, DRAchievementMedal drAchievementMedal, int curNUm, int medalRank, int index)
	{
		base.parent = parent;
		medalName = drAchievementMedal.Name;
		medalDesc = drAchievementMedal.Desc;
		medalIcon = drAchievementMedal.MedalIcon;
		medalRarity = drAchievementMedal.Rarity;
		achievementRewardItemDataList = new List<AchievementRewardItemData>();
		int num = drAchievementMedal.Value;
		if (drAchievementMedal.Flag == 1)
		{
			curNUm = ((index + 1 <= curNUm) ? 1 : 0);
			num = 1;
		}
		rate = ((curNUm > num) ? $"{num}/{num}" : $"{curNUm}/{num}");
		state = 2;
		if (medalRank >= drAchievementMedal.Rank)
		{
			state = 3;
		}
		LoadReward(drAchievementMedal.RewardsType, drAchievementMedal.Rewards, drAchievementMedal.RewardsNum);
	}

	private void LoadReward(List<int> itemType, List<int> itemID, List<int> itemCount)
	{
		if (itemType.Count == itemID.Count)
		{
			for (int i = 0; i < itemType.Count; i++)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(itemType[i], itemID[i], itemCount[i]);
				AchievementRewardItemData item = new AchievementRewardItemData(this, propDataBase.Icon, propDataBase.GetRarity(), propDataBase.Amount, state);
				achievementRewardItemDataList.Add(item);
			}
		}
	}
}
