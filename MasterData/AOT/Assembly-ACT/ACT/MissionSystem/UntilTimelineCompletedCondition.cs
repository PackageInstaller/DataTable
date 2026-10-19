using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class UntilTimelineCompletedCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		UntilTimelineCompletedConditionParam untilTimelineCompletedConditionParam = Param as UntilTimelineCompletedConditionParam;
		if (Singleton<ConversationManager>.instance.HaveKeyPoint(untilTimelineCompletedConditionParam.timelineId))
		{
			return true;
		}
		return false;
	}
}
