using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class GaoDa9_5_LevelController : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		InitActivity();
	}

	private void InitActivity()
	{
		GaoDa9_5_GroupController groupController = new GaoDa9_5_GroupController();
		AddGroupController(groupController);
	}
}
