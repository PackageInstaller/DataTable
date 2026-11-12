using UnityEngine;

[AddComponentMenu("触发器结果/序章关卡与引导/触发特殊引导特效", 1)]
public class Task_TriggerGuideFX : TaskCellBase
{
	public int GuideId;

	public bool isOpen;

	protected override void OnExecute()
	{
		if (GuideId <= 0)
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Trigger_Guide_Index_FX", GuideId, isOpen);
			EndAction();
		}
	}
}
