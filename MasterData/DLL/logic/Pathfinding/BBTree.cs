using System;
using System.Diagnostics;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public class BBTree : IAstarPooledObject
{
	private struct BBTreeBox
	{
		public IntRect rect;

		public int nodeOffset;

		public int left;

		public int right;

		public bool IsLeaf => nodeOffset >= 0;

		public BBTreeBox(IntRect rect)
		{
			nodeOffset = -1;
			this.rect = rect;
			left = (right = -1);
		}

		public BBTreeBox(int nodeOffset, IntRect rect)
		{
			this.nodeOffset = nodeOffset;
			this.rect = rect;
			left = (right = -1);
		}

		public bool Contains(Int3 point)
		{
			Int3 @int = point;
			return rect.Contains(@int.x, @int.z);
		}
	}

	private BBTreeBox[] tree;

	private TriangleMeshNode[] nodeLookup;

	private int count;

	private int leafNodes;

	private const int MaximumLeafSize = 4;

	public Rect Size
	{
		get
		{
			//IL_0068: Unknown result type (might be due to invalid IL or missing references)
			//IL_001c: Unknown result type (might be due to invalid IL or missing references)
			if (count == 0)
			{
				return new Rect(0f, 0f, 0f, 0f);
			}
			IntRect rect = tree[0].rect;
			return Rect.MinMaxRect((float)rect.xmin * 0.001f, (float)rect.ymin * 0.001f, (float)rect.xmax * 0.001f, (float)rect.ymax * 0.001f);
		}
	}

	public void Clear()
	{
		count = 0;
		leafNodes = 0;
		if (tree != null)
		{
			ArrayPool<BBTreeBox>.Release(ref tree);
		}
		if (nodeLookup != null)
		{
			for (int i = 0; i < nodeLookup.Length; i++)
			{
				nodeLookup[i] = null;
			}
			ArrayPool<TriangleMeshNode>.Release(ref nodeLookup);
		}
		tree = ArrayPool<BBTreeBox>.Claim(0);
		nodeLookup = ArrayPool<TriangleMeshNode>.Claim(0);
	}

	void IAstarPooledObject.OnEnterPool()
	{
		Clear();
	}

	private void EnsureCapacity(int c)
	{
		if (c > tree.Length)
		{
			BBTreeBox[] array = ArrayPool<BBTreeBox>.Claim(c);
			tree.CopyTo(array, 0);
			ArrayPool<BBTreeBox>.Release(ref tree);
			tree = array;
		}
	}

	private void EnsureNodeCapacity(int c)
	{
		if (c > nodeLookup.Length)
		{
			TriangleMeshNode[] array = ArrayPool<TriangleMeshNode>.Claim(c);
			nodeLookup.CopyTo(array, 0);
			ArrayPool<TriangleMeshNode>.Release(ref nodeLookup);
			nodeLookup = array;
		}
	}

	private int GetBox(IntRect rect)
	{
		if (count >= tree.Length)
		{
			EnsureCapacity(count + 1);
		}
		tree[count] = new BBTreeBox(rect);
		count++;
		return count - 1;
	}

	public void RebuildFrom(TriangleMeshNode[] nodes)
	{
		Clear();
		if (nodes.Length != 0)
		{
			EnsureCapacity(Mathf.CeilToInt((float)nodes.Length * 2.1f));
			EnsureNodeCapacity(Mathf.CeilToInt((float)nodes.Length * 1.1f));
			int[] array = ArrayPool<int>.Claim(nodes.Length);
			for (int i = 0; i < nodes.Length; i++)
			{
				array[i] = i;
			}
			IntRect[] array2 = ArrayPool<IntRect>.Claim(nodes.Length);
			for (int j = 0; j < nodes.Length; j++)
			{
				nodes[j].GetVertices(out var v, out var v2, out var v3);
				IntRect intRect = new IntRect(v.x, v.z, v.x, v.z).ExpandToContain(v2.x, v2.z).ExpandToContain(v3.x, v3.z);
				array2[j] = intRect;
			}
			RebuildFromInternal(nodes, array, array2, 0, nodes.Length, odd: false);
			ArrayPool<int>.Release(ref array);
			ArrayPool<IntRect>.Release(ref array2);
		}
	}

	private static int SplitByX(TriangleMeshNode[] nodes, int[] permutation, int from, int to, int divider)
	{
		int num = to;
		for (int i = from; i < num; i++)
		{
			if (nodes[permutation[i]].position.x > divider)
			{
				num--;
				int num2 = permutation[num];
				permutation[num] = permutation[i];
				permutation[i] = num2;
				i--;
			}
		}
		return num;
	}

	private static int SplitByZ(TriangleMeshNode[] nodes, int[] permutation, int from, int to, int divider)
	{
		int num = to;
		for (int i = from; i < num; i++)
		{
			if (nodes[permutation[i]].position.z > divider)
			{
				num--;
				int num2 = permutation[num];
				permutation[num] = permutation[i];
				permutation[i] = num2;
				i--;
			}
		}
		return num;
	}

	private int RebuildFromInternal(TriangleMeshNode[] nodes, int[] permutation, IntRect[] nodeBounds, int from, int to, bool odd)
	{
		IntRect rect = NodeBounds(permutation, nodeBounds, from, to);
		int box = GetBox(rect);
		if (to - from <= 4)
		{
			int num = (tree[box].nodeOffset = leafNodes * 4);
			EnsureNodeCapacity(num + 4);
			leafNodes++;
			for (int i = 0; i < 4; i++)
			{
				nodeLookup[num + i] = ((i < to - from) ? nodes[permutation[from + i]] : null);
			}
			return box;
		}
		int num2;
		if (odd)
		{
			int divider = (rect.xmin + rect.xmax) / 2;
			num2 = SplitByX(nodes, permutation, from, to, divider);
		}
		else
		{
			int divider2 = (rect.ymin + rect.ymax) / 2;
			num2 = SplitByZ(nodes, permutation, from, to, divider2);
		}
		if (num2 == from || num2 == to)
		{
			if (!odd)
			{
				int divider3 = (rect.xmin + rect.xmax) / 2;
				num2 = SplitByX(nodes, permutation, from, to, divider3);
			}
			else
			{
				int divider4 = (rect.ymin + rect.ymax) / 2;
				num2 = SplitByZ(nodes, permutation, from, to, divider4);
			}
			if (num2 == from || num2 == to)
			{
				num2 = (from + to) / 2;
			}
		}
		tree[box].left = RebuildFromInternal(nodes, permutation, nodeBounds, from, num2, !odd);
		tree[box].right = RebuildFromInternal(nodes, permutation, nodeBounds, num2, to, !odd);
		return box;
	}

	private static IntRect NodeBounds(int[] permutation, IntRect[] nodeBounds, int from, int to)
	{
		IntRect result = nodeBounds[permutation[from]];
		for (int i = from + 1; i < to; i++)
		{
			IntRect intRect = nodeBounds[permutation[i]];
			result.xmin = Math.Min(result.xmin, intRect.xmin);
			result.ymin = Math.Min(result.ymin, intRect.ymin);
			result.xmax = Math.Max(result.xmax, intRect.xmax);
			result.ymax = Math.Max(result.ymax, intRect.ymax);
		}
		return result;
	}

	[Conditional("ASTARDEBUG")]
	private static void DrawDebugRect(IntRect rect)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00de: Unknown result type (might be due to invalid IL or missing references)
		Debug.DrawLine(new Vector3((float)rect.xmin, 0f, (float)rect.ymin), new Vector3((float)rect.xmax, 0f, (float)rect.ymin), Color.white);
		Debug.DrawLine(new Vector3((float)rect.xmin, 0f, (float)rect.ymax), new Vector3((float)rect.xmax, 0f, (float)rect.ymax), Color.white);
		Debug.DrawLine(new Vector3((float)rect.xmin, 0f, (float)rect.ymin), new Vector3((float)rect.xmin, 0f, (float)rect.ymax), Color.white);
		Debug.DrawLine(new Vector3((float)rect.xmax, 0f, (float)rect.ymin), new Vector3((float)rect.xmax, 0f, (float)rect.ymax), Color.white);
	}

	[Conditional("ASTARDEBUG")]
	private static void DrawDebugNode(TriangleMeshNode node, float yoffset, Color color)
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

	public NNInfoInternal QueryClosest(Int3 p, NNConstraint constraint, out long distance)
	{
		distance = long.MaxValue;
		return QueryClosest(p, constraint, ref distance, new NNInfoInternal(null));
	}

	public NNInfoInternal QueryClosestXZ(Int3 p, NNConstraint constraint, ref long distance, NNInfoInternal previous)
	{
		long closestSqrDist = distance * distance;
		long num = closestSqrDist;
		if (count > 0 && SquaredRectPointDistance(tree[0].rect, p) < closestSqrDist)
		{
			SearchBoxClosestXZ(0, p, ref closestSqrDist, constraint, ref previous);
			if (closestSqrDist < num)
			{
				distance = IntMath.Sqrt(closestSqrDist);
			}
		}
		return previous;
	}

	private void SearchBoxClosestXZ(int boxi, Int3 p, ref long closestSqrDist, NNConstraint constraint, ref NNInfoInternal nnInfo)
	{
		BBTreeBox bBTreeBox = tree[boxi];
		if (bBTreeBox.IsLeaf)
		{
			TriangleMeshNode[] array = nodeLookup;
			for (int i = 0; i < 4 && array[bBTreeBox.nodeOffset + i] != null; i++)
			{
				TriangleMeshNode triangleMeshNode = array[bBTreeBox.nodeOffset + i];
				if (constraint == null || constraint.Suitable(triangleMeshNode))
				{
					Int3 constClampedPosition = triangleMeshNode.ClosestPointOnNodeXZ(p);
					long num = (constClampedPosition.x - p.x) * (constClampedPosition.x - p.x) + (constClampedPosition.z - p.z) * (constClampedPosition.z - p.z);
					if (nnInfo.constrainedNode == null || (float)num < (float)closestSqrDist - 1E-06f || ((float)num <= (float)closestSqrDist + 1E-06f && Mathf.Abs(constClampedPosition.y - p.y) < Mathf.Abs(nnInfo.constClampedPosition.y - p.y)))
					{
						nnInfo.constrainedNode = triangleMeshNode;
						nnInfo.constClampedPosition = constClampedPosition;
						closestSqrDist = num;
					}
				}
			}
		}
		else
		{
			int first = bBTreeBox.left;
			int second = bBTreeBox.right;
			GetOrderedChildren(ref first, ref second, out var firstDist, out var secondDist, p);
			if (firstDist <= closestSqrDist)
			{
				SearchBoxClosestXZ(first, p, ref closestSqrDist, constraint, ref nnInfo);
			}
			if (secondDist <= closestSqrDist)
			{
				SearchBoxClosestXZ(second, p, ref closestSqrDist, constraint, ref nnInfo);
			}
		}
	}

	public NNInfoInternal QueryClosest(Int3 p, NNConstraint constraint, ref long distance, NNInfoInternal previous)
	{
		long closestSqrDist = distance * distance;
		long num = closestSqrDist;
		if (count > 0 && SquaredRectPointDistance(tree[0].rect, p) < closestSqrDist)
		{
			SearchBoxClosest(0, p, ref closestSqrDist, constraint, ref previous);
			if (closestSqrDist < num)
			{
				distance = IntMath.Sqrt(closestSqrDist);
			}
		}
		return previous;
	}

	private void SearchBoxClosest(int boxi, Int3 p, ref long closestSqrDist, NNConstraint constraint, ref NNInfoInternal nnInfo)
	{
		BBTreeBox bBTreeBox = tree[boxi];
		if (bBTreeBox.IsLeaf)
		{
			TriangleMeshNode[] array = nodeLookup;
			for (int i = 0; i < 4 && array[bBTreeBox.nodeOffset + i] != null; i++)
			{
				TriangleMeshNode triangleMeshNode = array[bBTreeBox.nodeOffset + i];
				Int3 @int = triangleMeshNode.ClosestPointOnNode(p);
				long sqrMagnitudeLong = (@int - p).sqrMagnitudeLong;
				if (sqrMagnitudeLong < closestSqrDist && (constraint == null || constraint.Suitable(triangleMeshNode)))
				{
					nnInfo.constrainedNode = triangleMeshNode;
					nnInfo.constClampedPosition = @int;
					closestSqrDist = sqrMagnitudeLong;
				}
			}
		}
		else
		{
			int first = bBTreeBox.left;
			int second = bBTreeBox.right;
			GetOrderedChildren(ref first, ref second, out var firstDist, out var secondDist, p);
			if (firstDist < closestSqrDist)
			{
				SearchBoxClosest(first, p, ref closestSqrDist, constraint, ref nnInfo);
			}
			if (secondDist < closestSqrDist)
			{
				SearchBoxClosest(second, p, ref closestSqrDist, constraint, ref nnInfo);
			}
		}
	}

	private void GetOrderedChildren(ref int first, ref int second, out long firstDist, out long secondDist, Int3 p)
	{
		firstDist = SquaredRectPointDistance(tree[first].rect, p);
		secondDist = SquaredRectPointDistance(tree[second].rect, p);
		if (secondDist < firstDist)
		{
			int num = first;
			first = second;
			second = num;
			long num2 = firstDist;
			firstDist = secondDist;
			secondDist = num2;
		}
	}

	public TriangleMeshNode QueryInside(Int3 p, NNConstraint constraint)
	{
		if (count == 0 || !tree[0].Contains(p))
		{
			return null;
		}
		return SearchBoxInside(0, p, constraint);
	}

	private TriangleMeshNode SearchBoxInside(int boxi, Int3 p, NNConstraint constraint)
	{
		BBTreeBox bBTreeBox = tree[boxi];
		if (bBTreeBox.IsLeaf)
		{
			TriangleMeshNode[] array = nodeLookup;
			for (int i = 0; i < 4 && array[bBTreeBox.nodeOffset + i] != null; i++)
			{
				TriangleMeshNode triangleMeshNode = array[bBTreeBox.nodeOffset + i];
				if (triangleMeshNode.ContainsPoint(p) && (constraint == null || constraint.Suitable(triangleMeshNode)))
				{
					return triangleMeshNode;
				}
			}
		}
		else
		{
			if (tree[bBTreeBox.left].Contains(p))
			{
				TriangleMeshNode triangleMeshNode2 = SearchBoxInside(bBTreeBox.left, p, constraint);
				if (triangleMeshNode2 != null)
				{
					return triangleMeshNode2;
				}
			}
			if (tree[bBTreeBox.right].Contains(p))
			{
				TriangleMeshNode triangleMeshNode3 = SearchBoxInside(bBTreeBox.right, p, constraint);
				if (triangleMeshNode3 != null)
				{
					return triangleMeshNode3;
				}
			}
		}
		return null;
	}

	public void OnDrawGizmos()
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		Gizmos.color = new Color(1f, 1f, 1f, 0.5f);
		if (count != 0)
		{
			OnDrawGizmos(0, 0);
		}
	}

	private void OnDrawGizmos(int boxi, int depth)
	{
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		BBTreeBox bBTreeBox = tree[boxi];
		Vector3 val = (Vector3)new Int3(bBTreeBox.rect.xmin, 0, bBTreeBox.rect.ymin);
		Vector3 val2 = (Vector3)new Int3(bBTreeBox.rect.xmax, 0, bBTreeBox.rect.ymax);
		Vector3 val3 = (val + val2) * 0.5f;
		Vector3 val4 = (val2 - val3) * 2f;
		((Vector3)(ref val4))._002Ector(val4.x, 1f, val4.z);
		val3.y += depth * 2;
		Gizmos.color = AstarMath.IntToColor(depth, 1f);
		Gizmos.DrawCube(val3, val4);
		if (!bBTreeBox.IsLeaf)
		{
			OnDrawGizmos(bBTreeBox.left, depth + 1);
			OnDrawGizmos(bBTreeBox.right, depth + 1);
		}
	}

	private static bool NodeIntersectsCircle(TriangleMeshNode node, Int3 p, float radius)
	{
		if (float.IsPositiveInfinity(radius))
		{
			return true;
		}
		return (p - node.ClosestPointOnNode(p)).sqrMagnitude < radius * radius;
	}

	private static bool RectIntersectsCircle(IntRect r, Int3 p, Int radius)
	{
		if (int.MaxValue == radius.i)
		{
			return true;
		}
		Int3 @int = p;
		p.x = Math.Max(p.x, r.xmin);
		p.x = Math.Min(p.x, r.xmax);
		p.z = Math.Max(p.z, r.ymin);
		p.z = Math.Min(p.z, r.ymax);
		return (p.x - @int.x) * (p.x - @int.x) + (p.z - @int.z) * (p.z - @int.z) < radius.i * radius.i;
	}

	private static long SquaredRectPointDistance(IntRect r, Int3 p)
	{
		Int3 @int = p;
		p.x = Math.Max(p.x, r.xmin);
		p.x = Math.Min(p.x, r.xmax);
		p.z = Math.Max(p.z, r.ymin);
		p.z = Math.Min(p.z, r.ymax);
		return (p.x - @int.x) * (p.x - @int.x) + (p.z - @int.z) * (p.z - @int.z);
	}
}
