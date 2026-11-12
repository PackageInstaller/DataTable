using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class MiniBossRenOuLevelController : LevelControllerBase
{
	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "MiniBossRenOuGroupController")
		{
			MiniBossRenOuGroupController groupController = new MiniBossRenOuGroupController();
			AddGroupController(groupController);
		}
	}
}
