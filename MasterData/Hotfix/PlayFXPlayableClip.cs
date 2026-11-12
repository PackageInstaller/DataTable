using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public sealed class PlayFXPlayableClip : PlayableAsset, ITimelineClipAsset
{
	public enum Mode
	{
		[InspectorName("播放预制体特效")]
		PlayFX = 1,
		[InspectorName("播放内嵌在Timeline上的特效")]
		PlaySelfFX,
		[InspectorName("停止内嵌在Timeline上的特效")]
		StopSelfFX
	}

	public Mode mode = Mode.PlayFX;

	public GameObject fxPrefab;

	public ExposedReference<GameObject> fxInstance;

	public bool playOnceInLoop;

	public bool stopFXOnFinish;

	public ExposedReference<GameObject> bindOwner;

	public ClipCaps clipCaps => ClipCaps.SpeedMultiplier | ClipCaps.Blending;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		ScriptPlayable<PlayFXPlayableBehaviour> scriptPlayable = ScriptPlayable<PlayFXPlayableBehaviour>.Create(graph);
		PlayFXPlayableBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.mode = mode;
		behaviour.fxPrefab = fxPrefab;
		behaviour.fxInstance = fxInstance.Resolve(graph.GetResolver());
		behaviour.playOnceInLoop = playOnceInLoop;
		behaviour.stopFXOnFinish = stopFXOnFinish;
		behaviour.bindOwner = bindOwner.Resolve(graph.GetResolver());
		return scriptPlayable;
	}
}
