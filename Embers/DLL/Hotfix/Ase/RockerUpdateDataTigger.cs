namespace Ase;

[Trigger("摇杆控制显示更新存档触发器")]
public class RockerUpdateDataTigger : BaseTrigger
{
	public int[] RockerIDs;

	public override string TriggerName => "摇杆控制显示更新存档触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (RockerIDs != null)
		{
			int[] rockerIDs = RockerIDs;
			foreach (int rockerId in rockerIDs)
			{
				sceneSystem.GetLevelMapData().UpdateRockerControlData(rockerId);
			}
		}
	}
}
