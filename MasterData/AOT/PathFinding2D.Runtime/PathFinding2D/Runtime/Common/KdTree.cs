using System;
using System.Collections.Generic;
using PathFinding2D.Runtime.Models;
using UnityEngine;

namespace PathFinding2D.Runtime.Common;

public class KdTree
{
	private KdTreeNode root;

	private int size;

	public KdTree(List<Waypoint> points)
	{
		if (points != null && points.Count > 0)
		{
			root = BuildTree(points, 0);
			size = points.Count;
		}
	}

	private KdTreeNode BuildTree(List<Waypoint> points, int depth)
	{
		if (points.Count == 0)
		{
			return null;
		}
		int axis = depth % 3;
		points.Sort((Waypoint a, Waypoint b) => a.Position[axis].CompareTo(b.Position[axis]));
		int num = points.Count / 2;
		KdTreeNode kdTreeNode = new KdTreeNode(points[num]);
		List<Waypoint> range = points.GetRange(0, num);
		List<Waypoint> range2 = points.GetRange(num + 1, points.Count - num - 1);
		kdTreeNode.left = BuildTree(range, depth + 1);
		kdTreeNode.right = BuildTree(range2, depth + 1);
		return kdTreeNode;
	}

	public Waypoint FindNearest(Waypoint target)
	{
		if (root == null)
		{
			throw new InvalidOperationException("Tree is empty");
		}
		return FindNearest(root, target, 0).point;
	}

	private KdTreeNode FindNearest(KdTreeNode kdTreeNode, Waypoint target, int depth)
	{
		if (kdTreeNode == null)
		{
			return null;
		}
		int index = depth % 3;
		KdTreeNode kdTreeNode2;
		KdTreeNode kdTreeNode3;
		if (target.Position[index] < kdTreeNode.point.Position[index])
		{
			kdTreeNode2 = kdTreeNode.left;
			kdTreeNode3 = kdTreeNode.right;
		}
		else
		{
			kdTreeNode2 = kdTreeNode.right;
			kdTreeNode3 = kdTreeNode.left;
		}
		KdTreeNode kdTreeNode4 = kdTreeNode;
		KdTreeNode kdTreeNode5 = FindNearest(kdTreeNode2, target, depth + 1);
		if (kdTreeNode5 != null && SqrDistance(kdTreeNode5.point.Position, target.Position) < SqrDistance(kdTreeNode4.point.Position, target.Position))
		{
			kdTreeNode4 = kdTreeNode5;
		}
		float num = SqrDistance(kdTreeNode4.point.Position, target.Position);
		float num2 = target.Position[index] - kdTreeNode.point.Position[index];
		if (num2 * num2 < num)
		{
			kdTreeNode5 = FindNearest(kdTreeNode3, target, depth + 1);
			if (kdTreeNode5 != null && SqrDistance(kdTreeNode5.point.Position, target.Position) < num)
			{
				kdTreeNode4 = kdTreeNode5;
			}
		}
		return kdTreeNode4;
	}

	private float SqrDistance(Vector3 a, Vector3 b)
	{
		return (a - b).sqrMagnitude;
	}
}
