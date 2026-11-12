using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class HualingActivity_LevelController : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		InitActivity();
	}

	private void InitActivity()
	{
		HualingGrouplController_Activity groupController = new HualingGrouplController_Activity();
		AddGroupController(groupController);
	}
}
