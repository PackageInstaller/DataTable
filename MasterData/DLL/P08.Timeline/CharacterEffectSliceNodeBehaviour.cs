using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Playables;

public class CharacterEffectSliceNodeBehaviour : PlayableBehaviour
{
	private float m_originOffset;

	private float m_originRange = 1f;

	private float m_originDensity = 10f;

	private float m_originSpeed = 1f;

	public GameObject TPose;

	public float Offset;

	public AnimationCurve OffsetCurve;

	public float Range = 1f;

	public AnimationCurve RangeCurve;

	public float Density = 10f;

	public AnimationCurve DensityCurve;

	public float Speed = 1f;

	public AnimationCurve SpeedCurve;

	public SliceEffect SliceEffect;

	private void ResetSliceEffectParams()
	{
		if (SliceEffect != null)
		{
			SliceEffect.offset = m_originOffset;
			SliceEffect.range = m_originRange;
			SliceEffect.density = m_originDensity;
			SliceEffect.speed = m_originSpeed;
			SliceEffect.enabled = false;
			SliceEffect = null;
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		ResetSliceEffectParams();
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		ResetSliceEffectParams();
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		ResetSliceEffectParams();
	}

	public override void PrepareData(Playable playable, FrameData info)
	{
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (SliceEffect == null)
		{
			SliceEffect = ((CharacterEffect)playerData).sliceEffect;
			m_originOffset = SliceEffect.offset;
			m_originRange = SliceEffect.range;
			m_originDensity = SliceEffect.density;
			m_originSpeed = SliceEffect.speed;
		}
		if (!SliceEffect.enabled)
		{
			SliceEffect.enabled = true;
		}
		float num = (float)playable.GetTime();
		float num2 = (float)playable.GetDuration();
		float time = num / num2;
		SliceEffect.offset = OffsetCurve.Evaluate(time) * Offset;
		SliceEffect.range = RangeCurve.Evaluate(time) * Range;
		SliceEffect.density = DensityCurve.Evaluate(time) * Density;
		SliceEffect.speed = SpeedCurve.Evaluate(time) * Speed;
	}
}
