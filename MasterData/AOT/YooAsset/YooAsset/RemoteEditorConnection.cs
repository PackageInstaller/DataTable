using System;
using System.Collections.Generic;
using UnityEngine.Events;
using UnityEngine.Networking.PlayerConnection;

namespace YooAsset;

internal class RemoteEditorConnection
{
	private static RemoteEditorConnection _instance;

	private readonly Dictionary<Guid, UnityAction<MessageEventArgs>> _messageCallbacks = new Dictionary<Guid, UnityAction<MessageEventArgs>>();

	public static RemoteEditorConnection Instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = new RemoteEditorConnection();
			}
			return _instance;
		}
	}

	public void Initialize()
	{
		_messageCallbacks.Clear();
	}

	public void Register(Guid messageID, UnityAction<MessageEventArgs> callback)
	{
		if (messageID == Guid.Empty)
		{
			throw new ArgumentException("messageID is empty !");
		}
		if (!_messageCallbacks.ContainsKey(messageID))
		{
			_messageCallbacks.Add(messageID, callback);
		}
	}

	public void Unregister(Guid messageID)
	{
		if (_messageCallbacks.ContainsKey(messageID))
		{
			_messageCallbacks.Remove(messageID);
		}
	}

	public void Send(Guid messageID, byte[] data)
	{
		if (messageID == Guid.Empty)
		{
			throw new ArgumentException("messageID is empty !");
		}
		RemotePlayerConnection.Instance.HandleEditorMessage(messageID, data);
	}

	internal void HandlePlayerMessage(Guid messageID, byte[] data)
	{
		if (_messageCallbacks.TryGetValue(messageID, out var value))
		{
			MessageEventArgs e = new MessageEventArgs();
			e.playerId = 0;
			e.data = data;
			value?.Invoke(e);
		}
	}
}
