using System.Collections.Generic;

namespace Ase;

public class NPCGroup : BaseMapDataNodeGroup<NPCNode>
{
	public Dictionary<int, NPCNode> npcNodes = new Dictionary<int, NPCNode>();

	public override void OnInited(object data = null)
	{
	}

	public override void OnStarted(object data = null)
	{
	}

	public override void OnDispose()
	{
		foreach (NPCNode node in nodeList)
		{
			node.OnDispose();
		}
	}

	public NPCNode GetNPCNode(int nodeId)
	{
		npcNodes.TryGetValue(nodeId, out var value);
		return value;
	}
}
