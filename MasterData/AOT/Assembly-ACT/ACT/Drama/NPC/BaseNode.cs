using System;
using System.Collections.Generic;
using UnityEngine;
using XNode;

namespace ACT.Drama.NPC;

public class BaseNode : Node
{
	[NonSerialized]
	[HideInInspector]
	public NPCBehaviourTree behaviourTree;

	protected override void Init()
	{
		behaviourTree = graph as NPCBehaviourTree;
		base.Init();
	}

	public override object GetValue(NodePort port)
	{
		return null;
	}

	public virtual void EnterNode()
	{
	}

	public virtual void ExitNode()
	{
		List<NodePort> connections = GetOutputPort("Exit").GetConnections();
		if (connections != null)
		{
			for (int i = 0; i < connections.Count; i++)
			{
				(connections[i].node as BaseNode).EnterNode();
			}
		}
	}

	public virtual void TestNode()
	{
	}
}
