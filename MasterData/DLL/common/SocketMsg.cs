public struct SocketMsg
{
	public byte[] data;

	public int msgType;

	public SocketMsg(int msgtp, int len)
	{
		msgType = msgtp;
		data = new byte[len];
	}

	public SocketMsg(int msgtp, byte[] buffer)
	{
		msgType = msgtp;
		data = buffer;
	}
}
