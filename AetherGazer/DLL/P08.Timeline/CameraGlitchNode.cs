using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("相机故障特效")]
public class CameraGlitchNode : PlayableAsset
{
	[HideInInspector]
	public float GlitchIntensityValue = 1f;

	public AnimationCurve GlitchIntensityCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	[HideInInspector]
	public float GlitchFrequencyValue = 1f;

	public AnimationCurve GlitchFrequencyCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 30f), new Keyframe(1f, 0f));

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return CameraGlitchNodeBehaviour.Create(graph, GlitchIntensityValue, GlitchIntensityCurve, GlitchFrequencyValue, GlitchFrequencyCurve);
	}
}
