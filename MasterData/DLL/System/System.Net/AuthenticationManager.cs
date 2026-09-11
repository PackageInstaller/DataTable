using System.Collections;

namespace System.Net;

public class AuthenticationManager
{
	private static ArrayList modules;

	private static object locker = new object();

	private static ICredentialPolicy credential_policy = null;

	private static void EnsureModules()
	{
		lock (locker)
		{
			if (modules == null)
			{
				modules = new ArrayList();
				modules.Add(new NtlmClient());
				modules.Add(new DigestClient());
				modules.Add(new BasicClient());
			}
		}
	}

	public static Authorization Authenticate(string challenge, WebRequest request, ICredentials credentials)
	{
		if (request == null)
		{
			throw new ArgumentNullException("request");
		}
		if (credentials == null)
		{
			throw new ArgumentNullException("credentials");
		}
		if (challenge == null)
		{
			throw new ArgumentNullException("challenge");
		}
		return DoAuthenticate(challenge, request, credentials);
	}

	private static Authorization DoAuthenticate(string challenge, WebRequest request, ICredentials credentials)
	{
		EnsureModules();
		lock (modules)
		{
			foreach (IAuthenticationModule module in modules)
			{
				Authorization authorization = module.Authenticate(challenge, request, credentials);
				if (authorization != null)
				{
					authorization.ModuleAuthenticationType = module.AuthenticationType;
					return authorization;
				}
			}
		}
		return null;
	}

	public static Authorization PreAuthenticate(WebRequest request, ICredentials credentials)
	{
		if (request == null)
		{
			throw new ArgumentNullException("request");
		}
		if (credentials == null)
		{
			return null;
		}
		EnsureModules();
		lock (modules)
		{
			foreach (IAuthenticationModule module in modules)
			{
				Authorization authorization = module.PreAuthenticate(request, credentials);
				if (authorization != null)
				{
					authorization.ModuleAuthenticationType = module.AuthenticationType;
					return authorization;
				}
			}
		}
		return null;
	}
}
