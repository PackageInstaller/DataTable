using System;
using System.Diagnostics;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Internal;

internal sealed class PlayerLoopRunner
{
	private const int InitialSize = 16;

	private readonly PlayerLoopTiming timing;

	private readonly object runningAndQueueLock = new object();

	private readonly object arrayLock = new object();

	private readonly Action<Exception> unhandledExceptionCallback;

	private int tail;

	private bool running;

	private IPlayerLoopItem[] loopItems = new IPlayerLoopItem[16];

	private MinimumQueue<IPlayerLoopItem> waitQueue = new MinimumQueue<IPlayerLoopItem>(16);

	public PlayerLoopRunner(PlayerLoopTiming timing)
	{
		unhandledExceptionCallback = delegate(Exception ex)
		{
			Debug.LogException(ex);
		};
		this.timing = timing;
	}

	public void AddAction(IPlayerLoopItem item)
	{
		lock (runningAndQueueLock)
		{
			if (running)
			{
				waitQueue.Enqueue(item);
				return;
			}
		}
		lock (arrayLock)
		{
			if (loopItems.Length == tail)
			{
				Array.Resize(ref loopItems, checked(tail * 2));
			}
			loopItems[tail++] = item;
		}
	}

	public int Clear()
	{
		lock (arrayLock)
		{
			int num = 0;
			for (int i = 0; i < loopItems.Length; i++)
			{
				if (loopItems[i] != null)
				{
					num++;
				}
				loopItems[i] = null;
			}
			tail = 0;
			return num;
		}
	}

	public void Run()
	{
		RunCore();
	}

	private void Initialization()
	{
		RunCore();
	}

	private void LastInitialization()
	{
		RunCore();
	}

	private void EarlyUpdate()
	{
		RunCore();
	}

	private void LastEarlyUpdate()
	{
		RunCore();
	}

	private void FixedUpdate()
	{
		RunCore();
	}

	private void LastFixedUpdate()
	{
		RunCore();
	}

	private void PreUpdate()
	{
		RunCore();
	}

	private void LastPreUpdate()
	{
		RunCore();
	}

	private void Update()
	{
		RunCore();
	}

	private void LastUpdate()
	{
		RunCore();
	}

	private void PreLateUpdate()
	{
		RunCore();
	}

	private void LastPreLateUpdate()
	{
		RunCore();
	}

	private void PostLateUpdate()
	{
		RunCore();
	}

	private void LastPostLateUpdate()
	{
		RunCore();
	}

	private void TimeUpdate()
	{
		RunCore();
	}

	private void LastTimeUpdate()
	{
		RunCore();
	}

	[DebuggerHidden]
	private void RunCore()
	{
		lock (runningAndQueueLock)
		{
			running = true;
		}
		lock (arrayLock)
		{
			int num = tail - 1;
			for (int i = 0; i < loopItems.Length; i++)
			{
				IPlayerLoopItem playerLoopItem = loopItems[i];
				if (playerLoopItem != null)
				{
					try
					{
						if (!playerLoopItem.MoveNext())
						{
							loopItems[i] = null;
							goto IL_00f9;
						}
					}
					catch (Exception obj)
					{
						loopItems[i] = null;
						try
						{
							unhandledExceptionCallback(obj);
						}
						catch
						{
						}
						goto IL_00f9;
					}
					continue;
				}
				goto IL_00f9;
				IL_00f9:
				while (i < num)
				{
					IPlayerLoopItem playerLoopItem2 = loopItems[num];
					if (playerLoopItem2 != null)
					{
						try
						{
							if (!playerLoopItem2.MoveNext())
							{
								loopItems[num] = null;
								num--;
								continue;
							}
							loopItems[i] = playerLoopItem2;
							loopItems[num] = null;
							num--;
						}
						catch (Exception obj3)
						{
							loopItems[num] = null;
							num--;
							try
							{
								unhandledExceptionCallback(obj3);
							}
							catch
							{
							}
							continue;
						}
						goto IL_0106;
					}
					num--;
				}
				tail = i;
				break;
				IL_0106:;
			}
			lock (runningAndQueueLock)
			{
				running = false;
				while (waitQueue.Count != 0)
				{
					if (loopItems.Length == tail)
					{
						Array.Resize(ref loopItems, checked(tail * 2));
					}
					loopItems[tail++] = waitQueue.Dequeue();
				}
			}
		}
	}
}
