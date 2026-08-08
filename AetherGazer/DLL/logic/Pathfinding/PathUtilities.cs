using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public static class PathUtilities
{
	private struct TMNodeInfo
	{
		public TriangleMeshNode node;

		public int vi;

		public Int3 v0;

		public Int3 v1;

		public Int3 v2;

		public VFactor GetCosineAngle(Int3 dest, out int edgeIndex)
		{
			Int3 rhs = v1 - v0;
			Int3 rhs2 = v2 - v0;
			Int3 lhs = dest - v0;
			lhs.NormalizeTo(1000);
			rhs.NormalizeTo(1000);
			rhs2.NormalizeTo(1000);
			long num = Int3.DotXZLong(ref lhs, ref rhs);
			long num2 = Int3.DotXZLong(ref lhs, ref rhs2);
			VFactor result = new VFactor
			{
				den = 1000000L
			};
			if (num > num2)
			{
				edgeIndex = vi;
				result.nom = num;
				return result;
			}
			edgeIndex = (vi + 2) % 3;
			result.nom = num2;
			return result;
		}
	}

	private static Queue<GraphNode> BFSQueue;

	private static Dictionary<GraphNode, int> BFSMap;

	private static readonly NNConstraint constraint = new NNConstraint();

	private static List<TriangleMeshNode> checkedNodes = new List<TriangleMeshNode>();

	public static TriangleMeshNode PointOnNavemesh;

	public static Int3 mIntersectionPoint;

	public static Int3 mVertex;

	public static Int3 mNextVertex;

	public static bool IsPathPossible(GraphNode n1, GraphNode n2)
	{
		if (n1.Walkable && n2.Walkable)
		{
			return n1.Area == n2.Area;
		}
		return false;
	}

	public static bool IsPathPossible(List<GraphNode> nodes)
	{
		if (nodes.Count == 0)
		{
			return true;
		}
		uint area = nodes[0].Area;
		for (int i = 0; i < nodes.Count; i++)
		{
			if (!nodes[i].Walkable || nodes[i].Area != area)
			{
				return false;
			}
		}
		return true;
	}

	public static bool IsPathPossible(List<GraphNode> nodes, int tagMask)
	{
		if (nodes.Count == 0)
		{
			return true;
		}
		if (((tagMask >> (int)nodes[0].Tag) & 1) == 0)
		{
			return false;
		}
		if (!IsPathPossible(nodes))
		{
			return false;
		}
		List<GraphNode> reachableNodes = GetReachableNodes(nodes[0], tagMask);
		bool result = true;
		for (int i = 1; i < nodes.Count; i++)
		{
			if (!reachableNodes.Contains(nodes[i]))
			{
				result = false;
				break;
			}
		}
		ListPool<GraphNode>.Release(reachableNodes);
		return result;
	}

	public static List<GraphNode> GetReachableNodes(GraphNode seed, int tagMask = -1)
	{
		Stack<GraphNode> stack = StackPool<GraphNode>.Claim();
		List<GraphNode> list = ListPool<GraphNode>.Claim();
		HashSet<GraphNode> map = new HashSet<GraphNode>();
		Action<GraphNode> action = ((tagMask != -1) ? ((Action<GraphNode>)delegate(GraphNode node)
		{
			if (node.Walkable && ((tagMask >> (int)node.Tag) & 1) != 0 && map.Add(node))
			{
				list.Add(node);
				stack.Push(node);
			}
		}) : ((Action<GraphNode>)delegate(GraphNode node)
		{
			if (node.Walkable && map.Add(node))
			{
				list.Add(node);
				stack.Push(node);
			}
		}));
		action(seed);
		while (stack.Count > 0)
		{
			stack.Pop().GetConnections(action);
		}
		StackPool<GraphNode>.Release(stack);
		return list;
	}

	public static List<GraphNode> BFS(GraphNode seed, int depth, int tagMask = -1)
	{
		BFSQueue = BFSQueue ?? new Queue<GraphNode>();
		Queue<GraphNode> que = BFSQueue;
		BFSMap = BFSMap ?? new Dictionary<GraphNode, int>();
		Dictionary<GraphNode, int> map = BFSMap;
		que.Clear();
		map.Clear();
		List<GraphNode> result = ListPool<GraphNode>.Claim();
		int currentDist = -1;
		Action<GraphNode> action = ((tagMask != -1) ? ((Action<GraphNode>)delegate(GraphNode node)
		{
			if (node.Walkable && ((tagMask >> (int)node.Tag) & 1) != 0 && !map.ContainsKey(node))
			{
				map.Add(node, currentDist + 1);
				result.Add(node);
				que.Enqueue(node);
			}
		}) : ((Action<GraphNode>)delegate(GraphNode node)
		{
			if (node.Walkable && !map.ContainsKey(node))
			{
				map.Add(node, currentDist + 1);
				result.Add(node);
				que.Enqueue(node);
			}
		}));
		action(seed);
		while (que.Count > 0)
		{
			GraphNode graphNode = que.Dequeue();
			currentDist = map[graphNode];
			if (currentDist >= depth)
			{
				break;
			}
			graphNode.GetConnections(action);
		}
		que.Clear();
		map.Clear();
		return result;
	}

	public static List<Vector3> GetSpiralPoints(int count, float clearance)
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0090: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		List<Vector3> list = ListPool<Vector3>.Claim(count);
		float num = clearance / (MathF.PI * 2f);
		float num2 = 0f;
		list.Add(InvoluteOfCircle(num, num2));
		for (int i = 0; i < count; i++)
		{
			Vector3 val = list[list.Count - 1];
			float num3 = (0f - num2) / 2f + Mathf.Sqrt(num2 * num2 / 4f + 2f * clearance / num);
			float num4 = num2 + num3;
			float num5 = num2 + 2f * num3;
			while (num5 - num4 > 0.01f)
			{
				float num6 = (num4 + num5) / 2f;
				Vector3 val2 = InvoluteOfCircle(num, num6);
				Vector3 val3 = val2 - val;
				if (((Vector3)(ref val3)).sqrMagnitude < clearance * clearance)
				{
					num4 = num6;
				}
				else
				{
					num5 = num6;
				}
			}
			list.Add(InvoluteOfCircle(num, num5));
			num2 = num5;
		}
		return list;
	}

	private static Vector3 InvoluteOfCircle(float a, float t)
	{
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3(a * (Mathf.Cos(t) + t * Mathf.Sin(t)), 0f, a * (Mathf.Sin(t) - t * Mathf.Cos(t)));
	}

	public static void GetPointsAroundPointWorld(Int3 p, IRaycastableGraph g, List<Int3> previousPoints, Int radius, Int clearanceRadius)
	{
		if (previousPoints.Count != 0)
		{
			Int3 zero = Int3.zero;
			for (int i = 0; i < previousPoints.Count; i++)
			{
				zero += previousPoints[i];
			}
			zero /= (float)previousPoints.Count;
			for (int j = 0; j < previousPoints.Count; j++)
			{
				previousPoints[j] -= zero;
			}
			GetPointsAroundPoint(p, g, previousPoints, radius, clearanceRadius);
		}
	}

	public static void GetPointsAroundPoint(Int3 p, IRaycastableGraph g, List<Int3> previousPoints, Int radius, Int clearanceRadius)
	{
		if (g == null)
		{
			throw new ArgumentNullException("g");
		}
		if (!(g is NavGraph navGraph))
		{
			throw new ArgumentException("g is not a NavGraph");
		}
		NNInfoInternal nearestForce = navGraph.GetNearestForce(p, NNConstraint.Default);
		p = nearestForce.clampedPosition;
		if (nearestForce.node == null)
		{
			return;
		}
		VFactor vFactor = new VFactor(1414L, 1000L);
		radius = IntMath.Max(radius, clearanceRadius * vFactor * IntMath.Sqrt(previousPoints.Count));
		clearanceRadius *= clearanceRadius;
		for (int i = 0; i < previousPoints.Count; i++)
		{
			Int3 @int = previousPoints[i];
			float magnitude = @int.magnitude;
			if (magnitude > 0f)
			{
				@int /= magnitude;
			}
			Int obj = radius;
			@int *= (VFactor)obj;
			int num = 0;
			while (true)
			{
				Int3 int2 = p + @int;
				if (g.Linecast(p, int2, nearestForce.node, out var hit))
				{
					if (hit.point == Int3.zero)
					{
						num++;
						if (num > 8)
						{
							previousPoints[i] = int2;
							break;
						}
					}
					else
					{
						int2 = hit.point;
					}
				}
				bool flag = false;
				VFactor vFactor2 = new VFactor(1L, 20L);
				for (VFactor vFactor3 = new VFactor(1L, 10L); vFactor3 <= VFactor.one; vFactor3 += vFactor2)
				{
					Int3 int3 = IntMath.Lerp(p, int2, vFactor3);
					flag = true;
					for (int j = 0; j < i; j++)
					{
						if ((previousPoints[j] - int3).sqrMagnitudeLong < clearanceRadius.i)
						{
							flag = false;
							break;
						}
					}
					if (flag || num > 8)
					{
						flag = true;
						previousPoints[i] = int3;
						break;
					}
				}
				if (flag)
				{
					break;
				}
				clearanceRadius *= new VFactor(9L, 10L);
				VFactor vFactor4 = new VFactor(num, 5L);
				IntMath.sincos(out var s, out var c, 31416 * DRandom.Random(360u), 1800000L);
				@int = IntMath.Divide(new Int3(((Int)c).i, 0, ((Int)s).i) * IntMath.Lerp(obj.i, radius.i, vFactor4.nom, vFactor.den), 1000);
				@int.y = 0;
				num++;
			}
		}
	}

	public static List<Vector3> GetPointsOnNodes(List<GraphNode> nodes, int count, float clearanceRadius = 0f)
	{
		//IL_019d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0110: Unknown result type (might be due to invalid IL or missing references)
		//IL_0115: Unknown result type (might be due to invalid IL or missing references)
		//IL_0159: Unknown result type (might be due to invalid IL or missing references)
		//IL_0127: Unknown result type (might be due to invalid IL or missing references)
		//IL_012c: Unknown result type (might be due to invalid IL or missing references)
		//IL_012e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0133: Unknown result type (might be due to invalid IL or missing references)
		if (nodes == null)
		{
			throw new ArgumentNullException("nodes");
		}
		if (nodes.Count == 0)
		{
			throw new ArgumentException("no nodes passed");
		}
		List<Vector3> list = ListPool<Vector3>.Claim(count);
		clearanceRadius *= clearanceRadius;
		if (clearanceRadius > 0f || nodes[0] is TriangleMeshNode || nodes[0] is GridNode)
		{
			List<float> list2 = ListPool<float>.Claim(nodes.Count);
			float num = 0f;
			for (int i = 0; i < nodes.Count; i++)
			{
				float num2 = nodes[i].SurfaceArea();
				num2 += 0.001f;
				num += num2;
				list2.Add(num);
			}
			for (int j = 0; j < count; j++)
			{
				int num3 = 0;
				int num4 = 10;
				bool flag = false;
				while (!flag)
				{
					flag = true;
					if (num3 >= num4)
					{
						clearanceRadius *= 0.80999994f;
						num4 += 10;
						if (num4 > 100)
						{
							clearanceRadius = 0f;
						}
					}
					float item = Random.value * num;
					int num5 = list2.BinarySearch(item);
					if (num5 < 0)
					{
						num5 = ~num5;
					}
					if (num5 >= nodes.Count)
					{
						flag = false;
						continue;
					}
					GraphNode graphNode = nodes[num5];
					Vector3 val = graphNode.RandomPointOnSurface();
					if (clearanceRadius > 0f)
					{
						for (int k = 0; k < list.Count; k++)
						{
							Vector3 val2 = list[k] - val;
							if (((Vector3)(ref val2)).sqrMagnitude < clearanceRadius)
							{
								flag = false;
								break;
							}
						}
					}
					if (flag)
					{
						list.Add(val);
						break;
					}
					num3++;
				}
			}
			ListPool<float>.Release(list2);
		}
		else
		{
			for (int l = 0; l < count; l++)
			{
				list.Add(nodes[Random.Range(0, nodes.Count)].RandomPointOnSurface());
			}
		}
		return list;
	}

	public static bool IsOnGraph(Int3 point, int contrainY = 2000)
	{
		constraint.currentY = point.y;
		constraint.constrainY = contrainY;
		GraphNode graphNode = (AstarPath.active.graphs[0] as RecastGraph).PointOnNavmesh(point, constraint);
		TriangleMeshNode triangleMeshNode = graphNode as TriangleMeshNode;
		return triangleMeshNode != null;
	}

	public static bool IsOnGraph(Int3 point, out int area, int contrainY = 2000)
	{
		area = -1;
		constraint.currentY = point.y;
		constraint.constrainY = contrainY;
		GraphNode graphNode = (AstarPath.active.graphs[0] as RecastGraph).PointOnNavmesh(point, constraint);
		TriangleMeshNode triangleMeshNode = graphNode as TriangleMeshNode;
		bool flag = triangleMeshNode != null;
		if (flag)
		{
			area = (int)triangleMeshNode.Area;
		}
		return flag;
	}

	public static bool Linecast(Int3 origin, Int3 end, GraphNode hint, out GraphHitInfo hitInfo)
	{
		RecastGraph recastGraph = AstarPath.active.graphs[0] as RecastGraph;
		return recastGraph.Linecast(origin, end, hint, out hitInfo);
	}

	public static void DrawDebugNode(TriangleMeshNode node, float yoffset, Color color)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00aa: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		Debug.DrawLine((Vector3)node.GetVertex(1) + Vector3.up * yoffset, (Vector3)node.GetVertex(2) + Vector3.up * yoffset, color);
		Debug.DrawLine((Vector3)node.GetVertex(0) + Vector3.up * yoffset, (Vector3)node.GetVertex(1) + Vector3.up * yoffset, color);
		Debug.DrawLine((Vector3)node.GetVertex(2) + Vector3.up * yoffset, (Vector3)node.GetVertex(0) + Vector3.up * yoffset, color);
	}

	public static Int3 Move(Int3 srcLoc, Int3 delta, ref int groundY, bool isUseTangentMove = true)
	{
		if (AstarPath.active == null)
		{
			return Int3.zero;
		}
		if (delta.x == 0 && delta.z == 0)
		{
			return delta;
		}
		Int3 destLoc = srcLoc + delta;
		int startEdge = -1;
		constraint.constrainY = 2000;
		constraint.currentY = srcLoc.y;
		GraphNode graphNode = (AstarPath.active.graphs[0] as RecastGraph).PointOnNavmesh(srcLoc, constraint);
		TriangleMeshNode triangleMeshNode = graphNode as TriangleMeshNode;
		if (triangleMeshNode == null)
		{
			constraint.constrainDistance = true;
			triangleMeshNode = (AstarPath.active.graphs[0] as RecastGraph).GetNearest(srcLoc, constraint).node as TriangleMeshNode;
			if (triangleMeshNode == null)
			{
				Debug.Log((object)"最近的节点为空");
				return Int3.zero;
			}
		}
		MoveFromNode(triangleMeshNode, startEdge, srcLoc, destLoc, out var result, isUseTangentMove);
		checkedNodes.Clear();
		groundY = result.y;
		result.y = srcLoc.y;
		return result - srcLoc;
	}

	private static void MoveFromNode(TriangleMeshNode node, int startEdge, Int3 srcLoc, Int3 destLoc, out Int3 result, bool isUseTangentMove = true)
	{
		result = srcLoc;
		TriangleMeshNode triangleMeshNode = node;
		int y = destLoc.y;
		List<TMNodeInfo> nodeInfos = ListPool<TMNodeInfo>.Claim();
		while (node != null)
		{
			int count = 2;
			if (node.IsVertex(srcLoc, out var index))
			{
				int vertexIndex = node.GetVertexIndex(index);
				Int3 vertex = node.GetVertex(index);
				nodeInfos.Clear();
				GetAllNodesByVert(ref nodeInfos, node, vertex);
				TriangleMeshNode triangleMeshNode2 = null;
				int num = -1;
				for (int i = 0; i < nodeInfos.Count; i++)
				{
					TMNodeInfo tMNodeInfo = nodeInfos[i];
					if (!checkedNodes.Contains(tMNodeInfo.node) && !VectorMath.RightXZ(tMNodeInfo.v0, tMNodeInfo.v2, destLoc) && VectorMath.RightOrColinearXZ(tMNodeInfo.v0, tMNodeInfo.v1, destLoc))
					{
						triangleMeshNode2 = tMNodeInfo.node;
						num = tMNodeInfo.vi;
						break;
					}
				}
				if (triangleMeshNode2 == null)
				{
					int alongEdge = -1;
					VFactor vFactor = new VFactor
					{
						nom = -2L,
						den = 1L
					};
					for (int j = 0; j < nodeInfos.Count; j++)
					{
						TMNodeInfo tMNodeInfo2 = nodeInfos[j];
						if (!checkedNodes.Contains(tMNodeInfo2.node))
						{
							VFactor cosineAngle = tMNodeInfo2.GetCosineAngle(destLoc, out var edgeIndex);
							if (cosineAngle > vFactor)
							{
								vFactor = cosineAngle;
								alongEdge = edgeIndex;
								triangleMeshNode2 = tMNodeInfo2.node;
							}
						}
					}
					if (triangleMeshNode2 != null)
					{
						if (isUseTangentMove)
						{
							MoveAlongEdge(triangleMeshNode2, alongEdge, srcLoc, destLoc, out result);
						}
						else
						{
							result = srcLoc;
						}
					}
					else
					{
						result = srcLoc;
					}
					break;
				}
				node = triangleMeshNode2;
				startEdge = (num + 1) % 3;
				count = 1;
			}
			int num2 = -1;
			num2 = ((startEdge != -1) ? node.EdgeIntersect(srcLoc, destLoc, startEdge, count) : node.EdgeIntersect(srcLoc, destLoc));
			if (num2 == -1 && node.Area == triangleMeshNode.Area)
			{
				if (node.ContainsPoint(destLoc))
				{
					result = destLoc;
					break;
				}
				num2 = node.GetColinearEdge(srcLoc, destLoc);
				if (num2 != -1)
				{
					MoveAlongEdge(node, num2, srcLoc, destLoc, out result);
				}
				break;
			}
			TriangleMeshNode neighborByEdge = node.GetNeighborByEdge(srcLoc, destLoc, num2, out var neighborEdge);
			if (neighborByEdge != null)
			{
				node = neighborByEdge;
				startEdge = neighborEdge + 1;
				count = 2;
				continue;
			}
			GraphHitInfo hitInfo;
			if (isUseTangentMove)
			{
				MoveAlongEdge(node, num2, srcLoc, destLoc, out result);
			}
			else if (Linecast(srcLoc, destLoc, triangleMeshNode, out hitInfo))
			{
				result = hitInfo.point + IntMath.Divide(srcLoc - hitInfo.point, 10);
			}
			break;
		}
		ListPool<TMNodeInfo>.Release(nodeInfos);
	}

	private static void MoveAlongEdge(TriangleMeshNode node, int alongEdge, Int3 srcLoc, Int3 destLoc, out Int3 result, bool checkAnotherEdge = true)
	{
		Int3 vertex = node.GetVertex(alongEdge);
		Int3 vertex2 = node.GetVertex((alongEdge + 1) % 3);
		Int3 @int = destLoc - srcLoc;
		@int.y = 0;
		Int3 int2 = vertex2 - vertex;
		int2.y = 0;
		int2.NormalizeTo(1000);
		int num = int2.x * @int.x + int2.z * @int.z;
		Int3 int3 = VectorMath.LineIntersectionPointXZ(vertex, vertex2, srcLoc, destLoc, out var intersects);
		if (!intersects)
		{
			if (!VectorMath.IsColinearXZ(vertex, vertex2, srcLoc) || !VectorMath.IsColinearXZ(vertex, vertex2, destLoc))
			{
				result = srcLoc;
				return;
			}
			if (num >= 0)
			{
				int num2 = int2.x * (vertex2.x - vertex.x) + int2.z * (vertex2.z - vertex.z);
				int num3 = int2.x * (destLoc.x - vertex.x) + int2.z * (destLoc.z - vertex.z);
				int3 = ((num2 <= num3) ? vertex2 : destLoc);
			}
			else
			{
				int num4 = -int2.x * (vertex.x - vertex2.x) - int2.z * (vertex.z - vertex2.z);
				int num5 = -int2.x * (destLoc.x - vertex2.x) - int2.z * (destLoc.z - vertex2.z);
				int3 = ((Mathf.Abs(num4) <= Mathf.Abs(num5)) ? vertex : destLoc);
			}
		}
		mIntersectionPoint = int3;
		mVertex = vertex;
		mNextVertex = vertex2;
		@int = destLoc - int3;
		@int.y = 0;
		num = int2.x * @int.x + int2.z * @int.z;
		int num6 = -IntMath.Sqrt(vertex.XZSqrMagnitude(int3) * 1000000);
		int num7 = IntMath.Sqrt(vertex2.XZSqrMagnitude(int3) * 1000000);
		if (num >= num6 && num <= num7)
		{
			result = IntMath.Divide(int2, num, 1000000L) + int3;
			if (!node.ContainsPoint(result))
			{
				Int3 int4 = vertex2 - vertex;
				int4.y = 0;
				int4 *= 10000;
				long longMagnitude = int4.LongMagnitude;
				VFactor factor = new VFactor
				{
					nom = num,
					den = longMagnitude * 1000
				};
				getMinMax(out var min, out var max, int4.x, ref factor);
				getMinMax(out var min2, out var max2, int4.z, ref factor);
				if (!MakePointInTriangle(ref result, node, min, max, min2, max2, srcLoc) && !MakePointInTriangle(ref result, node, min - 4, max + 4, min2 - 4, max2 + 4, srcLoc))
				{
					result = srcLoc;
				}
			}
			return;
		}
		int num8;
		int num9;
		Int3 int5;
		if (num < num6)
		{
			num8 = num - num6;
			num9 = (alongEdge + 2) % 3;
			int5 = vertex;
		}
		else
		{
			num8 = num - num7;
			num9 = (alongEdge + 1) % 3;
			int5 = vertex2;
		}
		Int3 int6 = int2 * num8 / 1000000f;
		TriangleMeshNode neighborByEdge = node.GetNeighborByEdge(srcLoc, destLoc, num9, out var neighborEdge);
		if (neighborByEdge != null)
		{
			checkedNodes.Add(node);
			MoveFromNode(neighborByEdge, neighborEdge, int5, int6 + int5, out result);
		}
		else if (checkAnotherEdge && Int3.Dot((node.GetVertex((alongEdge + 2) % 3) - int5).NormalizeTo(1000), int6) > 0)
		{
			checkedNodes.Add(node);
			MoveAlongEdge(node, num9, int5, int6 + int5, out result, checkAnotherEdge: false);
		}
		else
		{
			result = int5;
		}
	}

	public static bool GetGroundY(Int3 pos, out int groundY)
	{
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		if (AstarPath.active == null)
		{
			groundY = pos.y;
			return false;
		}
		groundY = pos.y;
		constraint.currentY = pos.y;
		constraint.constrainY = 2000;
		GraphNode graphNode = (AstarPath.active.graphs[0] as RecastGraph).PointOnNavmesh(pos, constraint);
		if (!(graphNode is TriangleMeshNode node))
		{
			return false;
		}
		float num = CalculateY_Clamped((Vector3)pos, node);
		groundY = Mathf.RoundToInt(num * 1000f);
		return true;
	}

	private static void CalculateY(ref Int3 point, TriangleMeshNode node)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		float num = CalculateY((Vector3)point, node);
		point.y = Mathf.RoundToInt(num * 1000f);
	}

	private static float CalculateY(Vector3 pf, TriangleMeshNode node)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0105: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0119: Unknown result type (might be due to invalid IL or missing references)
		node.GetVertices(out var v, out var v2, out var v3);
		Vector3 val = (Vector3)v;
		Vector3 val2 = (Vector3)v2;
		Vector3 val3 = (Vector3)v3;
		float num = (val2.z - val3.z) * (val.x - val3.x) + (val3.x - val2.x) * (val.z - val3.z);
		float num2 = 1f / num;
		float num3 = (val2.z - val3.z) * (pf.x - val3.x) + (val3.x - val2.x) * (pf.z - val3.z);
		num3 *= num2;
		float num4 = (val3.z - val.z) * (pf.x - val3.x) + (val.x - val3.x) * (pf.z - val3.z);
		num4 *= num2;
		float num5 = 1f - num3 - num4;
		return num3 * val.y + num4 * val2.y + num5 * val3.y;
	}

	private static float CalculateY_Clamped(Vector3 pf, TriangleMeshNode node)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00de: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_011c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0125: Unknown result type (might be due to invalid IL or missing references)
		//IL_0130: Unknown result type (might be due to invalid IL or missing references)
		node.GetVertices(out var v, out var v2, out var v3);
		Vector3 val = (Vector3)v;
		Vector3 val2 = (Vector3)v2;
		Vector3 val3 = (Vector3)v3;
		float num = (val2.z - val3.z) * (val.x - val3.x) + (val3.x - val2.x) * (val.z - val3.z);
		float num2 = 1f / num;
		float num3 = (val2.z - val3.z) * (pf.x - val3.x) + (val3.x - val2.x) * (pf.z - val3.z);
		num3 *= num2;
		num3 = Mathf.Clamp01(num3);
		float num4 = (val3.z - val.z) * (pf.x - val3.x) + (val.x - val3.x) * (pf.z - val3.z);
		num4 *= num2;
		num4 = Mathf.Clamp01(num4);
		float num5 = Mathf.Clamp01(1f - num3 - num4);
		return num3 * val.y + num4 * val2.y + num5 * val3.y;
	}

	private static void GetAllNodesByVert(ref List<TMNodeInfo> nodeInfos, TriangleMeshNode startNode, Int3 vertPos)
	{
		if (nodeInfos == null)
		{
			nodeInfos = new List<TMNodeInfo>();
		}
		for (int i = 0; i < nodeInfos.Count; i++)
		{
			if (nodeInfos[i].node == startNode)
			{
				return;
			}
		}
		int num = -1;
		if (startNode.GetVertex(0).IsEqualXZ(ref vertPos))
		{
			num = 0;
		}
		else if (startNode.GetVertex(1).IsEqualXZ(ref vertPos))
		{
			num = 1;
		}
		else
		{
			if (!startNode.GetVertex(2).IsEqualXZ(ref vertPos))
			{
				return;
			}
			num = 2;
		}
		TMNodeInfo item = new TMNodeInfo
		{
			vi = num,
			node = startNode,
			v0 = startNode.GetVertex(num % 3),
			v1 = startNode.GetVertex((num + 1) % 3),
			v2 = startNode.GetVertex((num + 2) % 3)
		};
		nodeInfos.Add(item);
		if (startNode.connections == null)
		{
			return;
		}
		for (int j = 0; j < startNode.connections.Length; j++)
		{
			if (startNode.connections[j].node is TriangleMeshNode triangleMeshNode && triangleMeshNode.GraphIndex == startNode.GraphIndex && triangleMeshNode.Area == startNode.Area)
			{
				GetAllNodesByVert(ref nodeInfos, triangleMeshNode, vertPos);
			}
		}
	}

	private static void GetAllNodesByVert(ref List<TMNodeInfo> nodeInfos, TriangleMeshNode startNode, int vertIndex)
	{
		if (nodeInfos == null)
		{
			nodeInfos = new List<TMNodeInfo>();
		}
		for (int i = 0; i < nodeInfos.Count; i++)
		{
			if (nodeInfos[i].node == startNode)
			{
				return;
			}
		}
		int num = -1;
		if (startNode.v0 == vertIndex)
		{
			num = 0;
		}
		else if (startNode.v1 == vertIndex)
		{
			num = 1;
		}
		else
		{
			if (startNode.v2 != vertIndex)
			{
				return;
			}
			num = 2;
		}
		TMNodeInfo item = new TMNodeInfo
		{
			vi = num,
			node = startNode,
			v0 = startNode.GetVertex(num % 3),
			v1 = startNode.GetVertex((num + 1) % 3),
			v2 = startNode.GetVertex((num + 2) % 3)
		};
		nodeInfos.Add(item);
		if (startNode.connections == null)
		{
			return;
		}
		for (int j = 0; j < startNode.connections.Length; j++)
		{
			if (startNode.connections[j].node is TriangleMeshNode triangleMeshNode && triangleMeshNode.GraphIndex == startNode.GraphIndex)
			{
				GetAllNodesByVert(ref nodeInfos, triangleMeshNode, vertIndex);
			}
		}
	}

	private static bool MakePointInTriangle(ref Int3 result, TriangleMeshNode node, int minX, int maxX, int minZ, int maxZ, Int3 offset)
	{
		node.GetVertices(out var v, out var v2, out var v3);
		long num = v2.x - v.x;
		long num2 = v3.x - v2.x;
		long num3 = v.x - v3.x;
		long num4 = v2.z - v.z;
		long num5 = v3.z - v2.z;
		long num6 = v.z - v3.z;
		for (int i = minX; i <= maxX; i++)
		{
			for (int j = minZ; j <= maxZ; j++)
			{
				int num7 = i + offset.x;
				int num8 = j + offset.z;
				if (num * (num8 - v.z) - (num7 - v.x) * num4 <= 0 && num2 * (num8 - v2.z) - (num7 - v2.x) * num5 <= 0 && num3 * (num8 - v3.z) - (num7 - v3.x) * num6 <= 0)
				{
					result.x = num7;
					result.z = num8;
					return true;
				}
			}
		}
		return false;
	}

	private static void getMinMax(out int min, out int max, long axis, ref VFactor factor)
	{
		long num = axis * factor.nom;
		int num2 = (int)(num / factor.den);
		if (num < 0)
		{
			min = num2 - 1;
			max = num2;
		}
		else
		{
			min = num2;
			max = num2 + 1;
		}
	}
}
