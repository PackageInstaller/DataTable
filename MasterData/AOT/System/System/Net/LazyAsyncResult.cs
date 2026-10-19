using System.Threading;

namespace System.Net;

internal class LazyAsyncResult : IAsyncResult
{
	private class ThreadContext
	{
		internal int m_NestedIOCount;
	}

	[ThreadStatic]
	private static ThreadContext t_ThreadContext;

	private object m_AsyncObject;

	private object m_AsyncState;

	private AsyncCallback m_AsyncCallback;

	private object m_Result;

	private int m_IntCompleted;

	private bool m_EndCalled;

	private bool m_UserEvent;

	private object m_Event;

	private static ThreadContext CurrentThreadContext
	{
		get
		{
			ThreadContext threadContext = t_ThreadContext;
			if (threadContext == null)
			{
				threadContext = (t_ThreadContext = new ThreadContext());
			}
			return threadContext;
		}
	}

	internal object AsyncObject => m_AsyncObject;

	public object AsyncState => m_AsyncState;

	protected AsyncCallback AsyncCallback => m_AsyncCallback;

	public WaitHandle AsyncWaitHandle
	{
		get
		{
			m_UserEvent = true;
			if (m_IntCompleted == 0)
			{
				Interlocked.CompareExchange(ref m_IntCompleted, int.MinValue, 0);
			}
			ManualResetEvent waitHandle = (ManualResetEvent)m_Event;
			while (waitHandle == null)
			{
				LazilyCreateEvent(out waitHandle);
			}
			return waitHandle;
		}
	}

	public bool CompletedSynchronously
	{
		get
		{
			int num = m_IntCompleted;
			if (num == 0)
			{
				num = Interlocked.CompareExchange(ref m_IntCompleted, int.MinValue, 0);
			}
			return num > 0;
		}
	}

	public bool IsCompleted
	{
		get
		{
			int num = m_IntCompleted;
			if (num == 0)
			{
				num = Interlocked.CompareExchange(ref m_IntCompleted, int.MinValue, 0);
			}
			return (num & 0x7FFFFFFF) != 0;
		}
	}

	internal bool InternalPeekCompleted => (m_IntCompleted & 0x7FFFFFFF) != 0;

	internal bool EndCalled
	{
		get
		{
			return m_EndCalled;
		}
		set
		{
			m_EndCalled = value;
		}
	}

	internal LazyAsyncResult(object myObject, object myState, AsyncCallback myCallBack)
	{
		m_AsyncObject = myObject;
		m_AsyncState = myState;
		m_AsyncCallback = myCallBack;
		m_Result = DBNull.Value;
	}

	private bool LazilyCreateEvent(out ManualResetEvent waitHandle)
	{
		waitHandle = new ManualResetEvent(initialState: false);
		try
		{
			if (Interlocked.CompareExchange(ref m_Event, waitHandle, null) == null)
			{
				if (InternalPeekCompleted)
				{
					waitHandle.Set();
				}
				return true;
			}
			waitHandle.Close();
			waitHandle = (ManualResetEvent)m_Event;
			return false;
		}
		catch
		{
			m_Event = null;
			if (waitHandle != null)
			{
				waitHandle.Close();
			}
			throw;
		}
	}

	protected void ProtectedInvokeCallback(object result, IntPtr userToken)
	{
		if (result == DBNull.Value)
		{
			throw new ArgumentNullException("result");
		}
		if ((m_IntCompleted & 0x7FFFFFFF) != 0 || (Interlocked.Increment(ref m_IntCompleted) & 0x7FFFFFFF) != 1)
		{
			return;
		}
		if (m_Result == DBNull.Value)
		{
			m_Result = result;
		}
		ManualResetEvent manualResetEvent = (ManualResetEvent)m_Event;
		if (manualResetEvent != null)
		{
			try
			{
				manualResetEvent.Set();
			}
			catch (ObjectDisposedException)
			{
			}
		}
		Complete(userToken);
	}

	internal void InvokeCallback(object result)
	{
		ProtectedInvokeCallback(result, IntPtr.Zero);
	}

	internal void InvokeCallback()
	{
		ProtectedInvokeCallback(null, IntPtr.Zero);
	}

	protected virtual void Complete(IntPtr userToken)
	{
		bool flag = false;
		ThreadContext currentThreadContext = CurrentThreadContext;
		try
		{
			currentThreadContext.m_NestedIOCount++;
			if (m_AsyncCallback != null)
			{
				if (currentThreadContext.m_NestedIOCount >= 50)
				{
					ThreadPool.QueueUserWorkItem(WorkerThreadComplete);
					flag = true;
				}
				else
				{
					m_AsyncCallback(this);
				}
			}
		}
		finally
		{
			currentThreadContext.m_NestedIOCount--;
			if (!flag)
			{
				Cleanup();
			}
		}
	}

	private void WorkerThreadComplete(object state)
	{
		try
		{
			m_AsyncCallback(this);
		}
		finally
		{
			Cleanup();
		}
	}

	protected virtual void Cleanup()
	{
	}

	internal object InternalWaitForCompletion()
	{
		return WaitForCompletion(snap: true);
	}

	private object WaitForCompletion(bool snap)
	{
		ManualResetEvent waitHandle = null;
		bool flag = false;
		if (!(snap ? IsCompleted : InternalPeekCompleted))
		{
			waitHandle = (ManualResetEvent)m_Event;
			if (waitHandle == null)
			{
				flag = LazilyCreateEvent(out waitHandle);
			}
		}
		if (waitHandle != null)
		{
			try
			{
				waitHandle.WaitOne(-1, exitContext: false);
			}
			catch (ObjectDisposedException)
			{
			}
			finally
			{
				if (flag && !m_UserEvent)
				{
					ManualResetEvent manualResetEvent = (ManualResetEvent)m_Event;
					m_Event = null;
					if (!m_UserEvent)
					{
						manualResetEvent.Close();
					}
				}
			}
		}
		while (m_Result == DBNull.Value)
		{
			Thread.SpinWait(1);
		}
		return m_Result;
	}
}
