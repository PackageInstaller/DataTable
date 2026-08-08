using System;
using UnityEngine;
using UnityEngine.Playables;

public class SceneGraynessNodePlayable : PlayableBehaviour
{
	public SceneSetting sceneSetting;

	public AnimationCurve GraynessCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	[NonSerialized]
	private bool previewOutOfDate = true;

	[NonSerialized]
	private float originalValue;

	public bool IsValid => sceneSetting != null;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (previewOutOfDate)
		{
			sceneSetting = (SceneSetting)playerData;
			originalValue = sceneSetting.grayness;
		}
		float num = (float)(playable.GetTime() / playable.GetDuration());
		if (num >= 0f && num <= 1f)
		{
			sceneSetting.grayness = GraynessCurve.Evaluate(num);
		}
		if (num >= 1f && sceneSetting != null)
		{
			sceneSetting.grayness = originalValue;
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		previewOutOfDate = true;
		if (sceneSetting != null)
		{
			sceneSetting.grayness = originalValue;
		}
	}

	public override void OnGraphStart(Playable playable)
	{
		previewOutOfDate = true;
	}
}
