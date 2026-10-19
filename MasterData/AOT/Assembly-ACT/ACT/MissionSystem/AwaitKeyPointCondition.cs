using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class AwaitKeyPointCondition : MissionCondition
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
		AwaitKeyPointConditionParam awaitKeyPointConditionParam = Param as AwaitKeyPointConditionParam;
		if (awaitKeyPointConditionParam.reverseResult)
		{
			if (!Singleton<ConversationManager>.instance.HavePersistentKeyPoint(awaitKeyPointConditionParam.keyPoint))
			{
				return true;
			}
			return false;
		}
		if (Singleton<ConversationManager>.instance.HavePersistentKeyPoint(awaitKeyPointConditionParam.keyPoint))
		{
			return true;
		}
		return false;
	}
}
