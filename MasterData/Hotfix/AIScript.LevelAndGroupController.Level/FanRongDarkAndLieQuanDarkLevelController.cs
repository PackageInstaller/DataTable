using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class FanRongDarkAndLieQuanDarkLevelController : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "FanRongLieQuanLevelController")
		{
			AddGroupController(new FanRongDarkAndLieQuanDarkGroupController());
		}
	}
}
