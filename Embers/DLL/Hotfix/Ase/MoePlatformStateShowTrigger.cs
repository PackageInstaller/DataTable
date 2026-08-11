using UnityEngine;

namespace Ase;

[Trigger("移动平台状态显示触发器")]
public class MoePlatformStateShowTrigger : BaseTrigger
{
	public int MovingPlatformId;

	public GameObject IdeaShowObj;

	public GameObject PauseShowObj;

	public GameObject RunShowObj;

	public override string TriggerName => "移动平台状态显示触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (sceneSystem == null)
		{
			return;
		}
		LevelMapData levelMapData = sceneSystem.GetLevelMapData();
		if ((Object)(object)levelMapData != null)
		{
			levelMapData.GetMovingPlatformPauseState(MovingPlatformId);
			if (triggerType == AreaTriggerType.Enter)
			{
				IdeaShowObj.SetActive(value: false);
				PauseShowObj.SetActive(value: false);
				RunShowObj.SetActive(value: true);
			}
			else if (triggerType == AreaTriggerType.Exit)
			{
				IdeaShowObj.SetActive(value: true);
				PauseShowObj.SetActive(value: false);
				RunShowObj.SetActive(value: false);
			}
		}
	}
}
