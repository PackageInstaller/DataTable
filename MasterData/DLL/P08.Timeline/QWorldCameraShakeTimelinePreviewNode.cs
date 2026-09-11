using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

public class QWorldCameraShakeTimelinePreviewNode : PlayableAsset
{
	public NoiseSettings noiseSettings;

	public float amplitudeGainInput;

	public float frequencyGainInput;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<QWorldCameraShakeTimelinePreviewNodePlayable> scriptPlayable = ScriptPlayable<QWorldCameraShakeTimelinePreviewNodePlayable>.Create(graph);
		scriptPlayable.GetBehaviour().noiseSettings = noiseSettings;
		scriptPlayable.GetBehaviour().amplitudeGainInput = amplitudeGainInput;
		scriptPlayable.GetBehaviour().frequencyGainInput = frequencyGainInput;
		return scriptPlayable;
	}
}
