using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[TrackClipType(typeof(SDFacialExpressionClip))]
[TrackBindingType(typeof(SDFacialAnimator))]
[TrackColor(0.85f, 0.6f, 0.75f)]
public sealed class SDFacialExpressionTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<SDFacialExpressionMixer>.Create(graph, inputCount);
	}
}
