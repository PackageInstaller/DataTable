using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("闪白")]
public class StoryFlashActionNode : PlayableAsset
{
	public AnimationCurve Curve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public bool IsCustomFillColor;

	[ColorUsage(true, true)]
	public Color FillOuter = Color.white;

	[ColorUsage(true, true)]
	public Color FillInner = Color.white;

	[Range(0f, 16f)]
	public float FillSoft = 2f;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryFlashActionNodeBehaviour> scriptPlayable = ScriptPlayable<StoryFlashActionNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().Curve = Curve;
		scriptPlayable.GetBehaviour().IsCustomFillColor = IsCustomFillColor;
		scriptPlayable.GetBehaviour().FillOuter = FillOuter;
		scriptPlayable.GetBehaviour().FillInner = FillInner;
		scriptPlayable.GetBehaviour().FillSoft = FillSoft;
		return scriptPlayable;
	}
}
