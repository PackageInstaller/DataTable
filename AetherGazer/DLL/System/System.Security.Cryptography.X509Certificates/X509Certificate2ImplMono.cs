using System.Runtime.CompilerServices;
using Microsoft.Win32.SafeHandles;
using Mono.Security.Authenticode;
using Mono.Security.Cryptography;
using Mono.Security.X509;

namespace System.Security.Cryptography.X509Certificates;

internal class X509Certificate2ImplMono : X509Certificate2ImplUnix
{
	private X509CertificateImplCollection intermediateCerts;

	private Mono.Security.X509.X509Certificate _cert;

	private static string empty_error;

	private static byte[] signedData;

	public override bool IsValid => _cert != null;

	private Mono.Security.X509.X509Certificate Cert
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

	internal Mono.Security.X509.X509Certificate MonoCertificate => _cert;

	public X509Certificate2ImplMono(Mono.Security.X509.X509Certificate cert)
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
		switch (X509Certificate2.GetCertContentType(rawData))
		{
		case X509ContentType.Pfx:
			_cert = ImportPkcs12(rawData, password);
			break;
		case X509ContentType.Cert:
		case X509ContentType.Pkcs7:
			_cert = new Mono.Security.X509.X509Certificate(rawData);
			break;
		case X509ContentType.Authenticode:
		{
			AuthenticodeDeformatter authenticodeDeformatter = new AuthenticodeDeformatter(rawData);
			_cert = authenticodeDeformatter.SigningCertificate;
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

	private Mono.Security.X509.X509Certificate ImportPkcs12(byte[] rawData, SafePasswordHandle password)
	{
		if (password == null || password.IsInvalid)
		{
			return ImportPkcs12(rawData, (string)null);
		}
		string password2 = password.Mono_DangerousGetString();
		return ImportPkcs12(rawData, password2);
	}

	private Mono.Security.X509.X509Certificate ImportPkcs12(byte[] rawData, string password)
	{
		PKCS12 pKCS = null;
		if (string.IsNullOrEmpty(password))
		{
			try
			{
				pKCS = new PKCS12(rawData, null);
			}
			catch
			{
				pKCS = new PKCS12(rawData, string.Empty);
			}
		}
		else
		{
			pKCS = new PKCS12(rawData, password);
		}
		if (pKCS.Certificates.Count == 0)
		{
			return null;
		}
		if (pKCS.Keys.Count == 0)
		{
			return pKCS.Certificates.get_Item(0);
		}
		Mono.Security.X509.X509Certificate x509Certificate = null;
		AsymmetricAlgorithm asymmetricAlgorithm = pKCS.Keys[0] as AsymmetricAlgorithm;
		string text = asymmetricAlgorithm.ToXmlString(includePrivateParameters: false);
		foreach (Mono.Security.X509.X509Certificate certificate in pKCS.Certificates)
		{
			if ((certificate.RSA != null && text == certificate.RSA.ToXmlString(includePrivateParameters: false)) || (certificate.DSA != null && text == certificate.DSA.ToXmlString(includePrivateParameters: false)))
			{
				x509Certificate = certificate;
				break;
			}
		}
		if (x509Certificate == null)
		{
			x509Certificate = pKCS.Certificates.get_Item(0);
		}
		else
		{
			x509Certificate.RSA = asymmetricAlgorithm as RSA;
			x509Certificate.DSA = asymmetricAlgorithm as DSA;
		}
		if (pKCS.Certificates.Count > 1)
		{
			intermediateCerts = new X509CertificateImplCollection();
			foreach (Mono.Security.X509.X509Certificate certificate2 in pKCS.Certificates)
			{
				if (certificate2 != x509Certificate)
				{
					X509Certificate2ImplMono impl = new X509Certificate2ImplMono(certificate2);
					intermediateCerts.Add(impl, takeOwnership: true);
				}
			}
		}
		return x509Certificate;
	}

	[System.MonoTODO("by default this depends on the incomplete X509Chain")]
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

	static X509Certificate2ImplMono()
	{
		//IL_001c: Field data (rva=0x6f8) could not be found in any section!
		//IL_001c: Field data (rva=0x6f8) could not be found in any section!
		empty_error = Locale.GetText("Certificate instance is empty.");
		byte[] array = new byte[9];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		signedData = array;
	}
}
