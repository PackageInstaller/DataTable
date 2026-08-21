#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace SceneStreamer;

public class DynamicBvhSpace<T> where T : BvhObject
{
	private List<BvhNode<T>> leafs;

	private int generateCount;

	public Dictionary<T, BvhNode<T>> gameObjectToNode;

	public BvhNode<T> root { get; private set; }

	public DynamicBvhSpace()
	{
		leafs = new List<BvhNode<T>>();
		gameObjectToNode = new Dictionary<T, BvhNode<T>>();
	}

	public BvhNode<T> AddNode(T go)
	{
		BvhNode<T> bvhNode = new BvhNode<T>("node_" + generateCount, go);
		RecordGameobject(bvhNode);
		BuildBvh(bvhNode);
		generateCount++;
		return bvhNode;
	}

	public bool RemoveNode(T go)
	{
		if (gameObjectToNode.TryGetValue(go, out var value))
		{
			leafs.Remove(value);
			leafs.Remove(value.GetSibling());
			BvhNode<T> bvhNode = BvhNode<T>.SeparateNodes(value);
			if (bvhNode.isLeaf)
			{
				leafs.Add(bvhNode);
				RecordGameobject(bvhNode);
			}
			return true;
		}
		return false;
	}

	public void UpdateNode(T go)
	{
		if (RemoveNode(go))
		{
			AddNode(go);
		}
	}

	public void BuildBvh(BvhNode<T> leaf)
	{
		if (root == null)
		{
			root = leaf;
			leafs.Add(leaf);
			return;
		}
		BvhNode<T> bvhNode = SAH(leaf);
		if (bvhNode != null)
		{
			leafs.Remove(bvhNode);
			BvhNode<T> bvhNode2 = BvhNode<T>.CombineNodes(bvhNode, leaf);
			leafs.Add(leaf);
			leafs.Add(bvhNode2);
			RecordGameobject(bvhNode2);
			root = bvhNode2.FindRoot();
		}
		else
		{
			Log.Error("SAH 未找到合适的node");
		}
	}

	private void RecordGameobject(BvhNode<T> node)
	{
		T bvhObject = node.bvhObject;
		if (bvhObject != null)
		{
			if (gameObjectToNode.ContainsKey(bvhObject))
			{
				gameObjectToNode[bvhObject] = node;
			}
			else
			{
				gameObjectToNode.Add(bvhObject, node);
			}
		}
	}

	private BvhNode<T> SAH(BvhNode<T> newLeaf)
	{
		float num = float.MaxValue;
		BvhNode<T> result = null;
		foreach (BvhNode<T> leaf in leafs)
		{
			float surfaceArea = leaf.AABBData.Union(newLeaf.AABBData).surfaceArea;
			float num2 = surfaceArea;
			for (BvhNode<T> parent = leaf.parent; parent != null; parent = parent.parent)
			{
				float surfaceArea2 = parent.surfaceArea;
				surfaceArea = parent.AABBData.Union(newLeaf.AABBData).surfaceArea - surfaceArea2;
				num2 += surfaceArea;
			}
			if (num2 < num)
			{
				result = leaf;
				num = num2;
			}
		}
		return result;
	}
}
