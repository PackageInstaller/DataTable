using System;
using System.Collections;
using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/播放BGM", 6)]
public class Task_PlayBGM : TaskCellBase
{
	public string bgm;

	public float delaySecond;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(bgm))
		{
			LogWarning("未配置");
			EndAction(success: false);
			return;
		}
		StartCoroutine(DoDelayAction(delaySecond, () =>
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(bgm);
			EndAction();
		}));
	}

	private IEnumerator DoDelayAction(float delaySeconds, Action action)
	{
		yield return new WaitForSeconds(delaySeconds);
		action();
	}
}
