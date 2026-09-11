using System.Collections;
using System.Collections.Specialized;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Text;

namespace System.Net;

[Serializable]
[ComVisible(true)]
[DefaultMember("Item")]
public class WebHeaderCollection : NameValueCollection, ISerializable
{
	private enum RfcChar : byte
	{
		High,
		Reg,
		Ctl,
		CR,
		LF,
		WS,
		Colon,
		Delim
	}

	private const int ApproxAveHeaderLineSize = 30;

	private const int ApproxHighAvgNumHeaders = 16;

	private static readonly HeaderInfoTable HInfo;

	private string[] m_CommonHeaders;

	private int m_NumCommonHeaders;

	private static readonly string[] s_CommonHeaderNames;

	private static readonly sbyte[] s_CommonHeaderHints;

	private const int c_AcceptRanges = 0;

	private const int c_ContentLength = 1;

	private const int c_CacheControl = 2;

	private const int c_ContentType = 3;

	private const int c_Date = 4;

	private const int c_Expires = 5;

	private const int c_ETag = 6;

	private const int c_LastModified = 7;

	private const int c_Location = 8;

	private const int c_ProxyAuthenticate = 9;

	private const int c_P3P = 10;

	private const int c_SetCookie2 = 11;

	private const int c_SetCookie = 12;

	private const int c_Server = 13;

	private const int c_Via = 14;

	private const int c_WwwAuthenticate = 15;

	private const int c_XAspNetVersion = 16;

	private const int c_XPoweredBy = 17;

	private NameValueCollection m_InnerCollection;

	private WebHeaderCollectionType m_Type;

	private static readonly char[] HttpTrimCharacters;

	private static RfcChar[] RfcCharMap;

	private NameValueCollection InnerCollection
	{
		get
		{
			if (m_InnerCollection == null)
			{
				m_InnerCollection = new NameValueCollection(16, CaseInsensitiveAscii.StaticInstance);
			}
			return m_InnerCollection;
		}
	}

	private bool AllowHttpRequestHeader
	{
		get
		{
			if (m_Type == WebHeaderCollectionType.Unknown)
			{
				m_Type = WebHeaderCollectionType.WebRequest;
			}
			if (m_Type != WebHeaderCollectionType.WebRequest && m_Type != WebHeaderCollectionType.HttpWebRequest)
			{
				return m_Type == WebHeaderCollectionType.HttpListenerRequest;
			}
			return true;
		}
	}

	public override int Count => ((m_InnerCollection != null) ? m_InnerCollection.Count : 0) + m_NumCommonHeaders;

	public override string[] AllKeys
	{
		get
		{
			NormalizeCommonHeaders();
			return InnerCollection.AllKeys;
		}
	}

	private void NormalizeCommonHeaders()
	{
		if (m_CommonHeaders == null)
		{
			return;
		}
		for (int i = 0; i < m_CommonHeaders.Length; i++)
		{
			if (m_CommonHeaders[i] != null)
			{
				InnerCollection.Add(s_CommonHeaderNames[i], m_CommonHeaders[i]);
			}
		}
		m_CommonHeaders = null;
		m_NumCommonHeaders = 0;
	}

	internal static bool AllowMultiValues(string name)
	{
		HeaderInfo headerInfo = HInfo[name];
		if (!headerInfo.AllowMultiValues)
		{
			return headerInfo.HeaderName == "";
		}
		return true;
	}

	public void Remove(HttpRequestHeader header)
	{
		if (!AllowHttpRequestHeader)
		{
			throw new InvalidOperationException(global::SR.GetString("This collection holds response headers and cannot contain the specified request header."));
		}
		Remove(UnsafeNclNativeMethods.HttpApi.HTTP_REQUEST_HEADER_ID.ToString((int)header));
	}

	internal void AddInternal(string name, string value)
	{
		NormalizeCommonHeaders();
		InvalidateCachedArrays();
		InnerCollection.Add(name, value);
	}

	internal void ChangeInternal(string name, string value)
	{
		NormalizeCommonHeaders();
		InvalidateCachedArrays();
		InnerCollection.Set(name, value);
	}

	internal void RemoveInternal(string name)
	{
		NormalizeCommonHeaders();
		if (m_InnerCollection != null)
		{
			InvalidateCachedArrays();
			m_InnerCollection.Remove(name);
		}
	}

	internal void CheckUpdate(string name, string value)
	{
		value = CheckBadChars(value, isHeaderValue: true);
		ChangeInternal(name, value);
	}

	internal static string CheckBadChars(string name, bool isHeaderValue)
	{
		if (name == null || name.Length == 0)
		{
			if (!isHeaderValue)
			{
				throw (name == null) ? new ArgumentNullException("name") : new ArgumentException(global::SR.GetString("The parameter '{0}' cannot be an empty string.", "name"), "name");
			}
			return string.Empty;
		}
		if (isHeaderValue)
		{
			name = name.Trim(HttpTrimCharacters);
			int num = 0;
			for (int i = 0; i < name.Length; i++)
			{
				char c = (char)(0xFF & name[i]);
				switch (num)
				{
				case 0:
					if (c == '\r')
					{
						num = 1;
					}
					else if (c == '\n')
					{
						num = 2;
					}
					else if (c == '\u007f' || (c < ' ' && c != '\t'))
					{
						throw new ArgumentException(global::SR.GetString("Specified value has invalid Control characters."), "value");
					}
					break;
				case 1:
					if (c == '\n')
					{
						num = 2;
						break;
					}
					throw new ArgumentException(global::SR.GetString("Specified value has invalid CRLF characters."), "value");
				case 2:
					if (c == ' ' || c == '\t')
					{
						num = 0;
						break;
					}
					throw new ArgumentException(global::SR.GetString("Specified value has invalid CRLF characters."), "value");
				}
			}
			if (num != 0)
			{
				throw new ArgumentException(global::SR.GetString("Specified value has invalid CRLF characters."), "value");
			}
		}
		else
		{
			if (name.IndexOfAny(ValidationHelper.InvalidParamChars) != -1)
			{
				throw new ArgumentException(global::SR.GetString("Specified value has invalid HTTP Header characters."), "name");
			}
			if (ContainsNonAsciiChars(name))
			{
				throw new ArgumentException(global::SR.GetString("Specified value has invalid non-ASCII characters."), "name");
			}
		}
		return name;
	}

	internal static bool IsValidToken(string token)
	{
		if (token.Length > 0 && token.IndexOfAny(ValidationHelper.InvalidParamChars) == -1)
		{
			return !ContainsNonAsciiChars(token);
		}
		return false;
	}

	internal static bool ContainsNonAsciiChars(string token)
	{
		for (int i = 0; i < token.Length; i++)
		{
			if (token[i] < ' ' || token[i] > '~')
			{
				return true;
			}
		}
		return false;
	}

	internal void ThrowOnRestrictedHeader(string headerName)
	{
		if (m_Type == WebHeaderCollectionType.HttpWebRequest)
		{
			if (HInfo[headerName].IsRequestRestricted)
			{
				throw new ArgumentException(global::SR.GetString("The '{0}' header must be modified using the appropriate property or method.", headerName), "name");
			}
		}
		else if (m_Type == WebHeaderCollectionType.HttpListenerResponse && HInfo[headerName].IsResponseRestricted)
		{
			throw new ArgumentException(global::SR.GetString("The '{0}' header must be modified using the appropriate property or method.", headerName), "name");
		}
	}

	public override void Add(string name, string value)
	{
		name = CheckBadChars(name, isHeaderValue: false);
		ThrowOnRestrictedHeader(name);
		value = CheckBadChars(value, isHeaderValue: true);
		if (m_Type == WebHeaderCollectionType.HttpListenerResponse && value != null && value.Length > 65535)
		{
			throw new ArgumentOutOfRangeException("value", value, global::SR.GetString("Header values cannot be longer than {0} characters.", ushort.MaxValue));
		}
		NormalizeCommonHeaders();
		InvalidateCachedArrays();
		InnerCollection.Add(name, value);
	}

	public void Add(string header)
	{
		if (ValidationHelper.IsBlankString(header))
		{
			throw new ArgumentNullException("header");
		}
		int num = header.IndexOf(':');
		if (num < 0)
		{
			throw new ArgumentException(global::SR.GetString("Specified value does not have a ':' separator."), "header");
		}
		string name = header.Substring(0, num);
		string name2 = header.Substring(num + 1);
		name = CheckBadChars(name, isHeaderValue: false);
		ThrowOnRestrictedHeader(name);
		name2 = CheckBadChars(name2, isHeaderValue: true);
		if (m_Type == WebHeaderCollectionType.HttpListenerResponse && name2 != null && name2.Length > 65535)
		{
			throw new ArgumentOutOfRangeException("value", name2, global::SR.GetString("Header values cannot be longer than {0} characters.", ushort.MaxValue));
		}
		NormalizeCommonHeaders();
		InvalidateCachedArrays();
		InnerCollection.Add(name, name2);
	}

	public override void Set(string name, string value)
	{
		if (ValidationHelper.IsBlankString(name))
		{
			throw new ArgumentNullException("name");
		}
		name = CheckBadChars(name, isHeaderValue: false);
		ThrowOnRestrictedHeader(name);
		value = CheckBadChars(value, isHeaderValue: true);
		if (m_Type == WebHeaderCollectionType.HttpListenerResponse && value != null && value.Length > 65535)
		{
			throw new ArgumentOutOfRangeException("value", value, global::SR.GetString("Header values cannot be longer than {0} characters.", ushort.MaxValue));
		}
		NormalizeCommonHeaders();
		InvalidateCachedArrays();
		InnerCollection.Set(name, value);
	}

	internal void SetInternal(string name, string value)
	{
		if (ValidationHelper.IsBlankString(name))
		{
			throw new ArgumentNullException("name");
		}
		name = CheckBadChars(name, isHeaderValue: false);
		value = CheckBadChars(value, isHeaderValue: true);
		if (m_Type == WebHeaderCollectionType.HttpListenerResponse && value != null && value.Length > 65535)
		{
			throw new ArgumentOutOfRangeException("value", value, global::SR.GetString("Header values cannot be longer than {0} characters.", ushort.MaxValue));
		}
		NormalizeCommonHeaders();
		InvalidateCachedArrays();
		InnerCollection.Set(name, value);
	}

	public override void Remove(string name)
	{
		if (ValidationHelper.IsBlankString(name))
		{
			throw new ArgumentNullException("name");
		}
		ThrowOnRestrictedHeader(name);
		name = CheckBadChars(name, isHeaderValue: false);
		NormalizeCommonHeaders();
		if (m_InnerCollection != null)
		{
			InvalidateCachedArrays();
			m_InnerCollection.Remove(name);
		}
	}

	public override string[] GetValues(string header)
	{
		NormalizeCommonHeaders();
		HeaderInfo headerInfo = HInfo[header];
		string[] values = InnerCollection.GetValues(header);
		if (headerInfo == null || values == null || !headerInfo.AllowMultiValues)
		{
			return values;
		}
		ArrayList arrayList = null;
		for (int i = 0; i < values.Length; i++)
		{
			string[] array = headerInfo.Parser(values[i]);
			if (arrayList == null)
			{
				if (array.Length > 1)
				{
					arrayList = new ArrayList(values);
					arrayList.RemoveRange(i, values.Length - i);
					arrayList.AddRange(array);
				}
			}
			else
			{
				arrayList.AddRange(array);
			}
		}
		if (arrayList != null)
		{
			string[] array2 = new string[arrayList.Count];
			arrayList.CopyTo(array2);
			return array2;
		}
		return values;
	}

	public override string ToString()
	{
		return GetAsString(this, winInetCompat: false, forTrace: false);
	}

	internal static string GetAsString(NameValueCollection cc, bool winInetCompat, bool forTrace)
	{
		if (winInetCompat)
		{
			throw new InvalidOperationException();
		}
		if (cc == null || cc.Count == 0)
		{
			return "\r\n";
		}
		StringBuilder stringBuilder = new StringBuilder(30 * cc.Count);
		string text = cc[string.Empty];
		if (text != null)
		{
			stringBuilder.Append(text).Append("\r\n");
		}
		for (int i = 0; i < cc.Count; i++)
		{
			string key = cc.GetKey(i);
			string value = cc.Get(i);
			if (!ValidationHelper.IsBlankString(key))
			{
				stringBuilder.Append(key);
				if (winInetCompat)
				{
					stringBuilder.Append(':');
				}
				else
				{
					stringBuilder.Append(": ");
				}
				stringBuilder.Append(value).Append("\r\n");
			}
		}
		if (!forTrace)
		{
			stringBuilder.Append("\r\n");
		}
		return stringBuilder.ToString();
	}

	public WebHeaderCollection()
		: base(DBNull.Value)
	{
	}

	internal WebHeaderCollection(WebHeaderCollectionType type)
		: base(DBNull.Value)
	{
		m_Type = type;
		if (type == WebHeaderCollectionType.HttpWebResponse)
		{
			m_CommonHeaders = new string[s_CommonHeaderNames.Length - 1];
		}
	}

	protected WebHeaderCollection(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(DBNull.Value)
	{
		int @int = serializationInfo.GetInt32("Count");
		m_InnerCollection = new NameValueCollection(@int + 2, CaseInsensitiveAscii.StaticInstance);
		for (int i = 0; i < @int; i++)
		{
			string name = serializationInfo.GetString(i.ToString(NumberFormatInfo.InvariantInfo));
			string value = serializationInfo.GetString((i + @int).ToString(NumberFormatInfo.InvariantInfo));
			InnerCollection.Add(name, value);
		}
	}

	public override void OnDeserialization(object sender)
	{
	}

	public override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		NormalizeCommonHeaders();
		serializationInfo.AddValue("Count", Count);
		for (int i = 0; i < Count; i++)
		{
			serializationInfo.AddValue(i.ToString(NumberFormatInfo.InvariantInfo), GetKey(i));
			serializationInfo.AddValue((i + Count).ToString(NumberFormatInfo.InvariantInfo), Get(i));
		}
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	public override string Get(string name)
	{
		if (m_CommonHeaders != null && name != null && name.Length > 0 && name[0] < 'Ā')
		{
			int num = s_CommonHeaderHints[name[0] & 0x1F];
			if (num >= 0)
			{
				while (true)
				{
					string text = s_CommonHeaderNames[num++];
					if (text.Length < name.Length || CaseInsensitiveAscii.AsciiToLower[(uint)name[0]] != CaseInsensitiveAscii.AsciiToLower[(uint)text[0]])
					{
						break;
					}
					if (text.Length <= name.Length)
					{
						int i;
						for (i = 1; i < text.Length && (name[i] == text[i] || (name[i] <= 'ÿ' && CaseInsensitiveAscii.AsciiToLower[(uint)name[i]] == CaseInsensitiveAscii.AsciiToLower[(uint)text[i]])); i++)
						{
						}
						if (i == text.Length)
						{
							return m_CommonHeaders[num - 1];
						}
					}
				}
			}
		}
		if (m_InnerCollection == null)
		{
			return null;
		}
		return m_InnerCollection.Get(name);
	}

	public override IEnumerator GetEnumerator()
	{
		NormalizeCommonHeaders();
		return new NameObjectKeysEnumerator(InnerCollection);
	}

	public override string Get(int index)
	{
		NormalizeCommonHeaders();
		return InnerCollection.Get(index);
	}

	public override string GetKey(int index)
	{
		NormalizeCommonHeaders();
		return InnerCollection.GetKey(index);
	}

	static WebHeaderCollection()
	{
		//IL_00f5: Field data (rva=0x768) could not be found in any section!
		//IL_00f5: Field data (rva=0x768) could not be found in any section!
		//IL_00db: Field data (rva=0x730) could not be found in any section!
		//IL_00db: Field data (rva=0x730) could not be found in any section!
		//IL_00c5: Field data (rva=0x5b0) could not be found in any section!
		//IL_00c5: Field data (rva=0x5b0) could not be found in any section!
		HInfo = new HeaderInfoTable();
		s_CommonHeaderNames = new string[19]
		{
			"Accept-Ranges", "Content-Length", "Cache-Control", "Content-Type", "Date", "Expires", "ETag", "Last-Modified", "Location", "Proxy-Authenticate",
			"P3P", "Set-Cookie2", "Set-Cookie", "Server", "Via", "WWW-Authenticate", "X-AspNet-Version", "X-Powered-By", "["
		};
		sbyte[] array = new sbyte[32];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		s_CommonHeaderHints = array;
		char[] array2 = new char[6];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		HttpTrimCharacters = array2;
		RfcChar[] array3 = new RfcChar[128];
		RuntimeHelpers.InitializeArray(array3, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		RfcCharMap = array3;
	}
}
