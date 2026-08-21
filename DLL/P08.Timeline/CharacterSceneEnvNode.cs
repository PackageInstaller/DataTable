using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

internal class CharacterSceneEnvNode : PlayableAsset, ITimelineClipAsset
{
	public CharacterSceneEnvModifyBehaviour template = new CharacterSceneEnvModifyBehaviour();

	public ClipCaps clipCaps => ClipCaps.Extrapolation | ClipCaps.Blending;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<CharacterSceneEnvModifyBehaviour>.Create(graph, template);
	}
}
