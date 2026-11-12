using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/触发震屏", 7)]
public class Task_CameraShake : TaskCellBase
{
	public AdventurePlayerFeedbackEffectConfigureData playerfeedbackEffectConfigureData;

	protected override void OnExecute()
	{
		if (playerfeedbackEffectConfigureData == null)
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			playerfeedbackEffectConfigureData.Play(default, null, 2);
			EndAction();
		}
	}
}
