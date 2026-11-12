using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/黑屏淡出隐藏", 8)]
public class Task_CameraBlackScreenOff : TaskCellBase
{
	public float fadeTime = 0.5f;

	protected override void OnExecute()
	{
		if (fadeTime <= 0f)
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraBlackScreenTransition(fadeTime, () =>
			{
				EndAction();
			});
		}
	}
}
