using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class ShuangZiQiLevelController_Type2_Lv2 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		ShuangZiQiGroupController_Type2_Lv2 groupController = new ShuangZiQiGroupController_Type2_Lv2();
		AddGroupController(groupController);
	}
}
