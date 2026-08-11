#define ENABLE_DEBUG_AND_ABOVE_LOG
#define ENABLE_LOG
using System;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
public abstract class Window : WindowView, IWindow, IManageable
{
	public static readonly IMessenger Messenger = new Messenger();

	[SerializeField]
	private WindowType windowType = WindowType.FULL;

	[SerializeField]
	[Range(0f, 10f)]
	private int windowPriority = 0;

	[SerializeField]
	private bool stateBroadcast = true;

	private IWindowManager windowManager;

	private bool created = false;

	private bool dismissed = false;

	private bool activated = false;

	private ITransition dismissTransition;

	private WindowState state = WindowState.NONE;

	private string assetPath;

	private readonly object _lock = new object();

	private EventHandler activatedChanged;

	private EventHandler visibilityChanged;

	private EventHandler onDismissed;

	private EventHandler<WindowStateEventArgs> stateChanged;

	public IWindowManager WindowManager
	{
		get
		{
			return windowManager ?? (windowManager = UnityEngine.Object.FindObjectOfType<GlobalWindowManagerBase>());
		}
		set
		{
			windowManager = value;
		}
	}

	public new virtual string AssetPath
	{
		get
		{
			return assetPath;
		}
		set
		{
			assetPath = value;
		}
	}

	public bool Created => created;

	public bool Dismissed => dismissed;

	public bool Activated
	{
		get
		{
			return activated;
		}
		protected set
		{
			if (activated != value)
			{
				activated = value;
				OnActivatedChanged();
				RaiseActivatedChanged();
			}
		}
	}

	protected WindowState State
	{
		get
		{
			return state;
		}
		set
		{
			if (!state.Equals(value))
			{
				WindowState oldState = state;
				state = value;
				RaiseStateChanged(oldState, state);
			}
		}
	}

	public WindowType WindowType
	{
		get
		{
			return windowType;
		}
		set
		{
			windowType = value;
		}
	}

	public int WindowPriority
	{
		get
		{
			return windowPriority;
		}
		set
		{
			if (value < 0)
			{
				windowPriority = 0;
			}
			else if (value > 10)
			{
				windowPriority = 10;
			}
			else
			{
				windowPriority = value;
			}
		}
	}

	public event EventHandler ActivatedChanged
	{
		add
		{
			lock (_lock)
			{
				activatedChanged = (EventHandler)Delegate.Combine(activatedChanged, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				activatedChanged = (EventHandler)Delegate.Remove(activatedChanged, value);
			}
		}
	}

	public event EventHandler VisibilityChanged
	{
		add
		{
			lock (_lock)
			{
				visibilityChanged = (EventHandler)Delegate.Combine(visibilityChanged, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				visibilityChanged = (EventHandler)Delegate.Remove(visibilityChanged, value);
			}
		}
	}

	public event EventHandler OnDismissed
	{
		add
		{
			lock (_lock)
			{
				onDismissed = (EventHandler)Delegate.Combine(onDismissed, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				onDismissed = (EventHandler)Delegate.Remove(onDismissed, value);
			}
		}
	}

	public event EventHandler<WindowStateEventArgs> StateChanged
	{
		add
		{
			lock (_lock)
			{
				stateChanged = (EventHandler<WindowStateEventArgs>)Delegate.Combine(stateChanged, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				stateChanged = (EventHandler<WindowStateEventArgs>)Delegate.Remove(stateChanged, value);
			}
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		RaiseVisibilityChanged();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		RaiseVisibilityChanged();
	}

	protected void RaiseActivatedChanged()
	{
		try
		{
			if (activatedChanged != null)
			{
				activatedChanged(this, EventArgs.Empty);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	protected void RaiseVisibilityChanged()
	{
		try
		{
			if (visibilityChanged != null)
			{
				visibilityChanged(this, EventArgs.Empty);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	protected void RaiseOnDismissed()
	{
		try
		{
			if (onDismissed != null)
			{
				onDismissed(this, EventArgs.Empty);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	protected void RaiseStateChanged(WindowState oldState, WindowState newState)
	{
		try
		{
			WindowStateEventArgs e = new WindowStateEventArgs(this, oldState, newState);
			if (GlobalSetting.enableWindowStateBroadcast && stateBroadcast)
			{
				Messenger.Publish(e);
			}
			if (stateChanged != null)
			{
				stateChanged(this, e);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	public virtual IAsyncResult Activate(bool ignoreAnimation)
	{
		AsyncResult result = new AsyncResult();
		try
		{
			if (!Visibility)
			{
				result.SetException(new InvalidOperationException("The window is not visible."));
				return result;
			}
			if (Activated)
			{
				result.SetResult();
				return result;
			}
			if (!ignoreAnimation && ActivationAnimation != null)
			{
				ActivationAnimation.OnStart(delegate
				{
					State = WindowState.ACTIVATION_ANIMATION_BEGIN;
				}).OnEnd(delegate
				{
					State = WindowState.ACTIVATION_ANIMATION_END;
					Activated = true;
					State = WindowState.ACTIVATED;
					result.SetResult();
				}).Play();
			}
			else
			{
				Activated = true;
				State = WindowState.ACTIVATED;
				result.SetResult();
			}
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return result;
	}

	public virtual IAsyncResult Passivate(bool ignoreAnimation)
	{
		AsyncResult result = new AsyncResult();
		try
		{
			if (!Visibility)
			{
				result.SetException(new InvalidOperationException("The window is not visible."));
				return result;
			}
			if (!Activated)
			{
				result.SetResult();
				return result;
			}
			Activated = false;
			State = WindowState.PASSIVATED;
			if (!ignoreAnimation && PassivationAnimation != null)
			{
				PassivationAnimation.OnStart(delegate
				{
					State = WindowState.PASSIVATION_ANIMATION_BEGIN;
				}).OnEnd(delegate
				{
					State = WindowState.PASSIVATION_ANIMATION_END;
					result.SetResult();
				}).Play();
			}
			else
			{
				result.SetResult();
			}
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return result;
	}

	protected virtual void OnActivatedChanged()
	{
		Interactable = Activated;
	}

	public void Create(IBundle bundle = null)
	{
		if (dismissTransition != null || dismissed)
		{
			throw new ObjectDisposedException(Name);
		}
		if (!created)
		{
			State = WindowState.CREATE_BEGIN;
			Visibility = false;
			Interactable = Activated;
			WindowManager.Add(this);
			OnCreate(bundle);
			created = true;
			State = WindowState.CREATE_END;
		}
	}

	protected abstract void OnCreate(IBundle bundle);

	public ITransition Show(bool ignoreAnimation = false)
	{
		if (dismissTransition != null || dismissed)
		{
			throw new InvalidOperationException("The window has been destroyed");
		}
		if (Activated)
		{
			return new CompletedTransition(this);
		}
		if (Visibility)
		{
			DoHide(ignoreAnimation: true);
		}
		return WindowManager.Show(this).DisableAnimation(ignoreAnimation);
	}

	public virtual IAsyncResult DoShow(bool ignoreAnimation = false)
	{
		AsyncResult result = new AsyncResult();
		try
		{
			if (!created)
			{
				Create();
			}
			OnShow();
			Visibility = true;
			State = WindowState.VISIBLE;
			if (!ignoreAnimation && EnterAnimation != null)
			{
				EnterAnimation.OnStart(delegate
				{
					State = WindowState.ENTER_ANIMATION_BEGIN;
				}).OnEnd(delegate
				{
					State = WindowState.ENTER_ANIMATION_END;
					result.SetResult();
				}).Play();
			}
			else
			{
				result.SetResult();
			}
		}
		catch (Exception ex)
		{
			result.SetException(ex);
			Log.Warning("The window named \"{0}\" failed to open!Error:{1}", Name, ex);
		}
		return result;
	}

	protected virtual void OnShow()
	{
	}

	public ITransition Hide(bool ignoreAnimation = false)
	{
		if (!created)
		{
			throw new InvalidOperationException("The window has not been created.");
		}
		if (dismissTransition != null || dismissed)
		{
			throw new InvalidOperationException("The window has been destroyed");
		}
		if (!Visibility)
		{
			return new CompletedTransition(this);
		}
		return WindowManager.Hide(this).DisableAnimation(ignoreAnimation);
	}

	public virtual IAsyncResult DoHide(bool ignoreAnimation = false)
	{
		AsyncResult result = new AsyncResult();
		try
		{
			if (!ignoreAnimation && ExitAnimation != null)
			{
				ExitAnimation.OnStart(delegate
				{
					State = WindowState.EXIT_ANIMATION_BEGIN;
				}).OnEnd(delegate
				{
					State = WindowState.EXIT_ANIMATION_END;
					Visibility = false;
					State = WindowState.INVISIBLE;
					OnHide();
					result.SetResult();
				}).Play();
			}
			else
			{
				Visibility = false;
				State = WindowState.INVISIBLE;
				OnHide();
				result.SetResult();
			}
		}
		catch (Exception ex)
		{
			result.SetException(ex);
			Log.Warning("The window named \"{0}\" failed to hide!Error:{1}", Name, ex);
		}
		return result;
	}

	protected virtual void OnHide()
	{
	}

	public ITransition Dismiss(bool ignoreAnimation = false)
	{
		if (dismissTransition != null)
		{
			return dismissTransition;
		}
		if (dismissed)
		{
			return new CompletedTransition(this);
		}
		dismissTransition = WindowManager.Dismiss(this).DisableAnimation(ignoreAnimation);
		return dismissTransition;
	}

	public virtual void DoDismiss()
	{
		try
		{
			if (!dismissed)
			{
				State = WindowState.DISMISS_BEGIN;
				dismissed = true;
				OnDismiss();
				RaiseOnDismissed();
				WindowManager.Remove(this);
				if (!IsDestroyed() && base.gameObject != null)
				{
					UnityEngine.Object.Destroy(base.gameObject);
				}
				State = WindowState.DISMISS_END;
				dismissTransition = null;
			}
		}
		catch (Exception arg)
		{
			Log.Warning("The window named \"{0}\" failed to dismiss!Error:{1}", Name, arg);
		}
	}

	protected virtual void OnDismiss()
	{
	}

	protected override void OnDestroy()
	{
		if (!Dismissed && dismissTransition == null)
		{
			Dismiss(ignoreAnimation: true);
		}
		base.OnDestroy();
	}
}
