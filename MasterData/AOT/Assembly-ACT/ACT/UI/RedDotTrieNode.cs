using System.Collections.Generic;
using System.Linq;
using Fundamental;

namespace ACT.UI;

public class RedDotTrieNode
{
	public string nodeName;

	public bool isActive;

	public RedDotTrieNode parent;

	public RedDotTrie ownerTree;

	public int depth;

	public Dictionary<string, RedDotTrieNode> childNodeDic;

	public string CompletePath;

	public List<RedDotItem> itemList;

	public int childCount => childNodeDic.Count;

	public int ActiveChildCount
	{
		get
		{
			Dictionary<string, RedDotTrieNode> dictionary = childNodeDic;
			if (dictionary == null)
			{
				return 0;
			}
			return Enumerable.Count(dictionary, (KeyValuePair<string, RedDotTrieNode> x) => x.Key != "Root" && x.Value.isActive);
		}
	}

	public bool isLeaf
	{
		get
		{
			if (childNodeDic != null)
			{
				return childNodeDic.Count == 0;
			}
			return true;
		}
	}

	public bool isRoot => parent == null;

	public RedDotTrieNode()
	{
		childNodeDic = new Dictionary<string, RedDotTrieNode>();
		itemList = new List<RedDotItem>();
	}

	public void OnGetFromPool()
	{
		nodeName = string.Empty;
		isActive = false;
		parent = null;
		ownerTree = null;
		depth = 0;
		childNodeDic.Clear();
		itemList.Clear();
	}

	public void OnReleaseToPool()
	{
		nodeName = string.Empty;
		isActive = false;
		parent = null;
		ownerTree = null;
		depth = 0;
		childNodeDic.Clear();
		itemList.Clear();
	}

	public void Init(string nodeValue, RedDotTrieNode parent, RedDotTrie ownerTree, int depth, string completePath)
	{
		nodeName = nodeValue;
		isActive = false;
		this.parent = parent;
		this.ownerTree = ownerTree;
		this.depth = depth;
		CompletePath = completePath;
	}

	public RedDotTrieNode GetChildNode(string childNodeValue)
	{
		if (childNodeDic.TryGetValue(childNodeValue, out var value))
		{
			return value;
		}
		return null;
	}

	public RedDotTrieNode AddChildNode(string childNodeValue, string childNodeFullPath)
	{
		if (childNodeDic.TryGetValue(childNodeValue, out var value))
		{
			return value;
		}
		RedDotTrieNode redDotTrieNode = RedDotTrieNodePool.Get();
		redDotTrieNode.Init(childNodeValue, this, ownerTree, depth + 1, childNodeFullPath);
		childNodeDic.Add(childNodeValue, redDotTrieNode);
		return redDotTrieNode;
	}

	public void RemoveChildNode(RedDotTrieNode childNode)
	{
		if (childNode != null && GetChildNode(childNode.nodeName) == childNode)
		{
			childNodeDic.Remove(childNode.nodeName);
			childNode.ownerTree?.allNodeDic?.Remove(childNode.CompletePath);
			Singleton<RedDotManager>.instance.RemoveRegisteredPaths(childNode.CompletePath);
			RedDotTrieNodePool.Release(childNode);
		}
	}

	public bool ContainChildNode(string childNodeValue)
	{
		return childNodeDic.ContainsKey(childNodeValue);
	}

	public bool ContainChildNode(RedDotTrieNode childNode)
	{
		return childNodeDic.ContainsValue(childNode);
	}

	public void RemoveSelf()
	{
		if (isLeaf)
		{
			parent.RemoveChildNode(this);
		}
	}

	public void RemoveSelfAndAllChildNode()
	{
		List<RedDotTrieNode> allChildNodeIncludeSelf = GetAllChildNodeIncludeSelf();
		for (int num = allChildNodeIncludeSelf.Count - 1; num >= 0; num--)
		{
			allChildNodeIncludeSelf[num].RemoveSelf();
		}
	}

	private List<RedDotTrieNode> GetAllChildNodeIncludeSelf()
	{
		List<RedDotTrieNode> list = new List<RedDotTrieNode>();
		Stack<RedDotTrieNode> stack = new Stack<RedDotTrieNode>();
		stack.Push(this);
		while (stack.Count != 0)
		{
			RedDotTrieNode redDotTrieNode = stack.Pop();
			list.Add(redDotTrieNode);
			if (redDotTrieNode.isLeaf)
			{
				continue;
			}
			foreach (KeyValuePair<string, RedDotTrieNode> item in redDotTrieNode.childNodeDic)
			{
				stack.Push(item.Value);
			}
		}
		return list;
	}

	public void BindRedDotItem(RedDotItem redDotItem)
	{
		redDotItem.redDotTrieNode = this;
		if (!itemList.Contains(redDotItem))
		{
			itemList.Add(redDotItem);
		}
	}

	public void SetActiveBySelf(bool active)
	{
		if (isLeaf)
		{
			isActive = active;
			UpdateRedDotItem();
		}
	}

	public void SetActiveByChild()
	{
		if (!isLeaf && !isRoot)
		{
			isActive = childNodeDic.Any((KeyValuePair<string, RedDotTrieNode> p) => p.Value.isActive);
			UpdateRedDotItem();
		}
	}

	private void UpdateRedDotItem()
	{
		itemList.RemoveAll((RedDotItem item) => item == null);
		foreach (RedDotItem item in itemList)
		{
			item.UpdateDisplay();
		}
	}
}
