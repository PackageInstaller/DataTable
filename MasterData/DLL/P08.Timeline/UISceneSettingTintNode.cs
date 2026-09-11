using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("场景色调(Tint)")]
public class UISceneSettingTintNode : PlayableAsset
{
	public Gradient TintColorGradient;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<UISceneSettingTintBehaviour> scriptPlayable = ScriptPlayable<UISceneSettingTintBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().Initialize(TintColorGradient);
		return scriptPlayable;
	}
}
