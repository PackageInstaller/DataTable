using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public class ConstantPath : Path
{
	public GraphNode startNode;

	public Vector3 startPoint;

	public Vector3 originalStartPoint;

	public List<GraphNode> allNodes;

	public PathEndingCondition endingCondition;

	internal override bool FloodingPath => true;

	public static ConstantPath Construct(Vector3 start, int maxGScore, OnPathDelegate callback = null)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		ConstantPath constantPath = PathPool.GetPath<ConstantPath>();
		constantPath.Setup(start, maxGScore, callback);
		return constantPath;
	}

	protected void Setup(Vector3 start, int maxGScore, OnPathDelegate callback)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		base.callback = callback;
		startPoint = start;
		originalStartPoint = startPoint;
		endingCondition = new EndingConditionDistance(this, maxGScore);
	}

	protected override void OnEnterPool()
	{
		base.OnEnterPool();
		if (allNodes != null)
		{
			ListPool<GraphNode>.Release(allNodes);
		}
	}

	protected override void Reset()
	{
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		base.Reset();
		allNodes = ListPool<GraphNode>.Claim();
		endingCondition = null;
		originalStartPoint = Vector3.zero;
		startPoint = Vector3.zero;
		startNode = null;
		heuristic = Heuristic.None;
	}

	protected override void Prepare()
	{
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		nnConstraint.tags = enabledTags;
		startNode = AstarPath.active.GetNearest((Int3)startPoint, nnConstraint).node;
		if (startNode == null)
		{
			Error();
			LogError("Could not find close node to the start point");
		}
	}

	protected override void Initialize()
	{
		PathNode pathNode = pathHandler.GetPathNode(startNode);
		pathNode.node = startNode;
		pathNode.pathID = pathHandler.PathID;
		pathNode.parent = null;
		pathNode.cost = 0u;
		pathNode.G = GetTraversalCost(startNode);
		pathNode.H = CalculateHScore(startNode);
		startNode.Open(this, pathNode, pathHandler);
		searchedNodes++;
		pathNode.flag1 = true;
		allNodes.Add(startNode);
		if (pathHandler.heap.isEmpty)
		{
			base.CompleteState = PathCompleteState.Complete;
		}
		else
		{
			currentR = pathHandler.heap.Remove();
		}
	}

	protected override void Cleanup()
	{
		int count = allNodes.Count;
		for (int i = 0; i < count; i++)
		{
			pathHandler.GetPathNode(allNodes[i]).flag1 = false;
		}
	}

	protected override void CalculateStep(long targetTick)
	{
		int num = 0;
		while (base.CompleteState == PathCompleteState.NotCalculated)
		{
			searchedNodes++;
			if (endingCondition.TargetFound(currentR))
			{
				base.CompleteState = PathCompleteState.Complete;
				break;
			}
			if (!currentR.flag1)
			{
				allNodes.Add(currentR.node);
				currentR.flag1 = true;
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
				if (searchedNodes > 1000000)
				{
					throw new Exception("Probable infinite loop. Over 1,000,000 nodes searched");
				}
			}
			num++;
		}
	}
}
