using System.Net;
using System.Runtime.CompilerServices;

namespace Mono.Http;

internal class NtlmClient : IAuthenticationModule
{
	private static readonly ConditionalWeakTable<HttpWebRequest, NtlmSession> cache = new ConditionalWeakTable<HttpWebRequest, NtlmSession>();

	public string AuthenticationType => "NTLM";

	public Authorization Authenticate(string challenge, WebRequest webRequest, ICredentials credentials)
	{
		if (credentials == null || challenge == null)
		{
			return null;
		}
		string text = challenge.Trim();
		int num = text.ToLower().IndexOf("ntlm");
		if (num == -1)
		{
			return null;
		}
		num = text.IndexOfAny(new char[2] { ' ', '\t' });
		text = ((num == -1) ? null : text.Substring(num).Trim());
		if (!(webRequest is HttpWebRequest key))
		{
			return null;
		}
		lock (cache)
		{
			return cache.GetValue(key, (HttpWebRequest x) => new NtlmSession()).Authenticate(text, webRequest, credentials);
		}
	}

	public Authorization PreAuthenticate(WebRequest webRequest, ICredentials credentials)
	{
		return null;
	}
}
