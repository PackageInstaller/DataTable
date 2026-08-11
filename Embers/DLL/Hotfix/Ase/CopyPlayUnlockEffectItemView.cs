using System;
using GameFramework.Runtime;

namespace Ase;

public class CopyPlayUnlockEffectItemView : UGuiView
{
	public AutoDispose newUnlockEffect;

	protected virtual void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	protected virtual void SettleOpt(string optName)
	{
		if ("PlayUnlockEffect".Equals(optName))
		{
			PlayNewUnlockEffect();
		}
	}

	protected virtual void PlayNewUnlockEffect()
	{
		if (newUnlockEffect != null)
		{
			newUnlockEffect.gameObject.SetActive(value: true);
			newUnlockEffect.AddDisposeAction((Action)delegate
			{
				newUnlockEffect.gameObject.SetActive(value: false);
				AfterPlayNewUnlockEffect();
			});
		}
	}

	protected virtual void AfterPlayNewUnlockEffect()
	{
	}
}
