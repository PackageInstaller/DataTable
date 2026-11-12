using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class JiJuXieLevelController_Lv2 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "JiJuXieGroupController_Lv2")
		{
			JiJuXieGroupController_Lv2 groupController = new JiJuXieGroupController_Lv2();
			AddGroupController(groupController);
		}
	}
}
