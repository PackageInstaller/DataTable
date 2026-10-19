using System;
using ACT;
using ACT.UI;
using Fundamental;
using UnityEngine;

public class DestinyTriggerIcon : MonoBehaviour
{
	public BetterAnimation anim;

	public bool orginalPostaionIsUp;

	private bool _active;

	public void PlayAnim(bool isActive, Action onAnimComplate)
	{
		if (_active == isActive)
		{
			return;
		}
		string text;
		if (isActive)
		{
			text = (orginalPostaionIsUp ? "Active1" : "Active2");
		}
		else
		{
			text = (orginalPostaionIsUp ? "Normal1" : "Normal2");
		}
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		anim?.GetSequence(text).OnAnimationPlay((AnimationBuilder _) =>
		{
			if (isActive)
			{
				PlayCommonDestinyActiveSound();
			}
		}).OnComplete((AnimationBuilder _) =>
		{
			onAnimComplate?.Invoke();
			_active = isActive;
		})
			.Play();
	}

	public void InitDisplay(bool isActive)
	{
		string text;
		if (isActive)
		{
			text = (orginalPostaionIsUp ? "ActiveStatus1" : "ActiveStatus2");
		}
		else
		{
			text = (orginalPostaionIsUp ? "Normal1" : "Normal2");
		}
		if (!string.IsNullOrEmpty(text))
		{
			anim?.GetSequence(text).OnComplete((AnimationBuilder _) =>
			{
				_active = isActive;
			}).Play()
				.Complete();
		}
	}

	public void PlayCommonDestinyActiveSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GlowingStage/Active");
	}
}
