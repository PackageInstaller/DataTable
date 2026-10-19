using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using XNode;

namespace ACT.Drama.Conversation;

public class ConversationInteractEvent : InteractEvent
{
	[HideInInspector]
	public List<NodePort> nextNodes;

	[HideInInspector]
	public CancellationToken token;

	public override async UniTask OnInteract(object context)
	{
		if (nextNodes != null)
		{
			for (int i = 0; i < nextNodes.Count; i++)
			{
				(nextNodes[i].node as ConversationBaseNode).EnterNode(token);
			}
		}
	}
}
