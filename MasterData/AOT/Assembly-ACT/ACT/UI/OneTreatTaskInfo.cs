using ACT.Config;
using ACT.UI.DataProxy;

namespace ACT.UI;

public class OneTreatTaskInfo
{
	public int ActivityId;

	public int ChallengeGroupId;

	public int ChallengeId;

	public int SortIndex;

	public int CurrentProgress;

	public int TargetProgress;

	public ActivityChallengeData ChallengeData;

	public ItemUnifierProxy DisplayReward;

	public OneTreatTaskState State;
}
