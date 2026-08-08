using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public class TriangleMeshNode : MeshNode
{
	public int v0;

	public int v1;

	public int v2;

	protected static INavmeshHolder[] _navmeshHolders = new INavmeshHolder[0];

	protected static readonly object lockObject = new object();

	public TriangleMeshNode(AstarPath astar)
		: base(astar)
	{
	}

	public static INavmeshHolder GetNavmeshHolder(uint graphIndex)
	{
		return _navmeshHolders[graphIndex];
	}

	public bool IsVertex(Int3 p, out int index)
	{
		INavmeshHolder navmeshHolder = GetNavmeshHolder(base.GraphIndex);
		index = -1;
		if (navmeshHolder.GetVertex(v0).IsEqualXZ(ref p))
		{
			index = 0;
		}
		else if (navmeshHolder.GetVertex(v1).IsEqualXZ(ref p))
		{
			index = 1;
		}
		else if (navmeshHolder.GetVertex(v2).IsEqualXZ(ref p))
		{
			index = 2;
		}
		return index != -1;
	}

	public int EdgeIntersect(Int3 a, Int3 b)
	{
		GetVertices(out var @int, out var int2, out var int3);
		if (VectorMath.SegmentsIntersectXZ(@int, int2, a, b))
		{
			return 0;
		}
		if (VectorMath.SegmentsIntersectXZ(int2, int3, a, b))
		{
			return 1;
		}
		if (VectorMath.SegmentsIntersectXZ(int3, @int, a, b))
		{
			return 2;
		}
		return -1;
	}

	public int EdgeIntersect(Int3 a, Int3 b, int startEdge, int count)
	{
		Int3[] array = ArrayPool<Int3>.Claim(3);
		GetVertices(out array[0], out array[1], out array[2]);
		for (int i = 0; i < count; i++)
		{
			int num = (startEdge + i) % 3;
			int num2 = (num + 1) % 3;
			if (VectorMath.SegmentsIntersectXZ(array[num], array[num2], a, b))
			{
				ArrayPool<Int3>.Release(ref array);
				return num;
			}
		}
		ArrayPool<Int3>.Release(ref array);
		return -1;
	}

	public int EdgeIntersect(Int3 a, Int3 b, TriangleMeshNode node, int startEdge, int count)
	{
		Int3[] array = ArrayPool<Int3>.Claim(3);
		node.GetVertices(out array[0], out array[1], out array[2]);
		for (int i = 0; i < count; i++)
		{
			int num = (startEdge + i) % 3;
			int num2 = (num + 1) % 3;
			if (VectorMath.SegmentsIntersectXZ(array[num], array[num2], a, b))
			{
				ArrayPool<Int3>.Release(ref array);
				return num;
			}
		}
		ArrayPool<Int3>.Release(ref array);
		return -1;
	}

	public int GetColinearEdge(Int3 a, Int3 b)
	{
		GetVertices(out var @int, out var int2, out var int3);
		if (VectorMath.IsColinearXZ(@int, int2, a) && VectorMath.IsColinearXZ(@int, int2, b))
		{
			return 0;
		}
		if (VectorMath.IsColinearXZ(int2, int3, a) && VectorMath.IsColinearXZ(int2, int3, b))
		{
			return 1;
		}
		if (VectorMath.IsColinearXZ(int3, @int, a) && VectorMath.IsColinearXZ(int3, @int, b))
		{
			return 2;
		}
		return -1;
	}

	public static bool SegmentsIntersectXZ(Int3 start1, Int3 end1, Int3 start2, Int3 end2)
	{
		Int3 @int = end1 - start1;
		Int3 int2 = end2 - start2;
		long num = (long)int2.z * (long)@int.x - (long)int2.x * (long)@int.z;
		if (num == 0L)
		{
			return false;
		}
		long num2 = int2.x * (start1.z - start2.z) - int2.z * (start1.x - start2.x);
		long num3 = @int.x * (start1.z - start2.z) - @int.z * (start1.x - start2.x);
		long num4 = num2 * 1000 / num;
		long num5 = num3 * 1000 / num;
		if (num4 < 0 || num4 > 1000 || num5 < 0 || num5 > 1000)
		{
			return false;
		}
		return true;
	}

	public static bool EqualInDeviation(Int3 a, Int3 b)
	{
		if (Mathf.Abs(a.x - b.x) < 2 && Mathf.Abs(a.z - b.z) < 2)
		{
			return Mathf.Abs(a.y - b.y) < 2;
		}
		return false;
	}

	public TriangleMeshNode GetNeighborByEdge(Int3 start, Int3 end, int edge, out int neighborEdge)
	{
		neighborEdge = -1;
		if (edge < 0 || edge > 2 || connections == null)
		{
			return null;
		}
		Int3 vertex = GetVertex(edge % 3);
		Int3 vertex2 = GetVertex((edge + 1) % 3);
		Int3 vertex3 = GetVertex((edge + 2) % 3);
		for (int i = 0; i < connections.Length; i++)
		{
			TriangleMeshNode triangleMeshNode = connections[i].node as TriangleMeshNode;
			if (triangleMeshNode == this)
			{
				continue;
			}
			triangleMeshNode.GetVertices(out var @int, out var int2, out var int3);
			if (VectorMath.IsColinearXZ(@int, int2, vertex) && VectorMath.IsColinearXZ(@int, int2, vertex2) && SegmentsIntersectXZ(@int, int2, start, end) && VectorMath.RightOrColinearXZ(@int, int2, int3) != VectorMath.RightOrColinearXZ(@int, int2, vertex3))
			{
				neighborEdge = 0;
			}
			else if (VectorMath.IsColinearXZ(int2, int3, vertex) && VectorMath.IsColinearXZ(int2, int3, vertex2) && SegmentsIntersectXZ(int2, int3, start, end) && VectorMath.RightOrColinearXZ(int3, int2, @int) != VectorMath.RightOrColinearXZ(int3, int2, vertex3))
			{
				neighborEdge = 1;
			}
			else if (VectorMath.IsColinearXZ(int3, @int, vertex) && VectorMath.IsColinearXZ(int3, @int, vertex2) && SegmentsIntersectXZ(int3, @int, start, end) && VectorMath.RightOrColinearXZ(@int, int3, int2) != VectorMath.RightOrColinearXZ(@int, int3, vertex3))
			{
				neighborEdge = 2;
			}
			if (neighborEdge == -1)
			{
				if (EqualInDeviation(int2, vertex) && EqualInDeviation(@int, vertex2))
				{
					neighborEdge = 0;
				}
				else if (EqualInDeviation(int3, vertex) && EqualInDeviation(int2, vertex2))
				{
					neighborEdge = 1;
				}
				else if (EqualInDeviation(@int, vertex) && EqualInDeviation(int3, vertex2))
				{
					neighborEdge = 2;
				}
			}
			if (neighborEdge != -1)
			{
				return triangleMeshNode;
			}
		}
		return null;
	}

	public static void SetNavmeshHolder(int graphIndex, INavmeshHolder graph)
	{
		if (_navmeshHolders.Length <= graphIndex)
		{
			lock (lockObject)
			{
				if (_navmeshHolders.Length <= graphIndex)
				{
					INavmeshHolder[] array = new INavmeshHolder[graphIndex + 1];
					for (int i = 0; i < _navmeshHolders.Length; i++)
					{
						array[i] = _navmeshHolders[i];
					}
					_navmeshHolders = array;
				}
			}
		}
		_navmeshHolders[graphIndex] = graph;
	}

	public void UpdatePositionFromVertices()
	{
		GetVertices(out var @int, out var int2, out var int3);
		position = (@int + int2 + int3) * 0.333333f;
	}

	public int GetVertexIndex(int i)
	{
		return i switch
		{
			1 => v1, 
			0 => v0, 
			_ => v2, 
		};
	}

	public int GetVertexArrayIndex(int i)
	{
		return GetNavmeshHolder(base.GraphIndex).GetVertexArrayIndex(i switch
		{
			1 => v1, 
			0 => v0, 
			_ => v2, 
		});
	}

	public void GetVertices(out Int3 v0, out Int3 v1, out Int3 v2)
	{
		INavmeshHolder navmeshHolder = GetNavmeshHolder(base.GraphIndex);
		v0 = navmeshHolder.GetVertex(this.v0);
		v1 = navmeshHolder.GetVertex(this.v1);
		v2 = navmeshHolder.GetVertex(this.v2);
	}

	public override Int3 GetVertex(int i)
	{
		return GetNavmeshHolder(base.GraphIndex).GetVertex(GetVertexIndex(i));
	}

	public Int3 GetVertexInGraphSpace(int i)
	{
		return GetNavmeshHolder(base.GraphIndex).GetVertexInGraphSpace(GetVertexIndex(i));
	}

	public override int GetVertexCount()
	{
		return 3;
	}

	public override Int3 ClosestPointOnNode(Int3 p)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		GetVertices(out var @int, out var int2, out var int3);
		return (Int3)Polygon.ClosestPointOnTriangle((Vector3)@int, (Vector3)int2, (Vector3)int3, (Vector3)p);
	}

	public override Int3 ClosestPointOnNodeXZ(Int3 p)
	{
		GetVertices(out var a, out var b, out var c);
		return Polygon.ClosestPointOnTriangleXZ(a, b, c, p);
	}

	public override bool ContainsPoint(Int3 p)
	{
		GetVertices(out var @int, out var int2, out var int3);
		if ((long)(int2.x - @int.x) * (long)(p.z - @int.z) - (long)(p.x - @int.x) * (long)(int2.z - @int.z) > 0)
		{
			return false;
		}
		if ((long)(int3.x - int2.x) * (long)(p.z - int2.z) - (long)(p.x - int2.x) * (long)(int3.z - int2.z) > 0)
		{
			return false;
		}
		if ((long)(@int.x - int3.x) * (long)(p.z - int3.z) - (long)(p.x - int3.x) * (long)(@int.z - int3.z) > 0)
		{
			return false;
		}
		return true;
	}

	public override void UpdateRecursiveG(Path path, PathNode pathNode, PathHandler handler)
	{
		UpdateG(path, pathNode);
		handler.heap.Add(pathNode);
		if (connections == null)
		{
			return;
		}
		for (int i = 0; i < connections.Length; i++)
		{
			GraphNode node = connections[i].node;
			PathNode pathNode2 = handler.GetPathNode(node);
			if (pathNode2.parent == pathNode && pathNode2.pathID == handler.PathID)
			{
				node.UpdateRecursiveG(path, pathNode2, handler);
			}
		}
	}

	public override void Open(Path path, PathNode pathNode, PathHandler handler)
	{
		if (connections == null)
		{
			return;
		}
		bool flag = pathNode.flag2;
		for (int num = connections.Length - 1; num >= 0; num--)
		{
			Connection connection = connections[num];
			GraphNode node = connection.node;
			if (path.CanTraverse(connection.node))
			{
				PathNode pathNode2 = handler.GetPathNode(connection.node);
				if (pathNode2 != pathNode.parent)
				{
					uint num2 = connection.cost;
					if (flag || pathNode2.flag2)
					{
						num2 = path.GetConnectionSpecialCost(this, connection.node, num2);
					}
					if (pathNode2.pathID != handler.PathID)
					{
						pathNode2.node = connection.node;
						pathNode2.parent = pathNode;
						pathNode2.pathID = handler.PathID;
						pathNode2.cost = num2;
						pathNode2.H = path.CalculateHScore(node);
						node.UpdateG(path, pathNode2);
						handler.heap.Add(pathNode2);
					}
					else if (pathNode.G + num2 + path.GetTraversalCost(node) < pathNode2.G)
					{
						pathNode2.cost = num2;
						pathNode2.parent = pathNode;
						node.UpdateRecursiveG(path, pathNode2, handler);
					}
					else if (pathNode2.G + num2 + path.GetTraversalCost(this) < pathNode.G && node.ContainsConnection(this))
					{
						pathNode.parent = pathNode2;
						pathNode.cost = num2;
						UpdateRecursiveG(path, pathNode, handler);
					}
				}
			}
		}
	}

	public int SharedEdge(GraphNode other)
	{
		GetPortal(other, null, null, backwards: false, out var aIndex, out var _);
		return aIndex;
	}

	public override bool GetPortal(GraphNode _other, List<Int3> left, List<Int3> right, bool backwards)
	{
		int aIndex;
		int bIndex;
		return GetPortal(_other, left, right, backwards, out aIndex, out bIndex);
	}

	public bool GetPortal(GraphNode _other, List<Int3> left, List<Int3> right, bool backwards, out int aIndex, out int bIndex)
	{
		aIndex = -1;
		bIndex = -1;
		if (_other.GraphIndex != base.GraphIndex)
		{
			return false;
		}
		TriangleMeshNode triangleMeshNode = _other as TriangleMeshNode;
		int num = (GetVertexIndex(0) >> 12) & 0x7FFFF;
		int num2 = (triangleMeshNode.GetVertexIndex(0) >> 12) & 0x7FFFF;
		if (num != num2 && GetNavmeshHolder(base.GraphIndex) is RecastGraph)
		{
			for (int i = 0; i < connections.Length; i++)
			{
				_ = connections[i].node.GraphIndex;
				_ = base.GraphIndex;
			}
			INavmeshHolder navmeshHolder = GetNavmeshHolder(base.GraphIndex);
			navmeshHolder.GetTileCoordinates(num, out var x, out var z);
			navmeshHolder.GetTileCoordinates(num2, out var x2, out var z2);
			int num3;
			if (Math.Abs(x - x2) == 1)
			{
				num3 = 0;
			}
			else
			{
				if (Math.Abs(z - z2) != 1)
				{
					throw new Exception("Tiles not adjacent (" + x + ", " + z + ") (" + x2 + ", " + z2 + ")");
				}
				num3 = 2;
			}
			int vertexCount = GetVertexCount();
			int vertexCount2 = triangleMeshNode.GetVertexCount();
			int num4 = -1;
			int num5 = -1;
			for (int j = 0; j < vertexCount; j++)
			{
				int num6 = GetVertex(j)[num3];
				for (int k = 0; k < vertexCount2; k++)
				{
					if (num6 == triangleMeshNode.GetVertex((k + 1) % vertexCount2)[num3] && GetVertex((j + 1) % vertexCount)[num3] == triangleMeshNode.GetVertex(k)[num3])
					{
						num4 = j;
						num5 = k;
						j = vertexCount;
						break;
					}
				}
			}
			aIndex = num4;
			bIndex = num5;
			if (num4 != -1)
			{
				Int3 vertex = GetVertex(num4);
				Int3 vertex2 = GetVertex((num4 + 1) % vertexCount);
				int i2 = ((num3 != 2) ? 2 : 0);
				int val = Math.Min(vertex[i2], vertex2[i2]);
				int val2 = Math.Max(vertex[i2], vertex2[i2]);
				val = Math.Max(val, Math.Min(triangleMeshNode.GetVertex(num5)[i2], triangleMeshNode.GetVertex((num5 + 1) % vertexCount2)[i2]));
				val2 = Math.Min(val2, Math.Max(triangleMeshNode.GetVertex(num5)[i2], triangleMeshNode.GetVertex((num5 + 1) % vertexCount2)[i2]));
				if (vertex[i2] < vertex2[i2])
				{
					vertex[i2] = val;
					vertex2[i2] = val2;
				}
				else
				{
					vertex[i2] = val2;
					vertex2[i2] = val;
				}
				if (left != null)
				{
					left.Add(vertex);
					right.Add(vertex2);
				}
				return true;
			}
		}
		else if (!backwards)
		{
			int num7 = -1;
			int num8 = -1;
			int vertexCount3 = GetVertexCount();
			int vertexCount4 = triangleMeshNode.GetVertexCount();
			for (int l = 0; l < vertexCount3; l++)
			{
				int vertexIndex = GetVertexIndex(l);
				for (int m = 0; m < vertexCount4; m++)
				{
					if (vertexIndex == triangleMeshNode.GetVertexIndex((m + 1) % vertexCount4) && GetVertexIndex((l + 1) % vertexCount3) == triangleMeshNode.GetVertexIndex(m))
					{
						num7 = l;
						num8 = m;
						l = vertexCount3;
						break;
					}
				}
			}
			aIndex = num7;
			bIndex = num8;
			if (num7 == -1)
			{
				for (int n = 0; n < connections.Length; n++)
				{
					_ = connections[n].node.GraphIndex;
					_ = base.GraphIndex;
				}
				return false;
			}
			if (left != null)
			{
				left.Add(GetVertex(num7));
				right.Add(GetVertex((num7 + 1) % vertexCount3));
			}
		}
		return true;
	}

	public override float SurfaceArea()
	{
		INavmeshHolder navmeshHolder = GetNavmeshHolder(base.GraphIndex);
		return (float)Math.Abs(VectorMath.SignedTriangleAreaTimes2XZ(navmeshHolder.GetVertex(v0), navmeshHolder.GetVertex(v1), navmeshHolder.GetVertex(v2))) * 0.5f;
	}

	public override Vector3 RandomPointOnSurface()
	{
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		float value;
		float value2;
		do
		{
			value = Random.value;
			value2 = Random.value;
		}
		while (value + value2 > 1f);
		INavmeshHolder navmeshHolder = GetNavmeshHolder(base.GraphIndex);
		return (Vector3)(navmeshHolder.GetVertex(v1) - navmeshHolder.GetVertex(v0)) * value + (Vector3)(navmeshHolder.GetVertex(v2) - navmeshHolder.GetVertex(v0)) * value2 + (Vector3)navmeshHolder.GetVertex(v0);
	}

	public override void SerializeNode(GraphSerializationContext ctx)
	{
		base.SerializeNode(ctx);
		ctx.writer.Write(v0);
		ctx.writer.Write(v1);
		ctx.writer.Write(v2);
	}

	public override void DeserializeNode(GraphSerializationContext ctx)
	{
		base.DeserializeNode(ctx);
		v0 = ctx.reader.ReadInt32();
		v1 = ctx.reader.ReadInt32();
		v2 = ctx.reader.ReadInt32();
	}
}
