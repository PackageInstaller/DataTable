using System.Collections;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class AlphaAnimation : UIAnimation
{
	[Range(0f, 1f)]
	public float from = 1f;

	[Range(0f, 1f)]
	public float to = 1f;

	public float duration = 2f;

	public bool ingoreTimeScale;

	private IUIView view;

	private async void OnEnable()
	{
		view = GetComponent<IUIView>();
		switch (base.AnimationType)
		{
		case AnimationType.EnterAnimation:
			view.EnterAnimation = this;
			break;
		case AnimationType.ExitAnimation:
			view.ExitAnimation = this;
			break;
		case AnimationType.ActivationAnimation:
			if (view is IWindowView windowView2)
			{
				windowView2.ActivationAnimation = this;
			}
			break;
		case AnimationType.PassivationAnimation:
			if (view is IWindowView windowView)
			{
				windowView.PassivationAnimation = this;
			}
			break;
		}
		if (base.AnimationType == AnimationType.ActivationAnimation || base.AnimationType == AnimationType.EnterAnimation)
		{
			view.CanvasGroup.alpha = from;
		}
	}

	public override IAnimation Play()
	{
		if (this == null)
		{
			return null;
		}
		StartCoroutine(DoPlay());
		return this;
	}

	private IEnumerator DoPlay()
	{
		OnStart();
		if (view == null)
		{
			yield return null;
		}
		float delta = (to - from) / duration;
		float alpha = from;
		view.Alpha = alpha;
		if (delta > 0f)
		{
			while (alpha < to)
			{
				alpha += delta * (ingoreTimeScale ? Time.unscaledDeltaTime : Time.deltaTime);
				if (alpha > to)
				{
					alpha = to;
				}
				view.Alpha = alpha;
				yield return null;
			}
		}
		else
		{
			while (alpha > to)
			{
				alpha += delta * (ingoreTimeScale ? Time.unscaledDeltaTime : Time.deltaTime);
				if (alpha < to)
				{
					alpha = to;
				}
				view.Alpha = alpha;
				yield return null;
			}
		}
		OnEnd();
	}
}
