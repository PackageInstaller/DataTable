using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

namespace Pathfinding;

public class PathProcessor
{
	public struct GraphUpdateLock(PathProcessor pathProcessor, bool block)
	{
		private PathProcessor pathProcessor = pathProcessor;

		private int id = pathProcessor.Lock(block);

		public bool Held
		{
			get
			{
				if (pathProcessor != null)
				{
					return pathProcessor.locks.Contains(id);
				}
				return false;
			}
		}

		public void Release()
		{
			pathProcessor.Unlock(id);
		}
	}

	internal readonly ThreadControlQueue queue;

	private readonly AstarPath astar;

	private readonly PathReturnQueue returnQueue;

	private readonly PathThreadInfo[] threadInfos;

	private readonly Thread[] threads;

	private IEnumerator threadCoroutine;

	private int nextNodeIndex = 1;

	private readonly Stack<int> nodeIndexPool = new Stack<int>();

	private readonly List<int> locks = new List<int>();

	private int nextLockID;

	public int NumThreads => threadInfos.Length;

	public bool IsUsingMultithreading => threads != null;

	public event Action<Path> OnPathPreSearch;

	public event Action<Path> OnPathPostSearch;

	public event Action OnQueueUnblocked;

	internal PathProcessor(AstarPath astar, PathReturnQueue returnQueue, int processors, bool multithreaded)
	{
		this.astar = astar;
		this.returnQueue = returnQueue;
		if (processors < 0)
		{
			throw new ArgumentOutOfRangeException("processors");
		}
		if (!multithreaded && processors != 1)
		{
			throw new Exception("Only a single non-multithreaded processor is allowed");
		}
		queue = new ThreadControlQueue(processors);
		threadInfos = new PathThreadInfo[processors];
		for (int i = 0; i < processors; i++)
		{
			threadInfos[i] = new PathThreadInfo(i, astar, new PathHandler(i, processors));
		}
		if (multithreaded)
		{
			threads = new Thread[processors];
			for (int j = 0; j < processors; j++)
			{
				int threadIndex = j;
				Thread thread = new Thread((ThreadStart)delegate
				{
					CalculatePathsThreaded(threadInfos[threadIndex]);
				})
				{
					Name = "Pathfinding Thread " + j,
					IsBackground = true
				};
				threads[j] = thread;
				thread.Start();
			}
		}
		else
		{
			threadCoroutine = CalculatePaths(threadInfos[0]);
		}
	}

	private int Lock(bool block)
	{
		queue.Block();
		if (block && Application.isPlaying)
		{
			while (!queue.AllReceiversBlocked)
			{
				if (IsUsingMultithreading)
				{
					Thread.Sleep(1);
				}
				else
				{
					TickNonMultithreaded();
				}
			}
		}
		nextLockID++;
		locks.Add(nextLockID);
		return nextLockID;
	}

	private void Unlock(int id)
	{
		if (!locks.Remove(id))
		{
			throw new ArgumentException("This lock has already been released");
		}
		if (locks.Count == 0)
		{
			if (OnQueueUnblocked != null)
			{
				OnQueueUnblocked();
			}
			queue.Unblock();
		}
	}

	public GraphUpdateLock PausePathfinding(bool block)
	{
		return new GraphUpdateLock(this, block);
	}

	public void TickNonMultithreaded()
	{
		if (threadCoroutine == null)
		{
			return;
		}
		try
		{
			threadCoroutine.MoveNext();
		}
		catch (Exception ex)
		{
			threadCoroutine = null;
			if (!(ex is ThreadControlQueue.QueueTerminationException))
			{
				Debug.LogException(ex);
				Debug.LogError((object)"Unhandled exception during pathfinding. Terminating.");
				queue.TerminateReceivers();
				try
				{
					queue.PopNoBlock(blockedBefore: false);
					return;
				}
				catch
				{
					return;
				}
			}
		}
	}

	public void JoinThreads()
	{
		if (threads == null)
		{
			return;
		}
		for (int i = 0; i < threads.Length; i++)
		{
			if (!threads[i].Join(50))
			{
				Debug.LogError((object)("Could not terminate pathfinding thread[" + i + "] in 50ms, trying Thread.Abort"));
				threads[i].Abort();
			}
		}
	}

	public void AbortThreads()
	{
		if (threads == null)
		{
			return;
		}
		for (int i = 0; i < threads.Length; i++)
		{
			if (threads[i] != null && threads[i].IsAlive)
			{
				threads[i].Abort();
			}
		}
	}

	public int GetNewNodeIndex()
	{
		if (nodeIndexPool.Count <= 0)
		{
			return nextNodeIndex++;
		}
		return nodeIndexPool.Pop();
	}

	public void InitializeNode(GraphNode node)
	{
		if (!queue.AllReceiversBlocked)
		{
			throw new Exception("Trying to initialize a node when it is not safe to initialize any nodes. Must be done during a graph update. See http://arongranberg.com/astar/docs/graph-updates.php#direct");
		}
		for (int i = 0; i < threadInfos.Length; i++)
		{
			threadInfos[i].runData.InitializeNode(node);
		}
	}

	public void DestroyNode(GraphNode node)
	{
		if (node.NodeIndex != -1)
		{
			nodeIndexPool.Push(node.NodeIndex);
			for (int i = 0; i < threadInfos.Length; i++)
			{
				threadInfos[i].runData.DestroyNode(node);
			}
		}
	}

	private void CalculatePathsThreaded(PathThreadInfo threadInfo)
	{
		try
		{
			PathHandler runData = threadInfo.runData;
			if (runData.nodes == null)
			{
				throw new NullReferenceException("NodeRuns must be assigned to the threadInfo.runData.nodes field before threads are started\nthreadInfo is an argument to the thread functions");
			}
			long num = (long)(astar.maxFrameTime * 10000f);
			long num2 = DateTime.UtcNow.Ticks + num;
			while (true)
			{
				Path path = queue.Pop();
				IPathInternals pathInternals = path;
				num = (long)(astar.maxFrameTime * 10000f);
				pathInternals.PrepareBase(runData);
				pathInternals.AdvanceState(PathState.Processing);
				if (OnPathPreSearch != null)
				{
					OnPathPreSearch(path);
				}
				long ticks = DateTime.UtcNow.Ticks;
				long num3 = 0L;
				pathInternals.Prepare();
				if (!path.IsDone())
				{
					astar.debugPathData = pathInternals.PathHandler;
					astar.debugPathID = path.pathID;
					pathInternals.Initialize();
					while (!path.IsDone())
					{
						pathInternals.CalculateStep(num2);
						if (path.IsDone())
						{
							break;
						}
						num3 += DateTime.UtcNow.Ticks - ticks;
						Thread.Sleep(0);
						ticks = DateTime.UtcNow.Ticks;
						num2 = ticks + num;
						if (queue.IsTerminating)
						{
							path.Error();
						}
					}
					num3 += DateTime.UtcNow.Ticks - ticks;
					path.duration = (float)num3 * 0.0001f;
				}
				pathInternals.Cleanup();
				if (path.immediateCallback != null)
				{
					path.immediateCallback(path);
				}
				if (OnPathPostSearch != null)
				{
					OnPathPostSearch(path);
				}
				returnQueue.Enqueue(path);
				pathInternals.AdvanceState(PathState.ReturnQueue);
				if (DateTime.UtcNow.Ticks > num2)
				{
					Thread.Sleep(1);
					num2 = DateTime.UtcNow.Ticks + num;
				}
			}
		}
		catch (Exception ex)
		{
			if (ex is ThreadAbortException || ex is ThreadControlQueue.QueueTerminationException)
			{
				if (astar.logPathResults == PathLog.Heavy)
				{
					int threadIndex = threadInfo.threadIndex;
					Debug.LogWarning((object)("Shutting down pathfinding thread #" + threadIndex));
				}
				return;
			}
			Debug.LogException(ex);
			Debug.LogError((object)"Unhandled exception during pathfinding. Terminating.");
			queue.TerminateReceivers();
		}
		Debug.LogError((object)"Error : This part should never be reached.");
		queue.ReceiverTerminated();
	}

	private IEnumerator CalculatePaths(PathThreadInfo threadInfo)
	{
		int numPaths = 0;
		PathHandler runData = threadInfo.runData;
		if (runData.nodes == null)
		{
			throw new NullReferenceException("NodeRuns must be assigned to the threadInfo.runData.nodes field before threads are started\nthreadInfo is an argument to the thread functions");
		}
		long maxTicks = (long)(astar.maxFrameTime * 10000f);
		long targetTick = DateTime.UtcNow.Ticks + maxTicks;
		while (true)
		{
			Path p = null;
			bool blockedBefore = false;
			while (p == null)
			{
				try
				{
					p = queue.PopNoBlock(blockedBefore);
					blockedBefore |= p == null;
				}
				catch (ThreadControlQueue.QueueTerminationException)
				{
					yield break;
				}
				if (p == null)
				{
					yield return null;
				}
			}
			IPathInternals ip = p;
			maxTicks = (long)(astar.maxFrameTime * 10000f);
			ip.PrepareBase(runData);
			ip.AdvanceState(PathState.Processing);
			OnPathPreSearch?.Invoke(p);
			numPaths++;
			long ticks = DateTime.UtcNow.Ticks;
			long totalTicks = 0L;
			ip.Prepare();
			if (!p.IsDone())
			{
				astar.debugPathData = ip.PathHandler;
				astar.debugPathID = p.pathID;
				ip.Initialize();
				while (!p.IsDone())
				{
					ip.CalculateStep(targetTick);
					if (p.IsDone())
					{
						break;
					}
					totalTicks += DateTime.UtcNow.Ticks - ticks;
					yield return null;
					ticks = DateTime.UtcNow.Ticks;
					if (queue.IsTerminating)
					{
						p.Error();
					}
					targetTick = DateTime.UtcNow.Ticks + maxTicks;
				}
				totalTicks += DateTime.UtcNow.Ticks - ticks;
				p.duration = (float)totalTicks * 0.0001f;
			}
			ip.Cleanup();
			p.immediateCallback?.Invoke(p);
			OnPathPostSearch?.Invoke(p);
			returnQueue.Enqueue(p);
			ip.AdvanceState(PathState.ReturnQueue);
			if (DateTime.UtcNow.Ticks > targetTick)
			{
				yield return null;
				targetTick = DateTime.UtcNow.Ticks + maxTicks;
				numPaths = 0;
			}
		}
	}
}
