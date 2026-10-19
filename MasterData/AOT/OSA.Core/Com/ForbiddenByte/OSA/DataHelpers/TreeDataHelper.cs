using System;
using System.Collections.Generic;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.CustomAdapters.Tree;

namespace Com.ForbiddenByte.OSA.DataHelpers;

public class TreeDataHelper<T> where T : class, ITreeNodeModel
{
	protected IOSA _adapter;

	private RootTreeNodeModel _rootNode;

	private List<ITreeNodeModel> FlattenedVisibleNode { get; set; }

	public int ShowCount => FlattenedVisibleNode.Count;

	public ITreeNodeModel this[int index]
	{
		get
		{
			if (index < 0 || index >= FlattenedVisibleNode.Count)
			{
				return null;
			}
			return FlattenedVisibleNode[index];
		}
	}

	public TreeDataHelper(IOSA adapter)
	{
		_adapter = adapter;
		_rootNode = new RootTreeNodeModel();
		FlattenedVisibleNode = new List<ITreeNodeModel>();
	}

	public void ResetItems()
	{
		ResetVisibleNode();
		_adapter.ResetItems(FlattenedVisibleNode.Count);
	}

	private void ResetVisibleNode()
	{
		FlattenedVisibleNode.Clear();
		foreach (ITreeNodeModel child in _rootNode.Children)
		{
			InnerResetVisibleNode(child as T);
		}
	}

	private void InnerResetVisibleNode(T node)
	{
		if (node == null)
		{
			return;
		}
		FlattenedVisibleNode.Add(node);
		if (!node.Expanded)
		{
			return;
		}
		foreach (ITreeNodeModel child in node.Children)
		{
			T node2 = child as T;
			InnerResetVisibleNode(node2);
		}
	}

	public void AddTreeNode(T parent, T newNode, int indexInParent)
	{
		if (parent == null)
		{
			_rootNode.Children.Insert(indexInParent, newNode);
			newNode.Parent = _rootNode;
			newNode.Depth = _rootNode.Depth + 1;
		}
		else
		{
			parent.Children.Insert(indexInParent, newNode);
			newNode.Parent = parent;
			newNode.Depth = parent.Depth + 1;
		}
		newNode.Expanded = false;
	}

	public void Expand(T node)
	{
		if (node == null || node.Expanded)
		{
			return;
		}
		List<ITreeNodeModel> children = node.Children;
		if (children == null || children.Count <= 0)
		{
			return;
		}
		node.Expanded = true;
		int num = FlattenedVisibleNode.IndexOf(node);
		int num2 = num + 1;
		foreach (ITreeNodeModel child in node.Children)
		{
			FlattenedVisibleNode.Insert(num2, child);
			num2++;
		}
		_adapter.InsertItems(num + 1, node.Children.Count);
		_adapter.BringToView(num + 1);
	}

	public void Collapse(T node)
	{
		if (node == null || !node.Expanded)
		{
			return;
		}
		node.Expanded = false;
		int num = FlattenedVisibleNode.IndexOf(node) + 1;
		int i = num;
		for (int count = FlattenedVisibleNode.Count; i < count; i++)
		{
			ITreeNodeModel treeNodeModel = FlattenedVisibleNode[i];
			if (treeNodeModel.Depth <= node.Depth)
			{
				break;
			}
			treeNodeModel.Expanded = false;
		}
		int num2 = i - num;
		if (num2 > 0)
		{
			FlattenedVisibleNode.RemoveRange(num, num2);
			_adapter.RemoveItems(num, num2);
		}
	}

	public T GetNode(Predicate<T> p)
	{
		return InnerGetNode(p, _rootNode);
	}

	private T InnerGetNode(Predicate<T> p, ITreeNodeModel node)
	{
		if (node == null)
		{
			return null;
		}
		if (p(node as T))
		{
			return node as T;
		}
		T val = null;
		foreach (ITreeNodeModel child in node.Children)
		{
			val = InnerGetNode(p, child);
			if (val != null)
			{
				return val;
			}
		}
		return val;
	}

	public int GetIndexInVisible(T node)
	{
		for (int i = 0; i < FlattenedVisibleNode.Count; i++)
		{
			if (FlattenedVisibleNode[i] == node)
			{
				return i;
			}
		}
		return -1;
	}
}
