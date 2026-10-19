using UnityEngine;

namespace ACT.UI;

public abstract class SubUIViewBase : SubUIViewBase<SubUIViewInputController>
{
}
public abstract class SubUIViewBase<T> : SubUIView<T>, ISubUIViewLifecycle, ISubUIView, IBaseUIComponent where T : class, ISubInputController, new()
{
	protected const string OpenAnimationName = "Show";

	protected const string CloseAnimationName = "Hide";

	protected const string SwitchOpenAnimationName = "SwitchShow";

	protected const string SwitchCloseAnimationName = "SwitchHide";

	[SerializeField]
	protected BetterAnimation betterAnimation;

	public bool IsInited { get; private set; }

	public void Init(object param = null, bool isInit = true)
	{
		if (IsInited)
		{
			OnReInit(param);
			return;
		}
		IsInited = true;
		if (!gameObject.activeSelf)
		{
			gameObject.SetActive(value: true);
		}
		OnInit(param);
		FocusIn();
		PlayOpenAnimation(isInit);
	}

	public void UnInit(bool isClose = true)
	{
		if (IsInited)
		{
			IsInited = false;
			OnUnInit();
			FocusOut();
			PlayCloseAnimation(isClose);
		}
	}

	protected virtual void PlayOpenAnimation(bool isInit)
	{
		if (betterAnimation == null)
		{
			OnOpenAnimationComplete();
			return;
		}
		betterAnimation.StopAnimation();
		string animationName = (isInit ? "Show" : "SwitchShow");
		AnimationBuilder sequence = betterAnimation.GetSequence(animationName);
		if (sequence == null)
		{
			OnOpenAnimationComplete();
			return;
		}
		sequence.OnComplete((AnimationBuilder _) =>
		{
			OnOpenAnimationComplete();
		}).Play();
	}

	protected virtual void PlayCloseAnimation(bool isClose)
	{
		if (betterAnimation == null)
		{
			OnCloseAnimationComplete();
			return;
		}
		betterAnimation.StopAnimation();
		string animationName = (isClose ? "Hide" : "SwitchHide");
		AnimationBuilder sequence = betterAnimation.GetSequence(animationName);
		if (sequence == null)
		{
			OnCloseAnimationComplete();
			return;
		}
		sequence.OnComplete((AnimationBuilder _) =>
		{
			OnCloseAnimationComplete();
		}).Play();
	}

	protected virtual void OnInit(object param)
	{
	}

	protected virtual void OnReInit(object param)
	{
		OnInit(param);
	}

	protected virtual void OnUnInit()
	{
	}

	protected virtual void OnOpenAnimationComplete()
	{
	}

	protected virtual void OnCloseAnimationComplete()
	{
		if (this != null && gameObject != null)
		{
			gameObject.SetActive(value: false);
		}
	}
}
