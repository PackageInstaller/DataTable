using System;
using ACT.Battle;
using ACT.UI;

namespace ACT;

public class OperationPanel : SettingPanel
{
	public BetterAnimation pcPanel;

	public BetterAnimation mobilePanel;

	public override void PlayOpenAnim(Action onFinish = null)
	{
		if (MonoECS.instance.ispc)
		{
			pcPanel.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				onFinish?.Invoke();
			}).Play();
		}
		else
		{
			mobilePanel.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				onFinish?.Invoke();
			}).Play();
		}
	}

	public override void PlayCloseAnim(Action onFinish = null)
	{
		if (MonoECS.instance.ispc)
		{
			pcPanel.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				onFinish?.Invoke();
			}).Play();
		}
		else
		{
			mobilePanel.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				onFinish?.Invoke();
			}).Play();
		}
	}
}
