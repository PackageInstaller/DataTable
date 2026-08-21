using System;
using System.ComponentModel;
using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("测试功能/角色口型参考(CriLipsExPlayer)")]
[TrackClipType(typeof(CriLipsExPlayerNode))]
[TrackBindingType(typeof(CriLipsExPlayer))]
[TrackColor(0.5f, 0.5f, 0f)]
public class CriLipsExPlayerTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		foreach (TimelineClip clip in GetClips())
		{
			CriLipsExPlayerNode criLipsExPlayerNode = (CriLipsExPlayerNode)clip.asset;
			if (criLipsExPlayerNode.defaultDuration != clip.duration)
			{
				clip.duration = criLipsExPlayerNode.defaultDuration;
			}
		}
		return base.CreateTrackMixer(graph, go, inputCount);
	}
}
