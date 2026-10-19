using System;

namespace ACT.UI;

public class OneTreatScrapingPrizeViewData : UIViewData
{
	public int ActivityId;

	public int TicketItemId;

	public int TicketCount;

	public string Tier = "E";

	public int RewardId;

	public int RewardCount = 1;

	public string RewardName;

	public bool HasFinalReward;

	public int FinalRewardId;

	public int FinalRewardCount = 1;

	public string FinalRewardName;

	public bool CanDrawAgain;

	public Func<Action<OneTreatScrapingPrizeViewData>, bool> DrawAgain;

	public Action OnResultDisplayed;

	public Action OnClose;
}
