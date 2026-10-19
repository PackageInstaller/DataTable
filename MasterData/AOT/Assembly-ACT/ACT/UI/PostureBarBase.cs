using UnityEngine;

namespace ACT.UI;

public abstract class PostureBarBase : MonoBehaviour
{
	[SerializeField]
	protected TargetValueMaskBar bar;

	[SerializeField]
	protected TargetValueMaskBar weakBar;

	[SerializeField]
	protected BetterAnimation mainAnimation;

	protected EntityUIInfo EntityUIInfo;

	public virtual void Init(EntityUIInfo entityUIInfo, bool playInitAnimation = true)
	{
		EntityUIInfo = entityUIInfo;
	}

	protected void PlayInitAnimation(string animationName, bool playAnimation)
	{
		AnimationBuilder animationBuilder = mainAnimation?.GetSequence(animationName);
		if (playAnimation)
		{
			animationBuilder?.Play();
		}
		else
		{
			animationBuilder?.Complete();
		}
	}

	public virtual void UInit()
	{
	}

	public virtual void OnPostureValChange()
	{
	}

	public virtual void OnEnterPosture()
	{
	}

	public virtual void OnExitPosture()
	{
	}

	public virtual void OnEnterWeak()
	{
	}

	public virtual void OnExitWeak()
	{
	}

	public virtual void OnWeakChange()
	{
		if (weakBar != null)
		{
			TargetValueMaskBar targetValueMaskBar = weakBar;
			float value = (weakBar.TargetValue = EntityUIInfo.CurWeakPercentage);
			targetValueMaskBar.Value = value;
		}
	}

	public virtual void Posture2Weak()
	{
	}

	public virtual void Weak2Posture()
	{
	}

	public void InitBarVal(float percentage)
	{
		percentage = Mathf.Clamp01(percentage);
		TargetValueMaskBar targetValueMaskBar = bar;
		float value = (bar.TargetValue = percentage);
		targetValueMaskBar.Value = value;
	}
}
