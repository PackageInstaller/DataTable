using UnityEngine;
using UnityEngine.Playables;

public class UISceneSettingTintBehaviour : PlayableBehaviour
{
	private SceneSetting sceneSetting;

	private Gradient tintColorGradient;

	private Color oriTintColor;

	internal void Initialize(Gradient tintColorGradient)
	{
		this.tintColorGradient = tintColorGradient;
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		Object userData = info.output.GetUserData();
		sceneSetting = userData as SceneSetting;
		if (sceneSetting == null)
		{
			Debug.LogError("UISceneSettingTintBehaviour miss component SceneSetting!");
		}
		else
		{
			oriTintColor = sceneSetting.tint;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!(sceneSetting == null))
		{
			float time = (float)(playable.GetTime() / playable.GetDuration());
			sceneSetting.tint = tintColorGradient.Evaluate(time);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (sceneSetting != null)
		{
			sceneSetting.tint = oriTintColor;
		}
	}
}
