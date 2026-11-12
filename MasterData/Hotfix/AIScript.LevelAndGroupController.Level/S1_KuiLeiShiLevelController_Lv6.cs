using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class S1_KuiLeiShiLevelController_Lv6 : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		S1_KuiLeiShiGroupController_Lv6 groupController = new S1_KuiLeiShiGroupController_Lv6();
		AddGroupController(groupController);
	}
}
