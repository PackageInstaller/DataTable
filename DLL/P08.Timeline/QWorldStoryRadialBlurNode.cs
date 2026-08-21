using UnityEngine;
using UnityEngine.Playables;

public class QWorldStoryRadialBlurNode : PlayableAsset
{
	public AnimationCurve ScaleCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public AnimationCurve RangeCurve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(0.5f, 1f), new Keyframe(1f, 1f));

	public AnimationCurve SoftCurve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(0.5f, 1f), new Keyframe(1f, 1f));

	public bool IsOutward;

	public AnimationCurve WarpLerp = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public AnimationCurve WarpScale = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public AnimationCurve WarpDensity = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public AnimationCurve AbberationIntensity = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 0f), new Keyframe(1f, 0f));

	public ExposedReference<Transform> CenterER;

	public Vector2 CenterTransform = Vector2.zero;

	public bool IsUseCenterTransform;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<QWorldStoryRadialBlurNodeBehaviour> scriptPlayable = ScriptPlayable<QWorldStoryRadialBlurNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().ScaleCurve = ScaleCurve;
		scriptPlayable.GetBehaviour().RangeCurve = RangeCurve;
		scriptPlayable.GetBehaviour().SoftCurve = SoftCurve;
		scriptPlayable.GetBehaviour().IsOutward = IsOutward;
		scriptPlayable.GetBehaviour().WarpLerp = WarpLerp;
		scriptPlayable.GetBehaviour().WarpScale = WarpScale;
		scriptPlayable.GetBehaviour().WarpDensity = WarpDensity;
		scriptPlayable.GetBehaviour().AbberationIntensity = AbberationIntensity;
		scriptPlayable.GetBehaviour().CenterTransform = CenterTransform;
		scriptPlayable.GetBehaviour().IsUseCenterTransform = IsUseCenterTransform;
		scriptPlayable.GetBehaviour().CenterER = CenterER;
		return scriptPlayable;
	}
}
