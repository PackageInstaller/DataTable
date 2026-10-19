using System;
using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[TrackColor(0.53f, 0f, 0.08f)]
[TrackBindingType(typeof(CinemachineBrain), TrackBindingFlags.None)]
[TrackClipType(typeof(CinemachineShot))]
public class CinemachineTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<CinemachineMixer> scriptPlayable = ScriptPlayable<CinemachineMixer>.Create(graph);
		scriptPlayable.SetInputCount(inputCount);
		return scriptPlayable;
	}
}
