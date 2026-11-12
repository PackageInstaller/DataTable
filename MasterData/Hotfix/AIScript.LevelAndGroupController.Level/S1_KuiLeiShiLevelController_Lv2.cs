using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class S1_KuiLeiShiLevelController_Lv2 : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		S1_KuiLeiShiGroupController_Lv2 groupController = new S1_KuiLeiShiGroupController_Lv2();
		AddGroupController(groupController);
	}
}
