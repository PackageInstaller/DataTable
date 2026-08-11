using System;

namespace GameFramework.Runtime;

public class GenericUIAnimation<T> : IAnimation where T : IUIView
{
	private T view;

	private AnimationAction<T> animation;

	private Action _onStart;

	private Action _onEnd;

	public GenericUIAnimation(T view, AnimationAction<T> animation)
	{
		this.view = view;
		this.animation = animation;
	}

	protected virtual void OnStart()
	{
		try
		{
			if (_onStart != null)
			{
				_onStart();
				_onStart = null;
			}
		}
		catch (Exception)
		{
		}
	}

	protected virtual void OnEnd()
	{
		try
		{
			if (_onEnd != null)
			{
				_onEnd();
				_onEnd = null;
			}
		}
		catch (Exception)
		{
		}
	}

	public IAnimation OnStart(Action onStart)
	{
		_onStart = (Action)Delegate.Combine(_onStart, onStart);
		return this;
	}

	public IAnimation OnEnd(Action onEnd)
	{
		_onEnd = (Action)Delegate.Combine(_onEnd, onEnd);
		return this;
	}

	public virtual IAnimation Play()
	{
		if (animation != null)
		{
			animation(view, OnStart, OnEnd);
		}
		return this;
	}
}
