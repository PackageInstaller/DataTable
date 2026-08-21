using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
public class WindowManager : MonoBehaviour, IWindowManager
{
	private class InternalVisibleEnumerator : IEnumerator<IWindow>, IDisposable, IEnumerator
	{
		private List<IWindow> windows;

		private int index = -1;

		public IWindow Current => (index < 0 || index >= windows.Count) ? null : windows[index];

		object IEnumerator.Current => Current;

		public InternalVisibleEnumerator(List<IWindow> list)
		{
			windows = list;
		}

		public void Dispose()
		{
			index = -1;
			windows.Clear();
		}

		public bool MoveNext()
		{
			if (index >= windows.Count - 1)
			{
				return false;
			}
			index++;
			while (index < windows.Count)
			{
				IWindow window = windows[index];
				if (window != null && window.Visibility)
				{
					return true;
				}
				index++;
			}
			return false;
		}

		public void Reset()
		{
			index = -1;
		}
	}

	private class ShowTransition : Transition
	{
		private WindowManager manager;

		public ShowTransition(WindowManager manager, IManageable window)
			: base(window)
		{
			this.manager = manager;
		}

		protected virtual TransitionActionType Overlay(IWindow previous, IWindow current)
		{
			if (previous == null || previous.WindowType == WindowType.FULL)
			{
				return TransitionActionType.None;
			}
			if (previous.WindowType == WindowType.POPUP)
			{
				return TransitionActionType.Dismiss;
			}
			return TransitionActionType.None;
		}

		protected override IEnumerator DoTransition()
		{
			IManageable current = Window;
			int layer = ((Layer >= 0 && current.WindowType != WindowType.DIALOG && current.WindowType != WindowType.PROGRESS) ? Layer : 0);
			if (layer > 0)
			{
				int visibleCount = manager.VisibleCount;
				if (layer > visibleCount)
				{
					layer = visibleCount;
				}
			}
			Layer = layer;
			IManageable previous = (IManageable)manager.GetVisibleWindow(layer);
			if (previous != null)
			{
				if (previous.Activated)
				{
					IAsyncResult passivate = previous.Passivate(AnimationDisabled);
					yield return passivate.WaitForDone();
				}
				Func<IWindow, IWindow, TransitionActionType> policy = OverlayPolicy;
				if (policy == null)
				{
					policy = Overlay;
				}
				switch (policy(previous, current))
				{
				case TransitionActionType.Hide:
					previous.DoHide(AnimationDisabled);
					break;
				case TransitionActionType.Dismiss:
					previous.DoHide(AnimationDisabled).Callbackable().OnCallback(delegate
					{
						previous.DoDismiss();
					});
					break;
				}
			}
			if (!current.Visibility)
			{
				IAsyncResult show = current.DoShow(AnimationDisabled);
				yield return show.WaitForDone();
			}
			if (manager.Activated && current.Equals(manager.Current))
			{
				IAsyncResult activate = current.Activate(AnimationDisabled);
				yield return activate.WaitForDone();
			}
		}
	}

	private class HideTransition : Transition
	{
		private WindowManager manager;

		private bool dismiss;

		public HideTransition(WindowManager manager, IManageable window, bool dismiss)
			: base(window)
		{
			this.dismiss = dismiss;
			this.manager = manager;
		}

		protected override IEnumerator DoTransition()
		{
			IManageable current = Window;
			if (manager.IndexOf(current) == 0 && current.Activated)
			{
				IAsyncResult passivate = current.Passivate(AnimationDisabled);
				yield return passivate.WaitForDone();
			}
			if (current.Visibility)
			{
				IAsyncResult hide = current.DoHide(AnimationDisabled);
				yield return hide.WaitForDone();
			}
			if (dismiss)
			{
				current.DoDismiss();
			}
		}
	}

	private class BlockingCoroutineTransitionExecutor
	{
		private IAsyncResult taskResult;

		private bool running = false;

		private List<Transition> transitions = new List<Transition>();

		public bool IsRunning => running;

		public int Count => transitions.Count;

		public void Execute(Transition transition)
		{
			try
			{
				if (transition is ShowTransition && transition.Window.WindowType == WindowType.QUEUED_POPUP)
				{
					int num = transitions.FindLastIndex((Transition t) => t is ShowTransition && t.Window.WindowType == WindowType.QUEUED_POPUP && t.Window.WindowManager == transition.Window.WindowManager && t.Window.WindowPriority >= transition.Window.WindowPriority);
					if (num >= 0)
					{
						transitions.Insert(num + 1, transition);
						return;
					}
					num = transitions.FindIndex((Transition t) => t is ShowTransition && t.Window.WindowType == WindowType.QUEUED_POPUP && t.Window.WindowManager == transition.Window.WindowManager && t.Window.WindowPriority < transition.Window.WindowPriority);
					if (num >= 0)
					{
						transitions.Insert(num, transition);
						return;
					}
				}
				transitions.Add(transition);
			}
			finally
			{
				if (!running)
				{
					taskResult = Executors.RunOnCoroutine(DoTask());
				}
			}
		}

		public void Shutdown()
		{
			if (taskResult != null)
			{
				taskResult.Cancel();
				running = false;
				taskResult = null;
			}
			transitions.Clear();
		}

		private bool Check(Transition transition)
		{
			if (!(transition is ShowTransition))
			{
				return true;
			}
			IManageable window = transition.Window;
			IWindowManager windowManager = window.WindowManager;
			IWindow current = windowManager.Current;
			if (current == null)
			{
				return true;
			}
			if (current.WindowType == WindowType.DIALOG || current.WindowType == WindowType.PROGRESS)
			{
				return false;
			}
			if (current.WindowType == WindowType.QUEUED_POPUP && window.WindowType != WindowType.DIALOG && window.WindowType != WindowType.PROGRESS)
			{
				return false;
			}
			return true;
		}

		protected virtual IEnumerator DoTask()
		{
			try
			{
				running = true;
				yield return null;
				while (transitions.Count > 0)
				{
					Transition transition = transitions.Find((Transition e) => Check(e));
					if (transition != null)
					{
						transitions.Remove(transition);
						IAsyncResult result = Executors.RunOnCoroutine(transition.TransitionTask());
						yield return result.WaitForDone();
						IWindowManager manager = transition.Window.WindowManager;
						IWindow current = manager.Current;
						if (manager.Activated && current != null && !current.Activated && !transitions.Exists((Transition e) => e.Window.WindowManager.Equals(manager)))
						{
							IAsyncResult activate = (current as IManageable).Activate(transition.AnimationDisabled);
							yield return activate.WaitForDone();
						}
					}
					else
					{
						yield return null;
					}
				}
			}
			finally
			{
				running = false;
				taskResult = null;
			}
		}
	}

	private static BlockingCoroutineTransitionExecutor blockingExecutor;

	private bool lastActivated = true;

	private bool activated = true;

	private List<IWindow> windows = new List<IWindow>();

	public virtual bool Activated
	{
		get
		{
			return activated;
		}
		set
		{
			if (activated != value)
			{
				activated = value;
			}
		}
	}

	public int Count => windows.Count;

	public int VisibleCount => windows.FindAll((IWindow w) => w.Visibility).Count;

	public virtual IWindow Current
	{
		get
		{
			if (windows == null || windows.Count <= 0)
			{
				return null;
			}
			IWindow window = windows[0];
			return (window != null && window.Visibility) ? window : null;
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterAssembliesLoaded)]
	private static void OnInitialize()
	{
		if (blockingExecutor != null)
		{
			blockingExecutor = null;
		}
	}

	private static BlockingCoroutineTransitionExecutor GetTransitionExecutor()
	{
		if (blockingExecutor == null)
		{
			blockingExecutor = new BlockingCoroutineTransitionExecutor();
		}
		return blockingExecutor;
	}

	public virtual IWindow GetVisibleWindow(int index)
	{
		if (windows == null || windows.Count <= 1)
		{
			return null;
		}
		int num = -1;
		IEnumerator<IWindow> enumerator = Visibles();
		while (enumerator.MoveNext())
		{
			num++;
			if (num > index)
			{
				return null;
			}
			if (num == index)
			{
				return enumerator.Current;
			}
		}
		return null;
	}

	protected virtual void OnEnable()
	{
		Activated = lastActivated;
	}

	protected virtual void OnDisable()
	{
		lastActivated = Activated;
		Activated = false;
	}

	protected virtual void OnDestroy()
	{
		if (windows.Count > 0)
		{
			Clear();
		}
	}

	protected virtual void OnApplicationQuit()
	{
		if (blockingExecutor != null)
		{
			blockingExecutor.Shutdown();
			blockingExecutor = null;
		}
	}

	public virtual void Clear()
	{
		for (int i = 0; i < windows.Count; i++)
		{
			try
			{
				windows[i].Dismiss(ignoreAnimation: true);
			}
			catch (Exception)
			{
			}
		}
		windows.Clear();
	}

	public virtual bool Contains(IWindow window)
	{
		return windows.Contains(window);
	}

	public virtual int IndexOf(IWindow window)
	{
		return windows.IndexOf(window);
	}

	public virtual IWindow Get(int index)
	{
		if (index < 0 || index > windows.Count - 1)
		{
			throw new IndexOutOfRangeException();
		}
		return windows[index];
	}

	public virtual void Add(IWindow window)
	{
		if (window == null)
		{
			throw new ArgumentNullException("window");
		}
		if (!windows.Contains(window))
		{
			windows.Add(window);
			AddChild(GetTransform(window));
		}
	}

	public virtual bool Remove(IWindow window)
	{
		if (window == null)
		{
			throw new ArgumentNullException("window");
		}
		RemoveChild(GetTransform(window));
		return windows.Remove(window);
	}

	public virtual IWindow RemoveAt(int index)
	{
		if (index < 0 || index > windows.Count - 1)
		{
			throw new IndexOutOfRangeException();
		}
		IWindow window = windows[index];
		RemoveChild(GetTransform(window));
		windows.RemoveAt(index);
		return window;
	}

	protected virtual void MoveToLast(IWindow window)
	{
		if (window == null)
		{
			throw new ArgumentNullException("window");
		}
		try
		{
			int num = IndexOf(window);
			if (num >= 0 && num != Count - 1)
			{
				windows.RemoveAt(num);
				windows.Add(window);
			}
		}
		finally
		{
			Transform transform = GetTransform(window);
			if (transform != null)
			{
				transform.SetAsFirstSibling();
			}
		}
	}

	protected virtual void MoveToFirst(IWindow window)
	{
		MoveToIndex(window, 0);
	}

	protected virtual void MoveToIndex(IWindow window, int index)
	{
		if (window == null)
		{
			throw new ArgumentNullException("window");
		}
		int num = IndexOf(window);
		try
		{
			if (num >= 0 && num != index)
			{
				windows.RemoveAt(num);
				windows.Insert(index, window);
			}
		}
		finally
		{
			Transform transform = GetTransform(window);
			if (transform != null)
			{
				if (index == 0)
				{
					transform.SetAsLastSibling();
				}
				else
				{
					IWindow window2 = windows[index - 1];
					int childIndex = GetChildIndex(GetTransform(window2));
					int siblingIndex = ((num >= index) ? (childIndex - 1) : childIndex);
					transform.SetSiblingIndex(siblingIndex);
				}
			}
		}
	}

	public virtual IEnumerator<IWindow> Visibles()
	{
		return new InternalVisibleEnumerator(windows);
	}

	public virtual List<IWindow> Find(bool visible)
	{
		return windows.FindAll((IWindow w) => w.Visibility == visible);
	}

	public virtual IWindow Find(Type windowType)
	{
		if (windowType == null)
		{
			return null;
		}
		return windows.Find((IWindow w) => windowType.IsAssignableFrom(w.GetType()));
	}

	public virtual T Find<T>() where T : IWindow
	{
		return (T)windows.Find((IWindow w) => w is T);
	}

	public virtual IWindow Find(string name, Type windowType)
	{
		if (name == null || windowType == null)
		{
			return null;
		}
		return windows.Find((IWindow w) => windowType.IsAssignableFrom(w.GetType()) && w.Name.Equals(name));
	}

	public virtual T Find<T>(string name) where T : IWindow
	{
		return (T)windows.Find((IWindow w) => w is T && w.Name.Equals(name));
	}

	public virtual List<IWindow> FindAll(Type windowType)
	{
		List<IWindow> list = new List<IWindow>();
		foreach (IWindow window in windows)
		{
			if (windowType.IsAssignableFrom(window.GetType()))
			{
				list.Add(window);
			}
		}
		return list;
	}

	public virtual List<T> FindAll<T>() where T : IWindow
	{
		List<T> list = new List<T>();
		foreach (IWindow window in windows)
		{
			if (window is T)
			{
				list.Add((T)window);
			}
		}
		return list;
	}

	protected virtual Transform GetTransform(IWindow window)
	{
		try
		{
			if (window == null)
			{
				return null;
			}
			if (window is UIView)
			{
				return (window as UIView).Transform;
			}
			PropertyInfo property = window.GetType().GetProperty("Transform");
			if (property != null)
			{
				return (Transform)property.GetGetMethod().Invoke(window, null);
			}
			if (window is Component)
			{
				return (window as Component).transform;
			}
			return null;
		}
		catch (Exception)
		{
			return null;
		}
	}

	protected virtual int GetChildIndex(Transform child)
	{
		Transform transform = base.transform;
		int childCount = transform.childCount;
		for (int num = childCount - 1; num >= 0; num--)
		{
			if (transform.GetChild(num).Equals(child))
			{
				return num;
			}
		}
		return -1;
	}

	protected virtual void AddChild(Transform child, bool worldPositionStays = false)
	{
		if (!(child == null) && !base.transform.Equals(child.parent))
		{
			child.gameObject.layer = base.gameObject.layer;
			child.SetParent(base.transform, worldPositionStays);
			child.SetAsFirstSibling();
		}
	}

	protected virtual void RemoveChild(Transform child, bool worldPositionStays = false)
	{
		if (!(child == null) && base.transform.Equals(child.parent))
		{
			child.SetParent(null, worldPositionStays);
		}
	}

	public ITransition Show(IWindow window)
	{
		ShowTransition transition = new ShowTransition(this, (IManageable)window);
		GetTransitionExecutor().Execute(transition);
		return transition.OnStateChanged(delegate(IWindow w, WindowState state)
		{
			if (state == WindowState.VISIBLE)
			{
				MoveToIndex(w, transition.Layer);
			}
		});
	}

	public ITransition Hide(IWindow window)
	{
		HideTransition hideTransition = new HideTransition(this, (IManageable)window, dismiss: false);
		GetTransitionExecutor().Execute(hideTransition);
		return hideTransition.OnStateChanged(delegate(IWindow w, WindowState state)
		{
			if (state == WindowState.INVISIBLE)
			{
				MoveToLast(w);
			}
		});
	}

	public ITransition Dismiss(IWindow window)
	{
		HideTransition hideTransition = new HideTransition(this, (IManageable)window, dismiss: true);
		GetTransitionExecutor().Execute(hideTransition);
		return hideTransition.OnStateChanged(delegate(IWindow w, WindowState state)
		{
			if (state == WindowState.INVISIBLE)
			{
				MoveToLast(w);
			}
		});
	}
}
