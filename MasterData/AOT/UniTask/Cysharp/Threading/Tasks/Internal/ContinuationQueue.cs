using System;
using System.Diagnostics;
using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Internal;

internal sealed class ContinuationQueue
{
	private readonly PlayerLoopTiming timing;

	private SpinLock gate = new SpinLock(enableThreadOwnerTracking: false);

	private bool dequing;

	private int actionListCount;

	private Action[] actionList = new Action[16];

	private int waitingListCount;

	private Action[] waitingList = new Action[16];

	public ContinuationQueue(PlayerLoopTiming timing)
	{
		this.timing = timing;
	}

	public void Enqueue(Action continuation)
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
					Action[] destinationArray = new Action[num];
					Array.Copy(waitingList, destinationArray, waitingListCount);
					waitingList = destinationArray;
				}
				waitingList[waitingListCount] = continuation;
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
				Action[] destinationArray2 = new Action[num2];
				Array.Copy(actionList, destinationArray2, actionListCount);
				actionList = destinationArray2;
			}
			actionList[actionListCount] = continuation;
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

	public void Run()
	{
		RunCore();
	}

	[DebuggerHidden]
	private void RunCore()
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
			Action action = actionList[i];
			actionList[i] = null;
			try
			{
				action();
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
		bool lockTaken2 = false;
		try
		{
			gate.Enter(ref lockTaken2);
			dequing = false;
			Action[] array = actionList;
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
