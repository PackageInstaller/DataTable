using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationTreeData : ScriptableObject
{
	public T0InterationTreeType interationType = T0InterationTreeType.IDLE;

	public int treeID;

	public string interactionName;

	public int beginTreeNodeIndex = -1;

	public List<T0InterationTreeNode> treeNodeList;
}
