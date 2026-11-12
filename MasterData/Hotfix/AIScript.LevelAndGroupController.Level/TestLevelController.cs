using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class TestLevelController : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		TestGroupController groupController = new TestGroupController();
		AddGroupController(groupController);
	}
}
