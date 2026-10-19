using System.Threading;
using Cysharp.Threading.Tasks;
using XNode;

namespace ACT.Drama.Conversation;

public class EventNode : ConversationBaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string triggerObj;

	public BaseEvent[] events;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string next;

	public override async void EnterNode(CancellationToken cancellationToken)
	{
		conversationGraph.curNode = this;
		EventsInit(events, BaseEvent.EventTime.Before);
		await DoEvents(BaseEvent.EventTime.Before, cancellationToken);
		if (!cancellationToken.IsCancellationRequested)
		{
			ExitNode(cancellationToken);
		}
	}

	public override void ExitNode(CancellationToken cancellationToken)
	{
		ClearEvent();
		base.ExitNode(cancellationToken);
	}

	public override void JumpNode(bool isFirst = false)
	{
		BaseEvent[] array = (isFirst ? nodeEvents.ToArray() : events);
		foreach (BaseEvent baseEvent in array)
		{
			if (baseEvent == null)
			{
				if (!LuminApplication.LogEnabled)
				{
				}
			}
			else if (baseEvent.mustDo)
			{
				baseEvent.Init(null);
				baseEvent.DoEvent().Forget();
			}
		}
		base.JumpNode();
	}
}
