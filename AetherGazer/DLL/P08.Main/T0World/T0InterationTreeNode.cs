using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationTreeNode
{
	public int treeID;

	public int nodeID;

	[SerializeReference]
	public object interationData;

	public int parentTreeID;

	public List<int> childTreeIDList;

	[NonSerialized]
	public T0InterationTreeNode parentNode;

	[NonSerialized]
	public List<T0InterationTreeNode> childNodeList;
}
