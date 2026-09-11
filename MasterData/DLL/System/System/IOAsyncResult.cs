using System.Runtime.InteropServices;
using System.Threading;

namespace System;

[StructLayout(LayoutKind.Sequential)]
internal abstract class IOAsyncResult : IAsyncResult
{
	private AsyncCallback async_callback;

	private object async_state;

	private ManualResetEvent wait_handle;

	private bool completed_synchronously;

	private bool completed;

	public AsyncCallback AsyncCallback => async_callback;

	public object AsyncState => async_state;

	public WaitHandle AsyncWaitHandle
	{
		get
		{
			lock (this)
			{
				if (wait_handle == null)
				{
					wait_handle = new ManualResetEvent(completed);
				}
				return wait_handle;
			}
		}
	}

	public bool CompletedSynchronously
	{
		get
		{
			return completed_synchronously;
		}
		protected set
		{
			completed_synchronously = value;
		}
	}

	public bool IsCompleted
	{
		get
		{
			return completed;
		}
		protected set
		{
			completed = value;
			lock (this)
			{
				if (value && wait_handle != null)
				{
					wait_handle.Set();
				}
			}
		}
	}

	protected IOAsyncResult()
	{
	}

	protected void Init(AsyncCallback async_callback, object async_state)
	{
		this.async_callback = async_callback;
		this.async_state = async_state;
		completed = false;
		completed_synchronously = false;
		if (wait_handle != null)
		{
			wait_handle.Reset();
		}
	}

	protected IOAsyncResult(AsyncCallback async_callback, object async_state)
	{
		this.async_callback = async_callback;
		this.async_state = async_state;
	}

	internal abstract void CompleteDisposed();
}
