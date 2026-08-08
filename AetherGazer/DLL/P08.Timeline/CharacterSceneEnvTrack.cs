using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[DisplayName("DLC角色场景环境参数(CharacterSceneEnvNode)")]
[TrackClipType(typeof(CharacterSceneEnvNode))]
public class CharacterSceneEnvTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<CharacterSceneEnvModifyMixer>.Create(graph, inputCount);
	}
}
