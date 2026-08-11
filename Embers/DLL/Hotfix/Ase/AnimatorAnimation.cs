using System.Collections;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

[RequireComponent(typeof(Animator))]
public class AnimatorAnimation : UIAnimation
{
	private Animator animator;

	public string animName = "enter";

	public float duration = 2f;

	private IUIView view;

	private void Awake()
	{
		animator = GetComponent<Animator>();
		_ = (Object)(object)animator == null;
	}

	private async void OnEnable()
	{
		view = GetComponent<IUIView>();
		if (view == null)
		{
			return;
		}
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
	}

	public override IAnimation Play()
	{
		if ((Object)(object)animator == null)
		{
			return this;
		}
		animator.SetTrigger(Animator.StringToHash(animName));
		if (base.isActiveAndEnabled)
		{
			StartCoroutine(DoPlay());
		}
		return this;
	}

	private IEnumerator DoPlay()
	{
		OnStart();
		yield return new WaitForSeconds(duration);
		OnEnd();
	}
}
