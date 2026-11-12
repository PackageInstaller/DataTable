using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class JiJuXieLevelController_Lv3 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "JiJuXieGroupController_Lv3")
		{
			JiJuXieGroupController_Lv3 groupController = new JiJuXieGroupController_Lv3();
			AddGroupController(groupController);
		}
	}
}
