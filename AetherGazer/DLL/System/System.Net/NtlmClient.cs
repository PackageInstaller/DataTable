using Mono.Http;

namespace System.Net;

internal class NtlmClient : IAuthenticationModule
{
	private IAuthenticationModule authObject;

	public string AuthenticationType => "NTLM";

	public NtlmClient()
	{
		authObject = new Mono.Http.NtlmClient();
	}

	public Authorization Authenticate(string challenge, WebRequest webRequest, ICredentials credentials)
	{
		if (authObject == null)
		{
			return null;
		}
		return authObject.Authenticate(challenge, webRequest, credentials);
	}

	public Authorization PreAuthenticate(WebRequest webRequest, ICredentials credentials)
	{
		return null;
	}
}
