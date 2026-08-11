namespace Ase;

[Trigger("改变迷雾地图触发器")]
public class ChangeMapMaskTrigger : BaseTrigger
{
	public int Index;

	public override string TriggerName => "改变迷雾地图触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		int levelId = sceneSystem.GetLevelId();
		if (Singleton<ServiceSystem>.Instance != null && !Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMapMaskIndexUnLock(levelId, Index))
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ChangeMapMaskData(levelId, Index, 1);
		}
	}
}
