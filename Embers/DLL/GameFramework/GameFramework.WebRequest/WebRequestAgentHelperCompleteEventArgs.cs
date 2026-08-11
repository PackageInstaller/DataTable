namespace GameFramework.WebRequest;

public sealed class WebRequestAgentHelperCompleteEventArgs : GameFrameworkEventArgs
{
	private byte[] m_WebResponseBytes;

	public WebRequestAgentHelperCompleteEventArgs()
	{
		m_WebResponseBytes = null;
	}

	public static WebRequestAgentHelperCompleteEventArgs Create(byte[] webResponseBytes)
	{
		WebRequestAgentHelperCompleteEventArgs e = ReferencePool.Acquire<WebRequestAgentHelperCompleteEventArgs>();
		e.m_WebResponseBytes = webResponseBytes;
		return e;
	}

	public override void Clear()
	{
		m_WebResponseBytes = null;
	}

	public byte[] GetWebResponseBytes()
	{
		return m_WebResponseBytes;
	}
}
