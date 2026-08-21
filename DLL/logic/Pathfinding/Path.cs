using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public abstract class Path : IPathInternals
{
	protected PathHandler pathHandler;

	public OnPathDelegate callback;

	public OnPathDelegate immediateCallback;

	private object stateLock = new object();

	public ITraversalProvider traversalProvider;

	private string _errorLog = "";

	public List<GraphNode> path;

	public List<Vector3> vectorPath;

	public List<Int3> int3Path;

	public PathNode currentR;

	public float duration;

	protected int searchedNodes;

	protected bool hasBeenReset;

	public NNConstraint nnConstraint = PathNNConstraint.Default;

	internal Path next;

	public Heuristic heuristic;

	public float heuristicScale = 1f;

	protected GraphNode hTargetNode;

	protected Int3 hTarget;

	public int enabledTags = -1;

	private static readonly int[] ZeroTagPenalties = new int[32];

	protected int[] internalTagPenalties;

	protected int[] manualTagPenalties;

	private List<object> claimed = new List<object>();

	private bool releasedNotSilent;

	public PathState PipelineState { get; private set; }

	public PathCompleteState CompleteState { get; protected set; }

	public bool error => CompleteState == PathCompleteState.Error;

	public string errorLog => _errorLog;

	bool IPathInternals.Pooled { get; set; }

	[Obsolete("Has been renamed to 'Pooled' to use more widely underestood terminology", true)]
	internal bool recycled => false;

	internal ushort pathID { get; private set; }

	public int[] tagPenalties
	{
		get
		{
			return manualTagPenalties;
		}
		set
		{
			if (value == null || value.Length != 32)
			{
				manualTagPenalties = null;
				internalTagPenalties = ZeroTagPenalties;
			}
			else
			{
				manualTagPenalties = value;
				internalTagPenalties = value;
			}
		}
	}

	internal virtual bool FloodingPath => false;

	PathHandler IPathInternals.PathHandler => pathHandler;

	public float GetTotalLength()
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		if (vectorPath == null)
		{
			return float.PositiveInfinity;
		}
		float num = 0f;
		for (int i = 0; i < vectorPath.Count - 1; i++)
		{
			num += Vector3.Distance(vectorPath[i], vectorPath[i + 1]);
		}
		return num;
	}

	public IEnumerator WaitForPath()
	{
		if (PipelineState == PathState.Created)
		{
			throw new InvalidOperationException("This path has not been started yet");
		}
		while (PipelineState != PathState.Returned)
		{
			yield return null;
		}
	}

	public void BlockUntilCalculated()
	{
		AstarPath.BlockUntilCalculated(this);
	}

	internal uint CalculateHScore(GraphNode node)
	{
		switch (heuristic)
		{
		case Heuristic.Euclidean:
		{
			uint num3 = (uint)((float)(GetHTarget() - node.position).costMagnitude * heuristicScale);
			if (hTargetNode != null)
			{
				num3 = Math.Max(num3, AstarPath.active.euclideanEmbedding.GetHeuristic(node.NodeIndex, hTargetNode.NodeIndex));
			}
			return num3;
		}
		case Heuristic.Manhattan:
		{
			Int3 position = node.position;
			uint num3 = (uint)((float)(Math.Abs(hTarget.x - position.x) + Math.Abs(hTarget.y - position.y) + Math.Abs(hTarget.z - position.z)) * heuristicScale);
			if (hTargetNode != null)
			{
				num3 = Math.Max(num3, AstarPath.active.euclideanEmbedding.GetHeuristic(node.NodeIndex, hTargetNode.NodeIndex));
			}
			return num3;
		}
		case Heuristic.DiagonalManhattan:
		{
			Int3 @int = GetHTarget() - node.position;
			@int.x = Math.Abs(@int.x);
			@int.y = Math.Abs(@int.y);
			@int.z = Math.Abs(@int.z);
			int num = Math.Min(@int.x, @int.z);
			int num2 = Math.Max(@int.x, @int.z);
			uint num3 = (uint)((float)(14 * num / 10 + (num2 - num) + @int.y) * heuristicScale);
			if (hTargetNode != null)
			{
				num3 = Math.Max(num3, AstarPath.active.euclideanEmbedding.GetHeuristic(node.NodeIndex, hTargetNode.NodeIndex));
			}
			return num3;
		}
		default:
			return 0u;
		}
	}

	internal uint GetTagPenalty(int tag)
	{
		return (uint)internalTagPenalties[tag];
	}

	internal Int3 GetHTarget()
	{
		return hTarget;
	}

	internal bool CanTraverse(GraphNode node)
	{
		if (traversalProvider != null)
		{
			return traversalProvider.CanTraverse(this, node);
		}
		if (node.Walkable)
		{
			return ((enabledTags >> (int)node.Tag) & 1) != 0;
		}
		return false;
	}

	internal uint GetTraversalCost(GraphNode node)
	{
		if (traversalProvider != null)
		{
			return traversalProvider.GetTraversalCost(this, node);
		}
		return GetTagPenalty((int)node.Tag) + node.Penalty;
	}

	internal virtual uint GetConnectionSpecialCost(GraphNode a, GraphNode b, uint currentCost)
	{
		return currentCost;
	}

	public bool IsDone()
	{
		return CompleteState != PathCompleteState.NotCalculated;
	}

	void IPathInternals.AdvanceState(PathState s)
	{
		lock (stateLock)
		{
			PipelineState = (PathState)Math.Max((int)PipelineState, (int)s);
		}
	}

	[Obsolete("Use the 'PipelineState' property instead")]
	public PathState GetState()
	{
		return PipelineState;
	}

	public void LogError(string msg)
	{
		if (AstarPath.active.logPathResults != PathLog.None)
		{
			_errorLog += msg;
		}
		if (AstarPath.active.logPathResults != PathLog.None && AstarPath.active.logPathResults != PathLog.InGame)
		{
			Debug.LogWarning((object)msg);
		}
	}

	internal void ForceLogError(string msg)
	{
		Error();
		_errorLog += msg;
		Debug.LogError((object)msg);
	}

	internal void Log(string msg)
	{
		if (AstarPath.active.logPathResults != PathLog.None)
		{
			_errorLog += msg;
		}
	}

	public void Error()
	{
		CompleteState = PathCompleteState.Error;
	}

	private void ErrorCheck()
	{
		if (!hasBeenReset)
		{
			throw new Exception("The path has never been reset. Use the static Construct call, do not use the normal constructors.");
		}
		if (((IPathInternals)this).Pooled)
		{
			throw new Exception("The path is currently in a path pool. Are you sending the path for calculation twice?");
		}
		if (pathHandler == null)
		{
			throw new Exception("Field pathHandler is not set. Please report this bug.");
		}
		if (PipelineState > PathState.Processing)
		{
			throw new Exception("This path has already been processed. Do not request a path with the same path object twice.");
		}
	}

	protected virtual void OnEnterPool()
	{
		if (vectorPath != null)
		{
			ListPool<Vector3>.Release(vectorPath);
		}
		if (int3Path != null)
		{
			ListPool<Int3>.Release(int3Path);
		}
		if (path != null)
		{
			ListPool<GraphNode>.Release(path);
		}
		vectorPath = null;
		int3Path = null;
		path = null;
		callback = null;
		immediateCallback = null;
		traversalProvider = null;
	}

	protected virtual void Reset()
	{
		if (AstarPath.active == null)
		{
			throw new NullReferenceException("No AstarPath object found in the scene. Make sure there is one or do not create paths in Awake");
		}
		hasBeenReset = true;
		PipelineState = PathState.Created;
		releasedNotSilent = false;
		pathHandler = null;
		callback = null;
		immediateCallback = null;
		_errorLog = "";
		CompleteState = PathCompleteState.NotCalculated;
		path = ListPool<GraphNode>.Claim();
		vectorPath = ListPool<Vector3>.Claim();
		int3Path = ListPool<Int3>.Claim();
		currentR = null;
		duration = 0f;
		searchedNodes = 0;
		nnConstraint = PathNNConstraint.Default;
		next = null;
		heuristic = AstarPath.active.heuristic;
		heuristicScale = AstarPath.active.heuristicScale;
		enabledTags = -1;
		tagPenalties = null;
		pathID = AstarPath.active.GetNextPathID();
		hTarget = Int3.zero;
		hTargetNode = null;
		traversalProvider = null;
	}

	public void Claim(object o)
	{
		if (o == null)
		{
			throw new ArgumentNullException("o");
		}
		for (int i = 0; i < claimed.Count; i++)
		{
			if (claimed[i] == o)
			{
				throw new ArgumentException("You have already claimed the path with that object (" + o?.ToString() + "). Are you claiming the path with the same object twice?");
			}
		}
		claimed.Add(o);
	}

	[Obsolete("Use Release(o, true) instead")]
	internal void ReleaseSilent(object o)
	{
		Release(o, silent: true);
	}

	public void Release(object o, bool silent = false)
	{
		if (o == null)
		{
			throw new ArgumentNullException("o");
		}
		for (int i = 0; i < claimed.Count; i++)
		{
			if (claimed[i] == o)
			{
				claimed.RemoveAt(i);
				if (!silent)
				{
					releasedNotSilent = true;
				}
				if (claimed.Count == 0 && releasedNotSilent)
				{
					PathPool.Pool(this);
				}
				return;
			}
		}
		if (claimed.Count == 0)
		{
			throw new ArgumentException("You are releasing a path which is not claimed at all (most likely it has been pooled already). Are you releasing the path with the same object (" + o?.ToString() + ") twice?\nCheck out the documentation on path pooling for help.");
		}
		throw new ArgumentException("You are releasing a path which has not been claimed with this object (" + o?.ToString() + "). Are you releasing the path with the same object twice?\nCheck out the documentation on path pooling for help.");
	}

	protected virtual void Trace(PathNode from)
	{
		//IL_010d: Unknown result type (might be due to invalid IL or missing references)
		PathNode pathNode = from;
		int num = 0;
		while (pathNode != null)
		{
			pathNode = pathNode.parent;
			num++;
			if (num > 2048)
			{
				Debug.LogWarning((object)"Infinite loop? >2048 node path. Remove this message if you really have that long paths (Path.cs, Trace method)");
				break;
			}
		}
		if (path.Capacity < num)
		{
			path.Capacity = num;
		}
		if (vectorPath.Capacity < num)
		{
			vectorPath.Capacity = num;
		}
		if (int3Path.Capacity < num)
		{
			int3Path.Capacity = num;
		}
		pathNode = from;
		for (int i = 0; i < num; i++)
		{
			path.Add(pathNode.node);
			pathNode = pathNode.parent;
		}
		int num2 = num / 2;
		for (int j = 0; j < num2; j++)
		{
			GraphNode value = path[j];
			path[j] = path[num - j - 1];
			path[num - j - 1] = value;
		}
		for (int k = 0; k < num; k++)
		{
			vectorPath.Add((Vector3)path[k].position);
			int3Path.Add(path[k].position);
		}
	}

	protected void DebugStringPrefix(PathLog logMode, StringBuilder text)
	{
		text.Append(error ? "Path Failed : " : "Path Completed : ");
		text.Append("Computation Time ");
		text.Append(duration.ToString((logMode == PathLog.Heavy) ? "0.000 ms " : "0.00 ms "));
		text.Append("Searched Nodes ").Append(searchedNodes);
		if (!error)
		{
			text.Append(" Path Length ");
			text.Append((path == null) ? "Null" : path.Count.ToString());
		}
	}

	protected void DebugStringSuffix(PathLog logMode, StringBuilder text)
	{
		if (error)
		{
			text.Append("\nError: ").Append(errorLog);
		}
		if (logMode == PathLog.Heavy && !AstarPath.active.IsUsingMultithreading)
		{
			text.Append("\nCallback references ");
			if (callback != null)
			{
				text.Append(callback.Target.GetType().FullName).AppendLine();
			}
			else
			{
				text.AppendLine("NULL");
			}
		}
		text.Append("\nPath Number ").Append(pathID).Append(" (unique id)");
	}

	internal virtual string DebugString(PathLog logMode)
	{
		if (logMode == PathLog.None || (!error && logMode == PathLog.OnlyErrors))
		{
			return "";
		}
		StringBuilder debugStringBuilder = pathHandler.DebugStringBuilder;
		debugStringBuilder.Length = 0;
		DebugStringPrefix(logMode, debugStringBuilder);
		DebugStringSuffix(logMode, debugStringBuilder);
		return debugStringBuilder.ToString();
	}

	protected virtual void ReturnPath()
	{
		if (callback != null)
		{
			callback(this);
		}
	}

	protected void PrepareBase(PathHandler pathHandler)
	{
		if (pathHandler.PathID > pathID)
		{
			pathHandler.ClearPathIDs();
		}
		this.pathHandler = pathHandler;
		pathHandler.InitializeForPath(this);
		if (internalTagPenalties == null || internalTagPenalties.Length != 32)
		{
			internalTagPenalties = ZeroTagPenalties;
		}
		try
		{
			ErrorCheck();
		}
		catch (Exception ex)
		{
			ForceLogError("Exception in path " + pathID + "\n" + ex);
		}
	}

	protected abstract void Prepare();

	protected virtual void Cleanup()
	{
	}

	protected abstract void Initialize();

	protected abstract void CalculateStep(long targetTick);

	void IPathInternals.OnEnterPool()
	{
		OnEnterPool();
	}

	void IPathInternals.Reset()
	{
		Reset();
	}

	void IPathInternals.ReturnPath()
	{
		ReturnPath();
	}

	void IPathInternals.PrepareBase(PathHandler handler)
	{
		PrepareBase(handler);
	}

	void IPathInternals.Prepare()
	{
		Prepare();
	}

	void IPathInternals.Cleanup()
	{
		Cleanup();
	}

	void IPathInternals.Initialize()
	{
		Initialize();
	}

	void IPathInternals.CalculateStep(long targetTick)
	{
		CalculateStep(targetTick);
	}
}
