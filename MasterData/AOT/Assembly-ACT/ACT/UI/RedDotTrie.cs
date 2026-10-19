using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class RedDotTrie
{
	public char pathSeparator = '|';

	public RedDotTrieNode rootNode;

	public Dictionary<string, RedDotTrieNode> allNodeDic;

	public RedDotTrie()
	{
		allNodeDic = new Dictionary<string, RedDotTrieNode>();
		rootNode = RedDotTrieNodePool.Get();
		rootNode.Init("Root", null, this, 0, "Root");
		allNodeDic[rootNode.CompletePath] = rootNode;
	}

	public RedDotTrieNode GetNode(string nodeFullPath)
	{
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("节点查找路径为空，无法查找");
			}
			return null;
		}
		if (allNodeDic == null || !allNodeDic.TryGetValue(nodeFullPath, out var value))
		{
			return null;
		}
		return value;
	}

	public RedDotTrieNode GetNode(string[] nodeFullPathArray)
	{
		RedDotTrieNode childNode = rootNode;
		for (int i = 0; i < nodeFullPathArray.Length; i++)
		{
			childNode = childNode.GetChildNode(nodeFullPathArray[i]);
			if (childNode == null)
			{
				break;
			}
		}
		return childNode;
	}

	public RedDotTrieNode GetNode(List<string> nodeFullPathList)
	{
		RedDotTrieNode childNode = rootNode;
		for (int i = 0; i < nodeFullPathList.Count; i++)
		{
			childNode = childNode.GetChildNode(nodeFullPathList[i]);
			if (childNode == null)
			{
				break;
			}
		}
		return childNode;
	}

	public RedDotTrieNode AddNode(string nodeFullPath)
	{
		if (GetNode(nodeFullPath) != null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("已经有了同名节点 " + nodeFullPath);
			}
			return GetNode(nodeFullPath);
		}
		string[] nodeFullPathArray = nodeFullPath.Split(pathSeparator);
		return AddNode(nodeFullPathArray, nodeFullPath);
	}

	public RedDotTrieNode AddNode(string[] nodeFullPathArray, string nodeFullPath)
	{
		RedDotTrieNode redDotTrieNode = rootNode;
		string text = "";
		foreach (string text2 in nodeFullPathArray)
		{
			text = (string.IsNullOrEmpty(text) ? (text + text2) : (text + "|" + text2));
			redDotTrieNode = ((!redDotTrieNode.ContainChildNode(text2)) ? redDotTrieNode.AddChildNode(text2, text) : redDotTrieNode.GetChildNode(text2));
			allNodeDic[text] = redDotTrieNode;
		}
		return redDotTrieNode;
	}

	public void RemoveNode(string nodeFullPath)
	{
		if (string.IsNullOrEmpty(nodeFullPath))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("节点删除路径为空，无法删除");
			}
			return;
		}
		RedDotTrieNode node = GetNode(nodeFullPath);
		if (node == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("这个路径查不到节点，无法删除");
			}
		}
		else if (node.isRoot)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("不能删除根节点，无法删除");
			}
		}
		else if (node.isLeaf)
		{
			node.RemoveSelf();
		}
		else
		{
			node.RemoveSelfAndAllChildNode();
		}
	}

	public void RemoveNode(string[] nodeFullPathArray)
	{
		if (nodeFullPathArray == null || nodeFullPathArray.Length == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("节点删除路径为空，无法删除");
			}
			return;
		}
		RedDotTrieNode node = GetNode(nodeFullPathArray);
		if (node == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("这个路径查不到节点，无法删除");
			}
		}
		else if (node.isRoot)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("不能删除根节点，无法删除");
			}
		}
		else if (node.isLeaf)
		{
			node.RemoveSelf();
		}
		else
		{
			node.RemoveSelfAndAllChildNode();
		}
	}

	public void SetLeafNodeActive(string nodeFullPath, bool active)
	{
		RedDotTrieNode redDotTrieNode = GetNode(nodeFullPath);
		if (redDotTrieNode == null)
		{
			redDotTrieNode = AddNode(nodeFullPath);
		}
		if (redDotTrieNode.isLeaf)
		{
			redDotTrieNode.SetActiveBySelf(active);
			while (redDotTrieNode.parent != null)
			{
				redDotTrieNode.parent.SetActiveByChild();
				redDotTrieNode = redDotTrieNode.parent;
			}
		}
	}

	public bool LeafNodeIsActive(string nodeFullPath)
	{
		RedDotTrieNode node = GetNode(nodeFullPath);
		if (node == null)
		{
			AddNode(nodeFullPath);
			return false;
		}
		if (node.isLeaf)
		{
			return node.isActive;
		}
		return false;
	}

	public bool NodeIsActive(string nodeFullPath)
	{
		RedDotTrieNode node = GetNode(nodeFullPath);
		if (node == null)
		{
			AddNode(nodeFullPath);
			return false;
		}
		return node.isActive;
	}
}
