using System.Collections;
using Microsoft.Win32.SafeHandles;
using Mono.Security.Authenticode;
using Mono.Security.Cryptography;
using Mono.Security.X509;

namespace System.Security.Cryptography.X509Certificates;

internal class X509Certificate2ImplMono : X509Certificate2ImplUnix
{
	private X509CertificateImplCollection intermediateCerts;

	private X509Certificate _cert;

	private static string empty_error = Locale.GetText("Certificate instance is empty.");

	private static byte[] signedData = new byte[9] { 42, 134, 72, 134, 247, 13, 1, 7, 2 };

	public override bool IsValid => _cert != null;

	private X509Certificate Cert
	{
		get
		{
			ThrowIfContextInvalid();
			return _cert;
		}
	}

	public override bool HasPrivateKey => PrivateKey != null;

	public override AsymmetricAlgorithm PrivateKey
	{
		get
		{
			if (_cert == null)
			{
				throw new CryptographicException(empty_error);
			}
			try
			{
				if (_cert.RSA is RSACryptoServiceProvider rSACryptoServiceProvider)
				{
					if (rSACryptoServiceProvider.PublicOnly)
					{
						return null;
					}
					RSACryptoServiceProvider rSACryptoServiceProvider2 = new RSACryptoServiceProvider();
					rSACryptoServiceProvider2.ImportParameters(_cert.RSA.ExportParameters(includePrivateParameters: true));
					return rSACryptoServiceProvider2;
				}
				if (_cert.RSA is RSAManaged rSAManaged)
				{
					if (rSAManaged.PublicOnly)
					{
						return null;
					}
					RSAManaged rSAManaged2 = new RSAManaged();
					rSAManaged2.ImportParameters(_cert.RSA.ExportParameters(includePrivateParameters: true));
					return rSAManaged2;
				}
				if (_cert.DSA is DSACryptoServiceProvider dSACryptoServiceProvider)
				{
					if (dSACryptoServiceProvider.PublicOnly)
					{
						return null;
					}
					DSACryptoServiceProvider dSACryptoServiceProvider2 = new DSACryptoServiceProvider();
					dSACryptoServiceProvider2.ImportParameters(_cert.DSA.ExportParameters(includePrivateParameters: true));
					return dSACryptoServiceProvider2;
				}
			}
			catch
			{
			}
			return null;
		}
		set
		{
			if (_cert == null)
			{
				throw new CryptographicException(empty_error);
			}
			if (value == null)
			{
				_cert.RSA = null;
				_cert.DSA = null;
				return;
			}
			if (value is RSA)
			{
				_cert.RSA = (RSA)value;
				return;
			}
			if (value is DSA)
			{
				_cert.DSA = (DSA)value;
				return;
			}
			throw new NotSupportedException();
		}
	}

	internal override X509CertificateImplCollection IntermediateCertificates => intermediateCerts;

	internal X509Certificate MonoCertificate => _cert;

	public X509Certificate2ImplMono(X509Certificate cert)
	{
		_cert = cert;
	}

	private X509Certificate2ImplMono(X509Certificate2ImplMono other)
	{
		_cert = other._cert;
		if (other.intermediateCerts != null)
		{
			intermediateCerts = other.intermediateCerts.Clone();
		}
	}

	public X509Certificate2ImplMono(byte[] rawData, SafePasswordHandle password, X509KeyStorageFlags keyStorageFlags)
	{
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Expected O, but got Unknown
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Expected O, but got Unknown
		base._002Ector();
		switch (X509Certificate2.GetCertContentType(rawData))
		{
		case X509ContentType.Pfx:
			_cert = ImportPkcs12(rawData, password);
			break;
		case X509ContentType.Cert:
		case X509ContentType.Pkcs7:
			_cert = new X509Certificate(rawData);
			break;
		case X509ContentType.Authenticode:
		{
			AuthenticodeDeformatter val = new AuthenticodeDeformatter(rawData);
			_cert = val.SigningCertificate;
			if (_cert != null)
			{
				break;
			}
			goto default;
		}
		default:
			throw new CryptographicException(Locale.GetText("Unable to decode certificate."));
		}
	}

	public override X509CertificateImpl Clone()
	{
		ThrowIfContextInvalid();
		return new X509Certificate2ImplMono(this);
	}

	protected override byte[] GetRawCertData()
	{
		ThrowIfContextInvalid();
		return Cert.RawData;
	}

	public override RSA GetRSAPrivateKey()
	{
		return PrivateKey as RSA;
	}

	public override DSA GetDSAPrivateKey()
	{
		return PrivateKey as DSA;
	}

	private X509Certificate ImportPkcs12(byte[] rawData, SafePasswordHandle password)
	{
		if (password == null || password.IsInvalid)
		{
			return ImportPkcs12(rawData, (string)null);
		}
		string password2 = password.Mono_DangerousGetString();
		return ImportPkcs12(rawData, password2);
	}

	private X509Certificate ImportPkcs12(byte[] rawData, string password)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Expected O, but got Unknown
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Expected O, but got Unknown
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Expected O, but got Unknown
		PKCS12 val = null;
		if (string.IsNullOrEmpty(password))
		{
			try
			{
				val = new PKCS12(rawData, (string)null);
			}
			catch
			{
				val = new PKCS12(rawData, string.Empty);
			}
		}
		else
		{
			val = new PKCS12(rawData, password);
		}
		if (((CollectionBase)(object)val.Certificates).Count == 0)
		{
			return null;
		}
		if (val.Keys.Count == 0)
		{
			return val.Certificates[0];
		}
		X509Certificate val2 = null;
		AsymmetricAlgorithm asymmetricAlgorithm = val.Keys[0] as AsymmetricAlgorithm;
		string text = asymmetricAlgorithm.ToXmlString(includePrivateParameters: false);
		X509CertificateEnumerator enumerator = val.Certificates.GetEnumerator();
		try
		{
			while (enumerator.MoveNext())
			{
				X509Certificate current = enumerator.Current;
				if ((current.RSA != null && text == current.RSA.ToXmlString(includePrivateParameters: false)) || (current.DSA != null && text == current.DSA.ToXmlString(includePrivateParameters: false)))
				{
					val2 = current;
					break;
				}
			}
		}
		finally
		{
			if (enumerator is IDisposable disposable)
			{
				disposable.Dispose();
			}
		}
		if (val2 == null)
		{
			val2 = val.Certificates[0];
		}
		else
		{
			val2.RSA = asymmetricAlgorithm as RSA;
			val2.DSA = asymmetricAlgorithm as DSA;
		}
		if (((CollectionBase)(object)val.Certificates).Count > 1)
		{
			intermediateCerts = new X509CertificateImplCollection();
			enumerator = val.Certificates.GetEnumerator();
			try
			{
				while (enumerator.MoveNext())
				{
					X509Certificate current2 = enumerator.Current;
					if (current2 != val2)
					{
						X509Certificate2ImplMono impl = new X509Certificate2ImplMono(current2);
						intermediateCerts.Add(impl, takeOwnership: true);
					}
				}
			}
			finally
			{
				if (enumerator is IDisposable disposable2)
				{
					disposable2.Dispose();
				}
			}
		}
		return val2;
	}

	[MonoTODO("by default this depends on the incomplete X509Chain")]
	public override bool Verify(X509Certificate2 thisCertificate)
	{
		if (_cert == null)
		{
			throw new CryptographicException(empty_error);
		}
		if (!X509Chain.Create().Build(thisCertificate))
		{
			return false;
		}
		return true;
	}
}
