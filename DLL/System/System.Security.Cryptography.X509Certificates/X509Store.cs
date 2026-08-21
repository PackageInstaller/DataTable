using Mono.Security.X509;

namespace System.Security.Cryptography.X509Certificates;

public sealed class X509Store : IDisposable
{
	private string _name;

	private StoreLocation _location;

	private X509Certificate2Collection list;

	private OpenFlags _flags;

	private Mono.Security.X509.X509Store store;

	public X509Certificate2Collection Certificates
	{
		get
		{
			if (list == null)
			{
				list = new X509Certificate2Collection();
			}
			else if (store == null)
			{
				list.Clear();
			}
			return list;
		}
	}

	private X509Stores Factory
	{
		get
		{
			if (_location == StoreLocation.CurrentUser)
			{
				return X509StoreManager.CurrentUser;
			}
			return X509StoreManager.LocalMachine;
		}
	}

	internal Mono.Security.X509.X509Store Store => store;

	public X509Store(StoreName storeName, StoreLocation storeLocation)
	{
		if (storeName < StoreName.AddressBook || storeName > StoreName.TrustedPublisher)
		{
			throw new ArgumentException("storeName");
		}
		if (storeLocation < StoreLocation.CurrentUser || storeLocation > StoreLocation.LocalMachine)
		{
			throw new ArgumentException("storeLocation");
		}
		if (storeName == StoreName.CertificateAuthority)
		{
			_name = "CA";
		}
		else
		{
			_name = storeName.ToString();
		}
		_location = storeLocation;
	}

	public void Close()
	{
		store = null;
		if (list != null)
		{
			list.Clear();
		}
	}

	public void Dispose()
	{
		Close();
	}

	public void Open(OpenFlags flags)
	{
		if (string.IsNullOrEmpty(_name))
		{
			throw new CryptographicException(Locale.GetText("Invalid store name (null or empty)."));
		}
		string storeName = ((!(_name == "Root")) ? _name : "Trust");
		bool create = (flags & OpenFlags.OpenExistingOnly) != OpenFlags.OpenExistingOnly;
		store = Factory.Open(storeName, create);
		if (store == null)
		{
			throw new CryptographicException(Locale.GetText("Store {0} doesn't exists.", _name));
		}
		_flags = flags;
		foreach (Mono.Security.X509.X509Certificate certificate in store.Certificates)
		{
			X509Certificate2 x509Certificate = new X509Certificate2(certificate.RawData);
			x509Certificate.Impl.PrivateKey = certificate.RSA;
			Certificates.Add(x509Certificate);
		}
	}
}
