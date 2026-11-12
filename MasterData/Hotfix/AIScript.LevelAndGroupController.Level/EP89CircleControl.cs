namespace AIScript.LevelAndGroupController.Level;

public class EP89CircleControl : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "CircleControlClose")
		{
			SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = false;
		}
		else if (message == "CircleControlOpen")
		{
			SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = Singleton<UIGameSystemSetup>.Instance.EnableAttackGizmos;
		}
	}
}
