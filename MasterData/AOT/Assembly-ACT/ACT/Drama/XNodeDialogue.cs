using System.Threading;
using ACT.Drama.Conversation;
using Cysharp.Threading.Tasks;

namespace ACT.Drama;

public class XNodeDialogue : DialogueWrapper
{
	private readonly ConversationGraph m_XNodeGraph;

	public ConversationGraph XNodeGraph => m_XNodeGraph;

	public ConversationGraph ConversationGraph => m_XNodeGraph;

	public XNodeDialogue(ConversationGraph xNodeGraph, CancellationTokenSource cts)
	{
		m_XNodeGraph = xNodeGraph;
	}

	protected override async UniTask Play(CancellationToken token)
	{
		m_XNodeGraph.startNode.EnterNode(token);
		await UniTask.WaitUntilCanceled(token);
	}
}
