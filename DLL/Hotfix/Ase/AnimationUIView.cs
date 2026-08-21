using System;

namespace Ase;

public class AnimationUIView : UGuiView
{
	private Action _onShow;

	private Action _onHide;

	public void OnShow(Action onShow)
	{
		_onShow = (Action)Delegate.Combine(_onShow, onShow);
	}

	public void OnHide(Action onHide)
	{
		_onHide = (Action)Delegate.Combine(_onHide, onHide);
	}

	public virtual void Show(bool ignoreAnimation = false, Action onStartAction = null)
	{
		Visibility = true;
		_onShow?.Invoke();
		if (!ignoreAnimation && EnterAnimation != null)
		{
			EnterAnimation.OnStart(delegate
			{
				onStartAction?.Invoke();
			}).Play();
		}
		else
		{
			onStartAction?.Invoke();
		}
	}

	public virtual void Hide(bool ignoreAnimation = false, Action onEndAction = null)
	{
		if (!ignoreAnimation && Visibility && ExitAnimation != null)
		{
			ExitAnimation.OnEnd(delegate
			{
				Visibility = false;
				_onHide?.Invoke();
				onEndAction?.Invoke();
			}).Play();
		}
		else
		{
			Visibility = false;
			_onHide?.Invoke();
			onEndAction?.Invoke();
		}
	}
}
