using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using System.Threading;
using Microsoft.Win32.SafeHandles;

namespace System.Net.Sockets;

internal sealed class SafeSocketHandle : SafeHandleMinusOneIsInvalid
{
	private List<Thread> blocking_threads;

	private Dictionary<Thread, StackTrace> threads_stacktraces;

	private bool in_cleanup;

	private static bool THROW_ON_ABORT_RETRIES = Environment.GetEnvironmentVariable("MONO_TESTS_IN_PROGRESS") == "yes";

	public SafeSocketHandle(IntPtr preexistingHandle, bool ownsHandle)
		: base(ownsHandle)
	{
		SetHandle(preexistingHandle);
		if (THROW_ON_ABORT_RETRIES)
		{
			threads_stacktraces = new Dictionary<Thread, StackTrace>();
		}
	}

	protected override bool ReleaseHandle()
	{
		int error = 0;
		Socket.Blocking_icall(handle, block: false, out error);
		Socket.Shutdown_icall(handle, SocketShutdown.Both, out error);
		if (blocking_threads != null)
		{
			lock (blocking_threads)
			{
				int num = 0;
				while (blocking_threads.Count > 0)
				{
					if (num++ >= 10)
					{
						if (!THROW_ON_ABORT_RETRIES)
						{
							break;
						}
						StringBuilder stringBuilder = new StringBuilder();
						stringBuilder.AppendLine("Could not abort registered blocking threads before closing socket.");
						foreach (Thread blocking_thread in blocking_threads)
						{
							stringBuilder.AppendLine("Thread StackTrace:");
							stringBuilder.AppendLine(threads_stacktraces[blocking_thread].ToString());
						}
						stringBuilder.AppendLine();
						throw new Exception(stringBuilder.ToString());
					}
					if (blocking_threads.Count == 1 && blocking_threads[0] == Thread.CurrentThread)
					{
						break;
					}
					foreach (Thread blocking_thread2 in blocking_threads)
					{
						Socket.cancel_blocking_socket_operation(blocking_thread2);
					}
					in_cleanup = true;
					Monitor.Wait(blocking_threads, 100);
				}
			}
		}
		Socket.Close_icall(handle, out error);
		return error == 0;
	}

	public void RegisterForBlockingSyscall()
	{
		if (blocking_threads == null)
		{
			Interlocked.CompareExchange(ref blocking_threads, new List<Thread>(), null);
		}
		bool success = false;
		try
		{
			DangerousAddRef(ref success);
		}
		finally
		{
			lock (blocking_threads)
			{
				blocking_threads.Add(Thread.CurrentThread);
				if (THROW_ON_ABORT_RETRIES)
				{
					threads_stacktraces.Add(Thread.CurrentThread, new StackTrace(fNeedFileInfo: true));
				}
			}
			if (success)
			{
				DangerousRelease();
			}
			if (base.IsClosed)
			{
				throw new SocketException(10004);
			}
		}
	}

	public void UnRegisterForBlockingSyscall()
	{
		lock (blocking_threads)
		{
			Thread currentThread = Thread.CurrentThread;
			blocking_threads.Remove(currentThread);
			if (THROW_ON_ABORT_RETRIES && blocking_threads.IndexOf(currentThread) == -1)
			{
				threads_stacktraces.Remove(currentThread);
			}
			if (in_cleanup && blocking_threads.Count == 0)
			{
				Monitor.Pulse(blocking_threads);
			}
		}
	}
}
