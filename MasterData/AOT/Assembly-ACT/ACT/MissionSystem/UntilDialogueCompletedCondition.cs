using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class UntilDialogueCompletedCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		if (IsRepeat)
		{
			do
			{
				if (CheckCondition())
				{
					MarkSuccess();
				}
				await UniTask.Yield();
			}
			while (InMissionWorld);
			return;
		}
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
		UntilDialogueCompletedConditionParam untilDialogueCompletedConditionParam = Param as UntilDialogueCompletedConditionParam;
		if (Singleton<ConversationManager>.instance.HaveKeyPoint(untilDialogueCompletedConditionParam.storyGroupId))
		{
			return true;
		}
		return false;
	}
}
