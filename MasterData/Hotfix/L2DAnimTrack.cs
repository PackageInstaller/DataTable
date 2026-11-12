using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[TrackClipType(typeof(L2DAnimClip))]
[TrackBindingType(typeof(L2DAnimPlayer))]
public sealed class L2DAnimTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<L2DAnimMixer> scriptPlayable = ScriptPlayable<L2DAnimMixer>.Create(graph);
		scriptPlayable.SetInputCount(inputCount);
		return scriptPlayable;
	}
}
