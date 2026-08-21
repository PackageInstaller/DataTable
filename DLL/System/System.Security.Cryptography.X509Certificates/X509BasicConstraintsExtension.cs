using System.Text;
using Mono.Security;

namespace System.Security.Cryptography.X509Certificates;

public sealed class X509BasicConstraintsExtension : X509Extension
{
	internal const string oid = "2.5.29.19";

	internal const string friendlyName = "Basic Constraints";

	private bool _certificateAuthority;

	private bool _hasPathLengthConstraint;

	private int _pathLengthConstraint;

	private AsnDecodeStatus _status;

	public bool CertificateAuthority
	{
		get
		{
			AsnDecodeStatus status = _status;
			if (status == AsnDecodeStatus.Ok || status == AsnDecodeStatus.InformationNotAvailable)
			{
				return _certificateAuthority;
			}
			throw new CryptographicException("Badly encoded extension.");
		}
	}

	public bool HasPathLengthConstraint
	{
		get
		{
			AsnDecodeStatus status = _status;
			if (status == AsnDecodeStatus.Ok || status == AsnDecodeStatus.InformationNotAvailable)
			{
				return _hasPathLengthConstraint;
			}
			throw new CryptographicException("Badly encoded extension.");
		}
	}

	public int PathLengthConstraint
	{
		get
		{
			AsnDecodeStatus status = _status;
			if (status == AsnDecodeStatus.Ok || status == AsnDecodeStatus.InformationNotAvailable)
			{
				return _pathLengthConstraint;
			}
			throw new CryptographicException("Badly encoded extension.");
		}
	}

	public X509BasicConstraintsExtension()
	{
		_oid = new Oid("2.5.29.19", "Basic Constraints");
	}

	public X509BasicConstraintsExtension(AsnEncodedData encodedBasicConstraints, bool critical)
	{
		_oid = new Oid("2.5.29.19", "Basic Constraints");
		_raw = encodedBasicConstraints.RawData;
		base.Critical = critical;
		_status = Decode(base.RawData);
	}

	public X509BasicConstraintsExtension(bool certificateAuthority, bool hasPathLengthConstraint, int pathLengthConstraint, bool critical)
	{
		if (hasPathLengthConstraint)
		{
			if (pathLengthConstraint < 0)
			{
				throw new ArgumentOutOfRangeException("pathLengthConstraint");
			}
			_pathLengthConstraint = pathLengthConstraint;
		}
		_hasPathLengthConstraint = hasPathLengthConstraint;
		_certificateAuthority = certificateAuthority;
		_oid = new Oid("2.5.29.19", "Basic Constraints");
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
			_oid = new Oid("2.5.29.19", "Basic Constraints");
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
		if (extension.Length < 3 && (extension.Length != 2 || extension[1] != 0))
		{
			return AsnDecodeStatus.BadLength;
		}
		try
		{
			ASN1 aSN = new ASN1(extension);
			int num = 0;
			ASN1 aSN2 = aSN[num++];
			if (aSN2 != null && aSN2.Tag == 1)
			{
				_certificateAuthority = aSN2.Value[0] == byte.MaxValue;
				aSN2 = aSN[num++];
			}
			if (aSN2 != null && aSN2.Tag == 2)
			{
				_hasPathLengthConstraint = true;
				_pathLengthConstraint = ASN1Convert.ToInt32(aSN2);
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
		if (_certificateAuthority)
		{
			aSN.Add(new ASN1(1, new byte[1] { 255 }));
		}
		if (_hasPathLengthConstraint)
		{
			if (_pathLengthConstraint == 0)
			{
				aSN.Add(new ASN1(2, new byte[1]));
			}
			else
			{
				aSN.Add(ASN1Convert.FromInt32(_pathLengthConstraint));
			}
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
			if (_oid.Value != "2.5.29.19")
			{
				return $"Unknown Key Usage ({_oid.Value})";
			}
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append("Subject Type=");
			if (_certificateAuthority)
			{
				stringBuilder.Append("CA");
			}
			else
			{
				stringBuilder.Append("End Entity");
			}
			if (multiLine)
			{
				stringBuilder.Append(Environment.NewLine);
			}
			else
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append("Path Length Constraint=");
			if (_hasPathLengthConstraint)
			{
				stringBuilder.Append(_pathLengthConstraint);
			}
			else
			{
				stringBuilder.Append("None");
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
