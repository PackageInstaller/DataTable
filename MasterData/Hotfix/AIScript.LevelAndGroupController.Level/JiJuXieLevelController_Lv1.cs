using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class JiJuXieLevelController_Lv1 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "JiJuXieGroupController_Lv1")
		{
			JiJuXieGroupController_Lv1 groupController = new JiJuXieGroupController_Lv1();
			AddGroupController(groupController);
		}
	}
}
