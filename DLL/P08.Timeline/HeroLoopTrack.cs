using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("UI.Timeline/循环姿势轨道")]
[TrackClipType(typeof(LoopPoseNode))]
[TrackBindingType(typeof(HeroUITimelineBrain))]
public class HeroLoopTrack : TrackAsset
{
	protected override Playable CreatePlayable(PlayableGraph graph, GameObject gameObject, TimelineClip clip)
	{
		if (clip.asset is LoopPoseNode loopPoseNode)
		{
			loopPoseNode.clip = clip;
		}
		return base.CreatePlayable(graph, gameObject, clip);
	}
}
