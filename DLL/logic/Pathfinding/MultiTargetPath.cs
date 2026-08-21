using System;
using System.Collections.Generic;
using System.Text;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public class MultiTargetPath : ABPath
{
	public enum HeuristicMode
	{
		None,
		Average,
		MovingAverage,
		Midpoint,
		MovingMidpoint,
		Sequential
	}

	public OnPathDelegate[] callbacks;

	public GraphNode[] targetNodes;

	protected int targetNodeCount;

	public bool[] targetsFound;

	public Int3[] targetPoints;

	public Int3[] originalTargetPoints;

	public List<Vector3>[] vectorPaths;

	public List<GraphNode>[] nodePaths;

	public bool pathsForAll = true;

	public int chosenTarget = -1;

	private int sequentialTarget;

	public HeuristicMode heuristicMode = HeuristicMode.Sequential;

	public bool inverted { get; protected set; }

	public static MultiTargetPath Construct(Int3[] startPoints, Int3 target, OnPathDelegate[] callbackDelegates, OnPathDelegate callback = null)
	{
		MultiTargetPath multiTargetPath = Construct(target, startPoints, callbackDelegates, callback);
		multiTargetPath.inverted = true;
		return multiTargetPath;
	}

	public static MultiTargetPath Construct(Int3 start, Int3[] targets, OnPathDelegate[] callbackDelegates, OnPathDelegate callback = null)
	{
		MultiTargetPath multiTargetPath = PathPool.GetPath<MultiTargetPath>();
		multiTargetPath.Setup(start, targets, callbackDelegates, callback);
		return multiTargetPath;
	}

	protected void Setup(Int3 start, Int3[] targets, OnPathDelegate[] callbackDelegates, OnPathDelegate callback)
	{
		inverted = false;
		base.callback = callback;
		callbacks = callbackDelegates;
		if (callbacks != null && callbacks.Length != targets.Length)
		{
			throw new ArgumentException("The targets array must have the same length as the callbackDelegates array");
		}
		targetPoints = targets;
		originalStartPoint = start;
		startPoint = start;
		startIntPoint = start;
		if (targets.Length == 0)
		{
			Error();
			LogError("No targets were assigned to the MultiTargetPath");
			return;
		}
		endPoint = targets[0];
		originalTargetPoints = new Int3[targetPoints.Length];
		for (int i = 0; i < targetPoints.Length; i++)
		{
			originalTargetPoints[i] = targetPoints[i];
		}
	}

	protected override void Reset()
	{
		base.Reset();
		pathsForAll = true;
		chosenTarget = -1;
		sequentialTarget = 0;
		inverted = true;
		heuristicMode = HeuristicMode.Sequential;
	}

	protected override void OnEnterPool()
	{
		if (vectorPaths != null)
		{
			for (int i = 0; i < vectorPaths.Length; i++)
			{
				if (vectorPaths[i] != null)
				{
					ListPool<Vector3>.Release(vectorPaths[i]);
				}
			}
		}
		vectorPaths = null;
		vectorPath = null;
		if (nodePaths != null)
		{
			for (int j = 0; j < nodePaths.Length; j++)
			{
				if (nodePaths[j] != null)
				{
					ListPool<GraphNode>.Release(nodePaths[j]);
				}
			}
		}
		nodePaths = null;
		path = null;
		callbacks = null;
		targetNodes = null;
		targetsFound = null;
		targetPoints = null;
		originalTargetPoints = null;
		base.OnEnterPool();
	}

	private void ChooseShortestPath()
	{
		chosenTarget = -1;
		if (nodePaths == null)
		{
			return;
		}
		uint num = 2147483647u;
		for (int i = 0; i < nodePaths.Length; i++)
		{
			List<GraphNode> list = nodePaths[i];
			if (list != null)
			{
				uint g = pathHandler.GetPathNode(list[(!inverted) ? (list.Count - 1) : 0]).G;
				if (chosenTarget == -1 || g < num)
				{
					chosenTarget = i;
					num = g;
				}
			}
		}
	}

	private void SetPathParametersForReturn(int target)
	{
		path = nodePaths[target];
		vectorPath = vectorPaths[target];
		if (inverted)
		{
			startNode = targetNodes[target];
			startPoint = targetPoints[target];
			originalStartPoint = originalTargetPoints[target];
		}
		else
		{
			endNode = targetNodes[target];
			endPoint = targetPoints[target];
			originalEndPoint = originalTargetPoints[target];
		}
	}

	protected override void ReturnPath()
	{
		if (base.error)
		{
			if (callbacks != null)
			{
				for (int i = 0; i < callbacks.Length; i++)
				{
					if (callbacks[i] != null)
					{
						callbacks[i](this);
					}
				}
			}
			if (callback != null)
			{
				callback(this);
			}
			return;
		}
		bool flag = false;
		if (inverted)
		{
			endPoint = startPoint;
			endNode = startNode;
			originalEndPoint = originalStartPoint;
		}
		for (int j = 0; j < nodePaths.Length; j++)
		{
			if (nodePaths[j] != null)
			{
				base.CompleteState = PathCompleteState.Complete;
				flag = true;
			}
			else
			{
				base.CompleteState = PathCompleteState.Error;
			}
			if (callbacks != null && callbacks[j] != null)
			{
				SetPathParametersForReturn(j);
				callbacks[j](this);
				vectorPaths[j] = vectorPath;
			}
		}
		if (flag)
		{
			base.CompleteState = PathCompleteState.Complete;
			SetPathParametersForReturn(chosenTarget);
		}
		else
		{
			base.CompleteState = PathCompleteState.Error;
		}
		if (callback != null)
		{
			callback(this);
		}
	}

	protected void FoundTarget(PathNode nodeR, int i)
	{
		nodeR.flag1 = false;
		Trace(nodeR);
		vectorPaths[i] = vectorPath;
		nodePaths[i] = path;
		vectorPath = ListPool<Vector3>.Claim();
		path = ListPool<GraphNode>.Claim();
		targetsFound[i] = true;
		targetNodeCount--;
		if (!pathsForAll)
		{
			base.CompleteState = PathCompleteState.Complete;
			targetNodeCount = 0;
		}
		else if (targetNodeCount <= 0)
		{
			base.CompleteState = PathCompleteState.Complete;
		}
		else
		{
			RecalculateHTarget(firstTime: false);
		}
	}

	protected void RebuildOpenList()
	{
		BinaryHeap heap = pathHandler.heap;
		for (int i = 0; i < heap.numberOfItems; i++)
		{
			PathNode node = heap.GetNode(i);
			node.H = CalculateHScore(node.node);
			heap.SetF(i, node.F);
		}
		pathHandler.heap.Rebuild();
	}

	protected override void Prepare()
	{
		nnConstraint.tags = enabledTags;
		NNInfo nearest = AstarPath.active.GetNearest(startPoint, nnConstraint);
		startNode = nearest.node;
		if (startNode == null)
		{
			LogError("Could not find start node for multi target path");
			Error();
			return;
		}
		if (!CanTraverse(startNode))
		{
			Error();
			LogError("The node closest to the start point could not be traversed");
			return;
		}
		if (nnConstraint is PathNNConstraint pathNNConstraint)
		{
			pathNNConstraint.SetStart(nearest.node);
		}
		vectorPaths = new List<Vector3>[targetPoints.Length];
		nodePaths = new List<GraphNode>[targetPoints.Length];
		targetNodes = new GraphNode[targetPoints.Length];
		targetsFound = new bool[targetPoints.Length];
		targetNodeCount = targetPoints.Length;
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		for (int i = 0; i < targetPoints.Length; i++)
		{
			NNInfo nearest2 = AstarPath.active.GetNearest(targetPoints[i], nnConstraint);
			targetNodes[i] = nearest2.node;
			targetPoints[i] = nearest2.position;
			if (targetNodes[i] != null)
			{
				flag3 = true;
				endNode = targetNodes[i];
			}
			bool flag4 = false;
			if (nearest2.node != null && CanTraverse(nearest2.node))
			{
				flag = true;
			}
			else
			{
				flag4 = true;
			}
			if (nearest2.node != null && nearest2.node.Area == startNode.Area)
			{
				flag2 = true;
			}
			else
			{
				flag4 = true;
			}
			if (flag4)
			{
				targetsFound[i] = true;
				targetNodeCount--;
			}
		}
		startPoint = nearest.node.position;
		startIntPoint = startPoint;
		if (startNode == null || !flag3)
		{
			LogError("Couldn't find close nodes to either the start or the end (start = " + ((startNode != null) ? "found" : "not found") + " end = " + (flag3 ? "at least one found" : "none found") + ")");
			Error();
		}
		else if (!startNode.Walkable)
		{
			LogError("The node closest to the start point is not walkable");
			Error();
		}
		else if (!flag)
		{
			Error();
			LogError("No target nodes could be traversed");
		}
		else if (!flag2)
		{
			LogError("There are no valid paths to the targets");
			Error();
		}
		else
		{
			RecalculateHTarget(firstTime: true);
		}
	}

	private void RecalculateHTarget(bool firstTime)
	{
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00db: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0170: Unknown result type (might be due to invalid IL or missing references)
		//IL_0171: Unknown result type (might be due to invalid IL or missing references)
		//IL_017b: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0134: Unknown result type (might be due to invalid IL or missing references)
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		//IL_013a: Unknown result type (might be due to invalid IL or missing references)
		//IL_013f: Unknown result type (might be due to invalid IL or missing references)
		//IL_014e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0154: Unknown result type (might be due to invalid IL or missing references)
		//IL_0159: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_011b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0120: Unknown result type (might be due to invalid IL or missing references)
		if (!pathsForAll)
		{
			heuristic = Heuristic.None;
			heuristicScale = 0f;
			return;
		}
		switch (heuristicMode)
		{
		case HeuristicMode.None:
			heuristic = Heuristic.None;
			heuristicScale = 0f;
			break;
		case HeuristicMode.Average:
			if (!firstTime)
			{
				return;
			}
			goto case HeuristicMode.MovingAverage;
		case HeuristicMode.MovingAverage:
		{
			Vector3 val = Vector3.zero;
			int num2 = 0;
			for (int j = 0; j < targetPoints.Length; j++)
			{
				if (!targetsFound[j])
				{
					val += (Vector3)targetNodes[j].position;
					num2++;
				}
			}
			if (num2 == 0)
			{
				throw new Exception("Should not happen");
			}
			val /= (float)num2;
			hTarget = (Int3)val;
			break;
		}
		case HeuristicMode.Midpoint:
			if (!firstTime)
			{
				return;
			}
			goto case HeuristicMode.MovingMidpoint;
		case HeuristicMode.MovingMidpoint:
		{
			Vector3 val2 = Vector3.zero;
			Vector3 val3 = Vector3.zero;
			bool flag = false;
			for (int k = 0; k < targetPoints.Length; k++)
			{
				if (!targetsFound[k])
				{
					if (!flag)
					{
						val2 = (Vector3)targetNodes[k].position;
						val3 = (Vector3)targetNodes[k].position;
						flag = true;
					}
					else
					{
						val2 = Vector3.Min((Vector3)targetNodes[k].position, val2);
						val3 = Vector3.Max((Vector3)targetNodes[k].position, val3);
					}
				}
			}
			Int3 @int = (Int3)((val2 + val3) * 0.5f);
			hTarget = @int;
			break;
		}
		case HeuristicMode.Sequential:
		{
			if (!firstTime && !targetsFound[sequentialTarget])
			{
				return;
			}
			float num = 0f;
			for (int i = 0; i < targetPoints.Length; i++)
			{
				if (!targetsFound[i])
				{
					float sqrMagnitude = (targetNodes[i].position - startNode.position).sqrMagnitude;
					if (sqrMagnitude > num)
					{
						num = sqrMagnitude;
						hTarget = targetPoints[i];
						sequentialTarget = i;
					}
				}
			}
			break;
		}
		}
		if (!firstTime)
		{
			RebuildOpenList();
		}
	}

	protected override void Initialize()
	{
		PathNode pathNode = pathHandler.GetPathNode(startNode);
		pathNode.node = startNode;
		pathNode.pathID = base.pathID;
		pathNode.parent = null;
		pathNode.cost = 0u;
		pathNode.G = GetTraversalCost(startNode);
		pathNode.H = CalculateHScore(startNode);
		for (int i = 0; i < targetNodes.Length; i++)
		{
			if (startNode == targetNodes[i])
			{
				FoundTarget(pathNode, i);
			}
			else if (targetNodes[i] != null)
			{
				pathHandler.GetPathNode(targetNodes[i]).flag1 = true;
			}
		}
		if (targetNodeCount <= 0)
		{
			base.CompleteState = PathCompleteState.Complete;
			return;
		}
		startNode.Open(this, pathNode, pathHandler);
		searchedNodes++;
		if (pathHandler.heap.isEmpty)
		{
			LogError("No open points, the start node didn't open any nodes");
			Error();
		}
		else
		{
			currentR = pathHandler.heap.Remove();
		}
	}

	protected override void Cleanup()
	{
		ChooseShortestPath();
		ResetFlags();
	}

	private void ResetFlags()
	{
		if (targetNodes == null)
		{
			return;
		}
		for (int i = 0; i < targetNodes.Length; i++)
		{
			if (targetNodes[i] != null)
			{
				pathHandler.GetPathNode(targetNodes[i]).flag1 = false;
			}
		}
	}

	protected override void CalculateStep(long targetTick)
	{
		int num = 0;
		while (base.CompleteState == PathCompleteState.NotCalculated)
		{
			searchedNodes++;
			if (currentR.flag1)
			{
				for (int i = 0; i < targetNodes.Length; i++)
				{
					if (!targetsFound[i] && currentR.node == targetNodes[i])
					{
						FoundTarget(currentR, i);
						if (base.CompleteState != PathCompleteState.NotCalculated)
						{
							break;
						}
					}
				}
				if (targetNodeCount <= 0)
				{
					base.CompleteState = PathCompleteState.Complete;
					break;
				}
			}
			currentR.node.Open(this, currentR, pathHandler);
			if (pathHandler.heap.isEmpty)
			{
				base.CompleteState = PathCompleteState.Complete;
				break;
			}
			currentR = pathHandler.heap.Remove();
			if (num > 500)
			{
				if (DateTime.UtcNow.Ticks >= targetTick)
				{
					break;
				}
				num = 0;
			}
			num++;
		}
	}

	protected override void Trace(PathNode node)
	{
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		base.Trace(node);
		if (inverted)
		{
			int num = path.Count / 2;
			for (int i = 0; i < num; i++)
			{
				GraphNode value = path[i];
				path[i] = path[path.Count - i - 1];
				path[path.Count - i - 1] = value;
			}
			for (int j = 0; j < num; j++)
			{
				Vector3 value2 = vectorPath[j];
				vectorPath[j] = vectorPath[vectorPath.Count - j - 1];
				vectorPath[vectorPath.Count - j - 1] = value2;
			}
		}
	}

	internal override string DebugString(PathLog logMode)
	{
		//IL_022c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0231: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ba: Unknown result type (might be due to invalid IL or missing references)
		if (logMode == PathLog.None || (!base.error && logMode == PathLog.OnlyErrors))
		{
			return "";
		}
		StringBuilder debugStringBuilder = pathHandler.DebugStringBuilder;
		debugStringBuilder.Length = 0;
		DebugStringPrefix(logMode, debugStringBuilder);
		if (!base.error)
		{
			debugStringBuilder.Append("\nShortest path was ");
			debugStringBuilder.Append((chosenTarget == -1) ? "undefined" : nodePaths[chosenTarget].Count.ToString());
			debugStringBuilder.Append(" nodes long");
			if (logMode == PathLog.Heavy)
			{
				debugStringBuilder.Append("\nPaths (").Append(targetsFound.Length).Append("):");
				for (int i = 0; i < targetsFound.Length; i++)
				{
					debugStringBuilder.Append("\n\n\tPath ").Append(i).Append(" Found: ")
						.Append(targetsFound[i]);
					if (nodePaths[i] == null)
					{
						continue;
					}
					debugStringBuilder.Append("\n\t\tLength: ");
					debugStringBuilder.Append(nodePaths[i].Count);
					GraphNode graphNode = nodePaths[i][nodePaths[i].Count - 1];
					if (graphNode != null)
					{
						PathNode pathNode = pathHandler.GetPathNode(endNode);
						if (pathNode != null)
						{
							debugStringBuilder.Append("\n\t\tEnd Node");
							debugStringBuilder.Append("\n\t\t\tG: ");
							debugStringBuilder.Append(pathNode.G);
							debugStringBuilder.Append("\n\t\t\tH: ");
							debugStringBuilder.Append(pathNode.H);
							debugStringBuilder.Append("\n\t\t\tF: ");
							debugStringBuilder.Append(pathNode.F);
							debugStringBuilder.Append("\n\t\t\tPoint: ");
							debugStringBuilder.Append(((object)(Vector3)endPoint/*cast due to constrained. prefix*/).ToString());
							debugStringBuilder.Append("\n\t\t\tGraph: ");
							debugStringBuilder.Append(endNode.GraphIndex);
						}
						else
						{
							debugStringBuilder.Append("\n\t\tEnd Node: Null");
						}
					}
				}
				debugStringBuilder.Append("\nStart Node");
				debugStringBuilder.Append("\n\tPoint: ");
				debugStringBuilder.Append(((object)(Vector3)endPoint/*cast due to constrained. prefix*/).ToString());
				debugStringBuilder.Append("\n\tGraph: ");
				debugStringBuilder.Append(startNode.GraphIndex);
				debugStringBuilder.Append("\nBinary Heap size at completion: ");
				debugStringBuilder.AppendLine((pathHandler.heap == null) ? "Null" : (pathHandler.heap.numberOfItems - 2).ToString());
			}
		}
		DebugStringSuffix(logMode, debugStringBuilder);
		return debugStringBuilder.ToString();
	}
}
