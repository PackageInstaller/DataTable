using System;

namespace Ase;

public class CopyPlayUnlockEffectWindow : UGuiWindowBase
{
	public AutoDispose wMask;

	public AutoDispose aniMask;

	protected override void OnShow()
	{
		base.OnShow();
		OnOpenPlayAniMask();
	}

	protected void OnOpenPlayAniMask()
	{
		if (CheckNeedPlayEffect() && aniMask != null)
		{
			aniMask.gameObject.SetActive(value: true);
			aniMask.AddDisposeAction((Action)delegate
			{
				aniMask.gameObject.SetActive(value: false);
				OnPlayUnlockEffect();
			});
		}
	}

	protected void SetAniMaskDuration(float dura)
	{
		aniMask.ResetTime(dura);
	}

	protected void OnPlayUnlockEffect()
	{
		if (CheckNeedPlayEffect())
		{
			PlayUnlockEffect();
			if (wMask != null)
			{
				wMask.gameObject.SetActive(value: true);
				wMask.AddDisposeAction((Action)delegate
				{
					wMask.gameObject.SetActive(value: false);
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().SaveEffectPlay();
				});
			}
		}
		else
		{
			wMask.gameObject.SetActive(value: false);
		}
	}

	public virtual bool CheckNeedPlayEffect()
	{
		return true;
	}

	public virtual void PlayUnlockEffect()
	{
	}
}
