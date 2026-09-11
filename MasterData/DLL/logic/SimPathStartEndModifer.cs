using System;
using System.Collections.Generic;
using Pathfinding;

public static class SimPathStartEndModifer
{
	public enum Exactness
	{
		SnapToNode,
		Original,
		Interpolate,
		ClosestOnNode,
		NodeConnection
	}

	public static bool addPoints = true;

	public static Exactness exactStartPoint = Exactness.ClosestOnNode;

	public static Exactness exactEndPoint = Exactness.ClosestOnNode;

	public static Func<Int3> adjustStartPoint;

	public static bool useRaycasting;

	public static bool useGraphRaycasting = true;

	private static List<GraphNode> connectionBuffer;

	private static Action<GraphNode> connectionBufferAddDelegate;

	public static int Order => 0;

	public static void Apply(Path _p)
	{
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		if (_p is ABPath aBPath && aBPath.vectorPath.Count != 0)
		{
			if (aBPath.vectorPath.Count == 1 && !addPoints)
			{
				aBPath.vectorPath.Add(aBPath.vectorPath[0]);
			}
			Int3 @int = Snap(aBPath, exactStartPoint, start: true, out var forceAddPoint);
			Int3 int2 = Snap(aBPath, exactEndPoint, start: false, out var forceAddPoint2);
			if ((forceAddPoint || addPoints) && exactStartPoint != Exactness.SnapToNode)
			{
				aBPath.int3Path.Insert(0, @int);
			}
			else
			{
				aBPath.int3Path[0] = @int;
			}
			if ((forceAddPoint2 || addPoints) && exactEndPoint != Exactness.SnapToNode)
			{
				aBPath.int3Path.Add(int2);
			}
			else
			{
				aBPath.int3Path[aBPath.vectorPath.Count - 1] = int2;
			}
		}
	}

	private static Int3 Snap(ABPath path, Exactness mode, bool start, out bool forceAddPoint)
	{
		int num = ((!start) ? (path.path.Count - 1) : 0);
		GraphNode graphNode = path.path[num];
		Int3 position = graphNode.position;
		forceAddPoint = false;
		switch (mode)
		{
		case Exactness.ClosestOnNode:
			return GetClampedPoint(position, start ? path.startPoint : path.endPoint, graphNode);
		case Exactness.SnapToNode:
			return position;
		case Exactness.Original:
		case Exactness.Interpolate:
		case Exactness.NodeConnection:
		{
			Int3 @int = ((!start) ? path.originalEndPoint : ((adjustStartPoint != null) ? adjustStartPoint() : path.originalStartPoint));
			switch (mode)
			{
			case Exactness.Original:
				return GetClampedPoint(position, @int, graphNode);
			case Exactness.Interpolate:
			{
				Int3 clampedPoint = GetClampedPoint(position, @int, graphNode);
				GraphNode graphNode2 = path.path[IntMath.Clamp(num + (start ? 1 : (-1)), 0, path.path.Count - 1)];
				return VectorMath.ClosestPointOnSegment(position, graphNode2.position, clampedPoint);
			}
			case Exactness.NodeConnection:
			{
				connectionBuffer = connectionBuffer ?? new List<GraphNode>();
				connectionBufferAddDelegate = connectionBufferAddDelegate ?? new Action<GraphNode>(connectionBuffer.Add);
				GraphNode graphNode2 = path.path[IntMath.Clamp(num + (start ? 1 : (-1)), 0, path.path.Count - 1)];
				graphNode.GetConnections(connectionBufferAddDelegate);
				Int3 result = position;
				float num2 = float.PositiveInfinity;
				for (int num3 = connectionBuffer.Count - 1; num3 >= 0; num3--)
				{
					GraphNode graphNode3 = connectionBuffer[num3];
					Int3 int2 = VectorMath.ClosestPointOnSegment(position, graphNode3.position, @int);
					float sqrMagnitude = (int2 - @int).sqrMagnitude;
					if (sqrMagnitude < num2)
					{
						result = int2;
						num2 = sqrMagnitude;
						forceAddPoint = graphNode3 != graphNode2;
					}
				}
				connectionBuffer.Clear();
				return result;
			}
			default:
				throw new ArgumentException("Cannot reach this point, but the compiler is not smart enough to realize that.");
			}
		}
		default:
			throw new ArgumentException("Invalid mode");
		}
	}

	public static Int3 GetClampedPoint(Int3 from, Int3 to, GraphNode hint)
	{
		Int3 @int = to;
		if (useGraphRaycasting && hint != null && AstarData.GetGraph(hint) is IRaycastableGraph raycastableGraph && raycastableGraph.Linecast(from, @int, hint, out var hit))
		{
			@int = hit.point;
		}
		return @int;
	}
}
