#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using UnityEngine;

namespace SceneStreamer;

public class BvhNode<T> where T : BvhObject
{
	public BvhNode<T> parent;

	private Color spaceColor;

	public BvhNode<T> leftNode { get; private set; }

	public BvhNode<T> rightNode { get; private set; }

	public T bvhObject { get; private set; }

	public AABBData AABBData { get; private set; }

	public string name { get; private set; }

	public float surfaceArea => AABBData.surfaceArea;

	public bool isLeaf => bvhObject != null;

	public BvhNode(string name, T obj)
	{
		BindSceneObject(obj);
		InitialAABB();
		this.name = name;
		spaceColor = Color.cyan;
	}

	public void BindSceneObject(T obj)
	{
		bvhObject = obj;
	}

	public void SetLeaf(BvhNode<T> left, BvhNode<T> right)
	{
		leftNode = left;
		rightNode = right;
		if (left != null)
		{
			left.parent = this;
		}
		if (right != null)
		{
			right.parent = this;
		}
		bvhObject = null;
	}

	public void InitialAABB()
	{
		ResetAABB();
		if (bvhObject != null)
		{
			AABBData aABB = bvhObject.GetAABB();
			UnionAABB(aABB);
		}
	}

	public void ResetAABB()
	{
		AABBData = AABBData.Reset();
	}

	public void UnionAABB(AABBData another)
	{
		AABBData = AABBData.Union(another);
	}

	public void SetActive(bool value)
	{
		spaceColor = (value ? Color.green : Color.cyan);
	}

	public void DrawEndDepth()
	{
		if (leftNode == null && rightNode == null)
		{
			DrawGizmos();
			return;
		}
		rightNode?.DrawEndDepth();
		leftNode?.DrawEndDepth();
	}

	public void DrawDepth(int depth)
	{
		if (depth != 0)
		{
			DrawGizmos();
			rightNode?.DrawDepth(depth - 1);
			leftNode?.DrawDepth(depth - 1);
		}
	}

	public void DrawTargetDepth(int depth)
	{
		if (depth <= 0)
		{
			DrawGizmos();
			return;
		}
		rightNode?.DrawTargetDepth(depth - 1);
		leftNode?.DrawTargetDepth(depth - 1);
	}

	public void DrawGizmos()
	{
		if (!Application.isEditor)
		{
			Gizmos.color = spaceColor;
			Gizmos.DrawWireCube(AABBData.center, AABBData.size);
			Gizmos.DrawSphere(AABBData.minCorner, 0.1f);
			Gizmos.DrawSphere(AABBData.maxCorner, 0.1f);
		}
	}

	public BvhNode(BvhNode<T> source)
	{
		AABBData = source.AABBData;
		leftNode = source.leftNode;
		rightNode = source.rightNode;
		bvhObject = source.bvhObject;
		spaceColor = new Color(Random.value, Random.value, Random.value, 0.9f);
		name = source.name + "copied";
	}

	public BvhNode<T> GetSibling()
	{
		return parent?.GetTheOhterNode(this);
	}

	public BvhNode<T> GetTheOhterNode(BvhNode<T> separatetNode)
	{
		if (leftNode == separatetNode)
		{
			return rightNode;
		}
		if (rightNode == separatetNode)
		{
			return leftNode;
		}
		return null;
	}

	public BvhNode<T> FindRoot()
	{
		if (parent != null)
		{
			return parent.FindRoot();
		}
		return this;
	}

	public static BvhNode<T> CombineNodes(BvhNode<T> targetNode, BvhNode<T> insertNode)
	{
		BvhNode<T> bvhNode = new BvhNode<T>(targetNode);
		targetNode.UnionAABB(insertNode.AABBData);
		targetNode.AABBBroadCast();
		targetNode.SetLeaf(bvhNode, insertNode);
		return bvhNode;
	}

	public bool Contains(BvhNode<T> node)
	{
		if (leftNode != node)
		{
			return rightNode == node;
		}
		return true;
	}

	public bool Contains(Vector3 position)
	{
		Vector3 vector = AABBData.size * 0.5f;
		if (Mathf.Abs(position.x - AABBData.center.x) <= vector.x && Mathf.Abs(position.y - AABBData.center.y) <= vector.y)
		{
			return Mathf.Abs(position.z - AABBData.center.z) <= vector.z;
		}
		return false;
	}

	public bool Contains(AABBData other)
	{
		return IsIntersect(other);
	}

	public bool IsIntersect(AABBData other)
	{
		return AABBData.IsIntersect(other);
	}

	public void SetAABB(AABBData aabbData)
	{
		AABBData = aabbData;
	}

	public void UpdateAABB()
	{
		ResetAABB();
		if (leftNode != null)
		{
			UnionAABB(leftNode.AABBData);
		}
		if (rightNode != null)
		{
			UnionAABB(rightNode.AABBData);
		}
	}

	public void AABBBroadCast()
	{
		if (parent != null)
		{
			parent.UpdateAABB();
			parent.AABBBroadCast();
		}
	}

	public void RestActiveState()
	{
		SetActive(value: false);
		if (leftNode != null)
		{
			leftNode.RestActiveState();
		}
		if (rightNode != null)
		{
			rightNode.RestActiveState();
		}
	}

	public static BvhNode<T> SeparateNodes(BvhNode<T> separatetNode)
	{
		BvhNode<T> bvhNode = separatetNode.parent;
		if (bvhNode != null && bvhNode.Contains(separatetNode))
		{
			BvhNode<T> sibling = separatetNode.GetSibling();
			AABBData aABBData = sibling.AABBData;
			bvhNode.SetLeaf(sibling.leftNode, sibling.rightNode);
			bvhNode.SetAABB(aABBData);
			bvhNode.AABBBroadCast();
			bvhNode.BindSceneObject(sibling.bvhObject);
			return bvhNode;
		}
		Log.Error("分离节点失败，目标节点父级为null或者父级不含有目标节点");
		return null;
	}
}
