using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("场景后处理")]
public class QWorldStoryScenePostEffectNode : PlayableAsset
{
	public bool Tonemapping = true;

	public AnimationCurve Exposure = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public AnimationCurve Contrast = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public bool Invert = true;

	public AnimationCurve Grayness = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public AnimationCurve Darkness = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<QWorldStoryScenePostEffectNodeBehaviour> scriptPlayable = ScriptPlayable<QWorldStoryScenePostEffectNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().Tonemapping = Tonemapping;
		scriptPlayable.GetBehaviour().Exposure = Exposure;
		scriptPlayable.GetBehaviour().Contrast = Contrast;
		scriptPlayable.GetBehaviour().Grayness = Grayness;
		scriptPlayable.GetBehaviour().Darkness = Darkness;
		scriptPlayable.GetBehaviour().Invert = Invert;
		return scriptPlayable;
	}
}
