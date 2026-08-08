using System;
using System.Collections.Generic;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("闪白(单材质)")]
public class StoryFlashActionOverriderNode : PlayableAsset
{
	public AnimationCurve Curve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public bool IsCustomFillColor;

	[ColorUsage(true, true)]
	public Color FillOuter = Color.white;

	[ColorUsage(true, true)]
	public Color FillInner = Color.white;

	[Range(0f, 16f)]
	public float FillSoft = 2f;

	public bool AssignMaterial;

	public List<int> MaterialIndexes;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryFlashActionOverriderNodeBehaviour> scriptPlayable = ScriptPlayable<StoryFlashActionOverriderNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().Curve = Curve;
		scriptPlayable.GetBehaviour().IsCustomFillColor = IsCustomFillColor;
		scriptPlayable.GetBehaviour().FillOuter = FillOuter;
		scriptPlayable.GetBehaviour().FillInner = FillInner;
		scriptPlayable.GetBehaviour().FillSoft = FillSoft;
		scriptPlayable.GetBehaviour().AssignMaterial = AssignMaterial;
		scriptPlayable.GetBehaviour().MaterialIndexes = MaterialIndexes;
		return scriptPlayable;
	}
}
