using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class JiJuXieLevelController_Lv5 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		JiJuXieGroupController_Lv5 groupController = new JiJuXieGroupController_Lv5();
		AddGroupController(groupController);
	}
}
