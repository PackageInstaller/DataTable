using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class UntilPreconditionGroupComplete : MissionCondition
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
		UntilPreconditionGroupCompleteParam untilPreconditionGroupCompleteParam = Param as UntilPreconditionGroupCompleteParam;
		return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(untilPreconditionGroupCompleteParam.preconditionGroup);
	}
}
