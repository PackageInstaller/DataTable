using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using UnityEngine.Events;
using UnityEngine.Scripting;

namespace UnityEngine.Networking.PlayerConnection;

[Serializable]
public class PlayerConnection : ScriptableObject, IEditorPlayerConnection
{
	internal static IPlayerEditorConnectionNative connectionNative;

	[SerializeField]
	private PlayerEditorConnectionEvents m_PlayerEditorConnectionEvents = new PlayerEditorConnectionEvents();

	[SerializeField]
	private List<int> m_connectedPlayers = new List<int>();

	private bool m_IsInitilized;

	private static PlayerConnection s_Instance;

	public static PlayerConnection instance
	{
		get
		{
			if (s_Instance == null)
			{
				return CreateInstance();
			}
			return s_Instance;
		}
	}

	public bool isConnected => GetConnectionNativeApi().IsConnected();

	private static PlayerConnection CreateInstance()
	{
		s_Instance = ScriptableObject.CreateInstance<PlayerConnection>();
		s_Instance.hideFlags = HideFlags.HideAndDontSave;
		return s_Instance;
	}

	public void OnEnable()
	{
		if (!m_IsInitilized)
		{
			m_IsInitilized = true;
			GetConnectionNativeApi().Initialize();
		}
	}

	private IPlayerEditorConnectionNative GetConnectionNativeApi()
	{
		return connectionNative ?? new PlayerConnectionInternal();
	}

	public void Register(Guid messageId, UnityAction<MessageEventArgs> callback)
	{
		if (messageId == Guid.Empty)
		{
			throw new ArgumentException("Cant be Guid.Empty", "messageId");
		}
		if (!m_PlayerEditorConnectionEvents.messageTypeSubscribers.Any((PlayerEditorConnectionEvents.MessageTypeSubscribers x) => x.MessageTypeId == messageId))
		{
			GetConnectionNativeApi().RegisterInternal(messageId);
		}
		m_PlayerEditorConnectionEvents.AddAndCreate(messageId).AddListener(callback);
	}

	public void Unregister(Guid messageId, UnityAction<MessageEventArgs> callback)
	{
		m_PlayerEditorConnectionEvents.UnregisterManagedCallback(messageId, callback);
		if (!m_PlayerEditorConnectionEvents.messageTypeSubscribers.Any((PlayerEditorConnectionEvents.MessageTypeSubscribers x) => x.MessageTypeId == messageId))
		{
			GetConnectionNativeApi().UnregisterInternal(messageId);
		}
	}

	public void RegisterConnection(UnityAction<int> callback)
	{
		foreach (int connectedPlayer in m_connectedPlayers)
		{
			callback(connectedPlayer);
		}
		m_PlayerEditorConnectionEvents.connectionEvent.AddListener(callback);
	}

	public void RegisterDisconnection(UnityAction<int> callback)
	{
		m_PlayerEditorConnectionEvents.disconnectionEvent.AddListener(callback);
	}

	public void UnregisterConnection(UnityAction<int> callback)
	{
		m_PlayerEditorConnectionEvents.connectionEvent.RemoveListener(callback);
	}

	public void UnregisterDisconnection(UnityAction<int> callback)
	{
		m_PlayerEditorConnectionEvents.disconnectionEvent.RemoveListener(callback);
	}

	public void Send(Guid messageId, byte[] data)
	{
		if (messageId == Guid.Empty)
		{
			throw new ArgumentException("Cant be Guid.Empty", "messageId");
		}
		GetConnectionNativeApi().SendMessage(messageId, data, 0);
	}

	public bool TrySend(Guid messageId, byte[] data)
	{
		if (messageId == Guid.Empty)
		{
			throw new ArgumentException("Cant be Guid.Empty", "messageId");
		}
		return GetConnectionNativeApi().TrySendMessage(messageId, data, 0);
	}

	public bool BlockUntilRecvMsg(Guid messageId, int timeout)
	{
		bool msgReceived = false;
		UnityAction<MessageEventArgs> callback = delegate
		{
			msgReceived = true;
		};
		DateTime now = DateTime.Now;
		Register(messageId, callback);
		while ((DateTime.Now - now).TotalMilliseconds < (double)timeout && !msgReceived)
		{
			GetConnectionNativeApi().Poll();
		}
		Unregister(messageId, callback);
		return msgReceived;
	}

	public void DisconnectAll()
	{
		GetConnectionNativeApi().DisconnectAll();
	}

	[RequiredByNativeCode]
	private static void MessageCallbackInternal(IntPtr data, ulong size, ulong guid, string messageId)
	{
		byte[] array = null;
		if (size != 0)
		{
			array = new byte[size];
			Marshal.Copy(data, array, 0, (int)size);
		}
		instance.m_PlayerEditorConnectionEvents.InvokeMessageIdSubscribers(new Guid(messageId), array, (int)guid);
	}

	[RequiredByNativeCode]
	private static void ConnectedCallbackInternal(int playerId)
	{
		instance.m_connectedPlayers.Add(playerId);
		instance.m_PlayerEditorConnectionEvents.connectionEvent.Invoke(playerId);
	}

	[RequiredByNativeCode]
	private static void DisconnectedCallback(int playerId)
	{
		instance.m_connectedPlayers.Remove(playerId);
		instance.m_PlayerEditorConnectionEvents.disconnectionEvent.Invoke(playerId);
	}
}
