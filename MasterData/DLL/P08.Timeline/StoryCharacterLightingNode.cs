using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("角色阴影处理(CharacterLighting)")]
public class StoryCharacterLightingNode : PlayableAsset
{
	public AnimationCurve LightInclination;

	public AnimationCurve LightAzimuth;

	public bool ResetValueAfterEnd = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryCharacterLightingNodeBehaviour> scriptPlayable = ScriptPlayable<StoryCharacterLightingNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().m_lightInclination = LightInclination;
		scriptPlayable.GetBehaviour().m_lightAzimuth = LightAzimuth;
		scriptPlayable.GetBehaviour().m_ResetValueAfterEnd = ResetValueAfterEnd;
		return scriptPlayable;
	}
}
