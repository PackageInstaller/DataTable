using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class MechanismGroup : BaseMapDataNodeGroup<MechanismNode>
{
	[HideInInspector]
	public int serialId;

	public override void OnInited(object data = null)
	{
	}

	public override void OnStarted(object data = null)
	{
	}

	public List<MechanismNode> GetAllMechanismNode()
	{
		return nodeList;
	}

	public void OnGameSpeedChanged(float gameSpeed)
	{
		if (nodeList != null)
		{
			for (int i = 0; i < nodeList.Count; i++)
			{
				nodeList[i].OnGameSpeedChanged(gameSpeed);
			}
		}
	}

	public override void OnDispose()
	{
		foreach (MechanismNode node in nodeList)
		{
			node.OnDispose();
		}
	}
}
