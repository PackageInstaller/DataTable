namespace Ase;

[Trigger("更新复活点触发器")]
public class UpdateBornPointTigger : BaseTrigger
{
	public int bonfireId;

	public override string TriggerName => "更新复活点触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		sceneSystem.GetSystem<SceneSystem>().UpdateBonfireBornPoint(bonfireId.ToString());
	}
}
