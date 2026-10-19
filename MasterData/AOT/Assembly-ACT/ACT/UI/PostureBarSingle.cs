using UnityEngine;

namespace ACT.UI;

public class PostureBarSingle : PostureBarBase
{
	[SerializeField]
	protected PercentParticle postureParticle;

	[SerializeField]
	protected PercentParticle postureParticleLite;

	[SerializeField]
	protected string postureChangeAnimation;

	[SerializeField]
	protected string enterWeakAnimation;

	[SerializeField]
	protected string exitWeakAnimation;

	[SerializeField]
	protected string enterPostureAnimation;

	[SerializeField]
	protected string exitPostureAnimation;

	public override void Init(EntityUIInfo entityUIInfo, bool playInitAnimation = true)
	{
		base.Init(entityUIInfo, playInitAnimation);
		InitBarVal(EntityUIInfo.CurPosturePercentage);
		if (EntityUIInfo.InPosture)
		{
			if (EntityUIInfo.InWeak)
			{
				PlayInitAnimation(enterWeakAnimation, playInitAnimation);
			}
			else
			{
				PlayInitAnimation(enterPostureAnimation, playInitAnimation);
			}
		}
		else
		{
			PlayInitAnimation(exitPostureAnimation, playInitAnimation);
		}
	}

	private bool IsPostureStateAnimationPlaying()
	{
		if (mainAnimation == null || !mainAnimation.CurrentAnimationPlaying())
		{
			return false;
		}
		string text = mainAnimation.CurrentAnimationName();
		if (!(text == enterWeakAnimation) && !(text == exitWeakAnimation) && !(text == enterPostureAnimation))
		{
			return text == exitPostureAnimation;
		}
		return true;
	}

	public override void OnPostureValChange()
	{
		base.OnPostureValChange();
		float num = Mathf.Clamp01(EntityUIInfo.CurPosturePercentage);
		bar.TargetValue = num;
		if (EntityUIInfo.CurPosturePercentage < EntityUIInfo.OldPosturePercentage && !IsPostureStateAnimationPlaying())
		{
			mainAnimation.GetSequence(postureChangeAnimation)?.Play();
		}
		if (postureParticle != null && postureParticleLite != null && EntityUIInfo.DamageType == 2 && !EntityUIInfo.InWeak)
		{
			if (num < GameLoader.meta.barShakePercent)
			{
				postureParticleLite.Play(leftBase: true, bar.TargetValue);
			}
			else
			{
				postureParticle.Play(leftBase: true, bar.TargetValue);
			}
		}
	}

	public override void OnEnterWeak()
	{
		base.OnEnterWeak();
		mainAnimation.GetSequence(enterWeakAnimation)?.Play();
	}

	public override void OnExitWeak()
	{
		base.OnExitWeak();
		gameObject.SetActive(value: true);
		mainAnimation.GetSequence(exitWeakAnimation)?.Play();
		InitBarVal(EntityUIInfo.CurPosturePercentage);
	}

	public override void OnEnterPosture()
	{
		base.OnEnterPosture();
		gameObject.SetActive(value: true);
		if (EntityUIInfo.InWeak)
		{
			mainAnimation.GetSequence(enterWeakAnimation)?.Play();
		}
		else
		{
			mainAnimation.GetSequence(enterPostureAnimation)?.Play();
		}
	}

	public override void OnExitPosture()
	{
		base.OnExitPosture();
		mainAnimation.GetSequence(exitPostureAnimation)?.Play();
	}
}
