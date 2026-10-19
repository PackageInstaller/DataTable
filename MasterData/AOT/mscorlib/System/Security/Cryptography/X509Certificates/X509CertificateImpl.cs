namespace System.Security.Cryptography.X509Certificates;

internal abstract class X509CertificateImpl : IDisposable
{
	public abstract bool IsValid { get; }

	public abstract string Issuer { get; }

	public abstract string Subject { get; }

	public abstract byte[] RawData { get; }

	public abstract DateTime NotAfter { get; }

	public abstract DateTime NotBefore { get; }

	public abstract byte[] Thumbprint { get; }

	public abstract string KeyAlgorithm { get; }

	public abstract byte[] KeyAlgorithmParameters { get; }

	public abstract byte[] PublicKeyValue { get; }

	public abstract byte[] SerialNumber { get; }

	public abstract bool HasPrivateKey { get; }

	protected void ThrowIfContextInvalid()
	{
		if (!IsValid)
		{
			throw X509Helper.GetInvalidContextException();
		}
	}

	public abstract X509CertificateImpl Clone();

	public sealed override int GetHashCode()
	{
		if (!IsValid)
		{
			return 0;
		}
		byte[] thumbprint = Thumbprint;
		int num = 0;
		for (int i = 0; i < thumbprint.Length && i < 4; i++)
		{
			num = (num << 8) | thumbprint[i];
		}
		return num;
	}

	public abstract RSA GetRSAPrivateKey();

	public abstract DSA GetDSAPrivateKey();

	public sealed override bool Equals(object obj)
	{
		if (!(obj is X509CertificateImpl x509CertificateImpl))
		{
			return false;
		}
		if (!IsValid || !x509CertificateImpl.IsValid)
		{
			return false;
		}
		if (!Issuer.Equals(x509CertificateImpl.Issuer))
		{
			return false;
		}
		byte[] serialNumber = SerialNumber;
		byte[] serialNumber2 = x509CertificateImpl.SerialNumber;
		if (serialNumber.Length != serialNumber2.Length)
		{
			return false;
		}
		for (int i = 0; i < serialNumber.Length; i++)
		{
			if (serialNumber[i] != serialNumber2[i])
			{
				return false;
			}
		}
		return true;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	~X509CertificateImpl()
	{
		Dispose(disposing: false);
	}
}
