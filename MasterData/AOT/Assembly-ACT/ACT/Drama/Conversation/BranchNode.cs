using System.Collections.Generic;
using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using XNode;

namespace ACT.Drama.Conversation;

public class BranchNode : ConversationBaseNode
{
	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string pre;

	public int speaker;

	[Tooltip("是否有对话")]
	public bool haveContent;

	public ConversationData content;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string next;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false, dynamicPortList = true)]
	public BranchData[] branchs;

	public override async void EnterNode(CancellationToken cancellationToken)
	{
		conversationGraph.curNode = this;
		List<int> options = new List<int>();
		BranchData[] array = branchs;
		foreach (BranchData branchData in array)
		{
			options.Add(branchData.content);
		}
		List<InteractEvent> interactEvents = GetAllInteractEvents(cancellationToken);
		MonoConversationView.ConversationStatics conversationSubtitle;
		if (haveContent)
		{
			if (content.eventsBefore != null)
			{
				EventsInit(content.eventsBefore, BaseEvent.EventTime.Before);
			}
			if (content.eventsStart != null)
			{
				EventsInit(content.eventsStart, BaseEvent.EventTime.Start);
			}
			if (content.eventsEnd != null)
			{
				EventsInit(content.eventsEnd, BaseEvent.EventTime.End);
			}
			await DoEvents(BaseEvent.EventTime.Before, cancellationToken);
			conversationSubtitle = new MonoConversationView.ConversationStatics
			{
				localSpeakerId = ((speaker != 0) ? speaker : 10001),
				localContentId = content.content,
				options = options,
				interactEvents = interactEvents,
				emojiId = content.emoji,
				emotionPitch = (int)content.emotionPitch
			};
		}
		else
		{
			conversationSubtitle = new MonoConversationView.ConversationStatics
			{
				localSpeakerId = -1,
				localContentId = -1,
				options = options
			};
		}
		IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION);
		if (baseUIView == null || baseUIView.UIController.State != UIState.Opened)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CONVERSATION, conversationSubtitle);
			await UniTask.WaitUntil(() =>
			{
				if (!(Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) is MonoConversationView monoConversationView) || monoConversationView.UIController.State != UIState.Opened)
				{
					return false;
				}
				monoConversationView.SetUIViewData(conversationSubtitle);
				conversationManager.conversationView = monoConversationView;
				return true;
			}, PlayerLoopTiming.Update, cancellationToken);
		}
		else
		{
			conversationManager.conversationView.SetUIViewData(conversationSubtitle);
		}
		DoEvents(BaseEvent.EventTime.Start, cancellationToken).Forget();
		if (!haveContent)
		{
			await conversationManager.conversationView.ShowView(MonoConversationView.UIType.CHOICE_HIDE, cancellationToken);
		}
		else
		{
			await conversationManager.conversationView.ShowView(MonoConversationView.UIType.CHOICE_SHOW, cancellationToken);
		}
		await DoEvents(BaseEvent.EventTime.End, cancellationToken);
		if (!cancellationToken.IsCancellationRequested)
		{
			ExitNode(cancellationToken);
		}
	}

	public override void ExitNode(CancellationToken cancellationToken)
	{
		ClearEvent();
		int result = conversationManager.conversationView.result;
		if (result == -1)
		{
			return;
		}
		NodePort outputPort = GetOutputPort("branchs " + result);
		if (outputPort != null)
		{
			List<NodePort> connections = outputPort.GetConnections();
			if (connections != null)
			{
				for (int i = 0; i < connections.Count; i++)
				{
					(connections[i].node as ConversationBaseNode).EnterNode(cancellationToken);
				}
			}
			return;
		}
		List<NodePort> list = GetOutputPort("next")?.GetConnections();
		if (list != null)
		{
			for (int j = 0; j < list.Count; j++)
			{
				(list[j].node as ConversationBaseNode).EnterNode(cancellationToken);
			}
		}
	}

	public override void JumpNode(bool isFirst = false)
	{
		CancellationTokenSource cancellationTokenSource = conversationManager.JumpToBranch();
		EnterNode(cancellationTokenSource.Token);
	}

	public List<InteractEvent> GetAllInteractEvents(CancellationToken cancellationToken)
	{
		List<NodePort> connections = GetOutputPort("next").GetConnections();
		List<InteractEvent> list = new List<InteractEvent>();
		if (connections != null)
		{
			for (int i = 0; i < connections.Count; i++)
			{
				ConversationInteractEvent interactEvent = (connections[i].node as ConversationConditionNode).GetInteractEvent();
				if (interactEvent != null)
				{
					interactEvent.token = cancellationToken;
					list.Add(interactEvent);
				}
			}
		}
		list.Sort((InteractEvent x, InteractEvent y) => x.priority - y.priority);
		return list;
	}
}
