using System;

namespace Pathfinding;

public class XPath : ABPath
{
	public PathEndingCondition endingCondition;

	public new static XPath Construct(Int3 start, Int3 end, OnPathDelegate callback = null)
	{
		XPath xPath = PathPool.GetPath<XPath>();
		xPath.Setup(start, end, callback);
		xPath.endingCondition = new ABPathEndingCondition(xPath);
		return xPath;
	}

	protected override void Reset()
	{
		base.Reset();
		endingCondition = null;
	}

	protected override bool EndPointGridGraphSpecialCase(GraphNode endNode)
	{
		return false;
	}

	protected override void CompletePathIfStartIsValidTarget()
	{
		PathNode pathNode = pathHandler.GetPathNode(startNode);
		if (endingCondition.TargetFound(pathNode))
		{
			ChangeEndNode(startNode);
			Trace(pathNode);
			base.CompleteState = PathCompleteState.Complete;
		}
	}

	private void ChangeEndNode(GraphNode target)
	{
		if (endNode != null && endNode != startNode)
		{
			PathNode pathNode = pathHandler.GetPathNode(endNode);
			bool flag = (pathNode.flag2 = false);
			pathNode.flag1 = flag;
		}
		endNode = target;
		endPoint = target.position;
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
			currentR.node.Open(this, currentR, pathHandler);
			if (pathHandler.heap.isEmpty)
			{
				Error();
				LogError("Searched whole area but could not find target");
				return;
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
			ChangeEndNode(currentR.node);
			Trace(currentR);
		}
	}
}
