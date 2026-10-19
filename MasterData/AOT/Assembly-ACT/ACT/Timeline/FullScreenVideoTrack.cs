using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0.2f, 0.6f, 1f)]
[TrackClipType(typeof(FullScreenVideoClip))]
public class FullScreenVideoTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return Playable.Create(graph, inputCount);
	}
}
