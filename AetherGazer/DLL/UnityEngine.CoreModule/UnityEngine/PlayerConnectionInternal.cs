using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Export/PlayerConnection/PlayerConnectionInternal.bindings.h")]
internal class PlayerConnectionInternal : IPlayerEditorConnectionNative
{
	void IPlayerEditorConnectionNative.SendMessage(Guid messageId, byte[] data, int playerId)
	{
		if (messageId == Guid.Empty)
		{
			throw new ArgumentException("messageId must not be empty");
		}
		SendMessage(messageId.ToString("N"), data, playerId);
	}

	bool IPlayerEditorConnectionNative.TrySendMessage(Guid messageId, byte[] data, int playerId)
	{
		if (messageId == Guid.Empty)
		{
			throw new ArgumentException("messageId must not be empty");
		}
		return TrySendMessage(messageId.ToString("N"), data, playerId);
	}

	void IPlayerEditorConnectionNative.Poll()
	{
		PollInternal();
	}

	void IPlayerEditorConnectionNative.RegisterInternal(Guid messageId)
	{
		RegisterInternal(messageId.ToString("N"));
	}

	void IPlayerEditorConnectionNative.UnregisterInternal(Guid messageId)
	{
		UnregisterInternal(messageId.ToString("N"));
	}

	void IPlayerEditorConnectionNative.Initialize()
	{
		Initialize();
	}

	bool IPlayerEditorConnectionNative.IsConnected()
	{
		return IsConnected();
	}

	void IPlayerEditorConnectionNative.DisconnectAll()
	{
		DisconnectAll();
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerConnection_Bindings::IsConnected")]
	private static extern bool IsConnected();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerConnection_Bindings::Initialize")]
	private static extern void Initialize();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerConnection_Bindings::RegisterInternal")]
	private static extern void RegisterInternal(string messageId);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerConnection_Bindings::UnregisterInternal")]
	private static extern void UnregisterInternal(string messageId);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerConnection_Bindings::SendMessage")]
	private static extern void SendMessage(string messageId, [Unmarshalled] byte[] data, int playerId);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerConnection_Bindings::TrySendMessage")]
	private static extern bool TrySendMessage(string messageId, [Unmarshalled] byte[] data, int playerId);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerConnection_Bindings::PollInternal")]
	private static extern void PollInternal();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("PlayerConnection_Bindings::DisconnectAll")]
	private static extern void DisconnectAll();
}
