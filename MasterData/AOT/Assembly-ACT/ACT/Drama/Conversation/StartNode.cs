using System.Threading;
using UnityEngine;
using XNode;

namespace ACT.Drama.Conversation;

public class StartNode : ConversationBaseNode
{
	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string next;

	[Tooltip("玩家是否可操作")]
	public bool canOperation;

	[Tooltip("玩家是否可打断")]
	public bool canInterrupt;

	public int mainId;

	public CharacterInfo[] characterData;

	protected override void Init()
	{
		base.Init();
		conversationGraph.startNode = this;
	}

	public override async void EnterNode(CancellationToken cancellationToken)
	{
		conversationGraph.curNode = this;
		await conversationManager.StartLogic(canOperation, canInterrupt, mainId, characterData);
		if (!cancellationToken.IsCancellationRequested)
		{
			ExitNode(cancellationToken);
		}
	}

	public override void ExitNode(CancellationToken cancellationToken)
	{
		base.ExitNode(cancellationToken);
	}

	public override void JumpNode(bool isFirst = false)
	{
		base.JumpNode();
	}
}
