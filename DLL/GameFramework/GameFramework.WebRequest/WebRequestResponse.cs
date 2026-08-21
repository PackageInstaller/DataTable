namespace GameFramework.WebRequest;

public class WebRequestResponse : IReference
{
	private byte[] m_WebResponseBytes = null;

	public string ErrorMessage { get; private set; }

	public int OptionCode { get; private set; }

	public bool IsError => OptionCode == 1001;

	public byte[] GetWebResponseBytes()
	{
		return m_WebResponseBytes;
	}

	public static WebRequestResponse Create(byte[] webResponseBytes)
	{
		WebRequestResponse webRequestResponse = ReferencePool.Acquire<WebRequestResponse>();
		webRequestResponse.OptionCode = 1000;
		webRequestResponse.ErrorMessage = string.Empty;
		webRequestResponse.m_WebResponseBytes = webResponseBytes;
		return webRequestResponse;
	}

	public static WebRequestResponse Create(string errorMessage)
	{
		WebRequestResponse webRequestResponse = ReferencePool.Acquire<WebRequestResponse>();
		webRequestResponse.OptionCode = 1001;
		webRequestResponse.ErrorMessage = errorMessage;
		return webRequestResponse;
	}

	public void Clear()
	{
		m_WebResponseBytes = null;
		OptionCode = -1;
		ErrorMessage = null;
	}
}
