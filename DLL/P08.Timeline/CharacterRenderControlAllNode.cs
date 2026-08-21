using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
public class CharacterRenderControlAllNode : PlayableAsset, ITimelineClipAsset
{
	[SerializeField]
	public bool active = true;

	[SerializeField]
	public ActivationControlPlayable.PostPlaybackState postPlayback = ActivationControlPlayable.PostPlaybackState.Revert;

	[NonSerialized]
	[HideInInspector]
	public GameObject controlObject;

	public int controlCfg;

	public ClipCaps clipCaps => ClipCaps.ClipIn;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<CharacterRenderControllAllBehaviour> scriptPlayable = ScriptPlayable<CharacterRenderControllAllBehaviour>.Create(graph);
		CharacterRenderControllAllBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.controlObject = controlObject;
		behaviour.active = active;
		behaviour.postPlayback = postPlayback;
		behaviour.controlCfg = controlCfg;
		return scriptPlayable;
	}
}
