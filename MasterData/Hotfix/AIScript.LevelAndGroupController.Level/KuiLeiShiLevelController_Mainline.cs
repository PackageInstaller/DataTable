using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class KuiLeiShiLevelController_Mainline : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		KuiLeiShiGroupController_Mainline groupController = new KuiLeiShiGroupController_Mainline();
		AddGroupController(groupController);
	}
}
