using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class ShuangZiQiLevelController : LevelControllerBase
{
	private bool IsFirstRecieveMessage;

	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		ShuangZiQiGroupController groupController = new ShuangZiQiGroupController();
		AddGroupController(groupController);
	}
}
