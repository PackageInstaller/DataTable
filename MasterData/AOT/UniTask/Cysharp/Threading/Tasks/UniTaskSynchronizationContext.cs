using System;
using System.Runtime.InteropServices;
using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks;

public class UniTaskSynchronizationContext : SynchronizationContext
{
	[StructLayout(LayoutKind.Auto)]
	private readonly struct Callback
	{
		private readonly SendOrPostCallback callback;

		private readonly object state;

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

	private static SpinLock gate = new SpinLock(enableThreadOwnerTracking: false);

	private static bool dequing = false;

	private static int actionListCount = 0;

	private static Callback[] actionList = new Callback[16];

	private static int waitingListCount = 0;

	private static Callback[] waitingList = new Callback[16];

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
			actionList[i] = default;
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
