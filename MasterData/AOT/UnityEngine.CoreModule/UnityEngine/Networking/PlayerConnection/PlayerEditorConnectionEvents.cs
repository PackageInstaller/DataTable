using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Events;

namespace UnityEngine.Networking.PlayerConnection;

[Serializable]
internal class PlayerEditorConnectionEvents
{
	[Serializable]
	public class MessageEvent : UnityEvent<MessageEventArgs>
	{
	}

	[Serializable]
	public class ConnectionChangeEvent : UnityEvent<int>
	{
	}

	[Serializable]
	public class MessageTypeSubscribers
	{
		[SerializeField]
		private string m_messageTypeId;

		public int subscriberCount = 0;

		public MessageEvent messageCallback = new MessageEvent();

		public Guid MessageTypeId
		{
			get
			{
				return new Guid(m_messageTypeId);
			}
			set
			{
				m_messageTypeId = value.ToString();
			}
		}
	}

	[SerializeField]
	public List<MessageTypeSubscribers> messageTypeSubscribers = new List<MessageTypeSubscribers>();

	[SerializeField]
	public ConnectionChangeEvent connectionEvent = new ConnectionChangeEvent();

	[SerializeField]
	public ConnectionChangeEvent disconnectionEvent = new ConnectionChangeEvent();

	public void InvokeMessageIdSubscribers(Guid messageId, byte[] data, int playerId)
	{
		IEnumerable<MessageTypeSubscribers> enumerable = messageTypeSubscribers.Where((MessageTypeSubscribers x) => x.MessageTypeId == messageId);
		if (!enumerable.Any())
		{
			Guid guid = messageId;
			Debug.LogError("No actions found for messageId: " + guid.ToString());
			return;
		}
		MessageEventArgs arg = new MessageEventArgs
		{
			playerId = playerId,
			data = data
		};
		foreach (MessageTypeSubscribers item in enumerable)
		{
			item.messageCallback.Invoke(arg);
		}
	}

	public UnityEvent<MessageEventArgs> AddAndCreate(Guid messageId)
	{
		MessageTypeSubscribers messageTypeSubscribers = this.messageTypeSubscribers.SingleOrDefault((MessageTypeSubscribers x) => x.MessageTypeId == messageId);
		if (messageTypeSubscribers == null)
		{
			messageTypeSubscribers = new MessageTypeSubscribers
			{
				MessageTypeId = messageId,
				messageCallback = new MessageEvent()
			};
			this.messageTypeSubscribers.Add(messageTypeSubscribers);
		}
		messageTypeSubscribers.subscriberCount++;
		return messageTypeSubscribers.messageCallback;
	}

	public void UnregisterManagedCallback(Guid messageId, UnityAction<MessageEventArgs> callback)
	{
		MessageTypeSubscribers messageTypeSubscribers = this.messageTypeSubscribers.SingleOrDefault((MessageTypeSubscribers x) => x.MessageTypeId == messageId);
		if (messageTypeSubscribers != null)
		{
			messageTypeSubscribers.subscriberCount--;
			messageTypeSubscribers.messageCallback.RemoveListener(callback);
			if (messageTypeSubscribers.subscriberCount <= 0)
			{
				this.messageTypeSubscribers.Remove(messageTypeSubscribers);
			}
		}
	}
}
