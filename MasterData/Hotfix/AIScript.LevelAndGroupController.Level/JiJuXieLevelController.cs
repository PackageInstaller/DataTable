using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class JiJuXieLevelController : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "JiJuXieLevelController")
		{
			JiJuXieGroupController groupController = new JiJuXieGroupController();
			AddGroupController(groupController);
		}
	}
}
