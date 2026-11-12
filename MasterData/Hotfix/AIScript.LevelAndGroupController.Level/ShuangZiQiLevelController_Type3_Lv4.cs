using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class ShuangZiQiLevelController_Type3_Lv4 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		ShuangZiQiGroupController_Type3_Lv4 groupController = new ShuangZiQiGroupController_Type3_Lv4();
		AddGroupController(groupController);
	}
}
