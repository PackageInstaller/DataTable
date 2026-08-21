using System;
using System.Collections.Generic;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
public class WindowContainer : Window, IWindowManager
{
	private IWindowManager localWindowManager;

	bool IWindowManager.Activated
	{
		get
		{
			return localWindowManager.Activated;
		}
		set
		{
			localWindowManager.Activated = value;
		}
	}

	public IWindow Current => localWindowManager.Current;

	public int Count => localWindowManager.Count;

	public static WindowContainer Create(string name)
	{
		return Create(null, name);
	}

	public static WindowContainer Create(IWindowManager windowManager, string name)
	{
		GameObject gameObject = new GameObject(name, typeof(CanvasGroup));
		RectTransform rectTransform = gameObject.AddComponent<RectTransform>();
		rectTransform.anchorMin = Vector2.zero;
		rectTransform.anchorMax = Vector2.one;
		rectTransform.offsetMax = Vector2.zero;
		rectTransform.offsetMin = Vector2.zero;
		rectTransform.pivot = new Vector2(0.5f, 0.5f);
		rectTransform.localPosition = Vector3.zero;
		WindowContainer windowContainer = gameObject.AddComponent<WindowContainer>();
		windowContainer.WindowManager = windowManager;
		windowContainer.Create();
		windowContainer.Show(ignoreAnimation: true);
		return windowContainer;
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.WindowType = WindowType.FULL;
		localWindowManager = CreateWindowManager();
	}

	protected virtual IWindowManager CreateWindowManager()
	{
		return base.gameObject.AddComponent<WindowManager>();
	}

	protected override void OnActivatedChanged()
	{
		if (localWindowManager != null)
		{
			localWindowManager.Activated = base.Activated;
		}
		base.OnActivatedChanged();
	}

	public override IAsyncResult Activate(bool ignoreAnimation)
	{
		if (!Visibility)
		{
			throw new InvalidOperationException("The window is not visible.");
		}
		if (localWindowManager.Current != null)
		{
			base.Activated = true;
			return (localWindowManager.Current as IManageable).Activate(ignoreAnimation);
		}
		AsyncResult result = new AsyncResult();
		try
		{
			if (base.Activated)
			{
				result.SetResult();
				return result;
			}
			if (!ignoreAnimation && ActivationAnimation != null)
			{
				ActivationAnimation.OnStart(delegate
				{
					base.State = WindowState.ACTIVATION_ANIMATION_BEGIN;
				}).OnEnd(delegate
				{
					base.State = WindowState.ACTIVATION_ANIMATION_END;
					base.Activated = true;
					base.State = WindowState.ACTIVATED;
					result.SetResult();
				}).Play();
			}
			else
			{
				base.Activated = true;
				base.State = WindowState.ACTIVATED;
				result.SetResult();
			}
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return result;
	}

	public override IAsyncResult Passivate(bool ignoreAnimation)
	{
		if (!Visibility)
		{
			throw new InvalidOperationException("The window is not visible.");
		}
		if (localWindowManager.Current != null)
		{
			IAsyncResult asyncResult = (localWindowManager.Current as IManageable).Passivate(ignoreAnimation);
			asyncResult.Callbackable().OnCallback(delegate
			{
				base.Activated = false;
			});
			return asyncResult;
		}
		AsyncResult result = new AsyncResult();
		try
		{
			if (!base.Activated)
			{
				result.SetResult();
				return result;
			}
			base.Activated = false;
			base.State = WindowState.PASSIVATED;
			if (!ignoreAnimation && PassivationAnimation != null)
			{
				PassivationAnimation.OnStart(delegate
				{
					base.State = WindowState.PASSIVATION_ANIMATION_BEGIN;
				}).OnEnd(delegate
				{
					base.State = WindowState.PASSIVATION_ANIMATION_END;
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

	public IEnumerator<IWindow> Visibles()
	{
		return localWindowManager.Visibles();
	}

	public IWindow Get(int index)
	{
		return localWindowManager.Get(index);
	}

	public void Add(IWindow window)
	{
		localWindowManager.Add(window);
	}

	public bool Remove(IWindow window)
	{
		return localWindowManager.Remove(window);
	}

	public IWindow RemoveAt(int index)
	{
		return localWindowManager.RemoveAt(index);
	}

	public bool Contains(IWindow window)
	{
		return localWindowManager.Contains(window);
	}

	public int IndexOf(IWindow window)
	{
		return localWindowManager.IndexOf(window);
	}

	public List<IWindow> Find(bool visible)
	{
		return localWindowManager.Find(visible);
	}

	public T Find<T>() where T : IWindow
	{
		return localWindowManager.Find<T>();
	}

	public T Find<T>(string name) where T : IWindow
	{
		return localWindowManager.Find<T>(name);
	}

	public List<T> FindAll<T>() where T : IWindow
	{
		return localWindowManager.FindAll<T>();
	}

	public void Clear()
	{
		localWindowManager.Clear();
	}

	public ITransition Show(IWindow window)
	{
		return localWindowManager.Show(window);
	}

	public ITransition Hide(IWindow window)
	{
		return localWindowManager.Hide(window);
	}

	public ITransition Dismiss(IWindow window)
	{
		return localWindowManager.Dismiss(window);
	}
}
