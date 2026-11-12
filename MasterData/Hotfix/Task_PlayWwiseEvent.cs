using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/播放音效", 6)]
public class Task_PlayWwiseEvent : TaskCellBase
{
	public string wiseEvent;

	public GameObject targetPos;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(wiseEvent))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(wiseEvent, targetPos);
			EndAction();
		}
	}
}
