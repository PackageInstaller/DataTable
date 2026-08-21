namespace System.Net;

public class DnsEndPoint : EndPoint
{
	private string m_Host;

	private int m_Port;

	public string Host => m_Host;

	public int Port => m_Port;
}
