using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using XNode;

namespace ACT.Drama.Conversation;

public class ConversationBaseNode : Node
{
	[HideInInspector]
	protected List<BaseEvent> nodeEvents;

	[HideInInspector]
	public ConversationGraph conversationGraph;

	public ConversationManager conversationManager => Singleton<ConversationManager>.instance;

	protected override void Init()
	{
		conversationGraph = graph as ConversationGraph;
		base.Init();
	}

	public override object GetValue(NodePort port)
	{
		return null;
	}

	public virtual void EnterNode(CancellationToken cancellationToken)
	{
	}

	public virtual void ExitNode(CancellationToken cancellationToken)
	{
		List<NodePort> connections = GetOutputPort("next").GetConnections();
		if (connections != null)
		{
			for (int i = 0; i < connections.Count; i++)
			{
				(connections[i].node as ConversationBaseNode).EnterNode(cancellationToken);
			}
		}
	}

	public virtual void JumpNode(bool isFirst = false)
	{
		List<NodePort> connections = GetOutputPort("next").GetConnections();
		if (connections != null)
		{
			for (int i = 0; i < connections.Count; i++)
			{
				(connections[i].node as ConversationBaseNode).JumpNode();
			}
		}
	}

	public void EventsInit(BaseEvent[] events, BaseEvent.EventTime time)
	{
		if (nodeEvents == null)
		{
			nodeEvents = ListPool<BaseEvent>.Get();
			nodeEvents.Clear();
		}
		for (int i = 0; i < events.Length; i++)
		{
			if (events[i] == null)
			{
				if (!LuminApplication.LogEnabled)
				{
				}
			}
			else
			{
				events[i].Init(conversationGraph.Context);
				events[i].eventTime = time;
				nodeEvents.Add(events[i]);
			}
		}
	}

	public async UniTask DoEvents(BaseEvent.EventTime time, CancellationToken cancellationToken)
	{
		if (nodeEvents == null)
		{
			return;
		}
		List<BaseEvent> tempEvents = ListPool<BaseEvent>.Get();
		List<UniTask> list = new List<UniTask>();
		for (int i = 0; i < nodeEvents.Count; i++)
		{
			if (nodeEvents[i].eventTime == time)
			{
				if (time.Equals(BaseEvent.EventTime.Start))
				{
					nodeEvents[i].DoEvent(cancellationToken).Forget();
				}
				else
				{
					list.Add(nodeEvents[i].DoEvent(cancellationToken));
				}
			}
			else
			{
				tempEvents.Add(nodeEvents[i]);
			}
		}
		await UniTask.WhenAll(list);
		nodeEvents.Clear();
		ListPool<BaseEvent>.Release(nodeEvents);
		nodeEvents = tempEvents;
	}

	public void ClearEvent()
	{
		if (nodeEvents != null)
		{
			nodeEvents.Clear();
			ListPool<BaseEvent>.Release(nodeEvents);
			nodeEvents = null;
		}
	}
}
