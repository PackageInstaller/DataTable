namespace System.Net;

internal class HttpRequestCreator : IWebRequestCreate
{
	internal HttpRequestCreator()
	{
	}

	public WebRequest Create(Uri uri)
	{
		return new HttpWebRequest(uri);
	}
}
