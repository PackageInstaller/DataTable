#define ENABLE_DEBUG_AND_ABOVE_LOG
#define ENABLE_WARNING_AND_ABOVE_LOG
using System;
using System.Collections;

namespace GameFramework.Runtime;

public abstract class Transition : ITransition
{
	private IManageable window;

	private bool done = false;

	private bool animationDisabled = false;

	private int layer = 0;

	private Func<IWindow, IWindow, TransitionActionType> overlayPolicy;

	private bool running = false;

	private bool bound = false;

	private Action onStart;

	private Action<IWindow, WindowState> onStateChanged;

	private Action onFinish;

	public virtual IManageable Window
	{
		get
		{
			return window;
		}
		set
		{
			window = value;
		}
	}

	public virtual bool IsDone
	{
		get
		{
			return done;
		}
		protected set
		{
			done = value;
		}
	}

	public virtual bool AnimationDisabled
	{
		get
		{
			return animationDisabled;
		}
		protected set
		{
			animationDisabled = value;
		}
	}

	public virtual int Layer
	{
		get
		{
			return layer;
		}
		protected set
		{
			layer = value;
		}
	}

	public virtual Func<IWindow, IWindow, TransitionActionType> OverlayPolicy
	{
		get
		{
			return overlayPolicy;
		}
		protected set
		{
			overlayPolicy = value;
		}
	}

	public Transition(IManageable window)
	{
		this.window = window;
	}

	~Transition()
	{
		Unbind();
	}

	protected virtual void Bind()
	{
		if (!bound)
		{
			bound = true;
			if (window != null)
			{
				window.StateChanged += StateChanged;
			}
		}
	}

	protected virtual void Unbind()
	{
		if (bound)
		{
			bound = false;
			if (window != null)
			{
				window.StateChanged -= StateChanged;
			}
		}
	}

	public virtual object WaitForDone()
	{
		return Executors.WaitWhile(() => !IsDone);
	}

	protected void StateChanged(object sender, WindowStateEventArgs e)
	{
		RaiseStateChanged((IWindow)sender, e.State);
	}

	protected virtual void RaiseStart()
	{
		try
		{
			if (onStart != null)
			{
				onStart();
			}
		}
		catch (Exception arg)
		{
			Log.Warning("", arg);
		}
	}

	protected virtual void RaiseStateChanged(IWindow window, WindowState state)
	{
		try
		{
			if (onStateChanged != null)
			{
				onStateChanged(window, state);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("", arg);
		}
	}

	protected virtual void RaiseFinished()
	{
		try
		{
			if (onFinish != null)
			{
				onFinish();
			}
		}
		catch (Exception arg)
		{
			Log.Warning("", arg);
		}
	}

	protected virtual void OnStart()
	{
		Bind();
		RaiseStart();
	}

	protected virtual void OnEnd()
	{
		done = true;
		RaiseFinished();
		Unbind();
	}

	public IAwaiter GetAwaiter()
	{
		return new TransitionAwaiter(this);
	}

	public ITransition DisableAnimation(bool disabled)
	{
		if (running)
		{
			Log.Warning("The transition is running.DisableAnimation failed.");
			return this;
		}
		if (done)
		{
			Log.Warning("The transition is done.DisableAnimation failed.");
			return this;
		}
		animationDisabled = disabled;
		return this;
	}

	public ITransition AtLayer(int layer)
	{
		if (running)
		{
			Log.Warning("The transition is running.sets the layer failed.");
			return this;
		}
		if (done)
		{
			Log.Warning("The transition is done.sets the layer failed.");
			return this;
		}
		this.layer = layer;
		return this;
	}

	public ITransition Overlay(Func<IWindow, IWindow, TransitionActionType> policy)
	{
		if (running)
		{
			Log.Warning("The transition is running.sets the policy failed.");
			return this;
		}
		if (done)
		{
			Log.Warning("The transition is done.sets the policy failed.");
			return this;
		}
		OverlayPolicy = policy;
		return this;
	}

	public ITransition OnStart(Action callback)
	{
		if (running)
		{
			Log.Warning("The transition is running.OnStart failed.");
			return this;
		}
		if (done)
		{
			callback();
			return this;
		}
		onStart = (Action)Delegate.Combine(onStart, callback);
		return this;
	}

	public ITransition OnStateChanged(Action<IWindow, WindowState> callback)
	{
		if (running)
		{
			Log.Warning("The transition is running.OnStateChanged failed.");
			return this;
		}
		if (done)
		{
			return this;
		}
		onStateChanged = (Action<IWindow, WindowState>)Delegate.Combine(onStateChanged, callback);
		return this;
	}

	public ITransition OnFinish(Action callback)
	{
		if (done)
		{
			callback();
			return this;
		}
		onFinish = (Action)Delegate.Combine(onFinish, callback);
		return this;
	}

	public virtual IEnumerator TransitionTask()
	{
		running = true;
		OnStart();
		yield return DoTransition();
		OnEnd();
	}

	protected abstract IEnumerator DoTransition();
}
