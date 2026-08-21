using System;
using System.Runtime.InteropServices;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct InputEventListener : IObservable<InputEventPtr>
{
	internal class ObserverState
	{
		public InlinedArray<IObserver<InputEventPtr>> observers;

		public Action<InputEventPtr, InputDevice> onEventDelegate;

		public ObserverState()
		{
			onEventDelegate = delegate(InputEventPtr eventPtr, InputDevice device)
			{
				for (int num = observers.length - 1; num >= 0; num--)
				{
					observers[num].OnNext(eventPtr);
				}
			};
		}
	}

	private class DisposableObserver : IDisposable
	{
		public IObserver<InputEventPtr> observer;

		public void Dispose()
		{
			int num = s_ObserverState.observers.IndexOfReference(observer);
			if (num >= 0)
			{
				s_ObserverState.observers.RemoveAtWithCapacity(num);
			}
			if (s_ObserverState.observers.length == 0)
			{
				InputSystem.s_Manager.onEvent -= s_ObserverState.onEventDelegate;
			}
		}
	}

	internal static ObserverState s_ObserverState;

	public static InputEventListener operator +(InputEventListener _, Action<InputEventPtr, InputDevice> callback)
	{
		if (callback == null)
		{
			throw new ArgumentNullException("callback");
		}
		lock (InputSystem.s_Manager)
		{
			InputSystem.s_Manager.onEvent += callback;
		}
		return default(InputEventListener);
	}

	public static InputEventListener operator -(InputEventListener _, Action<InputEventPtr, InputDevice> callback)
	{
		if (callback == null)
		{
			throw new ArgumentNullException("callback");
		}
		lock (InputSystem.s_Manager)
		{
			InputSystem.s_Manager.onEvent -= callback;
		}
		return default(InputEventListener);
	}

	public IDisposable Subscribe(IObserver<InputEventPtr> observer)
	{
		if (s_ObserverState == null)
		{
			s_ObserverState = new ObserverState();
		}
		if (s_ObserverState.observers.length == 0)
		{
			InputSystem.s_Manager.onEvent += s_ObserverState.onEventDelegate;
		}
		s_ObserverState.observers.AppendWithCapacity(observer);
		return new DisposableObserver
		{
			observer = observer
		};
	}
}
