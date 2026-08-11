using System.Collections.Generic;

namespace Ase;

public class RankRewardItemData : ItemOptionBase
{
	private const int FirePowerHeroChallengeRankType = 10;

	private int _itemRank;

	private DRRankReward _drRankReward;

	private string _rankRange;

	private List<PropDataBase> _rewards = new List<PropDataBase>();

	public int ItemRank
	{
		get
		{
			return _itemRank;
		}
		set
		{
			Set(ref _itemRank, value, "ItemRank");
		}
	}

	public string RankRange
	{
		get
		{
			return _rankRange;
		}
		set
		{
			Set(ref _rankRange, value, "RankRange");
		}
	}

	public List<PropDataBase> Rewards => _rewards;

	public RankRewardItemData()
	{
	}

	public RankRewardItemData(OptionBase parent, DRRankReward drData)
	{
		base.parent = parent;
		int num = ((drData.Range.Count > 0) ? drData.Range[0] : 0);
		int num2 = ((drData.Range.Count > 1) ? drData.Range[1] : 0);
		if (num2 == 0)
		{
			if (num <= 3)
			{
				ItemRank = num;
			}
			else
			{
				ItemRank = 0;
				RankRange = $"{num}";
			}
		}
		else
		{
			ItemRank = 0;
			RankRange = $"{num}-{num2}";
		}
		for (int i = 0; i < drData.RewardId.Count; i++)
		{
			int count = ((drData.RewardNum.Count > i) ? drData.RewardNum[i] : 0);
			int type = ((drData.RewardType.Count > i) ? drData.RewardType[i] : 0);
			_rewards.Add(PropDataBase.CreateByType(type, drData.RewardId[i], count));
		}
		if (drData.HeroRankTitle > 0)
		{
			int heroId = Singleton<ServiceSystem>.Instance.GetService<IRankService>().GetHeroChallengeIdForRank();
			UserDefinition.TitleTypeEnum titleType = GetHeroRankTitleType(drData.RankId);
			DRTitle dataRow = GameEntry.DataTable.GetDataRow((DRTitle p) => p.Type == (int)titleType && p.EX == heroId);
			if (dataRow != null)
			{
				_rewards.Add(PropDataBase.CreateByType(PropTypeEnum.Title, dataRow.Id));
			}
		}
	}

	private static UserDefinition.TitleTypeEnum GetHeroRankTitleType(int rankId)
	{
		DRRank dataRow = GameEntry.DataTable.GetDataRow<DRRank>(rankId);
		DRRankType dRRankType = ((dataRow == null) ? null : GameEntry.DataTable.GetDataRow<DRRankType>(dataRow.RankType));
		if (dRRankType != null && dRRankType.Type == 10)
		{
			return UserDefinition.TitleTypeEnum.HeroRank_Fire;
		}
		return UserDefinition.TitleTypeEnum.HeroRank_Extreme;
	}
}
