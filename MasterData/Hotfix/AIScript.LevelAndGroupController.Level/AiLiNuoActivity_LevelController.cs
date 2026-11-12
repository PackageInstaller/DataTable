using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class AiLiNuoActivity_LevelController : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		InitActivity();
	}

	private void InitActivity()
	{
		AiLiNuoGroupController_Activity groupController = new AiLiNuoGroupController_Activity();
		AddGroupController(groupController);
	}
}
