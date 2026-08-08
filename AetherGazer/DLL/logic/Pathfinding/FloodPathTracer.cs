using System;
using UnityEngine;

namespace Pathfinding;

public class FloodPathTracer : ABPath
{
	protected FloodPath flood;

	protected override bool hasEndPoint => false;

	public static FloodPathTracer Construct(Vector3 start, FloodPath flood, OnPathDelegate callback = null)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		FloodPathTracer floodPathTracer = PathPool.GetPath<FloodPathTracer>();
		floodPathTracer.Setup(start, flood, callback);
		return floodPathTracer;
	}

	protected void Setup(Vector3 start, FloodPath flood, OnPathDelegate callback)
	{
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		this.flood = flood;
		if (flood == null || flood.PipelineState < PathState.Returned)
		{
			throw new ArgumentException("You must supply a calculated FloodPath to the 'flood' argument");
		}
		Setup((Int3)start, flood.originalStartPoint, callback);
		nnConstraint = new FloodPathConstraint(flood);
	}

	protected override void Reset()
	{
		base.Reset();
		flood = null;
	}

	protected override void Initialize()
	{
		if (startNode != null && flood.HasPathTo(startNode))
		{
			Trace(startNode);
			base.CompleteState = PathCompleteState.Complete;
		}
		else
		{
			Error();
			LogError("Could not find valid start node");
		}
	}

	protected override void CalculateStep(long targetTick)
	{
		if (!IsDone())
		{
			Error();
			LogError("Something went wrong. At this point the path should be completed");
		}
	}

	public void Trace(GraphNode from)
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		GraphNode graphNode = from;
		int num = 0;
		while (graphNode != null)
		{
			path.Add(graphNode);
			vectorPath.Add((Vector3)graphNode.position);
			graphNode = flood.GetParent(graphNode);
			num++;
			if (num > 1024)
			{
				Debug.LogWarning((object)"Inifinity loop? >1024 node path. Remove this message if you really have that long paths (FloodPathTracer.cs, Trace function)");
				break;
			}
		}
	}
}
