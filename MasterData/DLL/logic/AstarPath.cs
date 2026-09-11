using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using Pathfinding;
using Pathfinding.Util;
using UnityEngine;
using UnityEngine.Serialization;

[HelpURL("http://arongranberg.com/astar/docs/class_astar_path.php")]
[ExecuteInEditMode]
[AddComponentMenu("Pathfinding/Pathfinder")]
public class AstarPath : IAstarBehavior
{
	public enum AstarDistribution
	{
		WebsiteDownload,
		AssetStore
	}

	public static readonly AstarDistribution Distribution = AstarDistribution.AssetStore;

	public static readonly string Branch = "master_Pro";

	[FormerlySerializedAs("astarData")]
	public AstarData data;

	public static AstarPath active;

	public SimContext simContext;

	public TileHandler mTileHandler;

	public bool showNavGraphs = true;

	public bool showUnwalkableNodes = true;

	public GraphDebugMode debugMode;

	public float debugFloor;

	public float debugRoof = 20000f;

	public bool manualDebugFloorRoof;

	public bool showSearchTree;

	public float unwalkableNodeDebugSize = 0.3f;

	public PathLog logPathResults = PathLog.Normal;

	public int maxNearestNodeDistance = 100000;

	public bool scanOnStartup = true;

	public bool fullGetNearestSearch;

	public bool prioritizeGraphs;

	public long prioritizeGraphsLimit = 1000L;

	public AstarColor colorSettings;

	[SerializeField]
	protected string[] tagNames;

	public Heuristic heuristic = Heuristic.Euclidean;

	public float heuristicScale = 1f;

	public ThreadCount threadCount;

	public float maxFrameTime = 1f;

	[Obsolete("Minimum area size is mostly obsolete since the limit has been raised significantly, and the edge cases are handled automatically")]
	public int minAreaSize;

	public bool batchGraphUpdates;

	public float graphUpdateBatchingInterval = 0.2f;

	[NonSerialized]
	public PathHandler debugPathData;

	[NonSerialized]
	public ushort debugPathID;

	private string inGameDebugPath;

	[NonSerialized]
	private bool isScanningBacking;

	public static Action OnAwakeSettings;

	public static OnGraphDelegate OnGraphPreScan;

	public static OnGraphDelegate OnGraphPostScan;

	public static OnPathDelegate OnPathPreSearch;

	public static OnPathDelegate OnPathPostSearch;

	public static OnScanDelegate OnPreScan;

	public static OnScanDelegate OnPostScan;

	public static OnScanDelegate OnLatePostScan;

	public static OnScanDelegate OnGraphsUpdated;

	public static Action On65KOverflow;

	[Obsolete]
	public Action OnGraphsWillBeUpdated;

	[Obsolete]
	public Action OnGraphsWillBeUpdated2;

	private readonly GraphUpdateProcessor graphUpdates;

	private readonly WorkItemProcessor workItems;

	private PathProcessor pathProcessor;

	private bool graphUpdateRoutineRunning;

	private bool graphUpdatesWorkItemAdded;

	private float lastGraphUpdate = -9999f;

	private PathProcessor.GraphUpdateLock workItemLock;

	internal readonly PathReturnQueue pathReturnQueue;

	public EuclideanEmbedding euclideanEmbedding = new EuclideanEmbedding();

	public bool showGraphs;

	private ushort nextFreePathID = 1;

	private static int waitForPathDepth = 0;

	private NNConstraint mConstrait = NNConstraint.None;

	public static Version Version => new Version(4, 0, 11);

	[Obsolete]
	public Type[] graphTypes => data.graphTypes;

	[Obsolete("The 'astarData' field has been renamed to 'data'")]
	public AstarData astarData => data;

	public NavGraph[] graphs
	{
		get
		{
			if (data == null)
			{
				data = new AstarData();
			}
			return data.graphs;
		}
	}

	public long maxNearestNodeDistanceSqr => maxNearestNodeDistance * maxNearestNodeDistance;

	[Obsolete("This field has been renamed to 'batchGraphUpdates'")]
	public bool limitGraphUpdates
	{
		get
		{
			return batchGraphUpdates;
		}
		set
		{
			batchGraphUpdates = value;
		}
	}

	[Obsolete("This field has been renamed to 'graphUpdateBatchingInterval'")]
	public float maxGraphUpdateFreq
	{
		get
		{
			return graphUpdateBatchingInterval;
		}
		set
		{
			graphUpdateBatchingInterval = value;
		}
	}

	public float lastScanTime { get; private set; }

	public bool isScanning
	{
		get
		{
			return isScanningBacking;
		}
		private set
		{
			isScanningBacking = value;
		}
	}

	public int NumParallelThreads => pathProcessor.NumThreads;

	public bool IsUsingMultithreading => pathProcessor.IsUsingMultithreading;

	[Obsolete("Fixed grammar, use IsAnyGraphUpdateQueued instead")]
	public bool IsAnyGraphUpdatesQueued => IsAnyGraphUpdateQueued;

	public bool IsAnyGraphUpdateQueued => graphUpdates.IsAnyGraphUpdateQueued;

	public bool IsAnyGraphUpdateInProgress => graphUpdates.IsAnyGraphUpdateInProgress;

	public bool IsAnyWorkItemInProgress => workItems.workItemsInProgress;

	internal bool IsInsideWorkItem => workItems.workItemsInProgressRightNow;

	public string[] GetTagNames()
	{
		if (tagNames == null || tagNames.Length != 32)
		{
			tagNames = new string[32];
			for (int i = 0; i < tagNames.Length; i++)
			{
				tagNames[i] = i.ToString() ?? "";
			}
			tagNames[0] = "Basic Ground";
		}
		return tagNames;
	}

	internal ushort GetNextPathID()
	{
		if (nextFreePathID == 0)
		{
			nextFreePathID++;
			Debug.Log((object)"65K cleanup (this message is harmless, it just means you have searched a lot of paths)");
			if (On65KOverflow != null)
			{
				Action on65KOverflow = On65KOverflow;
				On65KOverflow = null;
				on65KOverflow();
			}
		}
		return nextFreePathID++;
	}

	private void RecalculateDebugLimits()
	{
		debugFloor = float.PositiveInfinity;
		debugRoof = float.NegativeInfinity;
		bool ignoreSearchTree = !showSearchTree || debugPathData == null;
		for (int i = 0; i < graphs.Length; i++)
		{
			if (graphs[i] == null || !graphs[i].drawGizmos)
			{
				continue;
			}
			graphs[i].GetNodes(delegate(GraphNode node)
			{
				if (ignoreSearchTree || GraphGizmoHelper.InSearchTree(node, debugPathData, debugPathID))
				{
					if (debugMode == GraphDebugMode.Penalty)
					{
						debugFloor = Mathf.Min(debugFloor, (float)node.Penalty);
						debugRoof = Mathf.Max(debugRoof, (float)node.Penalty);
					}
					else if (debugPathData != null)
					{
						PathNode pathNode = debugPathData.GetPathNode(node);
						switch (debugMode)
						{
						case GraphDebugMode.F:
							debugFloor = Mathf.Min(debugFloor, (float)pathNode.F);
							debugRoof = Mathf.Max(debugRoof, (float)pathNode.F);
							break;
						case GraphDebugMode.G:
							debugFloor = Mathf.Min(debugFloor, (float)pathNode.G);
							debugRoof = Mathf.Max(debugRoof, (float)pathNode.G);
							break;
						case GraphDebugMode.H:
							debugFloor = Mathf.Min(debugFloor, (float)pathNode.H);
							debugRoof = Mathf.Max(debugRoof, (float)pathNode.H);
							break;
						}
					}
				}
			});
		}
		if (float.IsInfinity(debugFloor))
		{
			debugFloor = 0f;
			debugRoof = 1f;
		}
		if (debugRoof - debugFloor < 1f)
		{
			debugRoof++;
		}
	}

	internal void Log(string s)
	{
		if (active == null)
		{
			Debug.Log((object)("No AstarPath object was found : " + s));
		}
		else if (active.logPathResults != PathLog.None && active.logPathResults != PathLog.OnlyErrors)
		{
			Debug.Log((object)s);
		}
	}

	private void LogPathResults(Path p)
	{
		if (logPathResults != PathLog.None && (logPathResults != PathLog.OnlyErrors || p.error))
		{
			string text = p.DebugString(logPathResults);
			if (logPathResults == PathLog.InGame)
			{
				inGameDebugPath = text;
			}
			else
			{
				Debug.Log((object)text);
			}
		}
	}

	public void Update()
	{
		if (!isScanning)
		{
			PerformBlockingActions();
		}
		pathProcessor.TickNonMultithreaded();
		pathReturnQueue.ReturnPaths(timeSlice: true);
	}

	private void PerformBlockingActions(bool force = false)
	{
		if (workItemLock.Held && pathProcessor.queue.AllReceiversBlocked)
		{
			pathReturnQueue.ReturnPaths(timeSlice: false);
			if (workItems.ProcessWorkItems(force))
			{
				workItemLock.Release();
			}
		}
	}

	[Obsolete("This method has been moved. Use the method on the context object that can be sent with work item delegates instead")]
	public void QueueWorkItemFloodFill()
	{
		throw new Exception("This method has been moved. Use the method on the context object that can be sent with work item delegates instead");
	}

	[Obsolete("This method has been moved. Use the method on the context object that can be sent with work item delegates instead")]
	public void EnsureValidFloodFill()
	{
		throw new Exception("This method has been moved. Use the method on the context object that can be sent with work item delegates instead");
	}

	public void AddWorkItem(Action callback)
	{
		AddWorkItem(new AstarWorkItem(callback));
	}

	public void AddWorkItem(AstarWorkItem item)
	{
		workItems.AddWorkItem(item);
		if (!workItemLock.Held)
		{
			workItemLock = PausePathfindingSoon();
		}
	}

	public void QueueGraphUpdates()
	{
		if (!graphUpdatesWorkItemAdded)
		{
			graphUpdatesWorkItemAdded = true;
			AstarWorkItem workItem = graphUpdates.GetWorkItem();
			AddWorkItem(new AstarWorkItem(delegate
			{
				graphUpdatesWorkItemAdded = false;
				lastGraphUpdate = Time.realtimeSinceStartup;
				workItem.init();
			}, workItem.update));
		}
	}

	private IEnumerator DelayedGraphUpdate()
	{
		graphUpdateRoutineRunning = true;
		yield return (object)new WaitForSeconds(graphUpdateBatchingInterval - (Time.realtimeSinceStartup - lastGraphUpdate));
		QueueGraphUpdates();
		graphUpdateRoutineRunning = false;
	}

	public void UpdateGraphs(Bounds bounds, float delay)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		UpdateGraphs(new GraphUpdateObject(bounds));
	}

	public void UpdateGraphs(Bounds bounds)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		UpdateGraphs(new GraphUpdateObject(bounds));
	}

	public void UpdateGraphs(GraphUpdateObject ob)
	{
		graphUpdates.AddToQueue(ob);
		QueueGraphUpdates();
	}

	public void FlushGraphUpdates()
	{
		if (IsAnyGraphUpdateQueued)
		{
			QueueGraphUpdates();
			FlushWorkItems();
		}
	}

	public void FlushWorkItems()
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = PausePathfinding();
		PerformBlockingActions(force: true);
		graphUpdateLock.Release();
	}

	[Obsolete("Use FlushWorkItems() instead")]
	public void FlushWorkItems(bool unblockOnComplete, bool block)
	{
		PathProcessor.GraphUpdateLock graphUpdateLock = PausePathfinding();
		PerformBlockingActions(block);
		graphUpdateLock.Release();
	}

	[Obsolete("Use FlushWorkItems instead")]
	public void FlushThreadSafeCallbacks()
	{
		FlushWorkItems();
	}

	public static int CalculateThreadCount(ThreadCount count)
	{
		if (count == ThreadCount.AutomaticLowLoad || count == ThreadCount.AutomaticHighLoad)
		{
			int num = Mathf.Max(1, SystemInfo.processorCount);
			int num2 = SystemInfo.systemMemorySize;
			if (num2 <= 0)
			{
				Debug.LogError((object)"Machine reporting that is has <= 0 bytes of RAM. This is definitely not true, assuming 1 GiB");
				num2 = 1024;
			}
			if (num <= 1)
			{
				return 0;
			}
			if (num2 <= 512)
			{
				return 0;
			}
			if (count == ThreadCount.AutomaticHighLoad)
			{
				if (num2 <= 1024)
				{
					num = Math.Min(num, 2);
				}
			}
			else
			{
				num /= 2;
				num = Mathf.Max(1, num);
				if (num2 <= 1024)
				{
					num = Math.Min(num, 2);
				}
				num = Math.Min(num, 6);
			}
			return num;
		}
		return (int)count;
	}

	public AstarPath(SimContext simContext)
	{
		active = this;
		this.simContext = simContext;
		if (!Application.isPlaying)
		{
			return;
		}
		pathProcessor = new PathProcessor(this, pathReturnQueue, 0, multithreaded: true);
		pathReturnQueue = new PathReturnQueue(this);
		workItems = new WorkItemProcessor(this);
		graphUpdates = new GraphUpdateProcessor(this);
		graphUpdates.OnGraphsUpdated += delegate
		{
			if (OnGraphsUpdated != null)
			{
				OnGraphsUpdated(this);
			}
		};
		if (OnAwakeSettings != null)
		{
			OnAwakeSettings();
		}
		GraphModifier.FindAllModifiers();
		InitializePathProcessor();
		InitializeProfiler();
		ConfigureReferencesInternal();
		InitializeAstarData();
		FlushWorkItems();
		euclideanEmbedding.dirty = true;
		if (scanOnStartup && (!data.cacheStartup || data.data_cachedStartup == null))
		{
			Scan();
		}
	}

	private void InitializePathProcessor()
	{
		int num = CalculateThreadCount(threadCount);
		int processors = Mathf.Max(num, 1);
		bool flag = num > 0;
		pathProcessor = new PathProcessor(this, pathReturnQueue, processors, flag);
		pathProcessor.OnPathPreSearch += delegate(Path path)
		{
			OnPathPreSearch?.Invoke(path);
		};
		pathProcessor.OnPathPostSearch += delegate(Path path)
		{
			OnPathPostSearch?.Invoke(path);
		};
		pathProcessor.OnQueueUnblocked += delegate
		{
			if (euclideanEmbedding.dirty)
			{
				euclideanEmbedding.RecalculateCosts();
			}
		};
		if (flag)
		{
			graphUpdates.EnableMultithreading();
		}
	}

	internal void VerifyIntegrity()
	{
		if (active != this)
		{
			throw new Exception("Singleton pattern broken. Make sure you only have one AstarPath object in the scene");
		}
		if (data == null)
		{
			throw new NullReferenceException("data is null... A* not set up correctly?");
		}
		if (data.graphs == null)
		{
			data.graphs = new NavGraph[0];
			data.UpdateShortcuts();
		}
	}

	public void ConfigureReferencesInternal()
	{
		active = this;
		data = data ?? new AstarData();
		colorSettings = colorSettings ?? new AstarColor();
		colorSettings.OnEnable();
	}

	private void InitializeProfiler()
	{
	}

	private void InitializeAstarData()
	{
		data.FindGraphTypes();
		data.Awake();
		data.UpdateShortcuts();
	}

	public void LoadAstartData(ref byte[] map)
	{
		data.cacheStartup = true;
		data.data_cachedStartup = map;
		InitializeAstarData();
	}

	public void FloodFill(GraphNode seed)
	{
		graphUpdates.FloodFill(seed);
	}

	public void FloodFill(GraphNode seed, uint area)
	{
		graphUpdates.FloodFill(seed, area);
	}

	[ContextMenu("Flood Fill Graphs")]
	public void FloodFill()
	{
		graphUpdates.FloodFill();
		workItems.OnFloodFill();
	}

	internal int GetNewNodeIndex()
	{
		return pathProcessor.GetNewNodeIndex();
	}

	internal void InitializeNode(GraphNode node)
	{
		pathProcessor.InitializeNode(node);
	}

	internal void DestroyNode(GraphNode node)
	{
		pathProcessor.DestroyNode(node);
	}

	[Obsolete("Use PausePathfinding instead. Make sure to call Release on the returned lock.", true)]
	public void BlockUntilPathQueueBlocked()
	{
	}

	public PathProcessor.GraphUpdateLock PausePathfinding()
	{
		return pathProcessor.PausePathfinding(block: true);
	}

	private PathProcessor.GraphUpdateLock PausePathfindingSoon()
	{
		return pathProcessor.PausePathfinding(block: false);
	}

	public void Scan(NavGraph graphToScan)
	{
		if (graphToScan == null)
		{
			throw new ArgumentNullException();
		}
		Scan(new NavGraph[1] { graphToScan });
	}

	public void Scan(NavGraph[] graphsToScan = null)
	{
		foreach (Progress item in ScanAsync(graphsToScan))
		{
		}
	}

	[Obsolete("ScanLoop is now named ScanAsync and is an IEnumerable<Progress>. Use foreach to iterate over the progress insead")]
	public void ScanLoop(OnScanStatus statusCallback)
	{
		foreach (Progress item in ScanAsync())
		{
			statusCallback(item);
		}
	}

	public IEnumerable<Progress> ScanAsync(NavGraph graphToScan)
	{
		if (graphToScan == null)
		{
			throw new ArgumentNullException();
		}
		return ScanAsync(new NavGraph[1] { graphToScan });
	}

	public IEnumerable<Progress> ScanAsync(NavGraph[] graphsToScan = null)
	{
		if (graphsToScan == null)
		{
			graphsToScan = graphs;
		}
		if (graphsToScan == null)
		{
			yield break;
		}
		if (isScanning)
		{
			throw new InvalidOperationException("Another async scan is already running");
		}
		isScanning = true;
		VerifyIntegrity();
		PathProcessor.GraphUpdateLock graphUpdateLock = PausePathfinding();
		pathReturnQueue.ReturnPaths(timeSlice: false);
		if (!Application.isPlaying)
		{
			data.FindGraphTypes();
			GraphModifier.FindAllModifiers();
		}
		yield return new Progress(0.05f, "Pre processing graphs");
		if (OnPreScan != null)
		{
			OnPreScan(this);
		}
		GraphModifier.TriggerEvent(GraphModifier.EventType.PreScan);
		data.LockGraphStructure();
		Stopwatch watch = Stopwatch.StartNew();
		for (int i = 0; i < graphsToScan.Length; i++)
		{
			if (graphsToScan[i] != null)
			{
				graphsToScan[i].DestroyAllNodesInternal();
			}
		}
		for (int j = 0; j < graphsToScan.Length; j++)
		{
			if (graphsToScan[j] == null)
			{
				continue;
			}
			float minp = Mathf.Lerp(0.1f, 0.8f, (float)j / (float)graphsToScan.Length);
			float maxp = Mathf.Lerp(0.1f, 0.8f, ((float)j + 0.95f) / (float)graphsToScan.Length);
			string progressDescriptionPrefix = "Scanning graph " + (j + 1) + " of " + graphsToScan.Length + " - ";
			IEnumerator<Progress> coroutine = ScanGraph(graphsToScan[j]).GetEnumerator();
			while (true)
			{
				try
				{
					if (!coroutine.MoveNext())
					{
						break;
					}
				}
				catch
				{
					isScanning = false;
					data.UnlockGraphStructure();
					graphUpdateLock.Release();
					throw;
				}
				yield return new Progress(Mathf.Lerp(minp, maxp, coroutine.Current.progress), progressDescriptionPrefix + coroutine.Current.description);
			}
		}
		data.UnlockGraphStructure();
		yield return new Progress(0.8f, "Post processing graphs");
		if (OnPostScan != null)
		{
			OnPostScan(this);
		}
		GraphModifier.TriggerEvent(GraphModifier.EventType.PostScan);
		FlushWorkItems();
		yield return new Progress(0.9f, "Computing areas");
		FloodFill();
		yield return new Progress(0.95f, "Late post processing");
		isScanning = false;
		if (OnLatePostScan != null)
		{
			OnLatePostScan(this);
		}
		GraphModifier.TriggerEvent(GraphModifier.EventType.LatePostScan);
		euclideanEmbedding.dirty = true;
		euclideanEmbedding.RecalculatePivots();
		FlushWorkItems();
		graphUpdateLock.Release();
		watch.Stop();
		lastScanTime = (float)watch.Elapsed.TotalSeconds;
		GC.Collect();
		Log("Scanning - Process took " + (lastScanTime * 1000f).ToString("0") + " ms to complete");
	}

	private IEnumerable<Progress> ScanGraph(NavGraph graph)
	{
		if (OnGraphPreScan != null)
		{
			yield return new Progress(0f, "Pre processing");
			OnGraphPreScan(graph);
		}
		yield return new Progress(0f, "");
		foreach (Progress item in graph.ScanInternal())
		{
			yield return new Progress(Mathf.Lerp(0f, 0.95f, item.progress), item.description);
		}
		yield return new Progress(0.95f, "Assigning graph indices");
		graph.GetNodes(delegate(GraphNode node)
		{
			node.GraphIndex = graph.graphIndex;
		});
		if (OnGraphPostScan != null)
		{
			yield return new Progress(0.99f, "Post processing");
			OnGraphPostScan(graph);
		}
	}

	[Obsolete("This method has been renamed to BlockUntilCalculated")]
	public static void WaitForPath(Path p)
	{
		BlockUntilCalculated(p);
	}

	public static void BlockUntilCalculated(Path p)
	{
		if (active == null)
		{
			throw new Exception("Pathfinding is not correctly initialized in this scene (yet?). AstarPath.active is null.\nDo not call this function in Awake");
		}
		if (p == null)
		{
			throw new ArgumentNullException("Path must not be null");
		}
		if (active.pathProcessor.queue.IsTerminating)
		{
			return;
		}
		if (p.PipelineState == PathState.Created)
		{
			throw new Exception("The specified path has not been started yet.");
		}
		waitForPathDepth++;
		if (waitForPathDepth == 5)
		{
			Debug.LogError((object)"You are calling the BlockUntilCalculated function recursively (maybe from a path callback). Please don't do this.");
		}
		if (p.PipelineState < PathState.ReturnQueue)
		{
			if (active.IsUsingMultithreading)
			{
				while (p.PipelineState < PathState.ReturnQueue)
				{
					if (active.pathProcessor.queue.IsTerminating)
					{
						waitForPathDepth--;
						throw new Exception("Pathfinding Threads seem to have crashed.");
					}
					Thread.Sleep(1);
					active.PerformBlockingActions(force: true);
				}
			}
			else
			{
				while (p.PipelineState < PathState.ReturnQueue)
				{
					if (active.pathProcessor.queue.IsEmpty && p.PipelineState != PathState.Processing)
					{
						waitForPathDepth--;
						throw new Exception("Critical error. Path Queue is empty but the path state is '" + p.PipelineState.ToString() + "'");
					}
					active.pathProcessor.TickNonMultithreaded();
					active.PerformBlockingActions(force: true);
				}
			}
		}
		active.pathReturnQueue.ReturnPaths(timeSlice: false);
		waitForPathDepth--;
	}

	[Obsolete("The threadSafe parameter has been deprecated")]
	public static void RegisterSafeUpdate(Action callback, bool threadSafe)
	{
		RegisterSafeUpdate(callback);
	}

	[Obsolete("Use AddWorkItem(System.Action) instead. Note the slight change in behavior (mentioned in the documentation).")]
	public static void RegisterSafeUpdate(Action callback)
	{
		active.AddWorkItem(new AstarWorkItem(callback));
	}

	public static void StartPath(Path p, bool pushToFront = false)
	{
		AstarPath astarPath = active;
		if (astarPath == null)
		{
			Debug.LogError((object)"There is no AstarPath object in the scene or it has not been initialized yet");
			return;
		}
		if (p.PipelineState != PathState.Created)
		{
			throw new Exception("The path has an invalid state. Expected " + PathState.Created.ToString() + " found " + p.PipelineState.ToString() + "\nMake sure you are not requesting the same path twice");
		}
		if (astarPath.pathProcessor.queue.IsTerminating)
		{
			p.Error();
			p.LogError("No new paths are accepted");
			return;
		}
		if (astarPath.graphs == null || astarPath.graphs.Length == 0)
		{
			Debug.LogError((object)"There are no graphs in the scene");
			p.Error();
			p.LogError("There are no graphs in the scene");
			Debug.LogError((object)p.errorLog);
			return;
		}
		p.Claim(astarPath);
		((IPathInternals)p).AdvanceState(PathState.PathQueue);
		if (pushToFront)
		{
			astarPath.pathProcessor.queue.PushFront(p);
		}
		else
		{
			astarPath.pathProcessor.queue.Push(p);
		}
	}

	public void AddSearchPath(Path p, bool pushToFront = false)
	{
		StartPath(p, pushToFront);
	}

	public NNInfo GetNearest(Int3 position)
	{
		return GetNearest(position, mConstrait);
	}

	public NNInfo GetNearest(Int3 position, NNConstraint constraint)
	{
		return GetNearest(position, constraint, null);
	}

	public NNInfo GetNearest(Int3 position, NNConstraint constraint, GraphNode hint)
	{
		NavGraph[] array = graphs;
		long num = long.MaxValue;
		NNInfoInternal internalInfo = default(NNInfoInternal);
		int num2 = -1;
		if (array != null)
		{
			for (int i = 0; i < array.Length; i++)
			{
				NavGraph navGraph = array[i];
				if (navGraph == null || !constraint.SuitableGraph(i, navGraph))
				{
					continue;
				}
				NNInfoInternal nNInfoInternal = ((!fullGetNearestSearch) ? navGraph.GetNearest(position, constraint) : navGraph.GetNearestForce(position, constraint));
				GraphNode node = nNInfoInternal.node;
				if (node != null)
				{
					long sqrMagnitudeLong = (nNInfoInternal.clampedPosition - position).sqrMagnitudeLong;
					if (prioritizeGraphs && sqrMagnitudeLong < prioritizeGraphsLimit * prioritizeGraphsLimit)
					{
						num = sqrMagnitudeLong;
						internalInfo = nNInfoInternal;
						num2 = i;
						break;
					}
					if (sqrMagnitudeLong < num)
					{
						num = sqrMagnitudeLong;
						internalInfo = nNInfoInternal;
						num2 = i;
					}
				}
			}
		}
		if (num2 == -1)
		{
			return default(NNInfo);
		}
		if (internalInfo.constrainedNode != null)
		{
			internalInfo.node = internalInfo.constrainedNode;
			internalInfo.clampedPosition = internalInfo.constClampedPosition;
		}
		if (!fullGetNearestSearch && internalInfo.node != null && !constraint.Suitable(internalInfo.node))
		{
			NNInfoInternal nearestForce = array[num2].GetNearestForce(position, constraint);
			if (nearestForce.node != null)
			{
				internalInfo = nearestForce;
			}
		}
		if (!constraint.Suitable(internalInfo.node) || (constraint.constrainDistance && (internalInfo.clampedPosition - position).sqrMagnitudeLong > maxNearestNodeDistanceSqr * 1000 * 1000))
		{
			return default(NNInfo);
		}
		return new NNInfo(internalInfo);
	}

	public GraphNode GetNearest(Ray ray)
	{
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		if (graphs == null)
		{
			return null;
		}
		float minDist = float.PositiveInfinity;
		GraphNode nearestNode = null;
		Vector3 lineDirection = ((Ray)(ref ray)).direction;
		Vector3 lineOrigin = ((Ray)(ref ray)).origin;
		for (int i = 0; i < graphs.Length; i++)
		{
			NavGraph navGraph = graphs[i];
			navGraph.GetNodes(delegate(GraphNode node)
			{
				//IL_0006: Unknown result type (might be due to invalid IL or missing references)
				//IL_000b: Unknown result type (might be due to invalid IL or missing references)
				//IL_000d: Unknown result type (might be due to invalid IL or missing references)
				//IL_0012: Unknown result type (might be due to invalid IL or missing references)
				//IL_0014: Unknown result type (might be due to invalid IL or missing references)
				//IL_0019: Unknown result type (might be due to invalid IL or missing references)
				//IL_001f: Unknown result type (might be due to invalid IL or missing references)
				//IL_002a: Unknown result type (might be due to invalid IL or missing references)
				//IL_002f: Unknown result type (might be due to invalid IL or missing references)
				//IL_0034: Unknown result type (might be due to invalid IL or missing references)
				//IL_0039: Unknown result type (might be due to invalid IL or missing references)
				//IL_003a: Unknown result type (might be due to invalid IL or missing references)
				//IL_0040: Unknown result type (might be due to invalid IL or missing references)
				//IL_005b: Unknown result type (might be due to invalid IL or missing references)
				//IL_0061: Unknown result type (might be due to invalid IL or missing references)
				//IL_007c: Unknown result type (might be due to invalid IL or missing references)
				//IL_007d: Unknown result type (might be due to invalid IL or missing references)
				//IL_007e: Unknown result type (might be due to invalid IL or missing references)
				//IL_0083: Unknown result type (might be due to invalid IL or missing references)
				Vector3 val = (Vector3)node.position;
				Vector3 val2 = lineOrigin + Vector3.Dot(val - lineOrigin, lineDirection) * lineDirection;
				float num = Mathf.Abs(val2.x - val.x);
				num *= num;
				if (!(num > minDist))
				{
					num = Mathf.Abs(val2.z - val.z);
					num *= num;
					if (!(num > minDist))
					{
						Vector3 val3 = val2 - val;
						float sqrMagnitude = ((Vector3)(ref val3)).sqrMagnitude;
						if (sqrMagnitude < minDist)
						{
							minDist = sqrMagnitude;
							nearestNode = node;
						}
					}
				}
			});
		}
		return nearestNode;
	}

	public void Initialize()
	{
	}

	public void Active()
	{
	}

	public void LateUpdate()
	{
	}

	public void Reset()
	{
	}

	public void Shutdown()
	{
		OnApplicationQuit();
	}

	private void OnDisable()
	{
	}

	private void OnDestroy()
	{
		if (!Application.isPlaying)
		{
			return;
		}
		if (logPathResults == PathLog.Heavy)
		{
			Debug.Log((object)"+++ AstarPath Component Destroyed - Cleaning Up Pathfinding Data +++");
		}
		if (active == this)
		{
			PausePathfinding();
			euclideanEmbedding.dirty = false;
			FlushWorkItems();
			pathProcessor.queue.TerminateReceivers();
			if (logPathResults == PathLog.Heavy)
			{
				Debug.Log((object)"Processing Possible Work Items");
			}
			graphUpdates.DisableMultithreading();
			pathProcessor.JoinThreads();
			if (logPathResults == PathLog.Heavy)
			{
				Debug.Log((object)"Returning Paths");
			}
			pathReturnQueue.ReturnPaths(timeSlice: false);
			if (logPathResults == PathLog.Heavy)
			{
				Debug.Log((object)"Destroying Graphs");
			}
			data.OnDestroy();
			if (logPathResults == PathLog.Heavy)
			{
				Debug.Log((object)"Cleaning up variables");
			}
			OnAwakeSettings = null;
			OnGraphPreScan = null;
			OnGraphPostScan = null;
			OnPathPreSearch = null;
			OnPathPostSearch = null;
			OnPreScan = null;
			OnPostScan = null;
			OnLatePostScan = null;
			On65KOverflow = null;
			OnGraphsUpdated = null;
			active = null;
		}
	}

	private void OnApplicationQuit()
	{
		OnDestroy();
		pathProcessor.AbortThreads();
	}
}
