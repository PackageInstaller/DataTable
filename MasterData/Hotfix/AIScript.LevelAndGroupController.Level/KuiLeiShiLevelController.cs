using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class KuiLeiShiLevelController : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		KuiLeiShiGroupController groupController = new KuiLeiShiGroupController();
		AddGroupController(groupController);
	}
}
