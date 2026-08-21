namespace System.Security.Cryptography.X509Certificates;

public sealed class X509ChainPolicy
{
	private OidCollection apps;

	private OidCollection cert;

	private X509CertificateCollection store;

	private X509Certificate2Collection store2;

	private X509RevocationFlag rflag;

	private X509RevocationMode mode;

	private TimeSpan timeout;

	private X509VerificationFlags vflags;

	private DateTime vtime;

	public X509Certificate2Collection ExtraStore
	{
		get
		{
			if (store2 != null)
			{
				return store2;
			}
			store2 = new X509Certificate2Collection();
			if (store != null)
			{
				foreach (X509Certificate item in store)
				{
					store2.Add(new X509Certificate2(item));
				}
			}
			return store2;
		}
	}

	public X509RevocationFlag RevocationFlag
	{
		get
		{
			return rflag;
		}
		set
		{
			if (value < X509RevocationFlag.EndCertificateOnly || value > X509RevocationFlag.ExcludeRoot)
			{
				throw new ArgumentException("RevocationFlag");
			}
			rflag = value;
		}
	}

	public X509RevocationMode RevocationMode
	{
		get
		{
			return mode;
		}
		set
		{
			if (value < X509RevocationMode.NoCheck || value > X509RevocationMode.Offline)
			{
				throw new ArgumentException("RevocationMode");
			}
			mode = value;
		}
	}

	public TimeSpan UrlRetrievalTimeout
	{
		set
		{
			timeout = value;
		}
	}

	public X509VerificationFlags VerificationFlags
	{
		get
		{
			return vflags;
		}
		set
		{
			if ((value | X509VerificationFlags.AllFlags) != X509VerificationFlags.AllFlags)
			{
				throw new ArgumentException("VerificationFlags");
			}
			vflags = value;
		}
	}

	public DateTime VerificationTime => vtime;

	public X509ChainPolicy()
	{
		Reset();
	}

	public void Reset()
	{
		apps = new OidCollection();
		cert = new OidCollection();
		store2 = null;
		rflag = X509RevocationFlag.ExcludeRoot;
		mode = X509RevocationMode.Online;
		timeout = TimeSpan.Zero;
		vflags = X509VerificationFlags.NoFlag;
		vtime = DateTime.Now;
	}
}
