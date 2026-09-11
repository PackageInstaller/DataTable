using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[DisplayName("PV专用(编辑器)/时间缩放")]
[TrackColor(0.855f, 0.8623f, 0.87f)]
[TrackClipType(typeof(TimeDilationClip))]
public class TimeDilationTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<TimeDilationMixerBehaviour>.Create(graph, inputCount);
	}
}
