using Google.Protobuf;

namespace ACT.Net;

public readonly struct NetPacket
{
	public static uint _sessionId;

	public ushort cmdId { get; }

	public uint sessionId { get; }

	public IMessage content { get; }

	public NetPacket(ushort c, IMessage m)
	{
		cmdId = c;
		sessionId = ++_sessionId;
		content = m;
	}

	public NetPacket(ushort c, uint s, IMessage m)
	{
		cmdId = c;
		sessionId = s;
		content = m;
	}

	public byte[] GetGcmEncryptedContentBytes(int cmdId)
	{
		if (cmdId == 1002)
		{
			return content.ToByteArray();
		}
		return LuminApplication.GcmEncrypt(content.ToByteArray());
	}
}
