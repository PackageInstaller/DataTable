using System.Collections;
using System.Collections.Generic;
using System.Text;
using Internal.Cryptography.Pal;
using Microsoft.Win32.SafeHandles;
using Mono.Security.X509;

namespace System.Security.Cryptography.X509Certificates;

internal abstract class X509Certificate2ImplUnix : X509Certificate2Impl
{
	private bool readCertData;

	private CertificateData certData;

	public sealed override string KeyAlgorithm
	{
		get
		{
			EnsureCertData();
			return certData.PublicKeyAlgorithm.AlgorithmId;
		}
	}

	public sealed override byte[] KeyAlgorithmParameters
	{
		get
		{
			EnsureCertData();
			return certData.PublicKeyAlgorithm.Parameters;
		}
	}

	public sealed override byte[] PublicKeyValue
	{
		get
		{
			EnsureCertData();
			return certData.PublicKey;
		}
	}

	public sealed override byte[] SerialNumber
	{
		get
		{
			EnsureCertData();
			return certData.SerialNumber;
		}
	}

	public sealed override string SignatureAlgorithm
	{
		get
		{
			EnsureCertData();
			return certData.SignatureAlgorithm.AlgorithmId;
		}
	}

	public sealed override int Version
	{
		get
		{
			EnsureCertData();
			return certData.Version + 1;
		}
	}

	public sealed override X500DistinguishedName SubjectName
	{
		get
		{
			EnsureCertData();
			return certData.Subject;
		}
	}

	public sealed override X500DistinguishedName IssuerName
	{
		get
		{
			EnsureCertData();
			return certData.Issuer;
		}
	}

	public sealed override string Subject => SubjectName.Name;

	public sealed override string Issuer => IssuerName.Name;

	public sealed override byte[] RawData
	{
		get
		{
			EnsureCertData();
			return certData.RawData;
		}
	}

	public sealed override byte[] Thumbprint
	{
		get
		{
			EnsureCertData();
			using SHA1 sHA = SHA1.Create();
			return sHA.ComputeHash(certData.RawData);
		}
	}

	public sealed override IEnumerable<X509Extension> Extensions
	{
		get
		{
			EnsureCertData();
			return certData.Extensions;
		}
	}

	public sealed override DateTime NotAfter
	{
		get
		{
			EnsureCertData();
			return certData.NotAfter.ToLocalTime();
		}
	}

	public sealed override DateTime NotBefore
	{
		get
		{
			EnsureCertData();
			return certData.NotBefore.ToLocalTime();
		}
	}

	private void EnsureCertData()
	{
		if (!readCertData)
		{
			ThrowIfContextInvalid();
			certData = new CertificateData(GetRawCertData());
			readCertData = true;
		}
	}

	protected abstract byte[] GetRawCertData();

	public sealed override string GetNameInfo(X509NameType nameType, bool forIssuer)
	{
		EnsureCertData();
		return certData.GetNameInfo(nameType, forIssuer);
	}

	public sealed override void AppendPrivateKeyInfo(StringBuilder sb)
	{
		if (HasPrivateKey)
		{
			sb.AppendLine();
			sb.AppendLine();
			sb.AppendLine("[Private Key]");
		}
	}

	public sealed override byte[] Export(X509ContentType contentType, SafePasswordHandle password)
	{
		ThrowIfContextInvalid();
		switch (contentType)
		{
		case X509ContentType.Cert:
			return RawData;
		case X509ContentType.Pfx:
			return ExportPkcs12(password);
		case X509ContentType.Pkcs7:
			return ExportPkcs12((string)null);
		case X509ContentType.SerializedCert:
		case X509ContentType.SerializedStore:
			throw new PlatformNotSupportedException("X509ContentType.SerializedCert and X509ContentType.SerializedStore are not supported on Unix.");
		default:
			throw new CryptographicException("Invalid content type.");
		}
	}

	private byte[] ExportPkcs12(SafePasswordHandle password)
	{
		if (password == null || password.IsInvalid)
		{
			return ExportPkcs12((string)null);
		}
		string password2 = password.Mono_DangerousGetString();
		return ExportPkcs12(password2);
	}

	private byte[] ExportPkcs12(string password)
	{
		PKCS12 pKCS = new PKCS12();
		try
		{
			Hashtable hashtable = new Hashtable();
			ArrayList arrayList = new ArrayList();
			arrayList.Add(new byte[4] { 1, 0, 0, 0 });
			hashtable.Add("1.2.840.113549.1.9.21", arrayList);
			if (password != null)
			{
				pKCS.Password = password;
			}
			pKCS.AddCertificate(new Mono.Security.X509.X509Certificate(RawData), hashtable);
			if (IntermediateCertificates != null)
			{
				for (int i = 0; i < IntermediateCertificates.Count; i++)
				{
					pKCS.AddCertificate(new Mono.Security.X509.X509Certificate(IntermediateCertificates[i].RawData));
				}
			}
			AsymmetricAlgorithm privateKey = PrivateKey;
			if (privateKey != null)
			{
				pKCS.AddPkcs8ShroudedKeyBag(privateKey, hashtable);
			}
			return pKCS.GetBytes();
		}
		finally
		{
			pKCS.Password = null;
		}
	}
}
