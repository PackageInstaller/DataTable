using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class EP9_LevelController : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		AddGroupController(new EP9_GroupController());
	}
}
