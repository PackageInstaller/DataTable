using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class DaysCondition : MissionCondition
{
	public override bool ServerVerify => true;

	protected override async void OnInMissionWorld()
	{
		do
		{
			if (await MarkSuccess())
			{
				MarkSuccess();
				break;
			}
			await UniTask.WaitForSeconds(60);
		}
		while (InMissionWorld);
	}

	public override bool PreCheckCondition()
	{
		return false;
	}
}
