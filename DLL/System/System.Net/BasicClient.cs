namespace System.Net;

internal class BasicClient : IAuthenticationModule
{
	public string AuthenticationType => "Basic";

	public Authorization Authenticate(string challenge, WebRequest webRequest, ICredentials credentials)
	{
		if (credentials == null || challenge == null)
		{
			return null;
		}
		if (challenge.Trim().ToLower().IndexOf("basic", StringComparison.Ordinal) == -1)
		{
			return null;
		}
		return InternalAuthenticate(webRequest, credentials);
	}

	private static byte[] GetBytes(string str)
	{
		int length = str.Length;
		byte[] array = new byte[length];
		for (length--; length >= 0; length--)
		{
			array[length] = (byte)str[length];
		}
		return array;
	}

	private static Authorization InternalAuthenticate(WebRequest webRequest, ICredentials credentials)
	{
		if (!(webRequest is HttpWebRequest httpWebRequest) || credentials == null)
		{
			return null;
		}
		NetworkCredential credential = credentials.GetCredential(httpWebRequest.AuthUri, "basic");
		if (credential == null)
		{
			return null;
		}
		string userName = credential.UserName;
		if (userName == null || userName == "")
		{
			return null;
		}
		string password = credential.Password;
		string domain = credential.Domain;
		byte[] inArray = ((domain != null && !(domain == "") && !(domain.Trim() == "")) ? GetBytes(domain + "\\" + userName + ":" + password) : GetBytes(userName + ":" + password));
		return new Authorization("Basic " + Convert.ToBase64String(inArray));
	}

	public Authorization PreAuthenticate(WebRequest webRequest, ICredentials credentials)
	{
		return InternalAuthenticate(webRequest, credentials);
	}
}
