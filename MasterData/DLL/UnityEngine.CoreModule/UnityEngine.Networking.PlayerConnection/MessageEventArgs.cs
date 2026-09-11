using System;

namespace UnityEngine.Networking.PlayerConnection;

[Serializable]
public class MessageEventArgs
{
	public int playerId;

	public byte[] data;
}
