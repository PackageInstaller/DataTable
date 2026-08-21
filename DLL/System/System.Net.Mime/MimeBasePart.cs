using System.Runtime.CompilerServices;
using System.Text;

namespace System.Net.Mime;

internal class MimeBasePart
{
	private static readonly char[] s_decodeEncodingSplitChars;

	private static readonly char[] s_headerValueSplitChars;

	private static readonly char[] s_questionMarkSplitChars;

	internal static bool ShouldUseBase64Encoding(Encoding encoding)
	{
		if (encoding != Encoding.Unicode && encoding != Encoding.UTF8 && encoding != Encoding.UTF32)
		{
			return encoding == Encoding.BigEndianUnicode;
		}
		return true;
	}

	internal static string EncodeHeaderValue(string value, Encoding encoding, bool base64Encoding)
	{
		return EncodeHeaderValue(value, encoding, base64Encoding, 0);
	}

	internal static string EncodeHeaderValue(string value, Encoding encoding, bool base64Encoding, int headerLength)
	{
		if (IsAscii(value, permitCROrLF: false))
		{
			return value;
		}
		if (encoding == null)
		{
			encoding = Encoding.GetEncoding("utf-8");
		}
		IEncodableStream encoderForHeader = new EncodedStreamFactory().GetEncoderForHeader(encoding, base64Encoding, headerLength);
		byte[] bytes = encoding.GetBytes(value);
		encoderForHeader.EncodeBytes(bytes, 0, bytes.Length);
		return encoderForHeader.GetEncodedString();
	}

	internal static string DecodeHeaderValue(string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			return string.Empty;
		}
		string text = string.Empty;
		string[] array = value.Split(s_headerValueSplitChars, StringSplitOptions.RemoveEmptyEntries);
		for (int i = 0; i < array.Length; i++)
		{
			string[] array2 = array[i].Split(s_questionMarkSplitChars);
			if (array2.Length != 5 || array2[0] != "=" || array2[4] != "=")
			{
				return value;
			}
			string name = array2[1];
			bool useBase64Encoding = array2[2] == "B";
			byte[] bytes = Encoding.ASCII.GetBytes(array2[3]);
			int count = new EncodedStreamFactory().GetEncoderForHeader(Encoding.GetEncoding(name), useBase64Encoding, 0).DecodeBytes(bytes, 0, bytes.Length);
			Encoding encoding = Encoding.GetEncoding(name);
			text += encoding.GetString(bytes, 0, count);
		}
		return text;
	}

	internal static Encoding DecodeEncoding(string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			return null;
		}
		string[] array = value.Split(s_decodeEncodingSplitChars);
		if (array.Length < 5 || array[0] != "=" || array[4] != "=")
		{
			return null;
		}
		return Encoding.GetEncoding(array[1]);
	}

	internal static bool IsAscii(string value, bool permitCROrLF)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		foreach (char c in value)
		{
			if (c > '\u007f')
			{
				return false;
			}
			if (!permitCROrLF && (c == '\r' || c == '\n'))
			{
				return false;
			}
		}
		return true;
	}

	static MimeBasePart()
	{
		//IL_0022: Field data (rva=0x748) could not be found in any section!
		//IL_0022: Field data (rva=0x748) could not be found in any section!
		//IL_000c: Field data (rva=0x740) could not be found in any section!
		//IL_000c: Field data (rva=0x740) could not be found in any section!
		char[] array = new char[3];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		s_decodeEncodingSplitChars = array;
		char[] array2 = new char[3];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		s_headerValueSplitChars = array2;
		s_questionMarkSplitChars = new char[1] { '?' };
	}
}
