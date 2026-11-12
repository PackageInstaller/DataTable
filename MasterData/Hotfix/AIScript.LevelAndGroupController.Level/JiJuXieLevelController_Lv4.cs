using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class JiJuXieLevelController_Lv4 : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		JiJuXieGroupController_Lv4 groupController = new JiJuXieGroupController_Lv4();
		AddGroupController(groupController);
	}
}
