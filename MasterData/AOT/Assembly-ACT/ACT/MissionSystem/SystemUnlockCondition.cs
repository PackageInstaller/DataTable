using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class SystemUnlockCondition : MissionCondition
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
		SystemUnlockConditionParam systemUnlockConditionParam = Param as SystemUnlockConditionParam;
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(systemUnlockConditionParam.systemId))
		{
			return true;
		}
		return false;
	}
}
