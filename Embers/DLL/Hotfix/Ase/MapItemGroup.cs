using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class MapItemGroup : BaseMapDataNodeGroup<MapItemNode>
{
	[HideInInspector]
	public int serialId;

	public override void OnInited(object data = null)
	{
	}

	public override void OnStarted(object data = null)
	{
	}

	public List<MapItemNode> GetAllMapItems()
	{
		return nodeList;
	}

	public override void OnDispose()
	{
		foreach (MapItemNode node in nodeList)
		{
			node.OnDispose();
		}
	}
}
