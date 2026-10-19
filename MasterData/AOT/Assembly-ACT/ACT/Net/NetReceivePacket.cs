namespace ACT.Net;

public readonly struct NetReceivePacket
{
	public ushort cmdId { get; }

	public uint sessionId { get; }

	public int offset { get; }

	public int length { get; }

	public byte[] data { get; }

	public NetReceivePacket(ushort c, uint s, int o, int l, byte[] d)
	{
		cmdId = c;
		sessionId = s;
		offset = o;
		length = l;
		data = d;
	}
}
