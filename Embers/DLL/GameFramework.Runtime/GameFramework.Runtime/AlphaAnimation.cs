using System.Collections;
using UnityEngine;

namespace GameFramework.Runtime;

public class AlphaAnimation : UIAnimation
{
	[Range(0f, 1f)]
	public float from = 1f;

	[Range(0f, 1f)]
	public float to = 1f;

	public float duration = 2f;

	private IUIView view;

	private void OnEnable()
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
			if (view is IWindowView)
			{
				(view as IWindowView).ActivationAnimation = this;
			}
			break;
		case AnimationType.PassivationAnimation:
			if (view is IWindowView)
			{
				(view as IWindowView).PassivationAnimation = this;
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
		StartCoroutine(DoPlay());
		return this;
	}

	private IEnumerator DoPlay()
	{
		OnStart();
		float delta = (to - from) / duration;
		float alpha = from;
		view.Alpha = alpha;
		if (delta > 0f)
		{
			while (alpha < to)
			{
				alpha += delta * Time.deltaTime;
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
				alpha += delta * Time.deltaTime;
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
