using UnityEngine.Serialization;

namespace Ase;

[Trigger("锁定小地图触发器")]
public class LockMiniMapTrigger : BaseTrigger
{
	public bool mode;

	public bool lockMiniMap;

	public bool closeMiniMap;

	public bool TaskBtnCtrl;

	[FormerlySerializedAs("TaskBtnCanClick")]
	public bool TaskBtnLockClick = true;

	public override string TriggerName => "锁定小地图触发器";

	protected override void DoExecute()
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
