using System;
using System.Runtime.InteropServices;
using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks;

public class UniTaskSynchronizationContext : SynchronizationContext
{
	[StructLayout(LayoutKind.Auto)]
	private readonly struct Callback(SendOrPostCallback callback, object state)
	{
		private readonly SendOrPostCallback callback = callback;

		private readonly object state = state;

		public void Invoke()
		{
			try
			{
				callback(state);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
	}

	private const int MaxArrayLength = 2146435071;

	private const int InitialSize = 16;

	private static SpinLock gate = new SpinLock(enableThreadOwnerTracking: false);

	private static bool dequing = false;

	private static int actionListCount = 0;

	private static Callback[] actionList = new Callback[16];

	private static int waitingListCount = 0;

	private static Callback[] waitingList = new Callback[16];

	private static int opCount;

	public override void Send(SendOrPostCallback d, object state)
	{
		d(state);
	}

	public override void Post(SendOrPostCallback d, object state)
	{
		bool lockTaken = false;
		try
		{
			gate.Enter(ref lockTaken);
			if (dequing)
			{
				if (waitingList.Length == waitingListCount)
				{
					int num = waitingListCount * 2;
					if ((uint)num > 2146435071u)
					{
						num = 2146435071;
					}
					Callback[] destinationArray = new Callback[num];
					Array.Copy(waitingList, destinationArray, waitingListCount);
					waitingList = destinationArray;
				}
				waitingList[waitingListCount] = new Callback(d, state);
				waitingListCount++;
				return;
			}
			if (actionList.Length == actionListCount)
			{
				int num2 = actionListCount * 2;
				if ((uint)num2 > 2146435071u)
				{
					num2 = 2146435071;
				}
				Callback[] destinationArray2 = new Callback[num2];
				Array.Copy(actionList, destinationArray2, actionListCount);
				actionList = destinationArray2;
			}
			actionList[actionListCount] = new Callback(d, state);
			actionListCount++;
		}
		finally
		{
			if (lockTaken)
			{
				gate.Exit(useMemoryBarrier: false);
			}
		}
	}

	public override void OperationStarted()
	{
		Interlocked.Increment(ref opCount);
	}

	public override void OperationCompleted()
	{
		Interlocked.Decrement(ref opCount);
	}

	public override SynchronizationContext CreateCopy()
	{
		return this;
	}

	internal static void Run()
	{
		bool lockTaken = false;
		try
		{
			gate.Enter(ref lockTaken);
			if (actionListCount == 0)
			{
				return;
			}
			dequing = true;
		}
		finally
		{
			if (lockTaken)
			{
				gate.Exit(useMemoryBarrier: false);
			}
		}
		for (int i = 0; i < actionListCount; i++)
		{
			Callback callback = actionList[i];
			actionList[i] = default(Callback);
			callback.Invoke();
		}
		bool lockTaken2 = false;
		try
		{
			gate.Enter(ref lockTaken2);
			dequing = false;
			Callback[] array = actionList;
			actionListCount = waitingListCount;
			actionList = waitingList;
			waitingListCount = 0;
			waitingList = array;
		}
		finally
		{
			if (lockTaken2)
			{
				gate.Exit(useMemoryBarrier: false);
			}
		}
	}
}
