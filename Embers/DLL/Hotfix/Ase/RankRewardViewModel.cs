using System.Collections.Generic;

namespace Ase;

public class RankRewardViewModel : OptionBase
{
	private List<DRRankReward> _rankRewards = new List<DRRankReward>();

	public List<DRRankReward> RankRewards => _rankRewards;

	public RankRewardViewModel()
	{
	}

	public RankRewardViewModel(List<DRRankReward> rewards)
	{
		if (rewards != null)
		{
			_rankRewards = rewards;
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}
}
