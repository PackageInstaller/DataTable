using System;
using UnityEngine;

namespace GameFramework.Runtime;

public abstract class UIAnimation : MonoBehaviour, IAnimation
{
	private Action _onStart;

	private Action _onEnd;

	[SerializeField]
	private AnimationType animationType;

	public AnimationType AnimationType
	{
		get
		{
			return animationType;
		}
		set
		{
			animationType = value;
		}
	}

	protected void OnStart()
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

	protected void OnEnd()
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

	public abstract IAnimation Play();
}
