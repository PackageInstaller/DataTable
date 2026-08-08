namespace System.Net.Sockets;

public class SendPacketsElement
{
	internal string m_FilePath;

	internal byte[] m_Buffer;

	internal int m_Offset;

	internal int m_Count;

	private bool m_endOfPacket;

	private SendPacketsElement()
	{
	}
}
