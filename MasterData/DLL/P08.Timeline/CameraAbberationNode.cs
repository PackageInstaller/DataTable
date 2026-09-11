using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("画面分离特效")]
public class CameraAbberationNode : PlayableAsset
{
	[HideInInspector]
	public float AbberationIntensityValue = 1f;

	public bool OnlyHit;

	public AnimationCurve AbberationIntensityCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return CameraAbberationNodeBehaviour.Create(graph, AbberationIntensityValue, AbberationIntensityCurve);
	}
}
