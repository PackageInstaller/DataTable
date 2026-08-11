using System.Threading.Tasks;

namespace GameFramework.WebRequest;

public class WebRequestTaskCompletionSource : TaskCompletionSource<WebRequestResponse>, IReference
{
	private string m_WebRequestUri;

	private byte[] m_PostData;

	public string WebRequestUri => m_WebRequestUri;

	public static WebRequestTaskCompletionSource Create(string webRequestUri, byte[] postData)
	{
		WebRequestTaskCompletionSource webRequestTaskCompletionSource = ReferencePool.Acquire<WebRequestTaskCompletionSource>();
		webRequestTaskCompletionSource.m_WebRequestUri = webRequestUri;
		webRequestTaskCompletionSource.m_PostData = postData;
		return webRequestTaskCompletionSource;
	}

	public void Clear()
	{
		m_WebRequestUri = null;
		m_PostData = null;
	}
}
