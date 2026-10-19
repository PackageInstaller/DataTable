using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;

namespace System.Runtime.Remoting.Messaging;

[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public class AsyncResult : IAsyncResult, IMessageSink, IThreadPoolWorkItem
{
	private object async_state;

	private WaitHandle handle;

	private object async_delegate;

	private IntPtr data;

	private object object_data;

	private bool sync_completed;

	private bool completed;

	private bool endinvoke_called;

	private object async_callback;

	private ExecutionContext current;

	private ExecutionContext original;

	private long add_time;

	private MonoMethodMessage call_message;

	private IMessageCtrl message_ctrl;

	private IMessage reply_message;

	private WaitCallback orig_cb;

	public virtual object AsyncState => async_state;

	public virtual WaitHandle AsyncWaitHandle
	{
		get
		{
			lock (this)
			{
				if (handle == null)
				{
					handle = new ManualResetEvent(completed);
				}
				return handle;
			}
		}
	}

	public virtual bool CompletedSynchronously => sync_completed;

	public virtual bool IsCompleted => completed;

	public bool EndInvokeCalled
	{
		get
		{
			return endinvoke_called;
		}
		set
		{
			endinvoke_called = value;
		}
	}

	public virtual object AsyncDelegate => async_delegate;

	public IMessageSink NextSink => null;

	internal MonoMethodMessage CallMessage
	{
		get
		{
			return call_message;
		}
		set
		{
			call_message = value;
		}
	}

	internal AsyncResult()
	{
	}

	public virtual IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		throw new NotSupportedException();
	}

	public virtual IMessage GetReplyMessage()
	{
		return reply_message;
	}

	public virtual void SetMessageCtrl(IMessageCtrl mc)
	{
		message_ctrl = mc;
	}

	internal void SetCompletedSynchronously(bool completed)
	{
		sync_completed = completed;
	}

	internal IMessage EndInvoke()
	{
		lock (this)
		{
			if (completed)
			{
				return reply_message;
			}
		}
		AsyncWaitHandle.WaitOne();
		return reply_message;
	}

	public virtual IMessage SyncProcessMessage(IMessage msg)
	{
		reply_message = msg;
		lock (this)
		{
			completed = true;
			if (handle != null)
			{
				((ManualResetEvent)AsyncWaitHandle).Set();
			}
		}
		if (async_callback != null)
		{
			((AsyncCallback)async_callback)(this);
		}
		return null;
	}

	void IThreadPoolWorkItem.ExecuteWorkItem()
	{
		Invoke();
	}

	void IThreadPoolWorkItem.MarkAborted(ThreadAbortException tae)
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern object Invoke();
}
