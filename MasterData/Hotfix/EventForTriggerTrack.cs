using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[TrackClipType(typeof(EventForTriggerClip))]
public sealed class EventForTriggerTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<EventForTriggerMixer> scriptPlayable = ScriptPlayable<EventForTriggerMixer>.Create(graph);
		scriptPlayable.SetInputCount(inputCount);
		return scriptPlayable;
	}
}
