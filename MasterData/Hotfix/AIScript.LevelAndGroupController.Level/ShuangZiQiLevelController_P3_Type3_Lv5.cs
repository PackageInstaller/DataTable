using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class ShuangZiQiLevelController_P3_Type3_Lv5 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		ShuangZiQiGroupController_P3_Type3_Lv5 groupController = new ShuangZiQiGroupController_P3_Type3_Lv5();
		AddGroupController(groupController);
	}
}
