using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class SystemUnlockAnimCondition : MissionCondition
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
		SystemUnlockAnimConditionParam systemUnlockAnimConditionParam = Param as SystemUnlockAnimConditionParam;
		if (Singleton<SystemUnlockManager>.instance.SystemHudIsOpened(systemUnlockAnimConditionParam.systemId))
		{
			return true;
		}
		return false;
	}
}
