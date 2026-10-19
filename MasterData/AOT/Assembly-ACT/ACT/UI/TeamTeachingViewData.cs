using System;

namespace ACT.UI;

public class TeamTeachingViewData : UIViewData
{
	public int MainTabId { get; set; }

	public int TrainingContentId { get; set; }

	public int ChallengeTime { get; set; } = -1;

	public bool DeferCompletedChallengeSort { get; set; }

	public Action OnClose { get; set; }
}
