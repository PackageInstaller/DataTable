using System.Globalization;
using System.Runtime.Serialization;
using System.Text;
using Internal.Cryptography;

namespace System.Security.Cryptography.X509Certificates;

[Serializable]
public class X509Certificate : IDisposable, IDeserializationCallback, ISerializable
{
	private X509CertificateImpl impl;

	private volatile byte[] lazyCertHash;

	private volatile byte[] lazySerialNumber;

	private volatile string lazyIssuer;

	private volatile string lazySubject;

	private volatile string lazyKeyAlgorithm;

	private volatile byte[] lazyKeyAlgorithmParameters;

	private volatile byte[] lazyPublicKey;

	private DateTime lazyNotBefore = DateTime.MinValue;

	private DateTime lazyNotAfter = DateTime.MinValue;

	public string Issuer
	{
		get
		{
			ThrowIfInvalid();
			string text = lazyIssuer;
			if (text == null)
			{
				text = (lazyIssuer = Impl.Issuer);
			}
			return text;
		}
	}

	public string Subject
	{
		get
		{
			ThrowIfInvalid();
			string text = lazySubject;
			if (text == null)
			{
				text = (lazySubject = Impl.Subject);
			}
			return text;
		}
	}

	internal X509CertificateImpl Impl => impl;

	internal bool IsValid => X509Helper.IsValid(impl);

	public virtual void Reset()
	{
		if (impl != null)
		{
			impl.Dispose();
			impl = null;
		}
		lazyCertHash = null;
		lazyIssuer = null;
		lazySubject = null;
		lazySerialNumber = null;
		lazyKeyAlgorithm = null;
		lazyKeyAlgorithmParameters = null;
		lazyPublicKey = null;
		lazyNotBefore = DateTime.MinValue;
		lazyNotAfter = DateTime.MinValue;
	}

	public X509Certificate()
	{
	}

	public X509Certificate(byte[] data)
	{
		if (data != null && data.Length != 0)
		{
			impl = X509Helper.Import(data);
		}
	}

	internal X509Certificate(X509CertificateImpl impl)
	{
		this.impl = X509Helper.InitFromCertificate(impl);
	}

	public X509Certificate(X509Certificate cert)
	{
		if (cert == null)
		{
			throw new ArgumentNullException("cert");
		}
		impl = X509Helper.InitFromCertificate(cert);
	}

	public X509Certificate(SerializationInfo info, StreamingContext context)
		: this()
	{
		throw new PlatformNotSupportedException();
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		throw new PlatformNotSupportedException();
	}

	void IDeserializationCallback.OnDeserialization(object sender)
	{
		throw new PlatformNotSupportedException();
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
		{
			Reset();
		}
	}

	public override bool Equals(object obj)
	{
		if (!(obj is X509Certificate other))
		{
			return false;
		}
		return Equals(other);
	}

	public virtual bool Equals(X509Certificate other)
	{
		if (other == null)
		{
			return false;
		}
		if (Impl == null)
		{
			return other.Impl == null;
		}
		if (!Issuer.Equals(other.Issuer))
		{
			return false;
		}
		byte[] rawSerialNumber = GetRawSerialNumber();
		byte[] rawSerialNumber2 = other.GetRawSerialNumber();
		if (rawSerialNumber.Length != rawSerialNumber2.Length)
		{
			return false;
		}
		for (int i = 0; i < rawSerialNumber.Length; i++)
		{
			if (rawSerialNumber[i] != rawSerialNumber2[i])
			{
				return false;
			}
		}
		return true;
	}

	public virtual byte[] GetCertHash()
	{
		ThrowIfInvalid();
		return GetRawCertHash().CloneByteArray();
	}

	public virtual string GetCertHashString()
	{
		ThrowIfInvalid();
		return GetRawCertHash().ToHexStringUpper();
	}

	private byte[] GetRawCertHash()
	{
		return lazyCertHash ?? (lazyCertHash = Impl.Thumbprint);
	}

	public virtual byte[] GetRawCertData()
	{
		ThrowIfInvalid();
		return Impl.RawData.CloneByteArray();
	}

	public override int GetHashCode()
	{
		if (Impl == null)
		{
			return 0;
		}
		byte[] rawCertHash = GetRawCertHash();
		int num = 0;
		for (int i = 0; i < rawCertHash.Length && i < 4; i++)
		{
			num = (num << 8) | rawCertHash[i];
		}
		return num;
	}

	public virtual string GetKeyAlgorithm()
	{
		ThrowIfInvalid();
		string text = lazyKeyAlgorithm;
		if (text == null)
		{
			text = (lazyKeyAlgorithm = Impl.KeyAlgorithm);
		}
		return text;
	}

	public virtual byte[] GetKeyAlgorithmParameters()
	{
		ThrowIfInvalid();
		byte[] array = lazyKeyAlgorithmParameters;
		if (array == null)
		{
			array = (lazyKeyAlgorithmParameters = Impl.KeyAlgorithmParameters);
		}
		return array.CloneByteArray();
	}

	public virtual byte[] GetPublicKey()
	{
		ThrowIfInvalid();
		byte[] array = lazyPublicKey;
		if (array == null)
		{
			array = (lazyPublicKey = Impl.PublicKeyValue);
		}
		return array.CloneByteArray();
	}

	public virtual byte[] GetSerialNumber()
	{
		ThrowIfInvalid();
		byte[] array = GetRawSerialNumber().CloneByteArray();
		Array.Reverse(array);
		return array;
	}

	public virtual string GetSerialNumberString()
	{
		ThrowIfInvalid();
		return GetRawSerialNumber().ToHexStringUpper();
	}

	private byte[] GetRawSerialNumber()
	{
		return lazySerialNumber ?? (lazySerialNumber = Impl.SerialNumber);
	}

	public override string ToString()
	{
		return ToString(fVerbose: false);
	}

	public virtual string ToString(bool fVerbose)
	{
		if (!fVerbose || !X509Helper.IsValid(impl))
		{
			return base.ToString();
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("[Subject]");
		stringBuilder.Append("  ");
		stringBuilder.AppendLine(Subject);
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Issuer]");
		stringBuilder.Append("  ");
		stringBuilder.AppendLine(Issuer);
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Serial Number]");
		stringBuilder.Append("  ");
		byte[] serialNumber = GetSerialNumber();
		Array.Reverse(serialNumber);
		stringBuilder.Append(serialNumber.ToHexArrayUpper());
		stringBuilder.AppendLine();
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Not Before]");
		stringBuilder.Append("  ");
		stringBuilder.AppendLine(FormatDate(GetNotBefore()));
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Not After]");
		stringBuilder.Append("  ");
		stringBuilder.AppendLine(FormatDate(GetNotAfter()));
		stringBuilder.AppendLine();
		stringBuilder.AppendLine("[Thumbprint]");
		stringBuilder.Append("  ");
		stringBuilder.Append(GetRawCertHash().ToHexArrayUpper());
		stringBuilder.AppendLine();
		return stringBuilder.ToString();
	}

	internal DateTime GetNotAfter()
	{
		ThrowIfInvalid();
		DateTime dateTime = lazyNotAfter;
		if (dateTime == DateTime.MinValue)
		{
			dateTime = (lazyNotAfter = impl.NotAfter);
		}
		return dateTime;
	}

	internal DateTime GetNotBefore()
	{
		ThrowIfInvalid();
		DateTime dateTime = lazyNotBefore;
		if (dateTime == DateTime.MinValue)
		{
			dateTime = (lazyNotBefore = impl.NotBefore);
		}
		return dateTime;
	}

	protected static string FormatDate(DateTime date)
	{
		CultureInfo cultureInfo = CultureInfo.CurrentCulture;
		if (!cultureInfo.DateTimeFormat.Calendar.IsValidDay(date.Year, date.Month, date.Day, 0))
		{
			cultureInfo = CultureInfo.InvariantCulture;
		}
		return date.ToString(cultureInfo);
	}

	internal void ImportHandle(X509CertificateImpl impl)
	{
		Reset();
		this.impl = impl;
	}

	internal void ThrowIfInvalid()
	{
		X509Helper.ThrowIfContextInvalid(impl);
	}
}
