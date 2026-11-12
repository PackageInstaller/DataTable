using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[TrackClipType(typeof(SDFacialBlinkClip))]
[TrackBindingType(typeof(SDFacialAnimator))]
[TrackColor(0.6f, 0.35f, 0.5f)]
public sealed class SDFacialBlinkTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<SDFacialBlinkMixer>.Create(graph, inputCount);
	}
}
