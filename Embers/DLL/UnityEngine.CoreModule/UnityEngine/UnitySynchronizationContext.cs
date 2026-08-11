using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using UnityEngine.Scripting;

namespace UnityEngine;

internal sealed class UnitySynchronizationContext : SynchronizationContext
{
	private struct WorkRequest(SendOrPostCallback callback, object state, ManualResetEvent waitHandle = null)
	{
		private readonly SendOrPostCallback m_DelagateCallback = callback;

		private readonly object m_DelagateState = state;

		private readonly ManualResetEvent m_WaitHandle = waitHandle;

		public void Invoke()
		{
			try
			{
				m_DelagateCallback(m_DelagateState);
			}
			finally
			{
				m_WaitHandle?.Set();
			}
		}
	}

	private readonly List<WorkRequest> m_AsyncWorkQueue;

	private readonly List<WorkRequest> m_CurrentFrameWork = new List<WorkRequest>(20);

	private readonly int m_MainThreadID;

	private int m_TrackedCount = 0;

	private UnitySynchronizationContext(int mainThreadID)
	{
		m_AsyncWorkQueue = new List<WorkRequest>(20);
		m_MainThreadID = mainThreadID;
	}

	private UnitySynchronizationContext(List<WorkRequest> queue, int mainThreadID)
	{
		m_AsyncWorkQueue = queue;
		m_MainThreadID = mainThreadID;
	}

	public override void Send(SendOrPostCallback callback, object state)
	{
		if (m_MainThreadID == Thread.CurrentThread.ManagedThreadId)
		{
			callback(state);
			return;
		}
		using ManualResetEvent manualResetEvent = new ManualResetEvent(initialState: false);
		lock (m_AsyncWorkQueue)
		{
			m_AsyncWorkQueue.Add(new WorkRequest(callback, state, manualResetEvent));
		}
		manualResetEvent.WaitOne();
	}

	public override void OperationStarted()
	{
		Interlocked.Increment(ref m_TrackedCount);
	}

	public override void OperationCompleted()
	{
		Interlocked.Decrement(ref m_TrackedCount);
	}

	public override void Post(SendOrPostCallback callback, object state)
	{
		lock (m_AsyncWorkQueue)
		{
			m_AsyncWorkQueue.Add(new WorkRequest(callback, state));
		}
	}

	public override SynchronizationContext CreateCopy()
	{
		return new UnitySynchronizationContext(m_AsyncWorkQueue, m_MainThreadID);
	}

	private void Exec()
	{
		lock (m_AsyncWorkQueue)
		{
			m_CurrentFrameWork.AddRange(m_AsyncWorkQueue);
			m_AsyncWorkQueue.Clear();
		}
		while (m_CurrentFrameWork.Count > 0)
		{
			WorkRequest workRequest = m_CurrentFrameWork[0];
			m_CurrentFrameWork.RemoveAt(0);
			workRequest.Invoke();
		}
	}

	private bool HasPendingTasks()
	{
		return m_AsyncWorkQueue.Count != 0 || m_TrackedCount != 0;
	}

	[RequiredByNativeCode]
	private static void InitializeSynchronizationContext()
	{
		SynchronizationContext.SetSynchronizationContext(new UnitySynchronizationContext(Thread.CurrentThread.ManagedThreadId));
	}

	[RequiredByNativeCode]
	private static void ExecuteTasks()
	{
		if (SynchronizationContext.Current is UnitySynchronizationContext unitySynchronizationContext)
		{
			unitySynchronizationContext.Exec();
		}
	}

	[RequiredByNativeCode]
	private static bool ExecutePendingTasks(long millisecondsTimeout)
	{
		if (!(SynchronizationContext.Current is UnitySynchronizationContext unitySynchronizationContext))
		{
			return true;
		}
		Stopwatch stopwatch = new Stopwatch();
		stopwatch.Start();
		while (unitySynchronizationContext.HasPendingTasks() && stopwatch.ElapsedMilliseconds <= millisecondsTimeout)
		{
			unitySynchronizationContext.Exec();
			Thread.Sleep(1);
		}
		return !unitySynchronizationContext.HasPendingTasks();
	}
}
