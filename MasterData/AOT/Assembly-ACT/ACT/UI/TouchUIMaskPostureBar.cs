using System;
using ACT.Battle.Configs;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[Obsolete]
public class TouchUIMaskPostureBar : TouchUIMaskBase
{
	public Slider frontSlider;

	public Slider backSlider;

	public Image bg;

	public Image weakBar;

	public Animation postureDisappear;

	public GameObject enterWeak;

	public GameObject recover;

	public GameObject damageMultiplier;

	public GameObject breakEffect;

	public override void SetValue()
	{
		frontSlider.value = targetValue;
		backSlider.value = value;
	}

	public void Close()
	{
		if (postureDisappear != null && postureDisappear.isPlaying)
		{
			postureDisappear.Stop();
		}
		if (enterWeak != null)
		{
			enterWeak.gameObject.SetActive(value: false);
		}
		if (recover != null)
		{
			recover.gameObject.SetActive(value: false);
		}
		bg.color = Color.white;
		gameObject.SetActive(value: false);
	}

	public void ResetPosture()
	{
		if (postureDisappear != null && postureDisappear.isPlaying)
		{
			postureDisappear.Stop();
		}
		if (enterWeak != null)
		{
			enterWeak.gameObject.SetActive(value: false);
		}
		if (recover != null)
		{
			recover.gameObject.SetActive(value: false);
		}
		frontSlider.gameObject.SetActive(value: true);
		backSlider.gameObject.SetActive(value: true);
		breakEffect?.SetActive(value: false);
		bg.color = Color.white;
		weakBar.fillAmount = 0f;
		if (damageMultiplier != null)
		{
			damageMultiplier.gameObject.SetActive(value: false);
		}
	}

	public void PostureOpen()
	{
		gameObject.SetActive(value: true);
	}

	public void PostureClose()
	{
		if (postureDisappear != null)
		{
			postureDisappear.Play();
		}
		else
		{
			gameObject.SetActive(value: false);
		}
	}

	public void EnterWeak(WeakEndMode weakEndMode)
	{
		enterWeak?.SetActive(value: true);
		recover?.SetActive(value: false);
		breakEffect?.SetActive(value: true);
		switch (weakEndMode)
		{
		case WeakEndMode.WeakEndToNormal:
		{
			frontSlider.gameObject.SetActive(value: false);
			backSlider.gameObject.SetActive(value: true);
			float num = (targetValue = 1f);
			value = num;
			break;
		}
		case WeakEndMode.WeakEndInactivePosture:
		{
			frontSlider.gameObject.SetActive(value: false);
			backSlider.gameObject.SetActive(value: false);
			float num = (targetValue = 0f);
			value = num;
			weakBar.fillAmount = 0f;
			break;
		}
		}
	}

	public void ExitWeak(WeakEndMode weakEndMode)
	{
		breakEffect?.SetActive(value: false);
		if (weakEndMode != WeakEndMode.WeakEndToNormal)
		{
			_ = 1;
			return;
		}
		frontSlider.gameObject.SetActive(value: true);
		frontSlider.value = 1f;
		if (enterWeak != null)
		{
			enterWeak.gameObject.SetActive(value: false);
		}
		if (recover != null)
		{
			recover.gameObject.SetActive(value: true);
		}
		weakBar.fillAmount = 0f;
	}
}
