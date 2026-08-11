using System.Globalization;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading;

namespace System.Security.Cryptography;

internal class DerSequenceReader
{
	internal enum DerTag : byte
	{
		Boolean = 1,
		Integer = 2,
		BitString = 3,
		OctetString = 4,
		Null = 5,
		ObjectIdentifier = 6,
		UTF8String = 12,
		Sequence = 16,
		Set = 17,
		PrintableString = 19,
		T61String = 20,
		IA5String = 22,
		UTCTime = 23,
		GeneralizedTime = 24,
		BMPString = 30
	}

	internal static DateTimeFormatInfo s_validityDateTimeFormatInfo;

	private static Encoding s_utf8EncodingWithExceptionFallback;

	private static Encoding s_latin1Encoding;

	private readonly byte[] _data;

	private readonly int _end;

	private int _position;

	[CompilerGenerated]
	private int _003CContentLength_003Ek__BackingField;

	private int ContentLength
	{
		[CompilerGenerated]
		set
		{
			_003CContentLength_003Ek__BackingField = value;
		}
	}

	internal bool HasData => _position < _end;

	internal DerSequenceReader(byte[] data)
		: this(data, 0, data.Length)
	{
	}

	internal DerSequenceReader(byte[] data, int offset, int length)
		: this(DerTag.Sequence, data, offset, length)
	{
	}

	private DerSequenceReader(DerTag tagToEat, byte[] data, int offset, int length)
	{
		if (offset < 0 || length < 2 || length > data.Length - offset)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		_data = data;
		_end = offset + length;
		_position = offset;
		EatTag(tagToEat);
		int num = (ContentLength = EatLength());
		_end = _position + num;
	}

	internal byte PeekTag()
	{
		if (!HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		byte num = _data[_position];
		if ((num & 0x1F) == 31)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		return num;
	}

	internal void SkipValue()
	{
		EatTag((DerTag)PeekTag());
		int num = EatLength();
		_position += num;
	}

	internal byte[] ReadNextEncodedValue()
	{
		PeekTag();
		int num = ScanContentLength(_data, _position + 1, _end, out var bytesConsumed);
		int num2 = 1 + bytesConsumed + num;
		byte[] array = new byte[num2];
		Buffer.BlockCopy(_data, _position, array, 0, num2);
		_position += num2;
		return array;
	}

	internal bool ReadBoolean()
	{
		EatTag(DerTag.Boolean);
		int num = EatLength();
		if (num != 1)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		bool result = _data[_position] != 0;
		_position += num;
		return result;
	}

	internal int ReadInteger()
	{
		byte[] array = ReadIntegerBytes();
		Array.Reverse(array);
		return (int)new BigInteger(array);
	}

	internal byte[] ReadIntegerBytes()
	{
		EatTag(DerTag.Integer);
		return ReadContentAsBytes();
	}

	internal byte[] ReadBitString()
	{
		EatTag(DerTag.BitString);
		int num = EatLength();
		if (num < 1)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		if (_data[_position] > 7)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		num--;
		_position++;
		byte[] array = new byte[num];
		Buffer.BlockCopy(_data, _position, array, 0, num);
		_position += num;
		return array;
	}

	internal byte[] ReadOctetString()
	{
		EatTag(DerTag.OctetString);
		return ReadContentAsBytes();
	}

	internal string ReadOidAsString()
	{
		EatTag(DerTag.ObjectIdentifier);
		int num = EatLength();
		if (num < 1)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		StringBuilder stringBuilder = new StringBuilder(num * 4);
		byte num2 = _data[_position];
		byte value = (byte)(num2 / 40);
		byte value2 = (byte)(num2 % 40);
		stringBuilder.Append(value);
		stringBuilder.Append('.');
		stringBuilder.Append(value2);
		bool flag = true;
		BigInteger bigInteger = new BigInteger(0);
		for (int i = 1; i < num; i++)
		{
			byte num3 = _data[_position + i];
			byte b = (byte)(num3 & 0x7F);
			if (flag)
			{
				stringBuilder.Append('.');
				flag = false;
			}
			bigInteger <<= 7;
			bigInteger += (BigInteger)b;
			if (num3 == b)
			{
				stringBuilder.Append(bigInteger);
				bigInteger = 0;
				flag = true;
			}
		}
		_position += num;
		return stringBuilder.ToString();
	}

	internal string ReadUtf8String()
	{
		EatTag(DerTag.UTF8String);
		int num = EatLength();
		string value = Encoding.UTF8.GetString(_data, _position, num);
		_position += num;
		return TrimTrailingNulls(value);
	}

	private DerSequenceReader ReadCollectionWithTag(DerTag expected)
	{
		CheckTag(expected, _data, _position);
		int num = ScanContentLength(_data, _position + 1, _end, out var bytesConsumed);
		int num2 = 1 + bytesConsumed + num;
		DerSequenceReader result = new DerSequenceReader(expected, _data, _position, num2);
		_position += num2;
		return result;
	}

	internal DerSequenceReader ReadSequence()
	{
		return ReadCollectionWithTag(DerTag.Sequence);
	}

	internal DerSequenceReader ReadSet()
	{
		return ReadCollectionWithTag(DerTag.Set);
	}

	internal string ReadPrintableString()
	{
		EatTag(DerTag.PrintableString);
		int num = EatLength();
		string value = Encoding.ASCII.GetString(_data, _position, num);
		_position += num;
		return TrimTrailingNulls(value);
	}

	internal string ReadIA5String()
	{
		EatTag(DerTag.IA5String);
		int num = EatLength();
		string value = Encoding.ASCII.GetString(_data, _position, num);
		_position += num;
		return TrimTrailingNulls(value);
	}

	internal string ReadT61String()
	{
		EatTag(DerTag.T61String);
		int num = EatLength();
		Encoding encoding = LazyInitializer.EnsureInitialized(ref s_utf8EncodingWithExceptionFallback, () => new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true));
		Encoding encoding2 = LazyInitializer.EnsureInitialized(ref s_latin1Encoding, () => Encoding.GetEncoding("iso-8859-1"));
		string value;
		try
		{
			value = encoding.GetString(_data, _position, num);
		}
		catch (DecoderFallbackException)
		{
			value = encoding2.GetString(_data, _position, num);
		}
		_position += num;
		return TrimTrailingNulls(value);
	}

	internal DateTime ReadX509Date()
	{
		return (DerTag)PeekTag() switch
		{
			DerTag.UTCTime => ReadUtcTime(), 
			DerTag.GeneralizedTime => ReadGeneralizedTime(), 
			_ => throw new CryptographicException("ASN1 corrupted data."), 
		};
	}

	internal DateTime ReadUtcTime()
	{
		return ReadTime(DerTag.UTCTime, "yyMMddHHmmss'Z'");
	}

	internal DateTime ReadGeneralizedTime()
	{
		return ReadTime(DerTag.GeneralizedTime, "yyyyMMddHHmmss'Z'");
	}

	internal string ReadBMPString()
	{
		EatTag(DerTag.BMPString);
		int num = EatLength();
		string value = Encoding.BigEndianUnicode.GetString(_data, _position, num);
		_position += num;
		return TrimTrailingNulls(value);
	}

	private static string TrimTrailingNulls(string value)
	{
		if (value != null && value.Length > 0)
		{
			int num = value.Length;
			while (num > 0 && value[num - 1] == '\0')
			{
				num--;
			}
			if (num != value.Length)
			{
				return value.Substring(0, num);
			}
		}
		return value;
	}

	private DateTime ReadTime(DerTag timeTag, string formatString)
	{
		EatTag(timeTag);
		int num = EatLength();
		string s = Encoding.ASCII.GetString(_data, _position, num);
		_position += num;
		DateTimeFormatInfo provider = LazyInitializer.EnsureInitialized(ref s_validityDateTimeFormatInfo, delegate
		{
			DateTimeFormatInfo obj = (DateTimeFormatInfo)CultureInfo.InvariantCulture.DateTimeFormat.Clone();
			obj.Calendar.TwoDigitYearMax = 2049;
			return obj;
		});
		if (!DateTime.TryParseExact(s, formatString, provider, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal, out var result))
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		return result;
	}

	private byte[] ReadContentAsBytes()
	{
		int num = EatLength();
		byte[] array = new byte[num];
		Buffer.BlockCopy(_data, _position, array, 0, num);
		_position += num;
		return array;
	}

	private void EatTag(DerTag expected)
	{
		if (!HasData)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		CheckTag(expected, _data, _position);
		_position++;
	}

	private static void CheckTag(DerTag expected, byte[] data, int position)
	{
		if (position >= data.Length)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		byte num = data[position];
		byte b = (byte)(num & 0x1F);
		if (b == 31)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		if ((num & 0x80) != 0 || (uint)(expected & (DerTag)0x1F) == b)
		{
			return;
		}
		throw new CryptographicException("ASN1 corrupted data.");
	}

	private int EatLength()
	{
		int result = ScanContentLength(_data, _position, _end, out var bytesConsumed);
		_position += bytesConsumed;
		return result;
	}

	private static int ScanContentLength(byte[] data, int offset, int end, out int bytesConsumed)
	{
		if (offset >= end)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		byte b = data[offset];
		if (b < 128)
		{
			bytesConsumed = 1;
			if (b > end - offset - bytesConsumed)
			{
				throw new CryptographicException("ASN1 corrupted data.");
			}
			return b;
		}
		int num = b & 0x7F;
		if (num > 4)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		bytesConsumed = 1 + num;
		if (bytesConsumed > end - offset)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		if (bytesConsumed == 1)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		int num2 = offset + bytesConsumed;
		int num3 = 0;
		for (int i = offset + 1; i < num2; i++)
		{
			num3 <<= 8;
			num3 |= data[i];
		}
		if (num3 < 0)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		if (num3 > end - offset - bytesConsumed)
		{
			throw new CryptographicException("ASN1 corrupted data.");
		}
		return num3;
	}
}
