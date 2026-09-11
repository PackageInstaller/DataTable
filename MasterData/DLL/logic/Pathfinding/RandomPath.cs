using System;
using UnityEngine;

namespace Pathfinding;

public class RandomPath : ABPath
{
	public int searchLength;

	public int spread = 5000;

	public float aimStrength;

	private PathNode chosenNodeR;

	private PathNode maxGScoreNodeR;

	private int maxGScore;

	public Vector3 aim;

	private int nodesEvaluatedRep;

	private readonly Random rnd = new Random();

	internal override bool FloodingPath => true;

	protected override bool hasEndPoint => false;

	protected override void Reset()
	{
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		base.Reset();
		searchLength = 5000;
		spread = 5000;
		aimStrength = 0f;
		chosenNodeR = null;
		maxGScoreNodeR = null;
		maxGScore = 0;
		aim = Vector3.zero;
		nodesEvaluatedRep = 0;
	}

	public RandomPath()
	{
	}

	[Obsolete("This constructor is obsolete. Please use the pooling API and the Construct methods")]
	public RandomPath(Vector3 start, int length, OnPathDelegate callback = null)
	{
		throw new Exception("This constructor is obsolete. Please use the pooling API and the Setup methods");
	}

	public static RandomPath Construct(Int3 start, int length, OnPathDelegate callback = null)
	{
		RandomPath randomPath = PathPool.GetPath<RandomPath>();
		randomPath.Setup(start, length, callback);
		return randomPath;
	}

	protected RandomPath Setup(Int3 start, int length, OnPathDelegate callback)
	{
		base.callback = callback;
		searchLength = length;
		originalStartPoint = start;
		originalEndPoint = Int3.zero;
		startPoint = start;
		endPoint = Int3.zero;
		startIntPoint = start;
		return this;
	}

	protected override void ReturnPath()
	{
		if (path != null && path.Count > 0)
		{
			endNode = path[path.Count - 1];
			endPoint = endNode.position;
			originalEndPoint = endPoint;
			hTarget = endNode.position;
		}
		if (callback != null)
		{
			callback(this);
		}
	}

	protected override void Prepare()
	{
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		nnConstraint.tags = enabledTags;
		NNInfo nearest = AstarPath.active.GetNearest(startPoint, nnConstraint);
		startPoint = nearest.node.position;
		endPoint = startPoint;
		startIntPoint = startPoint;
		hTarget = (Int3)aim;
		startNode = nearest.node;
		endNode = startNode;
		if (startNode == null || endNode == null)
		{
			LogError("Couldn't find close nodes to the start point");
			Error();
		}
		else if (!CanTraverse(startNode))
		{
			LogError("The node closest to the start point could not be traversed");
			Error();
		}
		else
		{
			heuristicScale = aimStrength;
		}
	}

	protected override void Initialize()
	{
		PathNode pathNode = pathHandler.GetPathNode(startNode);
		pathNode.node = startNode;
		if (searchLength + spread <= 0)
		{
			base.CompleteState = PathCompleteState.Complete;
			Trace(pathNode);
			return;
		}
		pathNode.pathID = base.pathID;
		pathNode.parent = null;
		pathNode.cost = 0u;
		pathNode.G = GetTraversalCost(startNode);
		pathNode.H = CalculateHScore(startNode);
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

	protected override void CalculateStep(long targetTick)
	{
		int num = 0;
		while (base.CompleteState == PathCompleteState.NotCalculated)
		{
			searchedNodes++;
			if (currentR.G >= searchLength)
			{
				if (currentR.G > searchLength + spread)
				{
					if (chosenNodeR == null)
					{
						chosenNodeR = currentR;
					}
					base.CompleteState = PathCompleteState.Complete;
					break;
				}
				nodesEvaluatedRep++;
				if (rnd.NextDouble() <= (double)(1f / (float)nodesEvaluatedRep))
				{
					chosenNodeR = currentR;
				}
			}
			else if (currentR.G > maxGScore)
			{
				maxGScore = (int)currentR.G;
				maxGScoreNodeR = currentR;
			}
			currentR.node.Open(this, currentR, pathHandler);
			if (pathHandler.heap.isEmpty)
			{
				if (chosenNodeR != null)
				{
					base.CompleteState = PathCompleteState.Complete;
				}
				else if (maxGScoreNodeR != null)
				{
					chosenNodeR = maxGScoreNodeR;
					base.CompleteState = PathCompleteState.Complete;
				}
				else
				{
					LogError("Not a single node found to search");
					Error();
				}
				break;
			}
			currentR = pathHandler.heap.Remove();
			if (num > 500)
			{
				if (DateTime.UtcNow.Ticks >= targetTick)
				{
					return;
				}
				num = 0;
				if (searchedNodes > 1000000)
				{
					throw new Exception("Probable infinite loop. Over 1,000,000 nodes searched");
				}
			}
			num++;
		}
		if (base.CompleteState == PathCompleteState.Complete)
		{
			Trace(chosenNodeR);
		}
	}
}
