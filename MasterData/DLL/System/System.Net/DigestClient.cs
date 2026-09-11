using System.Collections;

namespace System.Net;

internal class DigestClient : IAuthenticationModule
{
	private static readonly Hashtable cache = Hashtable.Synchronized(new Hashtable());

	private static Hashtable Cache
	{
		get
		{
			lock (cache.SyncRoot)
			{
				CheckExpired(cache.Count);
			}
			return cache;
		}
	}

	public string AuthenticationType => "Digest";

	private static void CheckExpired(int count)
	{
		if (count < 10)
		{
			return;
		}
		DateTime dateTime = DateTime.MaxValue;
		DateTime utcNow = DateTime.UtcNow;
		ArrayList arrayList = null;
		foreach (int key in cache.Keys)
		{
			DigestSession digestSession = (DigestSession)cache[key];
			if (digestSession.LastUse < dateTime && (digestSession.LastUse - utcNow).Ticks > 6000000000L)
			{
				dateTime = digestSession.LastUse;
				if (arrayList == null)
				{
					arrayList = new ArrayList();
				}
				arrayList.Add(key);
			}
		}
		if (arrayList == null)
		{
			return;
		}
		foreach (int item in arrayList)
		{
			cache.Remove(item);
		}
	}

	public Authorization Authenticate(string challenge, WebRequest webRequest, ICredentials credentials)
	{
		if (credentials == null || challenge == null)
		{
			return null;
		}
		if (challenge.Trim().ToLower().IndexOf("digest") == -1)
		{
			return null;
		}
		if (!(webRequest is HttpWebRequest httpWebRequest))
		{
			return null;
		}
		DigestSession digestSession = new DigestSession();
		if (!digestSession.Parse(challenge))
		{
			return null;
		}
		int num = httpWebRequest.Address.GetHashCode() ^ credentials.GetHashCode() ^ digestSession.Nonce.GetHashCode();
		DigestSession digestSession2 = (DigestSession)Cache[num];
		bool flag = digestSession2 == null;
		if (flag)
		{
			digestSession2 = digestSession;
		}
		else if (!digestSession2.Parse(challenge))
		{
			return null;
		}
		if (flag)
		{
			Cache.Add(num, digestSession2);
		}
		return digestSession2.Authenticate(webRequest, credentials);
	}

	public Authorization PreAuthenticate(WebRequest webRequest, ICredentials credentials)
	{
		if (!(webRequest is HttpWebRequest httpWebRequest))
		{
			return null;
		}
		if (credentials == null)
		{
			return null;
		}
		int num = httpWebRequest.Address.GetHashCode() ^ credentials.GetHashCode();
		return ((DigestSession)Cache[num])?.Authenticate(webRequest, credentials);
	}
}
