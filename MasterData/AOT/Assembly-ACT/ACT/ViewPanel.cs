using System;
using ACT.UI;

namespace ACT;

public class ViewPanel : SettingPanel
{
	public BetterAnimation betterAnimation;

	public override void PlayOpenAnim(Action onFinish = null)
	{
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			onFinish?.Invoke();
		}).Play();
	}

	public override void PlayCloseAnim(Action onFinish = null)
	{
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			onFinish?.Invoke();
		}).Play();
	}
}
