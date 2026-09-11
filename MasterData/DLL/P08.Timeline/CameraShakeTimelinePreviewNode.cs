using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

public class CameraShakeTimelinePreviewNode : PlayableAsset
{
	public NoiseSettings noiseSettings;

	public float amplitudeGainInput;

	public float frequencyGainInput;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<CameraShakeTimelinePreviewNodePlayable> scriptPlayable = ScriptPlayable<CameraShakeTimelinePreviewNodePlayable>.Create(graph);
		scriptPlayable.GetBehaviour().noiseSettings = noiseSettings;
		scriptPlayable.GetBehaviour().amplitudeGainInput = amplitudeGainInput;
		scriptPlayable.GetBehaviour().frequencyGainInput = frequencyGainInput;
		return scriptPlayable;
	}
}
