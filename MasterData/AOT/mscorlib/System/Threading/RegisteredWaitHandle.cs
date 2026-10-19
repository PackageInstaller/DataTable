using System.Runtime.InteropServices;

namespace System.Threading;

[ComVisible(true)]
public sealed class RegisteredWaitHandle : MarshalByRefObject
{
	private WaitHandle _waitObject;

	private WaitOrTimerCallback _callback;

	private object _state;

	private WaitHandle _finalEvent;

	private ManualResetEvent _cancelEvent;

	private TimeSpan _timeout;

	private int _callsInProcess;

	private bool _executeOnlyOnce;

	private bool _unregistered;

	internal RegisteredWaitHandle(WaitHandle waitObject, WaitOrTimerCallback callback, object state, TimeSpan timeout, bool executeOnlyOnce)
	{
		_waitObject = waitObject;
		_callback = callback;
		_state = state;
		_timeout = timeout;
		_executeOnlyOnce = executeOnlyOnce;
		_finalEvent = null;
		_cancelEvent = new ManualResetEvent(initialState: false);
		_callsInProcess = 0;
		_unregistered = false;
	}

	internal void Wait(object state)
	{
		bool success = false;
		try
		{
			_waitObject.SafeWaitHandle.DangerousAddRef(ref success);
			try
			{
				WaitHandle[] waitHandles = new WaitHandle[2] { _waitObject, _cancelEvent };
				do
				{
					int num = WaitHandle.WaitAny(waitHandles, _timeout, exitContext: false);
					if (!_unregistered)
					{
						lock (this)
						{
							_callsInProcess++;
						}
						ThreadPool.QueueUserWorkItem(DoCallBack, num == 258);
					}
				}
				while (!_unregistered && !_executeOnlyOnce);
			}
			catch
			{
			}
			lock (this)
			{
				_unregistered = true;
				if (_callsInProcess == 0 && _finalEvent != null)
				{
					NativeEventCalls.SetEvent(_finalEvent.SafeWaitHandle);
					_finalEvent = null;
				}
			}
		}
		catch (ObjectDisposedException)
		{
			if (success)
			{
				throw;
			}
		}
		finally
		{
			if (success)
			{
				_waitObject.SafeWaitHandle.DangerousRelease();
			}
		}
	}

	private void DoCallBack(object timedOut)
	{
		try
		{
			if (_callback != null)
			{
				_callback(_state, (bool)timedOut);
			}
		}
		finally
		{
			lock (this)
			{
				_callsInProcess--;
				if (_unregistered && _callsInProcess == 0 && _finalEvent != null)
				{
					NativeEventCalls.SetEvent(_finalEvent.SafeWaitHandle);
					_finalEvent = null;
				}
			}
		}
	}

	[ComVisible(true)]
	public bool Unregister(WaitHandle waitObject)
	{
		lock (this)
		{
			if (_unregistered)
			{
				return false;
			}
			_finalEvent = waitObject;
			_unregistered = true;
			_cancelEvent.Set();
			return true;
		}
	}
}
