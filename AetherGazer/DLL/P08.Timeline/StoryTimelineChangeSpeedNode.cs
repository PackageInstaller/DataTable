using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("改变Timeline播放速度")]
public class StoryTimelineChangeSpeedNode : PlayableAsset
{
	public AnimationCurve speedCurve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(0.5f, 1f), new Keyframe(1f, 1f));

	public bool inverseWhenFinished;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineChangeSpeedNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineChangeSpeedNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().speedCurve = speedCurve;
		scriptPlayable.GetBehaviour().inverseWhenFinished = inverseWhenFinished;
		return scriptPlayable;
	}
}
