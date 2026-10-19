using System.Threading;
using ACT.UI;
using Fundamental;
using XNode;

namespace ACT.Drama.Conversation;

public class TimelineNode : ConversationBaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string pre;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string next;

	public int timelineId;

	private bool isJump;

	private bool needJump;

	private CancellationTokenSource m_cts;

	protected override void Init()
	{
		base.Init();
		isJump = false;
		needJump = false;
	}

	public override async void EnterNode(CancellationToken cancellationToken)
	{
		conversationGraph.curNode = this;
		Singleton<NewUIManager>.instance.NeedPop = false;
		await Singleton<TimelineConversationManager>.instance.PlayTimeline(timelineId);
		if (isJump)
		{
			conversationManager.JumpConversation(doEvent: false);
			base.JumpNode();
		}
		else if (needJump)
		{
			ExitNode(m_cts.Token);
		}
		else if (!cancellationToken.IsCancellationRequested)
		{
			ExitNode(cancellationToken);
		}
	}

	public override void ExitNode(CancellationToken cancellationToken)
	{
		base.ExitNode(cancellationToken);
	}

	public override async void JumpNode(bool isFirst = false)
	{
		m_cts = conversationManager.JumpToBranch();
		needJump = true;
		if (!isFirst)
		{
			EnterNode(m_cts.Token);
		}
		isJump = Singleton<TimelineConversationManager>.instance.SkipConversation();
	}
}
