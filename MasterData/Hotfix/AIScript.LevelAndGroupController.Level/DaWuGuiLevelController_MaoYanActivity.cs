using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class DaWuGuiLevelController_MaoYanActivity : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "DaWuGuiLevelController_MaoYanActivity")
		{
			DaWuGuiGroupController_MaoYanActivity groupController = new DaWuGuiGroupController_MaoYanActivity();
			AddGroupController(groupController);
		}
	}
}
