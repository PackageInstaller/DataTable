using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class DcValueActivity_LevelController : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		InitActivity();
	}

	private void InitActivity()
	{
		DcValueGroupController_Activity groupController = new DcValueGroupController_Activity();
		AddGroupController(groupController);
	}
}
