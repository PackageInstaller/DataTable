using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class SecondsCondition : MissionCondition
{
	public override bool ServerVerify => true;

	protected override async void OnInMissionWorld()
	{
		do
		{
			if (CheckCondition())
			{
				bool result;
				do
				{
					result = await MarkSuccess();
					if (result)
					{
						break;
					}
					await UniTask.WaitForSeconds(7.5f);
				}
				while (CheckCondition() && InMissionWorld);
				if (result)
				{
					break;
				}
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	public override bool PreCheckCondition()
	{
		return false;
	}

	private bool CheckCondition()
	{
		SecondsConditionParam secondsConditionParam = Param as SecondsConditionParam;
		int startTs = GetStartTs();
		if (TimeManager.ServerTime.NowTimestampSecond - startTs >= secondsConditionParam.seconds)
		{
			return true;
		}
		return false;
	}
}
