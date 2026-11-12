using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/播放语音", 0)]
public class Task_PlayWwiseVoice : TaskCellBase
{
	public int charId;

	public string wiseEvent;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(wiseEvent))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<WwiseAudioManager>.Instance.WwiseVoice_Play(charId, wiseEvent);
			EndAction();
		}
	}
}
