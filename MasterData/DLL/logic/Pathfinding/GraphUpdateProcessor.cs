using System;
using System.Collections.Generic;
using System.Threading;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public class GraphUpdateProcessor
{
	private enum GraphUpdateOrder
	{
		GraphUpdate,
		FloodFill
	}

	private struct GUOSingle
	{
		public GraphUpdateOrder order;

		public IUpdatableGraph graph;

		public GraphUpdateObject obj;
	}

	private readonly AstarPath astar;

	private Thread graphUpdateThread;

	private bool anyGraphUpdateInProgress;

	private readonly Queue<GraphUpdateObject> graphUpdateQueue = new Queue<GraphUpdateObject>();

	private readonly Queue<GUOSingle> graphUpdateQueueAsync = new Queue<GUOSingle>();

	private readonly Queue<GUOSingle> graphUpdateQueuePost = new Queue<GUOSingle>();

	private readonly Queue<GUOSingle> graphUpdateQueueRegular = new Queue<GUOSingle>();

	private readonly ManualResetEvent asyncGraphUpdatesComplete = new ManualResetEvent(initialState: true);

	private readonly AutoResetEvent graphUpdateAsyncEvent = new AutoResetEvent(initialState: false);

	private readonly AutoResetEvent exitAsyncThread = new AutoResetEvent(initialState: false);

	private uint lastUniqueAreaIndex;

	public bool IsAnyGraphUpdateQueued => graphUpdateQueue.Count > 0;

	public bool IsAnyGraphUpdateInProgress => anyGraphUpdateInProgress;

	public event Action OnGraphsUpdated;

	public GraphUpdateProcessor(AstarPath astar)
	{
		this.astar = astar;
	}

	public AstarWorkItem GetWorkItem()
	{
		return new AstarWorkItem(QueueGraphUpdatesInternal, ProcessGraphUpdates);
	}

	public void EnableMultithreading()
	{
		if (graphUpdateThread == null || !graphUpdateThread.IsAlive)
		{
			graphUpdateThread = new Thread(ProcessGraphUpdatesAsync);
			graphUpdateThread.IsBackground = true;
			graphUpdateThread.Priority = ThreadPriority.Lowest;
			graphUpdateThread.Start(this);
		}
	}

	public void DisableMultithreading()
	{
		if (graphUpdateThread != null && graphUpdateThread.IsAlive)
		{
			exitAsyncThread.Set();
			if (!graphUpdateThread.Join(5000))
			{
				Debug.LogError((object)"Graph update thread did not exit in 5 seconds");
			}
			graphUpdateThread = null;
		}
	}

	public void AddToQueue(GraphUpdateObject ob)
	{
		graphUpdateQueue.Enqueue(ob);
	}

	private void QueueGraphUpdatesInternal()
	{
		bool flag = false;
		while (graphUpdateQueue.Count > 0)
		{
			GraphUpdateObject graphUpdateObject = graphUpdateQueue.Dequeue();
			if (graphUpdateObject.requiresFloodFill)
			{
				flag = true;
			}
			foreach (IUpdatableGraph updateableGraph in astar.data.GetUpdateableGraphs())
			{
				NavGraph graph = updateableGraph as NavGraph;
				if (graphUpdateObject.nnConstraint == null || graphUpdateObject.nnConstraint.SuitableGraph(astar.data.GetGraphIndex(graph), graph))
				{
					GUOSingle item = new GUOSingle
					{
						order = GraphUpdateOrder.GraphUpdate,
						obj = graphUpdateObject,
						graph = updateableGraph
					};
					graphUpdateQueueRegular.Enqueue(item);
				}
			}
		}
		if (flag)
		{
			GUOSingle item2 = new GUOSingle
			{
				order = GraphUpdateOrder.FloodFill
			};
			graphUpdateQueueRegular.Enqueue(item2);
		}
		GraphModifier.TriggerEvent(GraphModifier.EventType.PreUpdate);
		anyGraphUpdateInProgress = true;
	}

	private bool ProcessGraphUpdates(bool force)
	{
		if (force)
		{
			asyncGraphUpdatesComplete.WaitOne();
		}
		else if (!asyncGraphUpdatesComplete.WaitOne(0))
		{
			return false;
		}
		ProcessPostUpdates();
		if (!ProcessRegularUpdates(force))
		{
			return false;
		}
		GraphModifier.TriggerEvent(GraphModifier.EventType.PostUpdate);
		if (OnGraphsUpdated != null)
		{
			OnGraphsUpdated();
		}
		anyGraphUpdateInProgress = false;
		return true;
	}

	private bool ProcessRegularUpdates(bool force)
	{
		while (graphUpdateQueueRegular.Count > 0)
		{
			GUOSingle item = graphUpdateQueueRegular.Peek();
			GraphUpdateThreading graphUpdateThreading = ((item.order == GraphUpdateOrder.FloodFill) ? GraphUpdateThreading.SeparateThread : item.graph.CanUpdateAsync(item.obj));
			if (force || !Application.isPlaying || graphUpdateThread == null || !graphUpdateThread.IsAlive)
			{
				graphUpdateThreading &= (GraphUpdateThreading)(-2);
			}
			if ((graphUpdateThreading & GraphUpdateThreading.UnityInit) != GraphUpdateThreading.UnityThread)
			{
				if (StartAsyncUpdatesIfQueued())
				{
					return false;
				}
				item.graph.UpdateAreaInit(item.obj);
			}
			if ((graphUpdateThreading & GraphUpdateThreading.SeparateThread) != GraphUpdateThreading.UnityThread)
			{
				graphUpdateQueueRegular.Dequeue();
				graphUpdateQueueAsync.Enqueue(item);
				if ((graphUpdateThreading & GraphUpdateThreading.UnityPost) != GraphUpdateThreading.UnityThread && StartAsyncUpdatesIfQueued())
				{
					return false;
				}
				continue;
			}
			if (StartAsyncUpdatesIfQueued())
			{
				return false;
			}
			graphUpdateQueueRegular.Dequeue();
			if (item.order == GraphUpdateOrder.FloodFill)
			{
				FloodFill();
			}
			else
			{
				try
				{
					item.graph.UpdateArea(item.obj);
				}
				catch (Exception ex)
				{
					Debug.LogError((object)("Error while updating graphs\n" + ex));
				}
			}
			if ((graphUpdateThreading & GraphUpdateThreading.UnityPost) != GraphUpdateThreading.UnityThread)
			{
				item.graph.UpdateAreaPost(item.obj);
			}
		}
		if (StartAsyncUpdatesIfQueued())
		{
			return false;
		}
		return true;
	}

	private bool StartAsyncUpdatesIfQueued()
	{
		if (graphUpdateQueueAsync.Count > 0)
		{
			asyncGraphUpdatesComplete.Reset();
			graphUpdateAsyncEvent.Set();
			return true;
		}
		return false;
	}

	private void ProcessPostUpdates()
	{
		while (graphUpdateQueuePost.Count > 0)
		{
			GUOSingle gUOSingle = graphUpdateQueuePost.Dequeue();
			GraphUpdateThreading graphUpdateThreading = gUOSingle.graph.CanUpdateAsync(gUOSingle.obj);
			if ((graphUpdateThreading & GraphUpdateThreading.UnityPost) != GraphUpdateThreading.UnityThread)
			{
				try
				{
					gUOSingle.graph.UpdateAreaPost(gUOSingle.obj);
				}
				catch (Exception ex)
				{
					Debug.LogError((object)("Error while updating graphs (post step)\n" + ex));
				}
			}
		}
	}

	private void ProcessGraphUpdatesAsync()
	{
		AutoResetEvent[] array = new AutoResetEvent[2] { graphUpdateAsyncEvent, exitAsyncThread };
		while (true)
		{
			WaitHandle[] waitHandles = array;
			int num = WaitHandle.WaitAny(waitHandles);
			if (num == 1)
			{
				break;
			}
			while (graphUpdateQueueAsync.Count > 0)
			{
				GUOSingle item = graphUpdateQueueAsync.Dequeue();
				try
				{
					if (item.order == GraphUpdateOrder.GraphUpdate)
					{
						item.graph.UpdateArea(item.obj);
						graphUpdateQueuePost.Enqueue(item);
						continue;
					}
					if (item.order == GraphUpdateOrder.FloodFill)
					{
						FloodFill();
						continue;
					}
					throw new NotSupportedException(item.order.ToString() ?? "");
				}
				catch (Exception ex)
				{
					Debug.LogError((object)("Exception while updating graphs:\n" + ex));
				}
			}
			asyncGraphUpdatesComplete.Set();
		}
		graphUpdateQueueAsync.Clear();
		asyncGraphUpdatesComplete.Set();
	}

	public void FloodFill(GraphNode seed)
	{
		FloodFill(seed, lastUniqueAreaIndex + 1);
		lastUniqueAreaIndex++;
	}

	public void FloodFill(GraphNode seed, uint area)
	{
		if (area > 131071)
		{
			Debug.LogError((object)("Too high area index - The maximum area index is " + 131071u));
			return;
		}
		if (area < 0)
		{
			Debug.LogError((object)"Too low area index - The minimum area index is 0");
			return;
		}
		Stack<GraphNode> stack = StackPool<GraphNode>.Claim();
		stack.Push(seed);
		seed.Area = area;
		while (stack.Count > 0)
		{
			stack.Pop().FloodFill(stack, area);
		}
		StackPool<GraphNode>.Release(stack);
	}

	public void FloodFill()
	{
		NavGraph[] graphs = astar.graphs;
		if (graphs == null)
		{
			return;
		}
		for (int i = 0; i < graphs.Length; i++)
		{
			graphs[i]?.GetNodes(delegate(GraphNode node)
			{
				node.Area = 0u;
			});
		}
		lastUniqueAreaIndex = 0u;
		uint area = 0u;
		int forcedSmallAreas = 0;
		Stack<GraphNode> stack = StackPool<GraphNode>.Claim();
		for (int num = 0; num < graphs.Length; num++)
		{
			graphs[num]?.GetNodes(delegate(GraphNode node)
			{
				if (node.Walkable && node.Area == 0)
				{
					area++;
					uint num2 = area;
					if (area > 131071)
					{
						area--;
						num2 = area;
						if (forcedSmallAreas == 0)
						{
							forcedSmallAreas = 1;
						}
						forcedSmallAreas++;
					}
					stack.Clear();
					stack.Push(node);
					int num3 = 1;
					node.Area = num2;
					while (stack.Count > 0)
					{
						num3++;
						stack.Pop().FloodFill(stack, num2);
					}
				}
			});
		}
		lastUniqueAreaIndex = area;
		if (forcedSmallAreas > 0)
		{
			Debug.LogError((object)(forcedSmallAreas + " areas had to share IDs. This usually doesn't affect pathfinding in any significant way (you might get 'Searched whole area but could not find target' as a reason for path failure) however some path requests may take longer to calculate (specifically those that fail with the 'Searched whole area' error).The maximum number of areas is " + 131071u + "."));
		}
		StackPool<GraphNode>.Release(stack);
	}
}
