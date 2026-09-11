using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public class Funnel
{
	public struct FunnelPortals
	{
		public List<Int3> left;

		public List<Int3> right;
	}

	public struct PathPart
	{
		public int startIndex;

		public int endIndex;

		public Int3 startPoint;

		public Int3 endPoint;

		public bool isLink;
	}

	public static List<PathPart> SplitIntoParts(Path path)
	{
		List<GraphNode> path2 = path.path;
		List<PathPart> list = ListPool<PathPart>.Claim();
		if (path2 == null || path2.Count == 0)
		{
			return list;
		}
		int i;
		for (i = 0; i < path2.Count; i++)
		{
			if (path2[i] is TriangleMeshNode || path2[i] is GridNodeBase)
			{
				PathPart item = new PathPart
				{
					startIndex = i
				};
				for (uint graphIndex = path2[i].GraphIndex; i < path2.Count && (path2[i].GraphIndex == graphIndex || path2[i] is NodeLink3Node); i++)
				{
				}
				i = (item.endIndex = i - 1);
				if (item.startIndex == 0)
				{
					item.startPoint = path.int3Path[0];
				}
				else
				{
					item.startPoint = path2[item.startIndex - 1].position;
				}
				if (item.endIndex == path2.Count - 1)
				{
					item.endPoint = path.int3Path[path.int3Path.Count - 1];
				}
				else
				{
					item.endPoint = path2[item.endIndex + 1].position;
				}
				list.Add(item);
			}
			else
			{
				if (NodeLink2.GetNodeLink(path2[i]) == null)
				{
					throw new Exception("Unsupported node type or null node");
				}
				PathPart item2 = new PathPart
				{
					startIndex = i
				};
				uint graphIndex2 = path2[i].GraphIndex;
				for (i++; i < path2.Count && path2[i].GraphIndex == graphIndex2; i++)
				{
				}
				i--;
				if (i - item2.startIndex != 0)
				{
					if (i - item2.startIndex != 1)
					{
						throw new Exception("NodeLink2 link length greater than two (2) nodes. " + (i - item2.startIndex + 1));
					}
					item2.endIndex = i;
					item2.isLink = true;
					item2.startPoint = path2[item2.startIndex].position;
					item2.endPoint = path2[item2.endIndex].position;
					list.Add(item2);
				}
			}
		}
		return list;
	}

	public static FunnelPortals ConstructFunnelPortals(List<GraphNode> nodes, PathPart part)
	{
		List<Int3> list = ListPool<Int3>.Claim(nodes.Count + 1);
		List<Int3> list2 = ListPool<Int3>.Claim(nodes.Count + 1);
		if (nodes == null || nodes.Count == 0)
		{
			return new FunnelPortals
			{
				left = list,
				right = list2
			};
		}
		if (part.endIndex < part.startIndex || part.startIndex < 0 || part.endIndex > nodes.Count)
		{
			throw new ArgumentOutOfRangeException();
		}
		list.Add(part.startPoint);
		list2.Add(part.startPoint);
		for (int i = part.startIndex; i < part.endIndex - 1; i++)
		{
			if (!nodes[i].GetPortal(nodes[i + 1], list, list2, backwards: false))
			{
				list.Add(nodes[i].position);
				list2.Add(nodes[i].position);
				list.Add(nodes[i + 1].position);
				list2.Add(nodes[i + 1].position);
			}
		}
		list.Add(part.endPoint);
		list2.Add(part.endPoint);
		return new FunnelPortals
		{
			left = list,
			right = list2
		};
	}

	public static void ShrinkPortals(FunnelPortals portals, Int shrink)
	{
		if (shrink <= 0)
		{
			return;
		}
		for (int i = 0; i < portals.left.Count; i++)
		{
			Int3 @int = portals.left[i];
			Int3 int2 = portals.right[i];
			Int intMagnitude = (@int - int2).IntMagnitude;
			if (intMagnitude > 0)
			{
				VFactor vFactor = IntMath.Min(new VFactor(shrink.i, intMagnitude.i), new VFactor(4L, 10L));
				portals.left[i] = IntMath.Lerp(@int, int2, vFactor);
				portals.right[i] = IntMath.Lerp(@int, int2, VFactor.one - vFactor);
			}
		}
	}

	private static bool UnwrapHelper(Int3 portalStart, Int3 portalEnd, Int3 prevPoint, Int3 nextPoint, ref SimQuaternion mRot, ref Int3 mOffset)
	{
		if (VectorMath.IsColinear((Int2)portalStart, (Int2)portalEnd, (Int2)nextPoint))
		{
			return false;
		}
		Int3 @int = portalEnd - portalStart;
		long sqrMagnitudeLong = @int.sqrMagnitudeLong;
		prevPoint -= @int * new VFactor(Int3.Dot(prevPoint - portalStart, @int), sqrMagnitudeLong);
		nextPoint -= @int * new VFactor(Int3.Dot(nextPoint - portalStart, @int), sqrMagnitudeLong);
		SimQuaternion simQuaternion = SimQuaternion.FromToRotation(nextPoint - portalStart, portalStart - prevPoint);
		mOffset += mRot * (portalStart - simQuaternion * portalStart);
		mRot *= simQuaternion;
		return true;
	}

	public static void Unwrap(FunnelPortals funnel, Int2[] left, Int2[] right)
	{
		Int3 @int = Int3.Cross(funnel.right[1] - funnel.left[0], funnel.left[1] - funnel.left[0]);
		left[0] = (right[0] = Int2.zero);
		Int3 int2 = funnel.left[1];
		Int3 int3 = funnel.right[1];
		Int3 prevPoint = funnel.left[0];
		Debug.Log((object)("normal ============ " + @int));
		SimQuaternion mRot = SimQuaternion.FromToRotation(@int, Int3.forward);
		Int3 mOffset = mRot * -funnel.right[0];
		for (int i = 1; i < funnel.left.Count; i++)
		{
			if (UnwrapHelper(int2, int3, prevPoint, funnel.left[i], ref mRot, ref mOffset))
			{
				prevPoint = int2;
				int2 = funnel.left[i];
			}
			left[i] = mRot * funnel.left[i] + mOffset;
			if (UnwrapHelper(int2, int3, prevPoint, funnel.right[i], ref mRot, ref mOffset))
			{
				prevPoint = int3;
				int3 = funnel.right[i];
			}
			right[i] = mRot * funnel.right[i] + mOffset;
		}
	}

	private static int FixFunnel(ref Int2[] left, ref Int2[] right)
	{
		if (left.Length != right.Length)
		{
			throw new ArgumentException("left and right lists must have equal length");
		}
		if (left.Length < 3)
		{
			return -1;
		}
		int num = 0;
		while (left[1] == left[2] && right[1] == right[2])
		{
			left[1] = left[0];
			right[1] = right[0];
			num++;
			if (left.Length - num < 3)
			{
				return -1;
			}
		}
		Int2 @int = left[num + 2];
		if (@int == left[num + 1])
		{
			@int = right[num + 2];
		}
		while (VectorMath.IsColinear(left[num], left[num + 1], right[num + 1]) || VectorMath.RightOrColinear(left[num + 1], right[num + 1], @int) == VectorMath.RightOrColinear(left[num + 1], right[num + 1], left[num]))
		{
			left[num + 1] = left[num];
			right[num + 1] = right[num];
			num++;
			if (left.Length - num < 3)
			{
				return -1;
			}
			@int = left[num + 2];
			if (@int == left[num + 1])
			{
				@int = right[num + 2];
			}
		}
		if (!VectorMath.RightOrColinear(left[num], left[num + 1], right[num + 1]) && !VectorMath.IsColinear(left[num], left[num + 1], right[num + 1]))
		{
			Int2[] array = left;
			left = right;
			right = array;
		}
		return num;
	}

	protected static Vector2 ToXZ(Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		return new Vector2(p.x, p.z);
	}

	protected static Int2 ToXZ(Int3 p)
	{
		return new Int2(p.x, p.z);
	}

	protected static Vector3 FromXZ(Vector2 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3(p.x, 0f, p.y);
	}

	protected static Int3 FromXZ(Int2 p)
	{
		return new Int3(p.x, 0, p.y);
	}

	protected static bool RightOrColinear(Vector2 a, Vector2 b)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		return a.x * b.y - b.x * a.y <= 0f;
	}

	protected static bool RightOrColinear(Int2 a, Int2 b)
	{
		return a.x * b.y - b.x * a.y <= 0;
	}

	protected static bool LeftOrColinear(Vector2 a, Vector2 b)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		return a.x * b.y - b.x * a.y >= 0f;
	}

	protected static bool LeftOrColinear(Int2 a, Int2 b)
	{
		return a.x * b.y - b.x * a.y >= 0;
	}

	public static List<Int3> Calculate(FunnelPortals funnel, bool unwrap, bool splitAtEveryPortal)
	{
		Int2[] left = new Int2[funnel.left.Count];
		Int2[] right = new Int2[funnel.left.Count];
		if (unwrap)
		{
			Unwrap(funnel, left, right);
		}
		else
		{
			for (int i = 0; i < left.Length; i++)
			{
				left[i] = ToXZ(funnel.left[i]);
				right[i] = ToXZ(funnel.right[i]);
			}
		}
		Int2[] array = left;
		int num = FixFunnel(ref left, ref right);
		List<Int3> list = funnel.left;
		List<Int3> list2 = funnel.right;
		if (array != left)
		{
			list = funnel.right;
			list2 = funnel.left;
		}
		List<int> list3 = ListPool<int>.Claim();
		if (num == -1)
		{
			list3.Add(0);
			list3.Add(funnel.left.Count - 1);
		}
		else
		{
			Calculate(left, right, num, list3, int.MaxValue, out var _);
		}
		List<Int3> list4 = ListPool<Int3>.Claim(list3.Count);
		Int2 p = left[0];
		int num2 = 0;
		for (int j = 0; j < list3.Count; j++)
		{
			int num3 = list3[j];
			if (splitAtEveryPortal)
			{
				Int2 @int = ((num3 >= 0) ? left[num3] : right[-num3]);
				for (int k = num2 + 1; k < Math.Abs(num3); k++)
				{
					VFactor f = VectorMath.LineIntersectionFactorXZ(FromXZ(left[k]), FromXZ(right[k]), FromXZ(p), FromXZ(@int));
					list4.Add(IntMath.Lerp(list[k], list2[k], f));
				}
				num2 = Mathf.Abs(num3);
				p = @int;
			}
			if (num3 >= 0)
			{
				list4.Add(list[num3]);
			}
			else
			{
				list4.Add(list2[-num3]);
			}
		}
		ListPool<Int3>.Release(funnel.left);
		ListPool<Int3>.Release(funnel.right);
		ListPool<int>.Release(list3);
		return list4;
	}

	private static void Calculate(Int2[] left, Int2[] right, int startIndex, List<int> funnelPath, int maxCorners, out bool lastCorner)
	{
		if (left.Length != right.Length)
		{
			throw new ArgumentException();
		}
		lastCorner = false;
		int num = startIndex;
		int num2 = startIndex + 1;
		int num3 = startIndex + 1;
		Int2 @int = left[num];
		Int2 int2 = left[num3];
		Int2 int3 = right[num2];
		funnelPath.Add(num);
		for (int i = startIndex + 2; i < left.Length; i++)
		{
			if (funnelPath.Count >= maxCorners)
			{
				return;
			}
			if (funnelPath.Count > 2000)
			{
				Debug.LogWarning((object)"Avoiding infinite loop. Remove this check if you have this long paths.");
				break;
			}
			Int2 int4 = left[i];
			Int2 int5 = right[i];
			if (LeftOrColinear(int3 - @int, int5 - @int))
			{
				if (!(@int == int3) && !RightOrColinear(int2 - @int, int5 - @int))
				{
					@int = (int3 = int2);
					i = (num = (num2 = num3));
					funnelPath.Add(num);
					continue;
				}
				int3 = int5;
				num2 = i;
			}
			if (RightOrColinear(int2 - @int, int4 - @int))
			{
				if (@int == int2 || LeftOrColinear(int3 - @int, int4 - @int))
				{
					int2 = int4;
					num3 = i;
				}
				else
				{
					@int = (int2 = int3);
					i = (num = (num3 = num2));
					funnelPath.Add(-num);
				}
			}
		}
		lastCorner = true;
		funnelPath.Add(left.Length - 1);
	}
}
