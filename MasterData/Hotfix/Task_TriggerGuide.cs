using UnityEngine;

[AddComponentMenu("触发器结果/序章关卡与引导/触发引导", 1)]
public class Task_TriggerGuide : TaskCellBase
{
	public int GuideId;

	protected override void OnExecute()
	{
		if (GuideId <= 0)
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Trigger_Guide_Index", GuideId);
			EndAction();
		}
	}
}
