using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineResetFollowCameraBehaviour : PlayableBehaviour
{
	private bool finished;

	private bool ResetFollowCamera()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (null == battleScene)
		{
			return false;
		}
		Camera main = Camera.main;
		if (main == null)
		{
			return false;
		}
		float y = main.transform.rotation.eulerAngles.y;
		battleScene.virtualCameraParam.transposer.m_XAxis.Value = y;
		return false;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.PrepareFrame(playable, info);
		if (!finished)
		{
			finished = ResetFollowCamera();
		}
	}
}
