using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class SanJiankeLevelController_Lv1 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		IsFirstRecieveMessage = true;
	}

	protected override void OnReceiveInterActiveMessage(string message)
	{
		base.OnReceiveInterActiveMessage(message);
		if (message == "SanJianKeControllerLv1" && IsFirstRecieveMessage)
		{
			SanJiankeGroupController_Lv1 groupController = new SanJiankeGroupController_Lv1();
			AddGroupController(groupController);
			IsFirstRecieveMessage = false;
		}
	}
}
