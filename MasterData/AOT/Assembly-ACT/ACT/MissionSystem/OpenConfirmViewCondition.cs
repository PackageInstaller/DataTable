namespace ACT.MissionSystem;

public class OpenConfirmViewCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		while (!CheckCondition() && InMissionWorld)
		{
		}
		MarkSuccess();
	}

	private bool CheckCondition()
	{
		return false;
	}
}
