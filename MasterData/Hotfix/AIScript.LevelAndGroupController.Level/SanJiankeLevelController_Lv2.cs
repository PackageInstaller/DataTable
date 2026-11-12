using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class SanJiankeLevelController_Lv2 : LevelControllerBase
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
		if (message == "SanJianKeControllerLv2" && IsFirstRecieveMessage)
		{
			SanJiankeGroupController_Lv2 groupController = new SanJiankeGroupController_Lv2();
			AddGroupController(groupController);
			IsFirstRecieveMessage = false;
		}
	}
}
