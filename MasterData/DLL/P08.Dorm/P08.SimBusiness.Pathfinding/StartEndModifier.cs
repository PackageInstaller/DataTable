using System;
using System.Collections.Generic;
using Pathfinding;
using UnityEngine;

namespace P08.SimBusiness.Pathfinding;

[Serializable]
public class StartEndModifier : PathModifier
{
	public enum Exactness
	{
		SnapToNode,
		Original,
		Interpolate,
		ClosestOnNode,
		NodeConnection
	}

	public bool addPoints;

	public Exactness exactStartPoint = Exactness.ClosestOnNode;

	public Exactness exactEndPoint = Exactness.ClosestOnNode;

	public Func<Vector3> adjustStartPoint;

	public bool useRaycasting;

	public LayerMask mask = -1;

	public bool useGraphRaycasting;

	private List<GraphNode> connectionBuffer;

	private Action<GraphNode> connectionBufferAddDelegate;

	public override int Order => 0;

	private static void AddPoint(Path p, Vector3 v3pos)
	{
		p.vectorPath.Add(v3pos);
		p.int3Path.Add((Int3)v3pos);
	}

	private static void InsertPoint(Path p, int index, Vector3 v3pos)
	{
		p.vectorPath.Insert(index, v3pos);
		p.int3Path.Insert(index, (Int3)v3pos);
	}

	private static void SetPoint(Path p, int index, Vector3 v3pos)
	{
		p.vectorPath[index] = v3pos;
		p.int3Path[index] = (Int3)v3pos;
	}

	public override void Apply(Path _p)
	{
		if (_p is ABPath aBPath && aBPath.vectorPath.Count != 0)
		{
			if (aBPath.vectorPath.Count == 1 && !addPoints)
			{
				AddPoint(aBPath, aBPath.vectorPath[0]);
			}
			Vector3 v3pos = Snap(aBPath, exactStartPoint, start: true, out var forceAddPoint);
			Vector3 v3pos2 = Snap(aBPath, exactEndPoint, start: false, out var forceAddPoint2);
			if ((forceAddPoint || addPoints) && exactStartPoint != Exactness.SnapToNode)
			{
				InsertPoint(aBPath, 0, v3pos);
			}
			else
			{
				SetPoint(aBPath, 0, v3pos);
			}
			if ((forceAddPoint2 || addPoints) && exactEndPoint != Exactness.SnapToNode)
			{
				AddPoint(aBPath, v3pos2);
			}
			else
			{
				SetPoint(aBPath, aBPath.vectorPath.Count - 1, v3pos2);
			}
		}
	}

	private Vector3 Snap(ABPath path, Exactness mode, bool start, out bool forceAddPoint)
	{
		int num = ((!start) ? (path.path.Count - 1) : 0);
		GraphNode graphNode = path.path[num];
		Vector3 vector = (Vector3)graphNode.position;
		forceAddPoint = false;
		switch (mode)
		{
		case Exactness.ClosestOnNode:
			return (Vector3)(start ? path.startPoint : path.endPoint);
		case Exactness.SnapToNode:
			return vector;
		case Exactness.Original:
		case Exactness.Interpolate:
		case Exactness.NodeConnection:
		{
			Vector3 vector2 = ((!start) ? ((Vector3)path.originalEndPoint) : ((adjustStartPoint != null) ? adjustStartPoint() : ((Vector3)path.originalStartPoint)));
			switch (mode)
			{
			case Exactness.Original:
				return GetClampedPoint(vector, vector2, graphNode);
			case Exactness.Interpolate:
			{
				GraphNode graphNode2 = path.path[Mathf.Clamp(num + (start ? 1 : (-1)), 0, path.path.Count - 1)];
				return VectorMath.ClosestPointOnSegment(vector, (Vector3)graphNode2.position, vector2);
			}
			case Exactness.NodeConnection:
			{
				connectionBuffer = connectionBuffer ?? new List<GraphNode>();
				connectionBufferAddDelegate = connectionBufferAddDelegate ?? new Action<GraphNode>(connectionBuffer.Add);
				GraphNode graphNode2 = path.path[Mathf.Clamp(num + (start ? 1 : (-1)), 0, path.path.Count - 1)];
				graphNode.GetConnections(connectionBufferAddDelegate);
				Vector3 result = vector;
				float num2 = float.PositiveInfinity;
				for (int num3 = connectionBuffer.Count - 1; num3 >= 0; num3--)
				{
					GraphNode graphNode3 = connectionBuffer[num3];
					Vector3 vector3 = VectorMath.ClosestPointOnSegment(vector, (Vector3)graphNode3.position, vector2);
					float sqrMagnitude = (vector3 - vector2).sqrMagnitude;
					if (sqrMagnitude < num2)
					{
						result = vector3;
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

	protected Vector3 GetClampedPoint(Vector3 from, Vector3 to, GraphNode hint)
	{
		Vector3 vector = to;
		if (useRaycasting && Physics.Linecast(from, to, out var hitInfo, mask))
		{
			vector = hitInfo.point;
		}
		if (useGraphRaycasting && hint != null && AstarData.GetGraph(hint) is IRaycastableGraph raycastableGraph && raycastableGraph.Linecast((Int3)from, (Int3)vector, hint, out var hit))
		{
			vector = (Vector3)hit.point;
		}
		return vector;
	}
}
