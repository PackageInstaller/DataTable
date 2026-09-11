using System;
using System.Collections.Generic;
using UnityEngine;

namespace Oath;

[Serializable]
public class OathInterationTreeNode
{
	public int nodeID;

	[SerializeReference]
	public object interationData;

	public int parentTreeID;

	public List<int> childTreeIDList;

	[NonSerialized]
	public OathInterationTreeNode parentNode;

	[NonSerialized]
	public List<OathInterationTreeNode> childNodeList;
}
