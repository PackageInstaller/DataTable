using System.Text;
using Mono.Security;
using Mono.Security.Cryptography;

namespace System.Security.Cryptography.X509Certificates;

public sealed class X509SubjectKeyIdentifierExtension : X509Extension
{
	internal const string oid = "2.5.29.14";

	internal const string friendlyName = "Subject Key Identifier";

	private byte[] _subjectKeyIdentifier;

	private string _ski;

	private AsnDecodeStatus _status;

	public string SubjectKeyIdentifier
	{
		get
		{
			AsnDecodeStatus status = _status;
			if (status == AsnDecodeStatus.Ok || status == AsnDecodeStatus.InformationNotAvailable)
			{
				if (_subjectKeyIdentifier != null)
				{
					_ski = CryptoConvert.ToHex(_subjectKeyIdentifier);
				}
				return _ski;
			}
			throw new CryptographicException("Badly encoded extension.");
		}
	}

	public X509SubjectKeyIdentifierExtension()
	{
		_oid = new Oid("2.5.29.14", "Subject Key Identifier");
	}

	public X509SubjectKeyIdentifierExtension(AsnEncodedData encodedSubjectKeyIdentifier, bool critical)
	{
		_oid = new Oid("2.5.29.14", "Subject Key Identifier");
		_raw = encodedSubjectKeyIdentifier.RawData;
		base.Critical = critical;
		_status = Decode(base.RawData);
	}

	public X509SubjectKeyIdentifierExtension(byte[] subjectKeyIdentifier, bool critical)
	{
		if (subjectKeyIdentifier == null)
		{
			throw new ArgumentNullException("subjectKeyIdentifier");
		}
		if (subjectKeyIdentifier.Length == 0)
		{
			throw new ArgumentException("subjectKeyIdentifier");
		}
		_oid = new Oid("2.5.29.14", "Subject Key Identifier");
		base.Critical = critical;
		_subjectKeyIdentifier = (byte[])subjectKeyIdentifier.Clone();
		base.RawData = Encode();
	}

	public X509SubjectKeyIdentifierExtension(string subjectKeyIdentifier, bool critical)
	{
		if (subjectKeyIdentifier == null)
		{
			throw new ArgumentNullException("subjectKeyIdentifier");
		}
		if (subjectKeyIdentifier.Length < 2)
		{
			throw new ArgumentException("subjectKeyIdentifier");
		}
		_oid = new Oid("2.5.29.14", "Subject Key Identifier");
		base.Critical = critical;
		_subjectKeyIdentifier = FromHex(subjectKeyIdentifier);
		base.RawData = Encode();
	}

	public X509SubjectKeyIdentifierExtension(PublicKey key, bool critical)
		: this(key, X509SubjectKeyIdentifierHashAlgorithm.Sha1, critical)
	{
	}

	public X509SubjectKeyIdentifierExtension(PublicKey key, X509SubjectKeyIdentifierHashAlgorithm algorithm, bool critical)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		byte[] rawData = key.EncodedKeyValue.RawData;
		switch (algorithm)
		{
		case X509SubjectKeyIdentifierHashAlgorithm.Sha1:
			_subjectKeyIdentifier = SHA1.Create().ComputeHash(rawData);
			break;
		case X509SubjectKeyIdentifierHashAlgorithm.ShortSha1:
		{
			byte[] src = SHA1.Create().ComputeHash(rawData);
			_subjectKeyIdentifier = new byte[8];
			Buffer.BlockCopy(src, 12, _subjectKeyIdentifier, 0, 8);
			_subjectKeyIdentifier[0] = (byte)(0x40 | (_subjectKeyIdentifier[0] & 0xF));
			break;
		}
		case X509SubjectKeyIdentifierHashAlgorithm.CapiSha1:
		{
			ASN1 aSN = new ASN1(48);
			ASN1 aSN2 = aSN.Add(new ASN1(48));
			aSN2.Add(new ASN1(CryptoConfig.EncodeOID(key.Oid.Value)));
			aSN2.Add(new ASN1(key.EncodedParameters.RawData));
			byte[] array = new byte[rawData.Length + 1];
			Buffer.BlockCopy(rawData, 0, array, 1, rawData.Length);
			aSN.Add(new ASN1(3, array));
			_subjectKeyIdentifier = SHA1.Create().ComputeHash(aSN.GetBytes());
			break;
		}
		default:
			throw new ArgumentException("algorithm");
		}
		_oid = new Oid("2.5.29.14", "Subject Key Identifier");
		base.Critical = critical;
		base.RawData = Encode();
	}

	public override void CopyFrom(AsnEncodedData asnEncodedData)
	{
		if (asnEncodedData == null)
		{
			throw new ArgumentNullException("asnEncodedData");
		}
		if (!(asnEncodedData is X509Extension x509Extension))
		{
			throw new ArgumentException(Locale.GetText("Wrong type."), "asnEncodedData");
		}
		if (x509Extension._oid == null)
		{
			_oid = new Oid("2.5.29.14", "Subject Key Identifier");
		}
		else
		{
			_oid = new Oid(x509Extension._oid);
		}
		base.RawData = x509Extension.RawData;
		base.Critical = x509Extension.Critical;
		_status = Decode(base.RawData);
	}

	internal static byte FromHexChar(char c)
	{
		if (c >= 'a' && c <= 'f')
		{
			return (byte)(c - 97 + 10);
		}
		if (c >= 'A' && c <= 'F')
		{
			return (byte)(c - 65 + 10);
		}
		if (c >= '0' && c <= '9')
		{
			return (byte)(c - 48);
		}
		return byte.MaxValue;
	}

	internal static byte FromHexChars(char c1, char c2)
	{
		byte b = FromHexChar(c1);
		if (b < byte.MaxValue)
		{
			b = (byte)((b << 4) | FromHexChar(c2));
		}
		return b;
	}

	internal static byte[] FromHex(string hex)
	{
		if (hex == null)
		{
			return null;
		}
		int num = hex.Length >> 1;
		byte[] array = new byte[num];
		int num2 = 0;
		int num3 = 0;
		while (num2 < num)
		{
			array[num2++] = FromHexChars(hex[num3++], hex[num3++]);
		}
		return array;
	}

	internal AsnDecodeStatus Decode(byte[] extension)
	{
		if (extension == null || extension.Length == 0)
		{
			return AsnDecodeStatus.BadAsn;
		}
		_ski = string.Empty;
		if (extension[0] != 4)
		{
			return AsnDecodeStatus.BadTag;
		}
		if (extension.Length == 2)
		{
			return AsnDecodeStatus.InformationNotAvailable;
		}
		if (extension.Length < 3)
		{
			return AsnDecodeStatus.BadLength;
		}
		try
		{
			ASN1 aSN = new ASN1(extension);
			_subjectKeyIdentifier = aSN.Value;
		}
		catch
		{
			return AsnDecodeStatus.BadAsn;
		}
		return AsnDecodeStatus.Ok;
	}

	internal byte[] Encode()
	{
		return new ASN1(4, _subjectKeyIdentifier).GetBytes();
	}

	internal override string ToString(bool multiLine)
	{
		switch (_status)
		{
		case AsnDecodeStatus.BadAsn:
			return string.Empty;
		case AsnDecodeStatus.BadTag:
		case AsnDecodeStatus.BadLength:
			return FormatUnkownData(_raw);
		case AsnDecodeStatus.InformationNotAvailable:
			return "Information Not Available";
		default:
		{
			if (_oid.Value != "2.5.29.14")
			{
				return $"Unknown Key Usage ({_oid.Value})";
			}
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < _subjectKeyIdentifier.Length; i++)
			{
				stringBuilder.Append(_subjectKeyIdentifier[i].ToString("x2"));
				if (i != _subjectKeyIdentifier.Length - 1)
				{
					stringBuilder.Append(" ");
				}
			}
			if (multiLine)
			{
				stringBuilder.Append(Environment.NewLine);
			}
			return stringBuilder.ToString();
		}
		}
	}
}
