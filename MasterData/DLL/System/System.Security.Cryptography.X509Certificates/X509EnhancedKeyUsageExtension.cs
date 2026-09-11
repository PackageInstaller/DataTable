using System.Text;
using Mono.Security;

namespace System.Security.Cryptography.X509Certificates;

public sealed class X509EnhancedKeyUsageExtension : X509Extension
{
	private OidCollection _enhKeyUsage;

	private AsnDecodeStatus _status;

	public X509EnhancedKeyUsageExtension()
	{
		_oid = new Oid("2.5.29.37", "Enhanced Key Usage");
	}

	public X509EnhancedKeyUsageExtension(AsnEncodedData encodedEnhancedKeyUsages, bool critical)
	{
		_oid = new Oid("2.5.29.37", "Enhanced Key Usage");
		_raw = encodedEnhancedKeyUsages.RawData;
		base.Critical = critical;
		_status = Decode(base.RawData);
	}

	public X509EnhancedKeyUsageExtension(OidCollection enhancedKeyUsages, bool critical)
	{
		if (enhancedKeyUsages == null)
		{
			throw new ArgumentNullException("enhancedKeyUsages");
		}
		_oid = new Oid("2.5.29.37", "Enhanced Key Usage");
		base.Critical = critical;
		_enhKeyUsage = new OidCollection();
		foreach (Oid enhancedKeyUsage in enhancedKeyUsages)
		{
			_enhKeyUsage.Add(enhancedKeyUsage);
		}
		base.RawData = Encode();
	}

	public override void CopyFrom(AsnEncodedData asnEncodedData)
	{
		if (asnEncodedData == null)
		{
			throw new ArgumentNullException("encodedData");
		}
		if (!(asnEncodedData is X509Extension x509Extension))
		{
			throw new ArgumentException(Locale.GetText("Wrong type."), "asnEncodedData");
		}
		if (x509Extension._oid == null)
		{
			_oid = new Oid("2.5.29.37", "Enhanced Key Usage");
		}
		else
		{
			_oid = new Oid(x509Extension._oid);
		}
		base.RawData = x509Extension.RawData;
		base.Critical = x509Extension.Critical;
		_status = Decode(base.RawData);
	}

	internal AsnDecodeStatus Decode(byte[] extension)
	{
		if (extension == null || extension.Length == 0)
		{
			return AsnDecodeStatus.BadAsn;
		}
		if (extension[0] != 48)
		{
			return AsnDecodeStatus.BadTag;
		}
		if (_enhKeyUsage == null)
		{
			_enhKeyUsage = new OidCollection();
		}
		try
		{
			ASN1 aSN = new ASN1(extension);
			if (aSN.Tag != 48)
			{
				throw new CryptographicException(Locale.GetText("Invalid ASN.1 Tag"));
			}
			for (int i = 0; i < aSN.Count; i++)
			{
				_enhKeyUsage.Add(new Oid(ASN1Convert.ToOid(aSN.get_Item(i))));
			}
		}
		catch
		{
			return AsnDecodeStatus.BadAsn;
		}
		return AsnDecodeStatus.Ok;
	}

	internal byte[] Encode()
	{
		ASN1 aSN = new ASN1(48);
		foreach (Oid item in _enhKeyUsage)
		{
			aSN.Add(ASN1Convert.FromOid(item.Value));
		}
		return aSN.GetBytes();
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
			if (_oid.Value != "2.5.29.37")
			{
				return $"Unknown Key Usage ({_oid.Value})";
			}
			if (_enhKeyUsage.Count == 0)
			{
				return "Information Not Available";
			}
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < _enhKeyUsage.Count; i++)
			{
				Oid oid = _enhKeyUsage[i];
				if (oid.Value == "1.3.6.1.5.5.7.3.1")
				{
					stringBuilder.Append("Server Authentication (");
				}
				else
				{
					stringBuilder.Append("Unknown Key Usage (");
				}
				stringBuilder.Append(oid.Value);
				stringBuilder.Append(")");
				if (multiLine)
				{
					stringBuilder.Append(Environment.NewLine);
				}
				else if (i != _enhKeyUsage.Count - 1)
				{
					stringBuilder.Append(", ");
				}
			}
			return stringBuilder.ToString();
		}
		}
	}
}
