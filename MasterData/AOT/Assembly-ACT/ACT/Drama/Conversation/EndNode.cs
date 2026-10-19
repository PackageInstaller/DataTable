using System.Threading;
using Cysharp.Threading.Tasks;
using XNode;

namespace ACT.Drama.Conversation;

public class EndNode : ConversationBaseNode
{
	[Input(ShowBackingValue.Unconnected, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string Enter;

	public override void EnterNode(CancellationToken cancellationToken)
	{
		conversationGraph.curNode = this;
		conversationManager.PlayingXNodeDialogue?.Stop();
		conversationManager.EndLogic(cancellationToken).Forget();
	}

	public override void JumpNode(bool isFirst = false)
	{
		conversationManager.PlayingXNodeDialogue?.Stop();
		conversationManager.EndLogic(default).Forget();
	}
}
