using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Serialization;
using XNode;

namespace ACT.Drama.Conversation;

public class ChatNode : ConversationBaseNode
{
	public enum NextType
	{
		Chat,
		Branch,
		Event,
		End,
		Timeline,
		SubmitMission
	}

	[Input(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public string pre;

	public int speaker;

	[NonSerialized]
	[OdinSerialize]
	public List<ChatData> contents;

	public NextType nextType;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public ChatNode nextChat;

	[FormerlySerializedAs("nextBranchChat")]
	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public BranchNode nextBranch;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public EventNode nextEvent;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public EndNode nextEnd;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public TimelineNode nextTimeline;

	[Output(ShowBackingValue.Never, ConnectionType.Multiple, TypeConstraint.None, false)]
	public SubmitMissionNode nextSubmitMission;

	private Dictionary<NextType, string> singleDt = new Dictionary<NextType, string>
	{
		{
			NextType.Chat,
			"nextChat"
		},
		{
			NextType.Branch,
			"nextBranch"
		},
		{
			NextType.Event,
			"nextEvent"
		},
		{
			NextType.End,
			"nextEnd"
		},
		{
			NextType.Timeline,
			"nextTimeline"
		},
		{
			NextType.SubmitMission,
			"nextSubmitMission"
		}
	};

	protected override void Init()
	{
		base.Init();
	}

	public override object GetValue(NodePort port)
	{
		return null;
	}

	public override void OnCreateConnection(NodePort from, NodePort to)
	{
		if (Outputs.Contains(from) && from.ValueType != to.node.GetType())
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("不能将" + from.ValueType?.ToString() + "端口连接到" + to.node.GetType()?.ToString() + "节点！");
			}
			GetPort(from.fieldName).Disconnect(to);
		}
	}

	public override async void EnterNode(CancellationToken cancellationToken)
	{
		conversationGraph.curNode = this;
		for (int i = 0; i < contents.Count; i++)
		{
			ChatData content = contents[i];
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
			MonoConversationView.ConversationStatics conversationSubtitle = new MonoConversationView.ConversationStatics
			{
				localContentId = content.content,
				localSpeakerId = ((speaker != 0) ? speaker : 10001),
				emojiId = content.emoji,
				emotionPitch = (int)content.emotionPitch
			};
			if (conversationManager.conversationView == null || conversationManager.conversationView.UIController.State == UIState.Closed)
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
			try
			{
				if (!content.needClick)
				{
					await conversationManager.conversationView.ShowView(MonoConversationView.UIType.DELAY, cancellationToken);
				}
				else
				{
					await conversationManager.conversationView.ShowView(MonoConversationView.UIType.WAITCLICK, cancellationToken);
				}
				await DoEvents(BaseEvent.EventTime.End, cancellationToken);
			}
			catch
			{
			}
		}
		if (!cancellationToken.IsCancellationRequested)
		{
			ExitNode(cancellationToken);
		}
	}

	public override void ExitNode(CancellationToken cancellationToken)
	{
		ClearEvent();
		List<NodePort> list = null;
		switch (nextType)
		{
		case NextType.Chat:
			list = GetOutputPort("nextChat").GetConnections();
			break;
		case NextType.Branch:
			list = GetOutputPort("nextBranch").GetConnections();
			break;
		case NextType.Event:
			list = GetOutputPort("nextEvent").GetConnections();
			break;
		case NextType.End:
			list = GetOutputPort("nextEnd").GetConnections();
			break;
		case NextType.Timeline:
			list = GetOutputPort("nextTimeline").GetConnections();
			break;
		case NextType.SubmitMission:
			list = GetOutputPort("nextSubmitMission").GetConnections();
			break;
		}
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				(list[i].node as ConversationBaseNode).EnterNode(cancellationToken);
			}
		}
	}

	public override void JumpNode(bool isFirst = false)
	{
		for (int i = 0; i < contents.Count; i++)
		{
			ChatData chatData = contents[i];
			List<BaseEvent> list = new List<BaseEvent>();
			if (chatData.eventsBefore != null)
			{
				list.AddRange(chatData.eventsBefore);
			}
			if (chatData.eventsStart != null)
			{
				list.AddRange(chatData.eventsStart);
			}
			if (chatData.eventsEnd != null)
			{
				list.AddRange(chatData.eventsEnd);
			}
			foreach (BaseEvent item in list)
			{
				if (item.mustDo)
				{
					item.Init(null);
					item.DoEvent().Forget();
				}
			}
		}
		List<NodePort> list2 = null;
		list2 = nextType switch
		{
			NextType.Chat => GetOutputPort("nextChat").GetConnections(), 
			NextType.Branch => GetOutputPort("nextBranch").GetConnections(), 
			NextType.Event => GetOutputPort("nextEvent").GetConnections(), 
			NextType.End => GetOutputPort("nextEnd").GetConnections(), 
			NextType.Timeline => GetOutputPort("nextTimeline").GetConnections(), 
			NextType.SubmitMission => GetOutputPort("nextSubmitMission").GetConnections(), 
			_ => list2, 
		};
		if (list2 != null)
		{
			for (int j = 0; j < list2.Count; j++)
			{
				(list2[j].node as ConversationBaseNode).JumpNode();
			}
		}
	}
}
