using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("角色边缘光处理(CharacterRimLight)")]
public class StoryCharacterRimLightNode : PlayableAsset
{
	public Gradient RimLightColor;

	public AnimationCurve RimLightThreshold;

	public AnimationCurve RimLightFade;

	public AnimationCurve RimLightRange;

	public AnimationCurve RimLightInclination;

	public AnimationCurve RimLightAzimuth1;

	public AnimationCurve RimLightAzimuth2;

	public bool ResetValueAfterEnd = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryCharacterRimLightNodeBehaviour> scriptPlayable = ScriptPlayable<StoryCharacterRimLightNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().m_rimLightColor = RimLightColor;
		scriptPlayable.GetBehaviour().m_rimLightThreshold = RimLightThreshold;
		scriptPlayable.GetBehaviour().m_rimLightFade = RimLightFade;
		scriptPlayable.GetBehaviour().m_rimLightRange = RimLightRange;
		scriptPlayable.GetBehaviour().m_rimLightInclination = RimLightInclination;
		scriptPlayable.GetBehaviour().m_rimLightAzimuth1 = RimLightAzimuth1;
		scriptPlayable.GetBehaviour().m_rimLightAzimuth2 = RimLightAzimuth2;
		scriptPlayable.GetBehaviour().m_resetValueAfterEnd = ResetValueAfterEnd;
		return scriptPlayable;
	}
}
