using UnityEngine;
using UnityEngine.Playables;

public class CharacterEffectSliceNode : PlayableAsset
{
	public float Offset;

	public AnimationCurve OffsetCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f));

	public float Range = 1f;

	public AnimationCurve RangeCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f));

	public float Density = 10f;

	public AnimationCurve DensityCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f));

	public float Speed = 1f;

	public AnimationCurve SpeedCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f));

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<CharacterEffectSliceNodeBehaviour> scriptPlayable = ScriptPlayable<CharacterEffectSliceNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().Offset = Offset;
		scriptPlayable.GetBehaviour().OffsetCurve = OffsetCurve;
		scriptPlayable.GetBehaviour().Range = Range;
		scriptPlayable.GetBehaviour().RangeCurve = RangeCurve;
		scriptPlayable.GetBehaviour().Density = Density;
		scriptPlayable.GetBehaviour().DensityCurve = DensityCurve;
		scriptPlayable.GetBehaviour().Speed = Speed;
		scriptPlayable.GetBehaviour().SpeedCurve = SpeedCurve;
		return scriptPlayable;
	}
}
