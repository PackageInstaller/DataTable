using System.Runtime.Serialization;
using System.Text;
using Internal.Cryptography;
using Microsoft.Win32.SafeHandles;
using Mono;

namespace System.Security.Cryptography.X509Certificates;

[Serializable]
public class X509Certificate2 : X509Certificate
{
	private volatile byte[] lazyRawData;

	private volatile Oid lazySignatureAlgorithm;

	private volatile int lazyVersion;

	private volatile X500DistinguishedName lazySubjectName;

	private volatile X500DistinguishedName lazyIssuerName;

	private volatile PublicKey lazyPublicKey;

	private volatile AsymmetricAlgorithm lazyPrivateKey;

	private volatile X509ExtensionCollection lazyExtensions;

	public X509ExtensionCollection Extensions
	{
		get
		{
			ThrowIfInvalid();
			X509ExtensionCollection x509ExtensionCollection = lazyExtensions;
			if (x509ExtensionCollection == null)
			{
				x509ExtensionCollection = new X509ExtensionCollection();
				foreach (X509Extension extension in Impl.Extensions)
				{
					X509Extension x509Extension = CreateCustomExtensionIfAny(extension.Oid);
					if (x509Extension == null)
					{
						x509ExtensionCollection.Add(extension);
						continue;
					}
					x509Extension.CopyFrom(extension);
					x509ExtensionCollection.Add(x509Extension);
				}
				lazyExtensions = x509ExtensionCollection;
			}
			return x509ExtensionCollection;
		}
	}

	public bool HasPrivateKey
	{
		get
		{
			ThrowIfInvalid();
			return Impl.HasPrivateKey;
		}
	}

	public AsymmetricAlgorithm PrivateKey
	{
		get
		{
			ThrowIfInvalid();
			if (!HasPrivateKey)
			{
				return null;
			}
			if (lazyPrivateKey == null)
			{
				string keyAlgorithm = GetKeyAlgorithm();
				if (!(keyAlgorithm == "1.2.840.113549.1.1.1"))
				{
					if (!(keyAlgorithm == "1.2.840.10040.4.1"))
					{
						throw new NotSupportedException("The certificate key algorithm is not supported.");
					}
					lazyPrivateKey = Impl.GetDSAPrivateKey();
				}
				else
				{
					lazyPrivateKey = Impl.GetRSAPrivateKey();
				}
			}
			return lazyPrivateKey;
		}
	}

	public X500DistinguishedName IssuerName
	{
		get
		{
			ThrowIfInvalid();
			X500DistinguishedName x500DistinguishedName = lazyIssuerName;
			if (x500DistinguishedName == null)
			{
				x500DistinguishedName = (lazyIssuerName = Impl.IssuerName);
			}
			return x500DistinguishedName;
		}
	}

	public DateTime NotAfter => GetNotAfter();

	public DateTime NotBefore => GetNotBefore();

	public PublicKey PublicKey
	{
		get
		{
			ThrowIfInvalid();
			PublicKey publicKey = lazyPublicKey;
			if (publicKey == null)
			{
				string keyAlgorithm = GetKeyAlgorithm();
				byte[] keyAlgorithmParameters = GetKeyAlgorithmParameters();
				byte[] publicKey2 = GetPublicKey();
				Oid oid = new Oid(keyAlgorithm);
				publicKey = (lazyPublicKey = new PublicKey(oid, new AsnEncodedData(oid, keyAlgorithmParameters), new AsnEncodedData(oid, publicKey2)));
			}
			return publicKey;
		}
	}

	public byte[] RawData
	{
		get
		{
			ThrowIfInvalid();
			byte[] array = lazyRawData;
			if (array == null)
			{
				array = (lazyRawData = Impl.RawData);
			}
			return array.CloneByteArray();
		}
	}

	public string SerialNumber => GetSerialNumberString();

	public Oid SignatureAlgorithm
	{
		get
		{
			ThrowIfInvalid();
			Oid oid = lazySignatureAlgorithm;
			if (oid == null)
			{
				string signatureAlgorithm = Impl.SignatureAlgorithm;
				oid = (lazySignatureAlgorithm = Oid.FromOidValue(signatureAlgorithm, OidGroup.SignatureAlgorithm));
			}
			return oid;
		}
	}

	public X500DistinguishedName SubjectName
	{
		get
		{
			ThrowIfInvalid();
			X500DistinguishedName x500DistinguishedName = lazySubjectName;
			if (x500DistinguishedName == null)
			{
				x500DistinguishedName = (lazySubjectName = Impl.SubjectName);
			}
			return x500DistinguishedName;
		}
	}

	public string Thumbprint => GetCertHash().ToHexStringUpper();

	public int Version
	{
		get
		{
			ThrowIfInvalid();
			int num = lazyVersion;
			if (num == 0)
			{
				num = (lazyVersion = Impl.Version);
			}
			return num;
		}
	}

	internal new X509Certificate2Impl Impl
	{
		get
		{
			X509Certificate2Impl result = base.Impl as X509Certificate2Impl;
			X509Helper.ThrowIfContextInvalid(result);
			return result;
		}
	}

	public override void Reset()
	{
		lazyRawData = null;
		lazySignatureAlgorithm = null;
		lazyVersion = 0;
		lazySubjectName = null;
		lazyIssuerName = null;
		lazyPublicKey = null;
		lazyPrivateKey = null;
		lazyExtensions = null;
		base.Reset();
	}

	public X509Certificate2()
	{
	}

	public X509Certificate2(byte[] rawData)
		: base(rawData)
	{
		if (rawData != null && rawData.Length != 0)
		{
			using (SafePasswordHandle password = new SafePasswordHandle(null))
			{
				X509CertificateImpl x509CertificateImpl = X509Helper.Import(rawData, password, X509KeyStorageFlags.DefaultKeySet);
				ImportHandle(x509CertificateImpl);
			}
		}
	}

	public X509Certificate2(byte[] rawData, string password)
		: base(rawData, password)
	{
	}

	internal X509Certificate2(X509Certificate2Impl impl)
		: base(impl)
	{
	}

	public X509Certificate2(X509Certificate certificate)
		: base(certificate)
	{
	}

	protected X509Certificate2(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		throw new PlatformNotSupportedException();
	}

	public static X509ContentType GetCertContentType(byte[] rawData)
	{
		if (rawData == null || rawData.Length == 0)
		{
			throw new ArgumentException("Array cannot be empty or null.", "rawData");
		}
		return X509Pal.Instance.GetCertContentType(rawData);
	}

	public string GetNameInfo(X509NameType nameType, bool forIssuer)
	{
		return Impl.GetNameInfo(nameType, forIssuer);
	}

	public override string ToString()
	{
		return base.ToString(fVerbose: true);
	}

	public override string ToString(bool verbose)
	{
		if (!verbose || !base.IsValid)
		{
			return ToString();
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("[Version]");
		stringBuilder.Append("  V");
		stringBuilder.Append(Version);
		stringBuilder.AppendLine();
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Subject]");
		stringBuilder.Append("  ");
		stringBuilder.Append(SubjectName.Name);
		string nameInfo = GetNameInfo(X509NameType.SimpleName, forIssuer: false);
		if (nameInfo.Length > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("Simple Name: ");
			stringBuilder.Append(nameInfo);
		}
		string nameInfo2 = GetNameInfo(X509NameType.EmailName, forIssuer: false);
		if (nameInfo2.Length > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("Email Name: ");
			stringBuilder.Append(nameInfo2);
		}
		string nameInfo3 = GetNameInfo(X509NameType.UpnName, forIssuer: false);
		if (nameInfo3.Length > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("UPN Name: ");
			stringBuilder.Append(nameInfo3);
		}
		string nameInfo4 = GetNameInfo(X509NameType.DnsName, forIssuer: false);
		if (nameInfo4.Length > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("DNS Name: ");
			stringBuilder.Append(nameInfo4);
		}
		stringBuilder.AppendLine();
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Issuer]");
		stringBuilder.Append("  ");
		stringBuilder.Append(IssuerName.Name);
		nameInfo = GetNameInfo(X509NameType.SimpleName, forIssuer: true);
		if (nameInfo.Length > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("Simple Name: ");
			stringBuilder.Append(nameInfo);
		}
		nameInfo2 = GetNameInfo(X509NameType.EmailName, forIssuer: true);
		if (nameInfo2.Length > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("Email Name: ");
			stringBuilder.Append(nameInfo2);
		}
		nameInfo3 = GetNameInfo(X509NameType.UpnName, forIssuer: true);
		if (nameInfo3.Length > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("UPN Name: ");
			stringBuilder.Append(nameInfo3);
		}
		nameInfo4 = GetNameInfo(X509NameType.DnsName, forIssuer: true);
		if (nameInfo4.Length > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("DNS Name: ");
			stringBuilder.Append(nameInfo4);
		}
		stringBuilder.AppendLine();
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Serial Number]");
		stringBuilder.Append("  ");
		stringBuilder.AppendLine(SerialNumber);
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Not Before]");
		stringBuilder.Append("  ");
		stringBuilder.AppendLine(X509Certificate.FormatDate(NotBefore));
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Not After]");
		stringBuilder.Append("  ");
		stringBuilder.AppendLine(X509Certificate.FormatDate(NotAfter));
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Thumbprint]");
		stringBuilder.Append("  ");
		stringBuilder.AppendLine(Thumbprint);
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Signature Algorithm]");
		stringBuilder.Append("  ");
		stringBuilder.Append(SignatureAlgorithm.FriendlyName);
		stringBuilder.Append('(');
		stringBuilder.Append(SignatureAlgorithm.Value);
		stringBuilder.AppendLine(")");
		stringBuilder.AppendLine();
		stringBuilder.Append("[Public Key]");
		try
		{
			PublicKey publicKey = PublicKey;
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("Algorithm: ");
			stringBuilder.Append(publicKey.Oid.FriendlyName);
			try
			{
				stringBuilder.AppendLine();
				stringBuilder.Append("  ");
				stringBuilder.Append("Length: ");
				using RSA rSA = this.GetRSAPublicKey();
				if (rSA != null)
				{
					stringBuilder.Append(rSA.KeySize);
				}
			}
			catch (NotSupportedException)
			{
			}
			stringBuilder.AppendLine();
			stringBuilder.Append("  ");
			stringBuilder.Append("Key Blob: ");
			stringBuilder.AppendLine(publicKey.EncodedKeyValue.Format(multiLine: true));
			stringBuilder.Append("  ");
			stringBuilder.Append("Parameters: ");
			stringBuilder.Append(publicKey.EncodedParameters.Format(multiLine: true));
		}
		catch (CryptographicException)
		{
		}
		Impl.AppendPrivateKeyInfo(stringBuilder);
		X509ExtensionCollection extensions = Extensions;
		if (extensions.Count > 0)
		{
			stringBuilder.AppendLine();
			stringBuilder.AppendLine();
			stringBuilder.Append("[Extensions]");
			foreach (X509Extension item in extensions)
			{
				try
				{
					stringBuilder.AppendLine();
					stringBuilder.Append("* ");
					stringBuilder.Append(item.Oid.FriendlyName);
					stringBuilder.Append('(');
					stringBuilder.Append(item.Oid.Value);
					stringBuilder.Append("):");
					stringBuilder.AppendLine();
					stringBuilder.Append("  ");
					stringBuilder.Append(item.Format(multiLine: true));
				}
				catch (CryptographicException)
				{
				}
			}
		}
		stringBuilder.AppendLine();
		return stringBuilder.ToString();
	}

	public bool Verify()
	{
		return Impl.Verify(this);
	}

	private static X509Extension CreateCustomExtensionIfAny(Oid oid)
	{
		switch (oid.Value)
		{
		case "2.5.29.10":
			if (!X509Pal.Instance.SupportsLegacyBasicConstraintsExtension)
			{
				return null;
			}
			return new X509BasicConstraintsExtension();
		case "2.5.29.19":
			return new X509BasicConstraintsExtension();
		case "2.5.29.15":
			return new X509KeyUsageExtension();
		case "2.5.29.37":
			return new X509EnhancedKeyUsageExtension();
		case "2.5.29.14":
			return new X509SubjectKeyIdentifierExtension();
		default:
			return null;
		}
	}
}
