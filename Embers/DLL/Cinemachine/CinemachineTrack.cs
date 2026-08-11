using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[TrackClipType(typeof(CinemachineShot))]
[TrackBindingType(/*Could not decode attribute arguments.*/)]
[TrackColor(0.53f, 0f, 0.08f)]
public class CinemachineTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<CinemachineMixer> scriptPlayable = ScriptPlayable<CinemachineMixer>.Create(graph);
		scriptPlayable.SetInputCount(inputCount);
		return scriptPlayable;
	}
}
