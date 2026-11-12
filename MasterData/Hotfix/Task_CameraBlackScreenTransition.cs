using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/触发黑屏", 8)]
public class Task_CameraBlackScreenTransition : TaskCellBase
{
	public float time = 0.5f;

	public float fadeTime = 0.5f;

	protected override void OnExecute()
	{
		if (time <= 0f)
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<GameCameraStackManager>.Instance.StartMainCameraBlackScreenTransition(fadeTime);
			TaskCellBase.SuspendPlayer();
			TaskCellBase.SetHud_Invisible();
		}
	}

	protected override void LogicUpdate()
	{
		if (ElapsedTime > time + fadeTime)
		{
			EndAction();
			MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraBlackScreenTransition(fadeTime, () =>
			{
				TaskCellBase.ResumePlayer();
				TaskCellBase.SetHud_Visible();
			});
		}
	}
}
