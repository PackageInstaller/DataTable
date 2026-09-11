using System.Linq;
using System.Runtime.CompilerServices;
using Animancer;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Scripting;

public class ManualAnimationBehaviour : PlayableBehaviour
{
	public AnimationClip m_clip;

	public float m_blendTime = 0.3f;

	public Animator m_animatior;

	public double m_speed;

	private Playable m_playable;

	[SerializeField]
	private AnimancerComponent animancer;

	[SerializeField]
	private ManualAnimator manualAnimator;

	public override void OnGraphStart(Playable playable)
	{
		if (!(null == m_animatior))
		{
			base.OnGraphStart(playable);
			m_animatior.TryGetComponent<ManualAnimator>(out manualAnimator);
			if (!m_animatior.TryGetComponent<AnimancerComponent>(out animancer) && !manualAnimator)
			{
				manualAnimator = m_animatior.gameObject.AddComponent<ManualAnimator>();
			}
		}
	}

	[Preserve]
	private static Playable Play(Playable playable, AnimancerComponent animancer, AnimationClip clip, float blendTime, double speed)
	{
		if (!LuaForUtil.IsManualAnimatorBlend)
		{
			blendTime = 0f;
		}
		double time = playable.GetTime();
		Playable playable2 = animancer.Play(clip, blendTime).Playable;
		playable2.SetTime(time);
		playable2.SetSpeed(speed);
		return playable2;
	}

	[Preserve]
	private static Playable Play(Playable playable, ManualAnimator manualAnimator, AnimationClip clip, float blendTime, double speed)
	{
		double time = playable.GetTime();
		return manualAnimator.Play(playable.GetHashCode(), clip, time, blendTime, speed);
	}

	[MethodImpl((MethodImplOptions)256)]
	[Preserve]
	private static void Stop(Playable playable, AnimancerComponent animancer, AnimationClip clip)
	{
	}

	[MethodImpl((MethodImplOptions)256)]
	[Preserve]
	private static void Stop(Playable playable, ManualAnimator manualAnimator, AnimationClip clip)
	{
		manualAnimator.Stop(playable.GetHashCode(), clip);
	}

	public override void OnBehaviourPlay(Playable playable, FrameData inf)
	{
		if (!(null == m_animatior) && Application.isPlaying)
		{
			if ((bool)animancer)
			{
				m_playable = Play(playable, animancer, m_clip, m_blendTime, m_speed);
			}
			else if ((bool)manualAnimator)
			{
				m_playable = Play(playable, manualAnimator, m_clip, m_blendTime, m_speed);
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		m_playable = Playable.Null;
		if (!(null == m_animatior) && Application.isPlaying)
		{
			if ((bool)animancer)
			{
				Stop(playable, animancer, m_clip);
			}
			else if ((bool)manualAnimator)
			{
				Stop(playable, manualAnimator, m_clip);
			}
		}
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		base.PrepareFrame(playable, info);
		if (!m_playable.IsNull() && m_playable.IsValid())
		{
			float num = (float)playable.GetTime();
			m_playable.SetTime(num);
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		base.OnPlayableDestroy(playable);
		if ((bool)animancer)
		{
			AnimancerState[] array = animancer.States.Where((AnimancerState _state) => _state.EffectiveWeight == 0f).ToArray();
			for (int num = 0; num < array.Length; num++)
			{
				array[num].Destroy();
			}
		}
	}
}
