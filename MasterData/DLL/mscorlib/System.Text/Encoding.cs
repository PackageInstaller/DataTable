using System.Collections.Generic;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Text;

[Serializable]
[ComVisible(true)]
public abstract class Encoding : ICloneable
{
	[Serializable]
	internal class DefaultEncoder : Encoder, ISerializable, IObjectReference
	{
		private Encoding m_encoding;

		[NonSerialized]
		private bool m_hasInitializedEncoding;

		[NonSerialized]
		internal char charLeftOver;

		public DefaultEncoder(Encoding encoding)
		{
			m_encoding = encoding;
			m_hasInitializedEncoding = true;
		}

		internal DefaultEncoder(SerializationInfo info, StreamingContext context)
		{
			if (info == null)
			{
				throw new ArgumentNullException("info");
			}
			m_encoding = (Encoding)info.GetValue("encoding", typeof(Encoding));
			try
			{
				_fallback = (EncoderFallback)info.GetValue("_fallback", typeof(EncoderFallback));
				charLeftOver = (char)info.GetValue("charLeftOver", typeof(char));
			}
			catch (SerializationException)
			{
			}
		}

		public object GetRealObject(StreamingContext context)
		{
			if (m_hasInitializedEncoding)
			{
				return this;
			}
			Encoder encoder = m_encoding.GetEncoder();
			if (_fallback != null)
			{
				encoder._fallback = _fallback;
			}
			if (charLeftOver != 0 && encoder is EncoderNLS encoderNLS)
			{
				encoderNLS._charLeftOver = charLeftOver;
			}
			return encoder;
		}

		void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
		{
			if (info == null)
			{
				throw new ArgumentNullException("info");
			}
			info.AddValue("encoding", m_encoding);
		}

		public override int GetByteCount(char[] chars, int index, int count, bool flush)
		{
			return m_encoding.GetByteCount(chars, index, count);
		}

		public unsafe override int GetByteCount(char* chars, int count, bool flush)
		{
			return m_encoding.GetByteCount(chars, count);
		}

		public override int GetBytes(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex, bool flush)
		{
			return m_encoding.GetBytes(chars, charIndex, charCount, bytes, byteIndex);
		}

		public unsafe override int GetBytes(char* chars, int charCount, byte* bytes, int byteCount, bool flush)
		{
			return m_encoding.GetBytes(chars, charCount, bytes, byteCount);
		}
	}

	[Serializable]
	internal class DefaultDecoder : Decoder, ISerializable, IObjectReference
	{
		private Encoding m_encoding;

		[NonSerialized]
		private bool m_hasInitializedEncoding;

		public DefaultDecoder(Encoding encoding)
		{
			m_encoding = encoding;
			m_hasInitializedEncoding = true;
		}

		internal DefaultDecoder(SerializationInfo info, StreamingContext context)
		{
			if (info == null)
			{
				throw new ArgumentNullException("info");
			}
			m_encoding = (Encoding)info.GetValue("encoding", typeof(Encoding));
			try
			{
				_fallback = (DecoderFallback)info.GetValue("_fallback", typeof(DecoderFallback));
			}
			catch (SerializationException)
			{
				_fallback = null;
			}
		}

		public object GetRealObject(StreamingContext context)
		{
			if (m_hasInitializedEncoding)
			{
				return this;
			}
			Decoder decoder = m_encoding.GetDecoder();
			if (_fallback != null)
			{
				decoder._fallback = _fallback;
			}
			return decoder;
		}

		void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
		{
			if (info == null)
			{
				throw new ArgumentNullException("info");
			}
			info.AddValue("encoding", m_encoding);
		}

		public override int GetCharCount(byte[] bytes, int index, int count)
		{
			return GetCharCount(bytes, index, count, flush: false);
		}

		public override int GetCharCount(byte[] bytes, int index, int count, bool flush)
		{
			return m_encoding.GetCharCount(bytes, index, count);
		}

		public unsafe override int GetCharCount(byte* bytes, int count, bool flush)
		{
			return m_encoding.GetCharCount(bytes, count);
		}

		public override int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex)
		{
			return GetChars(bytes, byteIndex, byteCount, chars, charIndex, flush: false);
		}

		public override int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex, bool flush)
		{
			return m_encoding.GetChars(bytes, byteIndex, byteCount, chars, charIndex);
		}

		public unsafe override int GetChars(byte* bytes, int byteCount, char* chars, int charCount, bool flush)
		{
			return m_encoding.GetChars(bytes, byteCount, chars, charCount);
		}
	}

	internal class EncodingCharBuffer
	{
		private unsafe char* chars;

		private unsafe char* charStart;

		private unsafe char* charEnd;

		private int charCountResult;

		private Encoding enc;

		private DecoderNLS decoder;

		private unsafe byte* byteStart;

		private unsafe byte* byteEnd;

		private unsafe byte* bytes;

		private DecoderFallbackBuffer fallbackBuffer;

		internal unsafe bool MoreData => bytes < byteEnd;

		internal unsafe int BytesUsed => (int)(bytes - byteStart);

		internal int Count => charCountResult;

		internal unsafe EncodingCharBuffer(Encoding enc, DecoderNLS decoder, char* charStart, int charCount, byte* byteStart, int byteCount)
		{
			this.enc = enc;
			this.decoder = decoder;
			chars = charStart;
			this.charStart = charStart;
			charEnd = charStart + charCount;
			this.byteStart = byteStart;
			bytes = byteStart;
			byteEnd = byteStart + byteCount;
			if (this.decoder == null)
			{
				fallbackBuffer = enc.DecoderFallback.CreateFallbackBuffer();
			}
			else
			{
				fallbackBuffer = this.decoder.FallbackBuffer;
			}
			fallbackBuffer.InternalInitialize(bytes, charEnd);
		}

		internal unsafe bool AddChar(char ch, int numBytes)
		{
			if (chars != null)
			{
				if (chars >= charEnd)
				{
					bytes -= numBytes;
					enc.ThrowCharsOverflow(decoder, bytes <= byteStart);
					return false;
				}
				*(chars++) = ch;
			}
			charCountResult++;
			return true;
		}

		internal bool AddChar(char ch)
		{
			return AddChar(ch, 1);
		}

		internal unsafe void AdjustBytes(int count)
		{
			bytes += count;
		}

		internal unsafe byte GetNextByte()
		{
			if (bytes >= byteEnd)
			{
				return 0;
			}
			return *(bytes++);
		}

		internal bool Fallback(byte fallbackByte)
		{
			byte[] byteBuffer = new byte[1] { fallbackByte };
			return Fallback(byteBuffer);
		}

		internal unsafe bool Fallback(byte[] byteBuffer)
		{
			if (chars != null)
			{
				char* ptr = chars;
				if (!fallbackBuffer.InternalFallback(byteBuffer, bytes, ref chars))
				{
					bytes -= byteBuffer.Length;
					fallbackBuffer.InternalReset();
					enc.ThrowCharsOverflow(decoder, chars == charStart);
					return false;
				}
				charCountResult += (int)(chars - ptr);
			}
			else
			{
				charCountResult += fallbackBuffer.InternalFallback(byteBuffer, bytes);
			}
			return true;
		}
	}

	internal class EncodingByteBuffer
	{
		private unsafe byte* bytes;

		private unsafe byte* byteStart;

		private unsafe byte* byteEnd;

		private unsafe char* chars;

		private unsafe char* charStart;

		private unsafe char* charEnd;

		private int byteCountResult;

		private Encoding enc;

		private EncoderNLS encoder;

		internal EncoderFallbackBuffer fallbackBuffer;

		internal unsafe bool MoreData
		{
			get
			{
				if (fallbackBuffer.Remaining <= 0)
				{
					return chars < charEnd;
				}
				return true;
			}
		}

		internal unsafe int CharsUsed => (int)(chars - charStart);

		internal int Count => byteCountResult;

		internal unsafe EncodingByteBuffer(Encoding inEncoding, EncoderNLS inEncoder, byte* inByteStart, int inByteCount, char* inCharStart, int inCharCount)
		{
			enc = inEncoding;
			encoder = inEncoder;
			charStart = inCharStart;
			chars = inCharStart;
			charEnd = inCharStart + inCharCount;
			bytes = inByteStart;
			byteStart = inByteStart;
			byteEnd = inByteStart + inByteCount;
			if (encoder == null)
			{
				fallbackBuffer = enc.EncoderFallback.CreateFallbackBuffer();
			}
			else
			{
				fallbackBuffer = encoder.FallbackBuffer;
				if (encoder._throwOnOverflow && encoder.InternalHasFallbackBuffer && fallbackBuffer.Remaining > 0)
				{
					throw new ArgumentException(Environment.GetResourceString("Must complete Convert() operation or call Encoder.Reset() before calling GetBytes() or GetByteCount(). Encoder '{0}' fallback '{1}'.", encoder.Encoding.EncodingName, encoder.Fallback.GetType()));
				}
			}
			fallbackBuffer.InternalInitialize(chars, charEnd, encoder, bytes != null);
		}

		internal unsafe bool AddByte(byte b, int moreBytesExpected)
		{
			if (bytes != null)
			{
				if (bytes >= byteEnd - moreBytesExpected)
				{
					MovePrevious(bThrow: true);
					return false;
				}
				*(bytes++) = b;
			}
			byteCountResult++;
			return true;
		}

		internal bool AddByte(byte b1)
		{
			return AddByte(b1, 0);
		}

		internal bool AddByte(byte b1, byte b2)
		{
			return AddByte(b1, b2, 0);
		}

		internal bool AddByte(byte b1, byte b2, int moreBytesExpected)
		{
			if (AddByte(b1, 1 + moreBytesExpected))
			{
				return AddByte(b2, moreBytesExpected);
			}
			return false;
		}

		internal unsafe void MovePrevious(bool bThrow)
		{
			if (fallbackBuffer.bFallingBack)
			{
				fallbackBuffer.MovePrevious();
			}
			else if (chars > charStart)
			{
				chars--;
			}
			if (bThrow)
			{
				enc.ThrowBytesOverflow(encoder, bytes == byteStart);
			}
		}

		internal unsafe char GetNextChar()
		{
			char c = fallbackBuffer.InternalGetNextChar();
			if (c == '\0' && chars < charEnd)
			{
				c = *(chars++);
			}
			return c;
		}
	}

	private static volatile Encoding defaultEncoding;

	private static volatile Encoding unicodeEncoding;

	private static volatile Encoding bigEndianUnicode;

	private static volatile Encoding utf7Encoding;

	private static volatile Encoding utf8Encoding;

	private static volatile Encoding utf32Encoding;

	private static volatile Encoding asciiEncoding;

	private static volatile Encoding latin1Encoding;

	private static volatile Dictionary<int, Encoding> encodings;

	private const int MIMECONTF_MAILNEWS = 1;

	private const int MIMECONTF_BROWSER = 2;

	private const int MIMECONTF_SAVABLE_MAILNEWS = 256;

	private const int MIMECONTF_SAVABLE_BROWSER = 512;

	private const int CodePageDefault = 0;

	private const int CodePageNoOEM = 1;

	private const int CodePageNoMac = 2;

	private const int CodePageNoThread = 3;

	private const int CodePageNoSymbol = 42;

	private const int CodePageUnicode = 1200;

	private const int CodePageBigEndian = 1201;

	private const int CodePageWindows1252 = 1252;

	private const int CodePageMacGB2312 = 10008;

	private const int CodePageGB2312 = 20936;

	private const int CodePageMacKorean = 10003;

	private const int CodePageDLLKorean = 20949;

	private const int ISO2022JP = 50220;

	private const int ISO2022JPESC = 50221;

	private const int ISO2022JPSISO = 50222;

	private const int ISOKorean = 50225;

	private const int ISOSimplifiedCN = 50227;

	private const int EUCJP = 51932;

	private const int ChineseHZ = 52936;

	private const int DuplicateEUCCN = 51936;

	private const int EUCCN = 936;

	private const int EUCKR = 51949;

	internal const int CodePageASCII = 20127;

	internal const int ISO_8859_1 = 28591;

	private const int ISCIIAssemese = 57006;

	private const int ISCIIBengali = 57003;

	private const int ISCIIDevanagari = 57002;

	private const int ISCIIGujarathi = 57010;

	private const int ISCIIKannada = 57008;

	private const int ISCIIMalayalam = 57009;

	private const int ISCIIOriya = 57007;

	private const int ISCIIPanjabi = 57011;

	private const int ISCIITamil = 57004;

	private const int ISCIITelugu = 57005;

	private const int GB18030 = 54936;

	private const int ISO_8859_8I = 38598;

	private const int ISO_8859_8_Visual = 28598;

	private const int ENC50229 = 50229;

	private const int CodePageUTF7 = 65000;

	private const int CodePageUTF8 = 65001;

	private const int CodePageUTF32 = 12000;

	private const int CodePageUTF32BE = 12001;

	internal int m_codePage;

	internal CodePageDataItem dataItem;

	[NonSerialized]
	internal bool m_deserializedFromEverett;

	[OptionalField(VersionAdded = 2)]
	private bool m_isReadOnly = true;

	[OptionalField(VersionAdded = 2)]
	internal EncoderFallback encoderFallback;

	[OptionalField(VersionAdded = 2)]
	internal DecoderFallback decoderFallback;

	private static object s_InternalSyncObject;

	private static object InternalSyncObject
	{
		get
		{
			if (s_InternalSyncObject == null)
			{
				object value = new object();
				Interlocked.CompareExchange<object>(ref s_InternalSyncObject, value, (object)null);
			}
			return s_InternalSyncObject;
		}
	}

	public virtual ReadOnlySpan<byte> Preamble => GetPreamble();

	public virtual string BodyName
	{
		get
		{
			if (dataItem == null)
			{
				GetDataItem();
			}
			return dataItem.BodyName;
		}
	}

	public virtual string EncodingName => Environment.GetResourceStringEncodingName(m_codePage);

	public virtual string HeaderName
	{
		get
		{
			if (dataItem == null)
			{
				GetDataItem();
			}
			return dataItem.HeaderName;
		}
	}

	public virtual string WebName
	{
		get
		{
			if (dataItem == null)
			{
				GetDataItem();
			}
			return dataItem.WebName;
		}
	}

	public virtual int WindowsCodePage
	{
		get
		{
			if (dataItem == null)
			{
				GetDataItem();
			}
			return dataItem.UIFamilyCodePage;
		}
	}

	public virtual bool IsBrowserDisplay
	{
		get
		{
			if (dataItem == null)
			{
				GetDataItem();
			}
			return (dataItem.Flags & 2) != 0;
		}
	}

	public virtual bool IsBrowserSave
	{
		get
		{
			if (dataItem == null)
			{
				GetDataItem();
			}
			return (dataItem.Flags & 0x200) != 0;
		}
	}

	public virtual bool IsMailNewsDisplay
	{
		get
		{
			if (dataItem == null)
			{
				GetDataItem();
			}
			return (dataItem.Flags & 1) != 0;
		}
	}

	public virtual bool IsMailNewsSave
	{
		get
		{
			if (dataItem == null)
			{
				GetDataItem();
			}
			return (dataItem.Flags & 0x100) != 0;
		}
	}

	[ComVisible(false)]
	public virtual bool IsSingleByte => false;

	[ComVisible(false)]
	public EncoderFallback EncoderFallback
	{
		get
		{
			return encoderFallback;
		}
		set
		{
			if (IsReadOnly)
			{
				throw new InvalidOperationException(Environment.GetResourceString("Instance is read-only."));
			}
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			encoderFallback = value;
		}
	}

	[ComVisible(false)]
	public DecoderFallback DecoderFallback
	{
		get
		{
			return decoderFallback;
		}
		set
		{
			if (IsReadOnly)
			{
				throw new InvalidOperationException(Environment.GetResourceString("Instance is read-only."));
			}
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			decoderFallback = value;
		}
	}

	[ComVisible(false)]
	public bool IsReadOnly => m_isReadOnly;

	public static Encoding ASCII
	{
		get
		{
			if (asciiEncoding == null)
			{
				asciiEncoding = new ASCIIEncoding();
			}
			return asciiEncoding;
		}
	}

	private static Encoding Latin1
	{
		get
		{
			if (latin1Encoding == null)
			{
				latin1Encoding = new Latin1Encoding();
			}
			return latin1Encoding;
		}
	}

	public virtual int CodePage => m_codePage;

	public static Encoding Default
	{
		get
		{
			if (defaultEncoding == null)
			{
				defaultEncoding = CreateDefaultEncoding();
			}
			return defaultEncoding;
		}
	}

	public static Encoding Unicode
	{
		get
		{
			if (unicodeEncoding == null)
			{
				unicodeEncoding = new UnicodeEncoding(bigEndian: false, byteOrderMark: true);
			}
			return unicodeEncoding;
		}
	}

	public static Encoding BigEndianUnicode
	{
		get
		{
			if (bigEndianUnicode == null)
			{
				bigEndianUnicode = new UnicodeEncoding(bigEndian: true, byteOrderMark: true);
			}
			return bigEndianUnicode;
		}
	}

	public static Encoding UTF7
	{
		get
		{
			if (utf7Encoding == null)
			{
				utf7Encoding = new UTF7Encoding();
			}
			return utf7Encoding;
		}
	}

	public static Encoding UTF8
	{
		get
		{
			if (utf8Encoding == null)
			{
				utf8Encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: true);
			}
			return utf8Encoding;
		}
	}

	public static Encoding UTF32
	{
		get
		{
			if (utf32Encoding == null)
			{
				utf32Encoding = new UTF32Encoding(bigEndian: false, byteOrderMark: true);
			}
			return utf32Encoding;
		}
	}

	protected Encoding()
		: this(0)
	{
	}

	protected Encoding(int codePage)
	{
		if (codePage < 0)
		{
			throw new ArgumentOutOfRangeException("codePage");
		}
		m_codePage = codePage;
		SetDefaultFallbacks();
	}

	protected Encoding(int codePage, EncoderFallback encoderFallback, DecoderFallback decoderFallback)
	{
		if (codePage < 0)
		{
			throw new ArgumentOutOfRangeException("codePage");
		}
		m_codePage = codePage;
		this.encoderFallback = encoderFallback ?? new InternalEncoderBestFitFallback(this);
		this.decoderFallback = decoderFallback ?? new InternalDecoderBestFitFallback(this);
	}

	internal virtual void SetDefaultFallbacks()
	{
		encoderFallback = new InternalEncoderBestFitFallback(this);
		decoderFallback = new InternalDecoderBestFitFallback(this);
	}

	internal void OnDeserializing()
	{
		encoderFallback = null;
		decoderFallback = null;
		m_isReadOnly = true;
	}

	internal void OnDeserialized()
	{
		if (encoderFallback == null || decoderFallback == null)
		{
			m_deserializedFromEverett = true;
			SetDefaultFallbacks();
		}
		dataItem = null;
	}

	[OnDeserializing]
	private void OnDeserializing(StreamingContext ctx)
	{
		OnDeserializing();
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext ctx)
	{
		OnDeserialized();
	}

	[OnSerializing]
	private void OnSerializing(StreamingContext ctx)
	{
		dataItem = null;
	}

	internal void DeserializeEncoding(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		m_codePage = (int)info.GetValue("m_codePage", typeof(int));
		dataItem = null;
		try
		{
			m_isReadOnly = (bool)info.GetValue("m_isReadOnly", typeof(bool));
			encoderFallback = (EncoderFallback)info.GetValue("encoderFallback", typeof(EncoderFallback));
			decoderFallback = (DecoderFallback)info.GetValue("decoderFallback", typeof(DecoderFallback));
		}
		catch (SerializationException)
		{
			m_deserializedFromEverett = true;
			m_isReadOnly = true;
			SetDefaultFallbacks();
		}
	}

	internal void SerializeEncoding(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("m_isReadOnly", m_isReadOnly);
		info.AddValue("encoderFallback", EncoderFallback);
		info.AddValue("decoderFallback", DecoderFallback);
		info.AddValue("m_codePage", m_codePage);
		info.AddValue("dataItem", null);
		info.AddValue("Encoding+m_codePage", m_codePage);
		info.AddValue("Encoding+dataItem", null);
	}

	public static byte[] Convert(Encoding srcEncoding, Encoding dstEncoding, byte[] bytes)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes");
		}
		return Convert(srcEncoding, dstEncoding, bytes, 0, bytes.Length);
	}

	public static byte[] Convert(Encoding srcEncoding, Encoding dstEncoding, byte[] bytes, int index, int count)
	{
		if (srcEncoding == null || dstEncoding == null)
		{
			throw new ArgumentNullException((srcEncoding == null) ? "srcEncoding" : "dstEncoding", Environment.GetResourceString("Array cannot be null."));
		}
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", Environment.GetResourceString("Array cannot be null."));
		}
		return dstEncoding.GetBytes(srcEncoding.GetChars(bytes, index, count));
	}

	public static void RegisterProvider(EncodingProvider provider)
	{
		EncodingProvider.AddProvider(provider);
	}

	public static Encoding GetEncoding(int codepage)
	{
		Encoding value = EncodingProvider.GetEncodingFromProvider(codepage);
		if (value != null)
		{
			return value;
		}
		if (codepage < 0 || codepage > 65535)
		{
			throw new ArgumentOutOfRangeException("codepage", Environment.GetResourceString("Valid values are between {0} and {1}, inclusive.", 0, 65535));
		}
		lock (InternalSyncObject)
		{
			if (encodings != null)
			{
				encodings.TryGetValue(codepage, out value);
			}
			if (value == null)
			{
				if (encodings == null)
				{
					encodings = new Dictionary<int, Encoding>();
				}
				if (encodings.TryGetValue(codepage, out value))
				{
					return value;
				}
				switch (codepage)
				{
				case 0:
					value = Default;
					break;
				case 1200:
					value = Unicode;
					break;
				case 1201:
					value = BigEndianUnicode;
					break;
				case 65000:
					value = UTF7;
					break;
				case 12000:
					value = UTF32;
					break;
				case 12001:
					value = new UTF32Encoding(bigEndian: true, byteOrderMark: true);
					break;
				case 65001:
					value = UTF8;
					break;
				case 1:
				case 2:
				case 3:
				case 42:
					throw new ArgumentException(Environment.GetResourceString("{0} is not a supported code page.", codepage), "codepage");
				case 20127:
					value = ASCII;
					break;
				case 28591:
					value = Latin1;
					break;
				default:
					if (EncodingTable.GetCodePageDataItem(codepage) == null)
					{
						throw new NotSupportedException(Environment.GetResourceString("No data is available for encoding {0}. For information on defining a custom encoding, see the documentation for the Encoding.RegisterProvider method.", codepage));
					}
					switch (codepage)
					{
					case 12000:
						value = UTF32;
						break;
					case 12001:
						value = new UTF32Encoding(bigEndian: true, byteOrderMark: true);
						break;
					default:
						value = (Encoding)EncodingHelper.InvokeI18N("GetEncoding", codepage);
						if (value == null)
						{
							throw new NotSupportedException($"Encoding {codepage} data could not be found. Make sure you have correct international codeset assembly installed and enabled.");
						}
						break;
					}
					break;
				}
				encodings.Add(codepage, value);
			}
		}
		return value;
	}

	public static Encoding GetEncoding(int codepage, EncoderFallback encoderFallback, DecoderFallback decoderFallback)
	{
		Encoding encodingFromProvider = EncodingProvider.GetEncodingFromProvider(codepage, encoderFallback, decoderFallback);
		if (encodingFromProvider != null)
		{
			return encodingFromProvider;
		}
		encodingFromProvider = GetEncoding(codepage);
		Encoding obj = (Encoding)encodingFromProvider.Clone();
		obj.EncoderFallback = encoderFallback;
		obj.DecoderFallback = decoderFallback;
		return obj;
	}

	public static Encoding GetEncoding(string name)
	{
		Encoding encodingFromProvider = EncodingProvider.GetEncodingFromProvider(name);
		if (encodingFromProvider != null)
		{
			return encodingFromProvider;
		}
		return GetEncoding(EncodingTable.GetCodePageFromName(name));
	}

	public static Encoding GetEncoding(string name, EncoderFallback encoderFallback, DecoderFallback decoderFallback)
	{
		Encoding encodingFromProvider = EncodingProvider.GetEncodingFromProvider(name, encoderFallback, decoderFallback);
		if (encodingFromProvider != null)
		{
			return encodingFromProvider;
		}
		return GetEncoding(EncodingTable.GetCodePageFromName(name), encoderFallback, decoderFallback);
	}

	public static EncodingInfo[] GetEncodings()
	{
		return EncodingTable.GetEncodings();
	}

	public virtual byte[] GetPreamble()
	{
		return EmptyArray<byte>.Value;
	}

	private void GetDataItem()
	{
		if (dataItem == null)
		{
			dataItem = EncodingTable.GetCodePageDataItem(m_codePage);
			if (dataItem == null)
			{
				throw new NotSupportedException(Environment.GetResourceString("No data is available for encoding {0}. For information on defining a custom encoding, see the documentation for the Encoding.RegisterProvider method.", m_codePage));
			}
		}
	}

	[ComVisible(false)]
	public virtual object Clone()
	{
		Encoding obj = (Encoding)MemberwiseClone();
		obj.m_isReadOnly = false;
		return obj;
	}

	public virtual int GetByteCount(char[] chars)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("chars", Environment.GetResourceString("Array cannot be null."));
		}
		return GetByteCount(chars, 0, chars.Length);
	}

	public virtual int GetByteCount(string s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		char[] array = s.ToCharArray();
		return GetByteCount(array, 0, array.Length);
	}

	public abstract int GetByteCount(char[] chars, int index, int count);

	public int GetByteCount(string str, int index, int count)
	{
		return GetByteCount(str.ToCharArray(), index, count);
	}

	[ComVisible(false)]
	[CLSCompliant(false)]
	public unsafe virtual int GetByteCount(char* chars, int count)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("chars", Environment.GetResourceString("Array cannot be null."));
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", Environment.GetResourceString("Non-negative number required."));
		}
		char[] array = new char[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = chars[i];
		}
		return GetByteCount(array, 0, count);
	}

	internal unsafe virtual int GetByteCount(char* chars, int count, EncoderNLS encoder)
	{
		return GetByteCount(chars, count);
	}

	public virtual byte[] GetBytes(char[] chars)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("chars", Environment.GetResourceString("Array cannot be null."));
		}
		return GetBytes(chars, 0, chars.Length);
	}

	public virtual byte[] GetBytes(char[] chars, int index, int count)
	{
		byte[] array = new byte[GetByteCount(chars, index, count)];
		GetBytes(chars, index, count, array, 0);
		return array;
	}

	public abstract int GetBytes(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex);

	public virtual byte[] GetBytes(string s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s", Environment.GetResourceString("String reference not set to an instance of a String."));
		}
		byte[] array = new byte[GetByteCount(s)];
		GetBytes(s, 0, s.Length, array, 0);
		return array;
	}

	public virtual int GetBytes(string s, int charIndex, int charCount, byte[] bytes, int byteIndex)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		return GetBytes(s.ToCharArray(), charIndex, charCount, bytes, byteIndex);
	}

	internal unsafe virtual int GetBytes(char* chars, int charCount, byte* bytes, int byteCount, EncoderNLS encoder)
	{
		return GetBytes(chars, charCount, bytes, byteCount);
	}

	[ComVisible(false)]
	[CLSCompliant(false)]
	public unsafe virtual int GetBytes(char* chars, int charCount, byte* bytes, int byteCount)
	{
		if (bytes == null || chars == null)
		{
			throw new ArgumentNullException((bytes == null) ? "bytes" : "chars", Environment.GetResourceString("Array cannot be null."));
		}
		if (charCount < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((charCount < 0) ? "charCount" : "byteCount", Environment.GetResourceString("Non-negative number required."));
		}
		char[] array = new char[charCount];
		for (int i = 0; i < charCount; i++)
		{
			array[i] = chars[i];
		}
		byte[] array2 = new byte[byteCount];
		int bytes2 = GetBytes(array, 0, charCount, array2, 0);
		if (bytes2 < byteCount)
		{
			byteCount = bytes2;
		}
		for (int i = 0; i < byteCount; i++)
		{
			bytes[i] = array2[i];
		}
		return byteCount;
	}

	public virtual int GetCharCount(byte[] bytes)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", Environment.GetResourceString("Array cannot be null."));
		}
		return GetCharCount(bytes, 0, bytes.Length);
	}

	public abstract int GetCharCount(byte[] bytes, int index, int count);

	[CLSCompliant(false)]
	[ComVisible(false)]
	public unsafe virtual int GetCharCount(byte* bytes, int count)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", Environment.GetResourceString("Array cannot be null."));
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", Environment.GetResourceString("Non-negative number required."));
		}
		byte[] array = new byte[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = bytes[i];
		}
		return GetCharCount(array, 0, count);
	}

	internal unsafe virtual int GetCharCount(byte* bytes, int count, DecoderNLS decoder)
	{
		return GetCharCount(bytes, count);
	}

	public virtual char[] GetChars(byte[] bytes)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", Environment.GetResourceString("Array cannot be null."));
		}
		return GetChars(bytes, 0, bytes.Length);
	}

	public virtual char[] GetChars(byte[] bytes, int index, int count)
	{
		char[] array = new char[GetCharCount(bytes, index, count)];
		GetChars(bytes, index, count, array, 0);
		return array;
	}

	public abstract int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex);

	[ComVisible(false)]
	[CLSCompliant(false)]
	public unsafe virtual int GetChars(byte* bytes, int byteCount, char* chars, int charCount)
	{
		if (chars == null || bytes == null)
		{
			throw new ArgumentNullException((chars == null) ? "chars" : "bytes", Environment.GetResourceString("Array cannot be null."));
		}
		if (byteCount < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteCount < 0) ? "byteCount" : "charCount", Environment.GetResourceString("Non-negative number required."));
		}
		byte[] array = new byte[byteCount];
		for (int i = 0; i < byteCount; i++)
		{
			array[i] = bytes[i];
		}
		char[] array2 = new char[charCount];
		int chars2 = GetChars(array, 0, byteCount, array2, 0);
		if (chars2 < charCount)
		{
			charCount = chars2;
		}
		for (int i = 0; i < charCount; i++)
		{
			chars[i] = array2[i];
		}
		return charCount;
	}

	internal unsafe virtual int GetChars(byte* bytes, int byteCount, char* chars, int charCount, DecoderNLS decoder)
	{
		return GetChars(bytes, byteCount, chars, charCount);
	}

	[CLSCompliant(false)]
	[ComVisible(false)]
	public unsafe string GetString(byte* bytes, int byteCount)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", Environment.GetResourceString("Array cannot be null."));
		}
		if (byteCount < 0)
		{
			throw new ArgumentOutOfRangeException("byteCount", Environment.GetResourceString("Non-negative number required."));
		}
		return string.CreateStringFromEncoding(bytes, byteCount, this);
	}

	public unsafe virtual int GetChars(ReadOnlySpan<byte> bytes, Span<char> chars)
	{
		fixed (byte* nonNullPinnableReference = &MemoryMarshal.GetNonNullPinnableReference(bytes))
		{
			fixed (char* nonNullPinnableReference2 = &MemoryMarshal.GetNonNullPinnableReference(chars))
			{
				return GetChars(nonNullPinnableReference, bytes.Length, nonNullPinnableReference2, chars.Length);
			}
		}
	}

	public unsafe string GetString(ReadOnlySpan<byte> bytes)
	{
		fixed (byte* nonNullPinnableReference = &MemoryMarshal.GetNonNullPinnableReference(bytes))
		{
			return GetString(nonNullPinnableReference, bytes.Length);
		}
	}

	[ComVisible(false)]
	public bool IsAlwaysNormalized()
	{
		return IsAlwaysNormalized(NormalizationForm.FormC);
	}

	[ComVisible(false)]
	public virtual bool IsAlwaysNormalized(NormalizationForm form)
	{
		return false;
	}

	public virtual Decoder GetDecoder()
	{
		return new DefaultDecoder(this);
	}

	private static Encoding CreateDefaultEncoding()
	{
		Encoding encoding = EncodingHelper.GetDefaultEncoding();
		encoding.m_isReadOnly = true;
		return encoding;
	}

	internal void setReadOnly(bool value = true)
	{
		m_isReadOnly = value;
	}

	public virtual Encoder GetEncoder()
	{
		return new DefaultEncoder(this);
	}

	public abstract int GetMaxByteCount(int charCount);

	public abstract int GetMaxCharCount(int byteCount);

	public virtual string GetString(byte[] bytes)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", Environment.GetResourceString("Array cannot be null."));
		}
		return GetString(bytes, 0, bytes.Length);
	}

	public virtual string GetString(byte[] bytes, int index, int count)
	{
		return new string(GetChars(bytes, index, count));
	}

	public override bool Equals(object value)
	{
		if (value is Encoding encoding)
		{
			if (m_codePage == encoding.m_codePage && EncoderFallback.Equals(encoding.EncoderFallback))
			{
				return DecoderFallback.Equals(encoding.DecoderFallback);
			}
			return false;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return m_codePage + EncoderFallback.GetHashCode() + DecoderFallback.GetHashCode();
	}

	internal virtual char[] GetBestFitUnicodeToBytesData()
	{
		return EmptyArray<char>.Value;
	}

	internal virtual char[] GetBestFitBytesToUnicodeData()
	{
		return EmptyArray<char>.Value;
	}

	internal void ThrowBytesOverflow()
	{
		throw new ArgumentException(Environment.GetResourceString("The output byte buffer is too small to contain the encoded data, encoding '{0}' fallback '{1}'.", EncodingName, EncoderFallback.GetType()), "bytes");
	}

	internal void ThrowBytesOverflow(EncoderNLS encoder, bool nothingEncoded)
	{
		if ((encoder?._throwOnOverflow ?? true) | nothingEncoded)
		{
			if (encoder != null && encoder.InternalHasFallbackBuffer)
			{
				encoder.FallbackBuffer.InternalReset();
			}
			ThrowBytesOverflow();
		}
		encoder.ClearMustFlush();
	}

	internal void ThrowCharsOverflow()
	{
		throw new ArgumentException(Environment.GetResourceString("The output char buffer is too small to contain the decoded characters, encoding '{0}' fallback '{1}'.", EncodingName, DecoderFallback.GetType()), "chars");
	}

	internal void ThrowCharsOverflow(DecoderNLS decoder, bool nothingDecoded)
	{
		if ((decoder?._throwOnOverflow ?? true) | nothingDecoded)
		{
			if (decoder != null && decoder.InternalHasFallbackBuffer)
			{
				decoder.FallbackBuffer.InternalReset();
			}
			ThrowCharsOverflow();
		}
		decoder.ClearMustFlush();
	}

	public unsafe virtual int GetCharCount(ReadOnlySpan<byte> bytes)
	{
		fixed (byte* nonNullPinnableReference = &MemoryMarshal.GetNonNullPinnableReference(bytes))
		{
			return GetCharCount(nonNullPinnableReference, bytes.Length);
		}
	}

	public unsafe virtual int GetByteCount(ReadOnlySpan<char> chars)
	{
		fixed (char* nonNullPinnableReference = &MemoryMarshal.GetNonNullPinnableReference(chars))
		{
			return GetByteCount(nonNullPinnableReference, chars.Length);
		}
	}

	public unsafe virtual int GetBytes(ReadOnlySpan<char> chars, Span<byte> bytes)
	{
		fixed (char* nonNullPinnableReference = &MemoryMarshal.GetNonNullPinnableReference(chars))
		{
			fixed (byte* nonNullPinnableReference2 = &MemoryMarshal.GetNonNullPinnableReference(bytes))
			{
				return GetBytes(nonNullPinnableReference, chars.Length, nonNullPinnableReference2, bytes.Length);
			}
		}
	}

	public unsafe byte[] GetBytes(string s, int index, int count)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s", "String reference not set to an instance of a String.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (index > s.Length - count)
		{
			throw new ArgumentOutOfRangeException("index", "Index and count must refer to a location within the string.");
		}
		fixed (char* ptr = s)
		{
			int byteCount = GetByteCount(ptr + index, count);
			if (byteCount == 0)
			{
				return Array.Empty<byte>();
			}
			byte[] array = new byte[byteCount];
			fixed (byte* bytes = &array[0])
			{
				GetBytes(ptr + index, count, bytes, byteCount);
			}
			return array;
		}
	}
}
