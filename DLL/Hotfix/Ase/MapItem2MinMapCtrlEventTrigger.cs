namespace Ase;

[Trigger("交互物2锁定小地图触发器")]
public class MapItem2MinMapCtrlEventTrigger : MapItemEventTrigger
{
	public bool mode;

	public bool lockMiniMap;

	public bool closeMiniMap;

	public bool TaskBtnCtrl;

	public bool TaskBtnLockClick = true;

	public override string TriggerName => "交互物-锁定小地图触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (mode)
		{
			sceneSystem.GetSystem<BattleSystem>().SetMiniMapVisible(!closeMiniMap);
		}
		else
		{
			sceneSystem.GetSystem<BattleSystem>().SetLockMiniMap(lockMiniMap);
		}
		if (TaskBtnCtrl)
		{
			sceneSystem.GetSystem<BattleSystem>().TaskBtnCanClick(TaskBtnLockClick);
		}
	}
}
