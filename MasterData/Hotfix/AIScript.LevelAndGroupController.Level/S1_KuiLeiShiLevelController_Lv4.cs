using AIScript.LevelAndGroupController.Group;

namespace AIScript.LevelAndGroupController.Level;

public class S1_KuiLeiShiLevelController_Lv4 : LevelControllerBase
{
	protected override void OnControllerStart()
	{
		base.OnControllerStart();
		S1_KuiLeiShiGroupController_Lv4 groupController = new S1_KuiLeiShiGroupController_Lv4();
		AddGroupController(groupController);
	}
}
