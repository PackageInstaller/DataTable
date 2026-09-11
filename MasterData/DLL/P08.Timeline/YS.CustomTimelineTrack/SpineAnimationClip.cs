using System;
using Spine;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

[Serializable]
public class SpineAnimationClip : PlayableAsset
{
	public GameObject spinePrefab;

	public string animationName = string.Empty;

	public bool loop;

	public Vector3 localPosition = Vector3.zero;

	public Vector3 localEulerAngles = Vector3.zero;

	public Vector3 localScale = Vector3.one;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<SpineAnimationBehaviour> scriptPlayable = ScriptPlayable<SpineAnimationBehaviour>.Create(graph);
		SpineAnimationBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.spinePrefab = spinePrefab;
		behaviour.animationName = animationName;
		behaviour.loop = loop;
		behaviour.localPosition = localPosition;
		behaviour.localEulerAngles = localEulerAngles;
		behaviour.localScale = localScale;
		return scriptPlayable;
	}

	public static double GetSuggestedDuration(GameObject spinePrefab, string animationName)
	{
		Spine.Animation animation = SpineAnimationBehaviour.FindAnimation(spinePrefab, animationName);
		if (animation == null || animation.Duration <= 0f)
		{
			return 1.0;
		}
		return animation.Duration;
	}
}
