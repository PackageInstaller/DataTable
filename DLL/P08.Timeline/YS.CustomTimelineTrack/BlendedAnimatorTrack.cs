using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("测试功能/BlendedAnimator")]
[TrackClipType(typeof(BlendedAnimatorNode))]
public class BlendedAnimatorTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<BlendedAnimatorMixer> scriptPlayable = BlendedAnimatorMixer.Create(graph, inputCount);
		scriptPlayable.GetBehaviour().animator = go.GetComponent<Animator>();
		return scriptPlayable;
	}

	protected override Playable CreatePlayable(PlayableGraph graph, GameObject go, TimelineClip clip)
	{
		_ = clip.asset is BlendedAnimatorNode;
		return base.CreatePlayable(graph, go, clip);
	}
}
