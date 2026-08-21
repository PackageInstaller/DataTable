using System.Collections.Generic;
using UnityEngine;

namespace SceneStreamer;

public class BvhSpace<T> where T : BvhObject
{
	public BvhNode<T> root { get; private set; }

	public void BuildBvh(List<T> sceneObjects, int depth, int type = 0)
	{
		root = new BvhNode<T>("root", null);
		foreach (T sceneObject in sceneObjects)
		{
			AABBData aABB = sceneObject.GetAABB();
			root.UnionAABB(aABB);
		}
		if (type == 0)
		{
			BinaryPartition(root, sceneObjects, 0, sceneObjects.Count, depth);
		}
		else
		{
			AxisPartition(root, sceneObjects, depth);
		}
	}

	private void AxisPartition(BvhNode<T> node, List<T> sceneObjects, int depth)
	{
		if (depth <= 0)
		{
			return;
		}
		BvhNode<T> bvhNode = new BvhNode<T>(node.name + "_leftKid_" + depth, null);
		BvhNode<T> bvhNode2 = new BvhNode<T>(node.name + "_rightKid_" + depth, null);
		List<T> list = new List<T>();
		List<T> list2 = new List<T>();
		switch (PickVariance(sceneObjects))
		{
		case 0:
		{
			float x = node.AABBData.center.x;
			foreach (T sceneObject in sceneObjects)
			{
				AABBData aABB3 = sceneObject.GetAABB();
				if (sceneObject.position.x <= x)
				{
					list.Add(sceneObject);
					bvhNode.UnionAABB(aABB3);
				}
				else
				{
					list2.Add(sceneObject);
					bvhNode2.UnionAABB(aABB3);
				}
			}
			break;
		}
		case 1:
		{
			float y = node.AABBData.center.y;
			foreach (T sceneObject2 in sceneObjects)
			{
				AABBData aABB2 = sceneObject2.GetAABB();
				if (sceneObject2.position.y <= y)
				{
					list.Add(sceneObject2);
					bvhNode.UnionAABB(aABB2);
				}
				else
				{
					list2.Add(sceneObject2);
					bvhNode2.UnionAABB(aABB2);
				}
			}
			break;
		}
		case 2:
		{
			float z = node.AABBData.center.z;
			foreach (T sceneObject3 in sceneObjects)
			{
				AABBData aABB = sceneObject3.GetAABB();
				if (sceneObject3.position.z <= z)
				{
					list.Add(sceneObject3);
					bvhNode.UnionAABB(aABB);
				}
				else
				{
					list2.Add(sceneObject3);
					bvhNode2.UnionAABB(aABB);
				}
			}
			break;
		}
		}
		node.SetLeaf(bvhNode, bvhNode2);
		AxisPartition(bvhNode, list, depth - 1);
		AxisPartition(bvhNode2, list2, depth - 1);
	}

	private void BinaryPartition(BvhNode<T> node, List<T> objs, int startIndex, int endIndex, int depth)
	{
		if (depth > 0)
		{
			int num = (endIndex + startIndex) / 2;
			BvhNode<T> bvhNode = new BvhNode<T>(node.name + "_leftKid_" + depth, null);
			BvhNode<T> bvhNode2 = new BvhNode<T>(node.name + "_rightKid_" + depth, null);
			for (int i = startIndex; i < num; i++)
			{
				AABBData aABB = objs[i].GetAABB();
				bvhNode.UnionAABB(aABB);
			}
			for (int j = num; j < endIndex; j++)
			{
				AABBData aABB2 = objs[j].GetAABB();
				bvhNode2.UnionAABB(aABB2);
			}
			node.SetLeaf(bvhNode, bvhNode2);
			BinaryPartition(bvhNode, objs, startIndex, num, depth - 1);
			BinaryPartition(bvhNode2, objs, num, endIndex, depth - 1);
		}
	}

	private int PickVariance(List<T> sceneObjects)
	{
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		foreach (T sceneObject in sceneObjects)
		{
			Vector3 position = sceneObject.position;
			num += position.x;
			num2 += position.y;
			num3 += position.z;
		}
		num /= (float)sceneObjects.Count;
		num2 /= (float)sceneObjects.Count;
		num3 /= (float)sceneObjects.Count;
		float num4 = 0f;
		float num5 = 0f;
		float num6 = 0f;
		foreach (T sceneObject2 in sceneObjects)
		{
			Vector3 position2 = sceneObject2.position;
			num4 += Mathf.Pow(position2.x - num, 2f);
			num5 += Mathf.Pow(position2.y - num2, 2f);
			num6 += Mathf.Pow(position2.z - num3, 2f);
		}
		num4 /= (float)(sceneObjects.Count - 1);
		num5 /= (float)(sceneObjects.Count - 1);
		num6 /= (float)(sceneObjects.Count - 1);
		if (num4 > num5 && num4 > num6)
		{
			return 0;
		}
		if (num5 > num6 && num5 > num4)
		{
			return 1;
		}
		if (num6 > num4 && num6 > num5)
		{
			return 2;
		}
		return 0;
	}
}
