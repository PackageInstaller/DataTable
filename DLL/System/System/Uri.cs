using System.Collections;
using System.ComponentModel;
using System.Globalization;
using System.IO;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Text;
using System.Threading;

namespace System;

[Serializable]
[TypeConverter(typeof(UriTypeConverter))]
public class Uri : ISerializable
{
	[Flags]
	private enum Flags : ulong
	{
		Zero = 0uL,
		SchemeNotCanonical = 1uL,
		UserNotCanonical = 2uL,
		HostNotCanonical = 4uL,
		PortNotCanonical = 8uL,
		PathNotCanonical = 0x10uL,
		QueryNotCanonical = 0x20uL,
		FragmentNotCanonical = 0x40uL,
		CannotDisplayCanonical = SchemeNotCanonical | UserNotCanonical | HostNotCanonical | PortNotCanonical | PathNotCanonical | QueryNotCanonical | FragmentNotCanonical,
		E_UserNotCanonical = 0x80uL,
		E_HostNotCanonical = 0x100uL,
		E_PortNotCanonical = 0x200uL,
		E_PathNotCanonical = 0x400uL,
		E_QueryNotCanonical = 0x800uL,
		E_FragmentNotCanonical = 0x1000uL,
		E_CannotDisplayCanonical = E_UserNotCanonical | E_HostNotCanonical | E_PortNotCanonical | E_PathNotCanonical | E_QueryNotCanonical | E_FragmentNotCanonical,
		ShouldBeCompressed = 0x2000uL,
		FirstSlashAbsent = 0x4000uL,
		BackslashInPath = 0x8000uL,
		IndexMask = CannotDisplayCanonical | E_CannotDisplayCanonical | ShouldBeCompressed | FirstSlashAbsent | BackslashInPath,
		HostTypeMask = 0x70000uL,
		HostNotParsed = 0uL,
		IPv6HostType = 0x10000uL,
		IPv4HostType = 0x20000uL,
		DnsHostType = 0x30000uL,
		UncHostType = 0x40000uL,
		BasicHostType = 0x50000uL,
		UnusedHostType = 0x60000uL,
		UnknownHostType = HostTypeMask,
		UserEscaped = 0x80000uL,
		AuthorityFound = 0x100000uL,
		HasUserInfo = 0x200000uL,
		LoopbackHost = 0x400000uL,
		NotDefaultPort = 0x800000uL,
		UserDrivenParsing = 0x1000000uL,
		CanonicalDnsHost = 0x2000000uL,
		ErrorOrParsingRecursion = 0x4000000uL,
		DosPath = 0x8000000uL,
		UncPath = 0x10000000uL,
		ImplicitFile = 0x20000000uL,
		MinimalUriInfoSet = 0x40000000uL,
		AllUriInfoSet = 0x80000000uL,
		IdnHost = 0x100000000uL,
		HasUnicode = 0x200000000uL,
		HostUnicodeNormalized = 0x400000000uL,
		RestUnicodeNormalized = 0x800000000uL,
		UnicodeHost = 0x1000000000uL,
		IntranetUri = 0x2000000000uL,
		UseOrigUncdStrOffset = 0x4000000000uL,
		UserIriCanonical = 0x8000000000uL,
		PathIriCanonical = 0x10000000000uL,
		QueryIriCanonical = 0x20000000000uL,
		FragmentIriCanonical = 0x40000000000uL,
		IriCanonical = UserIriCanonical | PathIriCanonical | QueryIriCanonical | FragmentIriCanonical,
		CompressedSlashes = 0x100000000000uL
	}

	private class UriInfo
	{
		public string Host;

		public string ScopeId;

		public string String;

		public Offset Offset;

		public string DnsSafeHost;

		public MoreInfo MoreInfo;
	}

	[StructLayout(LayoutKind.Sequential, Pack = 1)]
	private struct Offset
	{
		public ushort Scheme;

		public ushort User;

		public ushort Host;

		public ushort PortValue;

		public ushort Path;

		public ushort Query;

		public ushort Fragment;

		public ushort End;
	}

	private class MoreInfo
	{
		public string Path;

		public string Query;

		public string Fragment;

		public string AbsoluteUri;

		public int Hash;

		public string RemoteUrl;
	}

	[Flags]
	private enum Check
	{
		None = 0,
		EscapedCanonical = 1,
		DisplayCanonical = 2,
		DotSlashAttn = 4,
		DotSlashEscaped = 0x80,
		BackslashInPath = 0x10,
		ReservedFound = 0x20,
		NotIriCanonical = 0x40,
		FoundNonAscii = 8
	}

	public static readonly string UriSchemeFile = UriParser.FileUri.SchemeName;

	public static readonly string UriSchemeFtp = UriParser.FtpUri.SchemeName;

	public static readonly string UriSchemeGopher = UriParser.GopherUri.SchemeName;

	public static readonly string UriSchemeHttp = UriParser.HttpUri.SchemeName;

	public static readonly string UriSchemeHttps = UriParser.HttpsUri.SchemeName;

	internal static readonly string UriSchemeWs = UriParser.WsUri.SchemeName;

	internal static readonly string UriSchemeWss = UriParser.WssUri.SchemeName;

	public static readonly string UriSchemeMailto = UriParser.MailToUri.SchemeName;

	public static readonly string UriSchemeNews = UriParser.NewsUri.SchemeName;

	public static readonly string UriSchemeNntp = UriParser.NntpUri.SchemeName;

	public static readonly string UriSchemeNetTcp = UriParser.NetTcpUri.SchemeName;

	public static readonly string UriSchemeNetPipe = UriParser.NetPipeUri.SchemeName;

	public static readonly string SchemeDelimiter = "://";

	private const int c_Max16BitUtf8SequenceLength = 12;

	internal const int c_MaxUriBufferSize = 65520;

	private const int c_MaxUriSchemeName = 1024;

	private string m_String;

	private string m_originalUnicodeString;

	private UriParser m_Syntax;

	private string m_DnsSafeHost;

	private Flags m_Flags;

	private UriInfo m_Info;

	private bool m_iriParsing;

	private static volatile bool s_ConfigInitialized;

	private static volatile bool s_ConfigInitializing;

	private static volatile UriIdnScope s_IdnScope = UriIdnScope.None;

	private static volatile bool s_IriParsing = !(Environment.GetEnvironmentVariable("MONO_URI_IRIPARSING") == "false");

	private static bool useDotNetRelativeOrAbsolute = Environment.GetEnvironmentVariable("MONO_URI_DOTNETRELATIVEORABSOLUTE") == "true";

	private const UriKind DotNetRelativeOrAbsolute = (UriKind)300;

	internal static readonly bool IsWindowsFileSystem = Path.DirectorySeparatorChar == '\\';

	private static object s_initLock;

	private const UriFormat V1ToStringUnescape = (UriFormat)32767;

	internal const char c_DummyChar = '\uffff';

	internal const char c_EOL = '\ufffe';

	internal static readonly char[] HexLowerChars = new char[16]
	{
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'a', 'b', 'c', 'd', 'e', 'f'
	};

	private static readonly char[] _WSchars = new char[4] { ' ', '\n', '\r', '\t' };

	private bool IsImplicitFile => (m_Flags & Flags.ImplicitFile) != 0;

	private bool IsUncOrDosPath => (m_Flags & (Flags.DosPath | Flags.UncPath)) != 0;

	private bool IsDosPath => (m_Flags & Flags.DosPath) != 0;

	private bool IsUncPath => (m_Flags & Flags.UncPath) != 0;

	private Flags HostType => m_Flags & Flags.HostTypeMask;

	private UriParser Syntax => m_Syntax;

	private bool IsNotAbsoluteUri => m_Syntax == null;

	private bool AllowIdn
	{
		get
		{
			if (m_Syntax != null && (m_Syntax.Flags & UriSyntaxFlags.AllowIdn) != UriSyntaxFlags.None)
			{
				if (s_IdnScope != UriIdnScope.All)
				{
					if (s_IdnScope == UriIdnScope.AllExceptIntranet)
					{
						return NotAny(Flags.IntranetUri);
					}
					return false;
				}
				return true;
			}
			return false;
		}
	}

	internal bool UserDrivenParsing => (m_Flags & Flags.UserDrivenParsing) != 0;

	private ushort SecuredPathIndex
	{
		get
		{
			if (IsDosPath)
			{
				char c = m_String[m_Info.Offset.Path];
				return (ushort)((c == '/' || c == '\\') ? 3u : 2u);
			}
			return 0;
		}
	}

	public string AbsolutePath
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			string text = PrivateAbsolutePath;
			if (IsDosPath && text[0] == '/')
			{
				text = text.Substring(1);
			}
			return text;
		}
	}

	private string PrivateAbsolutePath
	{
		get
		{
			UriInfo uriInfo = EnsureUriInfo();
			if (uriInfo.MoreInfo == null)
			{
				uriInfo.MoreInfo = new MoreInfo();
			}
			string text = uriInfo.MoreInfo.Path;
			if (text == null)
			{
				text = GetParts(UriComponents.Path | UriComponents.KeepDelimiter, UriFormat.UriEscaped);
				uriInfo.MoreInfo.Path = text;
			}
			return text;
		}
	}

	public string AbsoluteUri
	{
		get
		{
			if (m_Syntax == null)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			UriInfo uriInfo = EnsureUriInfo();
			if (uriInfo.MoreInfo == null)
			{
				uriInfo.MoreInfo = new MoreInfo();
			}
			string text = uriInfo.MoreInfo.AbsoluteUri;
			if (text == null)
			{
				text = GetParts(UriComponents.AbsoluteUri, UriFormat.UriEscaped);
				uriInfo.MoreInfo.AbsoluteUri = text;
			}
			return text;
		}
	}

	public string LocalPath
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			return GetLocalPath();
		}
	}

	public string Authority
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			return GetParts(UriComponents.Host | UriComponents.Port, UriFormat.UriEscaped);
		}
	}

	public UriHostNameType HostNameType
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			if (m_Syntax.IsSimple)
			{
				EnsureUriInfo();
			}
			else
			{
				EnsureHostString(allowDnsOptimization: false);
			}
			return HostType switch
			{
				Flags.DnsHostType => UriHostNameType.Dns, 
				Flags.IPv4HostType => UriHostNameType.IPv4, 
				Flags.IPv6HostType => UriHostNameType.IPv6, 
				Flags.BasicHostType => UriHostNameType.Basic, 
				Flags.UncHostType => UriHostNameType.Basic, 
				Flags.HostTypeMask => UriHostNameType.Unknown, 
				_ => UriHostNameType.Unknown, 
			};
		}
	}

	public bool IsDefaultPort
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			if (m_Syntax.IsSimple)
			{
				EnsureUriInfo();
			}
			else
			{
				EnsureHostString(allowDnsOptimization: false);
			}
			return NotAny(Flags.NotDefaultPort);
		}
	}

	public bool IsFile
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			return (object)m_Syntax.SchemeName == UriSchemeFile;
		}
	}

	public bool IsLoopback
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			EnsureHostString(allowDnsOptimization: false);
			return InFact(Flags.LoopbackHost);
		}
	}

	public string PathAndQuery
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			string text = GetParts(UriComponents.PathAndQuery, UriFormat.UriEscaped);
			if (IsDosPath && text[0] == '/')
			{
				text = text.Substring(1);
			}
			return text;
		}
	}

	public string[] Segments
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			string[] array = null;
			if (array == null)
			{
				string privateAbsolutePath = PrivateAbsolutePath;
				if (privateAbsolutePath.Length == 0)
				{
					array = new string[0];
				}
				else
				{
					ArrayList arrayList = new ArrayList();
					int num = 0;
					while (num < privateAbsolutePath.Length)
					{
						int num2 = privateAbsolutePath.IndexOf('/', num);
						if (num2 == -1)
						{
							num2 = privateAbsolutePath.Length - 1;
						}
						arrayList.Add(privateAbsolutePath.Substring(num, num2 - num + 1));
						num = num2 + 1;
					}
					array = (string[])arrayList.ToArray(typeof(string));
				}
			}
			return array;
		}
	}

	public bool IsUnc
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			return IsUncPath;
		}
	}

	public string Host
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			return GetParts(UriComponents.Host, UriFormat.UriEscaped);
		}
	}

	private static object InitializeLock
	{
		get
		{
			if (s_initLock == null)
			{
				object value = new object();
				Interlocked.CompareExchange(ref s_initLock, value, null);
			}
			return s_initLock;
		}
	}

	public int Port
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			if (m_Syntax.IsSimple)
			{
				EnsureUriInfo();
			}
			else
			{
				EnsureHostString(allowDnsOptimization: false);
			}
			if (InFact(Flags.NotDefaultPort))
			{
				return m_Info.Offset.PortValue;
			}
			return m_Syntax.DefaultPort;
		}
	}

	public string Query
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			UriInfo uriInfo = EnsureUriInfo();
			if (uriInfo.MoreInfo == null)
			{
				uriInfo.MoreInfo = new MoreInfo();
			}
			string text = uriInfo.MoreInfo.Query;
			if (text == null)
			{
				text = GetParts(UriComponents.Query | UriComponents.KeepDelimiter, UriFormat.UriEscaped);
				uriInfo.MoreInfo.Query = text;
			}
			return text;
		}
	}

	public string Fragment
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			UriInfo uriInfo = EnsureUriInfo();
			if (uriInfo.MoreInfo == null)
			{
				uriInfo.MoreInfo = new MoreInfo();
			}
			string text = uriInfo.MoreInfo.Fragment;
			if (text == null)
			{
				text = GetParts(UriComponents.Fragment | UriComponents.KeepDelimiter, UriFormat.UriEscaped);
				uriInfo.MoreInfo.Fragment = text;
			}
			return text;
		}
	}

	public string Scheme
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			return m_Syntax.SchemeName;
		}
	}

	private bool OriginalStringSwitched
	{
		get
		{
			if (!m_iriParsing || !InFact(Flags.HasUnicode))
			{
				if (AllowIdn)
				{
					if (!InFact(Flags.IdnHost))
					{
						return InFact(Flags.UnicodeHost);
					}
					return true;
				}
				return false;
			}
			return true;
		}
	}

	public string OriginalString
	{
		get
		{
			if (!OriginalStringSwitched)
			{
				return m_String;
			}
			return m_originalUnicodeString;
		}
	}

	public string DnsSafeHost
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			if (AllowIdn && ((m_Flags & Flags.IdnHost) != Flags.Zero || (m_Flags & Flags.UnicodeHost) != Flags.Zero))
			{
				EnsureUriInfo();
				return m_Info.DnsSafeHost;
			}
			EnsureHostString(allowDnsOptimization: false);
			if (!string.IsNullOrEmpty(m_Info.DnsSafeHost))
			{
				return m_Info.DnsSafeHost;
			}
			if (m_Info.Host.Length == 0)
			{
				return string.Empty;
			}
			string text = m_Info.Host;
			if (HostType == Flags.IPv6HostType)
			{
				text = text.Substring(1, text.Length - 2);
				if (m_Info.ScopeId != null)
				{
					text += m_Info.ScopeId;
				}
			}
			else if (HostType == Flags.BasicHostType && InFact(Flags.HostNotCanonical | Flags.E_HostNotCanonical))
			{
				char[] array = new char[text.Length];
				int destPosition = 0;
				UriHelper.UnescapeString(text, 0, text.Length, array, ref destPosition, '\uffff', '\uffff', '\uffff', UnescapeMode.Unescape | UnescapeMode.UnescapeAll, m_Syntax, isQuery: false);
				text = new string(array, 0, destPosition);
			}
			m_Info.DnsSafeHost = text;
			return text;
		}
	}

	public bool IsAbsoluteUri => m_Syntax != null;

	public bool UserEscaped => InFact(Flags.UserEscaped);

	public string UserInfo
	{
		get
		{
			if (IsNotAbsoluteUri)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
			}
			return GetParts(UriComponents.UserInfo, UriFormat.UriEscaped);
		}
	}

	internal bool HasAuthority => InFact(Flags.AuthorityFound);

	internal static bool IriParsingStatic(UriParser syntax)
	{
		if (s_IriParsing)
		{
			if (syntax == null || !syntax.InFact(UriSyntaxFlags.AllowIriParsing))
			{
				return syntax == null;
			}
			return true;
		}
		return false;
	}

	private bool AllowIdnStatic(UriParser syntax, Flags flags)
	{
		if (syntax != null && (syntax.Flags & UriSyntaxFlags.AllowIdn) != UriSyntaxFlags.None)
		{
			if (s_IdnScope != UriIdnScope.All)
			{
				if (s_IdnScope == UriIdnScope.AllExceptIntranet)
				{
					return StaticNotAny(flags, Flags.IntranetUri);
				}
				return false;
			}
			return true;
		}
		return false;
	}

	private bool IsIntranet(string schemeHost)
	{
		return false;
	}

	private void SetUserDrivenParsing()
	{
		m_Flags = Flags.UserDrivenParsing | (m_Flags & Flags.UserEscaped);
	}

	private bool NotAny(Flags flags)
	{
		return (m_Flags & flags) == 0;
	}

	private bool InFact(Flags flags)
	{
		return (m_Flags & flags) != 0;
	}

	private static bool StaticNotAny(Flags allFlags, Flags checkFlags)
	{
		return (allFlags & checkFlags) == 0;
	}

	private static bool StaticInFact(Flags allFlags, Flags checkFlags)
	{
		return (allFlags & checkFlags) != 0;
	}

	private UriInfo EnsureUriInfo()
	{
		Flags flags = m_Flags;
		if ((m_Flags & Flags.MinimalUriInfoSet) == Flags.Zero)
		{
			CreateUriInfo(flags);
		}
		return m_Info;
	}

	private void EnsureParseRemaining()
	{
		if ((m_Flags & Flags.AllUriInfoSet) == Flags.Zero)
		{
			ParseRemaining();
		}
	}

	private void EnsureHostString(bool allowDnsOptimization)
	{
		EnsureUriInfo();
		if (m_Info.Host == null && (!allowDnsOptimization || !InFact(Flags.CanonicalDnsHost)))
		{
			CreateHostString();
		}
	}

	public Uri(string uriString)
	{
		if (uriString == null)
		{
			throw new ArgumentNullException("uriString");
		}
		CreateThis(uriString, dontEscape: false, UriKind.Absolute);
	}

	public Uri(string uriString, UriKind uriKind)
	{
		if (uriString == null)
		{
			throw new ArgumentNullException("uriString");
		}
		CreateThis(uriString, dontEscape: false, uriKind);
	}

	public Uri(Uri baseUri, string relativeUri)
	{
		if ((object)baseUri == null)
		{
			throw new ArgumentNullException("baseUri");
		}
		if (!baseUri.IsAbsoluteUri)
		{
			throw new ArgumentOutOfRangeException("baseUri");
		}
		CreateUri(baseUri, relativeUri, dontEscape: false);
	}

	private void CreateUri(Uri baseUri, string relativeUri, bool dontEscape)
	{
		CreateThis(relativeUri, dontEscape, (UriKind)300);
		UriFormatException parsingError;
		if (baseUri.Syntax.IsSimple)
		{
			Uri uri = ResolveHelper(baseUri, this, ref relativeUri, ref dontEscape, out parsingError);
			if (parsingError != null)
			{
				throw parsingError;
			}
			if (uri != null)
			{
				if ((object)uri != this)
				{
					CreateThisFromUri(uri);
				}
				return;
			}
		}
		else
		{
			dontEscape = false;
			relativeUri = baseUri.Syntax.InternalResolve(baseUri, this, out parsingError);
			if (parsingError != null)
			{
				throw parsingError;
			}
		}
		m_Flags = Flags.Zero;
		m_Info = null;
		m_Syntax = null;
		CreateThis(relativeUri, dontEscape, UriKind.Absolute);
	}

	public Uri(Uri baseUri, Uri relativeUri)
	{
		if ((object)baseUri == null)
		{
			throw new ArgumentNullException("baseUri");
		}
		if (!baseUri.IsAbsoluteUri)
		{
			throw new ArgumentOutOfRangeException("baseUri");
		}
		CreateThisFromUri(relativeUri);
		string newUriString = null;
		bool userEscaped;
		UriFormatException parsingError;
		if (baseUri.Syntax.IsSimple)
		{
			userEscaped = InFact(Flags.UserEscaped);
			relativeUri = ResolveHelper(baseUri, this, ref newUriString, ref userEscaped, out parsingError);
			if (parsingError != null)
			{
				throw parsingError;
			}
			if (relativeUri != null)
			{
				if ((object)relativeUri != this)
				{
					CreateThisFromUri(relativeUri);
				}
				return;
			}
		}
		else
		{
			userEscaped = false;
			newUriString = baseUri.Syntax.InternalResolve(baseUri, this, out parsingError);
			if (parsingError != null)
			{
				throw parsingError;
			}
		}
		m_Flags = Flags.Zero;
		m_Info = null;
		m_Syntax = null;
		CreateThis(newUriString, userEscaped, UriKind.Absolute);
	}

	private unsafe static ParsingError GetCombinedString(Uri baseUri, string relativeStr, bool dontEscape, ref string result)
	{
		for (int i = 0; i < relativeStr.Length && relativeStr[i] != '/' && relativeStr[i] != '\\' && relativeStr[i] != '?' && relativeStr[i] != '#'; i++)
		{
			if (relativeStr[i] != ':')
			{
				continue;
			}
			if (i < 2)
			{
				break;
			}
			string text = relativeStr.Substring(0, i);
			fixed (char* ptr = text)
			{
				UriParser syntax = null;
				if (CheckSchemeSyntax(ptr, (ushort)text.Length, ref syntax) == ParsingError.None)
				{
					if (baseUri.Syntax != syntax)
					{
						result = relativeStr;
						return ParsingError.None;
					}
					relativeStr = ((i + 1 >= relativeStr.Length) ? string.Empty : relativeStr.Substring(i + 1));
				}
			}
			break;
		}
		if (relativeStr.Length == 0)
		{
			result = baseUri.OriginalString;
			return ParsingError.None;
		}
		result = CombineUri(baseUri, relativeStr, dontEscape ? UriFormat.UriEscaped : UriFormat.SafeUnescaped);
		return ParsingError.None;
	}

	private static UriFormatException GetException(ParsingError err)
	{
		return err switch
		{
			ParsingError.None => null, 
			ParsingError.BadFormat => new UriFormatException(global::SR.GetString("Invalid URI: The format of the URI could not be determined.")), 
			ParsingError.BadScheme => new UriFormatException(global::SR.GetString("Invalid URI: The URI scheme is not valid.")), 
			ParsingError.BadAuthority => new UriFormatException(global::SR.GetString("Invalid URI: The Authority/Host could not be parsed.")), 
			ParsingError.EmptyUriString => new UriFormatException(global::SR.GetString("Invalid URI: The URI is empty.")), 
			ParsingError.SchemeLimit => new UriFormatException(global::SR.GetString("Invalid URI: The Uri scheme is too long.")), 
			ParsingError.SizeLimit => new UriFormatException(global::SR.GetString("Invalid URI: The Uri string is too long.")), 
			ParsingError.MustRootedPath => new UriFormatException(global::SR.GetString("Invalid URI: A Dos path must be rooted, for example, 'c:\\\\'.")), 
			ParsingError.BadHostName => new UriFormatException(global::SR.GetString("Invalid URI: The hostname could not be parsed.")), 
			ParsingError.NonEmptyHost => new UriFormatException(global::SR.GetString("Invalid URI: The format of the URI could not be determined.")), 
			ParsingError.BadPort => new UriFormatException(global::SR.GetString("Invalid URI: Invalid port specified.")), 
			ParsingError.BadAuthorityTerminator => new UriFormatException(global::SR.GetString("Invalid URI: The Authority/Host cannot end with a backslash character ('\\\\').")), 
			ParsingError.CannotCreateRelative => new UriFormatException(global::SR.GetString("A relative URI cannot be created because the 'uriString' parameter represents an absolute URI.")), 
			_ => new UriFormatException(global::SR.GetString("Invalid URI: The format of the URI could not be determined.")), 
		};
	}

	protected Uri(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		string text = serializationInfo.GetString("AbsoluteUri");
		if (text.Length != 0)
		{
			CreateThis(text, dontEscape: false, UriKind.Absolute);
			return;
		}
		text = serializationInfo.GetString("RelativeUri");
		if (text == null)
		{
			throw new ArgumentNullException("uriString");
		}
		CreateThis(text, dontEscape: false, UriKind.Relative);
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	protected void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		if (IsAbsoluteUri)
		{
			serializationInfo.AddValue("AbsoluteUri", GetParts(UriComponents.SerializationInfoString, UriFormat.UriEscaped));
			return;
		}
		serializationInfo.AddValue("AbsoluteUri", string.Empty);
		serializationInfo.AddValue("RelativeUri", GetParts(UriComponents.SerializationInfoString, UriFormat.UriEscaped));
	}

	private static bool StaticIsFile(UriParser syntax)
	{
		return syntax.InFact(UriSyntaxFlags.FileLikeUri);
	}

	private static void InitializeUriConfig()
	{
		if (s_ConfigInitialized)
		{
			return;
		}
		lock (InitializeLock)
		{
			if (!s_ConfigInitialized && !s_ConfigInitializing)
			{
				s_ConfigInitialized = true;
				s_ConfigInitializing = false;
			}
		}
	}

	private string GetLocalPath()
	{
		EnsureParseRemaining();
		bool flag = m_Info.Offset.Host != m_Info.Offset.Path && IsFile && OriginalString.StartsWith("file://", StringComparison.Ordinal) && !IsLoopback;
		if (flag)
		{
			flag = false;
			for (int i = m_Info.Offset.Host; i < m_Info.Offset.Path; i++)
			{
				if (OriginalString[i] != '/')
				{
					flag = true;
					break;
				}
			}
		}
		bool flag2 = IsUncPath | flag;
		if ((IsUncOrDosPath && (IsWindowsFileSystem || !IsUncPath)) | flag)
		{
			EnsureHostString(allowDnsOptimization: false);
			int num;
			if (NotAny(Flags.HostNotCanonical | Flags.PathNotCanonical | Flags.ShouldBeCompressed) && !flag)
			{
				num = (IsUncPath ? (m_Info.Offset.Host - 2) : m_Info.Offset.Path);
				string text = ((IsImplicitFile && m_Info.Offset.Host == ((!IsDosPath) ? 2 : 0) && m_Info.Offset.Query == m_Info.Offset.End) ? m_String : ((IsDosPath && (m_String[num] == '/' || m_String[num] == '\\')) ? m_String.Substring(num + 1, m_Info.Offset.Query - num - 1) : m_String.Substring(num, m_Info.Offset.Query - num)));
				if (IsDosPath && text[1] == '|')
				{
					text = text.Remove(1, 1);
					text = text.Insert(1, ":");
				}
				for (int j = 0; j < text.Length; j++)
				{
					if (text[j] == '/')
					{
						text = text.Replace('/', '\\');
						break;
					}
				}
				return text;
			}
			int destPosition = 0;
			num = m_Info.Offset.Path;
			string host = m_Info.Host;
			char[] array = new char[host.Length + 3 + m_Info.Offset.Fragment - m_Info.Offset.Path];
			if (flag2)
			{
				array[0] = '\\';
				array[1] = '\\';
				destPosition = 2;
				UriHelper.UnescapeString(host, 0, host.Length, array, ref destPosition, '\uffff', '\uffff', '\uffff', UnescapeMode.CopyOnly, m_Syntax, isQuery: false);
			}
			else if (m_String[num] == '/' || m_String[num] == '\\')
			{
				num++;
			}
			ushort num2 = (ushort)destPosition;
			UnescapeMode unescapeMode = ((InFact(Flags.PathNotCanonical) && !IsImplicitFile) ? (UnescapeMode.Unescape | UnescapeMode.UnescapeAll) : UnescapeMode.CopyOnly);
			UriHelper.UnescapeString(m_String, num, m_Info.Offset.Query, array, ref destPosition, '\uffff', '\uffff', '\uffff', unescapeMode, m_Syntax, isQuery: true);
			if (array[1] == '|')
			{
				array[1] = ':';
			}
			if (InFact(Flags.ShouldBeCompressed))
			{
				array = Compress(array, (ushort)(IsDosPath ? (num2 + 2) : num2), ref destPosition, m_Syntax);
			}
			for (ushort num3 = 0; num3 < (ushort)destPosition; num3++)
			{
				if (array[num3] == '/')
				{
					array[num3] = '\\';
				}
			}
			return new string(array, 0, destPosition);
		}
		return GetUnescapedParts(UriComponents.Path | UriComponents.KeepDelimiter, UriFormat.Unescaped);
	}

	internal static bool IsGenDelim(char ch)
	{
		if (ch != ':' && ch != '/' && ch != '?' && ch != '#' && ch != '[' && ch != ']')
		{
			return ch == '@';
		}
		return true;
	}

	public static bool IsHexDigit(char character)
	{
		if ((character < '0' || character > '9') && (character < 'A' || character > 'F'))
		{
			if (character >= 'a')
			{
				return character <= 'f';
			}
			return false;
		}
		return true;
	}

	public static int FromHex(char digit)
	{
		if ((digit >= '0' && digit <= '9') || (digit >= 'A' && digit <= 'F') || (digit >= 'a' && digit <= 'f'))
		{
			if (digit > '9')
			{
				return ((digit <= 'F') ? (digit - 65) : (digit - 97)) + 10;
			}
			return digit - 48;
		}
		throw new ArgumentException("digit");
	}

	public override int GetHashCode()
	{
		if (IsNotAbsoluteUri)
		{
			return CalculateCaseInsensitiveHashCode(OriginalString);
		}
		UriInfo uriInfo = EnsureUriInfo();
		if (uriInfo.MoreInfo == null)
		{
			uriInfo.MoreInfo = new MoreInfo();
		}
		int num = uriInfo.MoreInfo.Hash;
		if (num == 0)
		{
			string text = uriInfo.MoreInfo.RemoteUrl;
			if (text == null)
			{
				text = GetParts(UriComponents.HttpRequestUrl, UriFormat.SafeUnescaped);
			}
			num = CalculateCaseInsensitiveHashCode(text);
			if (num == 0)
			{
				num = 16777216;
			}
			uriInfo.MoreInfo.Hash = num;
		}
		return num;
	}

	public override string ToString()
	{
		if (m_Syntax == null)
		{
			if (!m_iriParsing || !InFact(Flags.HasUnicode))
			{
				return OriginalString;
			}
			return m_String;
		}
		EnsureUriInfo();
		if (m_Info.String == null)
		{
			if (Syntax.IsSimple)
			{
				m_Info.String = GetComponentsHelper(UriComponents.AbsoluteUri, (UriFormat)32767);
			}
			else
			{
				m_Info.String = GetParts(UriComponents.AbsoluteUri, UriFormat.SafeUnescaped);
			}
		}
		return m_Info.String;
	}

	public static bool operator ==(Uri uri1, Uri uri2)
	{
		if ((object)uri1 == uri2)
		{
			return true;
		}
		if ((object)uri1 == null || (object)uri2 == null)
		{
			return false;
		}
		return uri2.Equals(uri1);
	}

	public static bool operator !=(Uri uri1, Uri uri2)
	{
		if ((object)uri1 == uri2)
		{
			return false;
		}
		if ((object)uri1 == null || (object)uri2 == null)
		{
			return true;
		}
		return !uri2.Equals(uri1);
	}

	public unsafe override bool Equals(object comparand)
	{
		if (comparand == null)
		{
			return false;
		}
		if (this == comparand)
		{
			return true;
		}
		Uri result = comparand as Uri;
		if ((object)result == null)
		{
			if (!(comparand is string uriString))
			{
				return false;
			}
			if (!TryCreate(uriString, UriKind.RelativeOrAbsolute, out result))
			{
				return false;
			}
		}
		if ((object)m_String == result.m_String)
		{
			return true;
		}
		if (IsAbsoluteUri != result.IsAbsoluteUri)
		{
			return false;
		}
		if (IsNotAbsoluteUri)
		{
			return OriginalString.Equals(result.OriginalString);
		}
		if (NotAny(Flags.AllUriInfoSet) || result.NotAny(Flags.AllUriInfoSet))
		{
			if (!IsUncOrDosPath)
			{
				if (m_String.Length == result.m_String.Length)
				{
					fixed (char* ptr = m_String)
					{
						fixed (char* ptr2 = result.m_String)
						{
							int num = m_String.Length - 1;
							while (num >= 0 && ptr[num] == ptr2[num])
							{
								num--;
							}
							if (num == -1)
							{
								return true;
							}
						}
					}
				}
			}
			else if (string.Compare(m_String, result.m_String, StringComparison.OrdinalIgnoreCase) == 0)
			{
				return true;
			}
		}
		EnsureUriInfo();
		result.EnsureUriInfo();
		if (!UserDrivenParsing && !result.UserDrivenParsing && Syntax.IsSimple && result.Syntax.IsSimple)
		{
			if (InFact(Flags.CanonicalDnsHost) && result.InFact(Flags.CanonicalDnsHost))
			{
				ushort num2 = m_Info.Offset.Host;
				ushort num3 = m_Info.Offset.Path;
				ushort num4 = result.m_Info.Offset.Host;
				ushort path = result.m_Info.Offset.Path;
				string text = result.m_String;
				if (num3 - num2 > path - num4)
				{
					num3 = (ushort)(num2 + path - num4);
				}
				while (num2 < num3)
				{
					if (m_String[num2] != text[num4])
					{
						return false;
					}
					if (text[num4] == ':')
					{
						break;
					}
					num2++;
					num4++;
				}
				if (num2 < m_Info.Offset.Path && m_String[num2] != ':')
				{
					return false;
				}
				if (num4 < path && text[num4] != ':')
				{
					return false;
				}
			}
			else
			{
				EnsureHostString(allowDnsOptimization: false);
				result.EnsureHostString(allowDnsOptimization: false);
				if (!m_Info.Host.Equals(result.m_Info.Host))
				{
					return false;
				}
			}
			if (Port != result.Port)
			{
				return false;
			}
		}
		UriInfo info = m_Info;
		UriInfo info2 = result.m_Info;
		if (info.MoreInfo == null)
		{
			info.MoreInfo = new MoreInfo();
		}
		if (info2.MoreInfo == null)
		{
			info2.MoreInfo = new MoreInfo();
		}
		string text2 = info.MoreInfo.RemoteUrl;
		if (text2 == null)
		{
			text2 = GetParts(UriComponents.HttpRequestUrl, UriFormat.SafeUnescaped);
			info.MoreInfo.RemoteUrl = text2;
		}
		string text3 = info2.MoreInfo.RemoteUrl;
		if (text3 == null)
		{
			text3 = result.GetParts(UriComponents.HttpRequestUrl, UriFormat.SafeUnescaped);
			info2.MoreInfo.RemoteUrl = text3;
		}
		if (!IsUncOrDosPath)
		{
			if (text2.Length != text3.Length)
			{
				return false;
			}
			fixed (char* ptr3 = text2)
			{
				fixed (char* ptr4 = text3)
				{
					char* ptr5 = ptr3 + text2.Length;
					char* ptr6 = ptr4 + text2.Length;
					while (ptr5 != ptr3)
					{
						if (*(--ptr5) != *(--ptr6))
						{
							return false;
						}
					}
					return true;
				}
			}
		}
		return string.Compare(info.MoreInfo.RemoteUrl, info2.MoreInfo.RemoteUrl, IsUncOrDosPath ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal) == 0;
	}

	internal static string InternalEscapeString(string rawString)
	{
		if (rawString == null)
		{
			return string.Empty;
		}
		int destPos = 0;
		char[] array = UriHelper.EscapeString(rawString, 0, rawString.Length, null, ref destPos, isUriString: true, '?', '#', '%');
		if (array == null)
		{
			return rawString;
		}
		return new string(array, 0, destPos);
	}

	private unsafe static ParsingError ParseScheme(string uriString, ref Flags flags, ref UriParser syntax)
	{
		int length = uriString.Length;
		if (length == 0)
		{
			return ParsingError.EmptyUriString;
		}
		if (length >= 65520)
		{
			return ParsingError.SizeLimit;
		}
		fixed (char* uriString2 = uriString)
		{
			ParsingError err = ParsingError.None;
			ushort num = ParseSchemeCheckImplicitFile(uriString2, (ushort)length, ref err, ref flags, ref syntax);
			if (err != ParsingError.None)
			{
				return err;
			}
			flags |= (Flags)num;
		}
		return ParsingError.None;
	}

	internal UriFormatException ParseMinimal()
	{
		ParsingError parsingError = PrivateParseMinimal();
		if (parsingError == ParsingError.None)
		{
			return null;
		}
		m_Flags |= Flags.ErrorOrParsingRecursion;
		return GetException(parsingError);
	}

	private unsafe ParsingError PrivateParseMinimal()
	{
		ushort num = (ushort)(m_Flags & Flags.IndexMask);
		ushort num2 = (ushort)m_String.Length;
		string newHost = null;
		m_Flags &= ~(Flags.IndexMask | Flags.UserDrivenParsing);
		fixed (char* ptr = ((m_iriParsing && (m_Flags & Flags.HasUnicode) != Flags.Zero && (m_Flags & Flags.HostUnicodeNormalized) == Flags.Zero) ? m_originalUnicodeString : m_String))
		{
			if (num2 > num && IsLWS(ptr[num2 - 1]))
			{
				num2--;
				while (num2 != num && IsLWS(ptr[(int)(--num2)]))
				{
				}
				num2++;
			}
			if (m_Syntax.IsAllSet(UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowDOSPath) && NotAny(Flags.ImplicitFile) && num + 1 < num2)
			{
				ushort num3 = num;
				char c;
				while (num3 < num2 && ((c = ptr[(int)num3]) == '\\' || c == '/'))
				{
					num3++;
				}
				if (m_Syntax.InFact(UriSyntaxFlags.FileLikeUri) || num3 - num <= 3)
				{
					if (num3 - num >= 2)
					{
						m_Flags |= Flags.AuthorityFound;
					}
					if (num3 + 1 < num2 && ((c = ptr[num3 + 1]) == ':' || c == '|') && IsAsciiLetter(ptr[(int)num3]))
					{
						if (num3 + 2 >= num2 || ((c = ptr[num3 + 2]) != '\\' && c != '/'))
						{
							if (m_Syntax.InFact(UriSyntaxFlags.FileLikeUri))
							{
								return ParsingError.MustRootedPath;
							}
						}
						else
						{
							m_Flags |= Flags.DosPath;
							if (m_Syntax.InFact(UriSyntaxFlags.MustHaveAuthority))
							{
								m_Flags |= Flags.AuthorityFound;
							}
							num = ((num3 == num || num3 - num == 2) ? num3 : ((ushort)(num3 - 1)));
						}
					}
					else if (m_Syntax.InFact(UriSyntaxFlags.FileLikeUri) && num3 - num >= 2 && num3 - num != 3 && num3 < num2 && ptr[(int)num3] != '?' && ptr[(int)num3] != '#')
					{
						if (!IsWindowsFileSystem)
						{
							if (num3 - num > 3)
							{
								m_Flags |= Flags.CompressedSlashes;
								num = num3;
							}
						}
						else
						{
							m_Flags |= Flags.UncPath;
							num = num3;
						}
					}
				}
			}
			if ((m_Flags & (Flags.DosPath | Flags.UncPath)) == Flags.Zero && (IsWindowsFileSystem || (m_Flags & (Flags.ImplicitFile | Flags.CompressedSlashes)) == Flags.Zero))
			{
				if (num + 2 <= num2)
				{
					char c2 = ptr[(int)num];
					char c3 = ptr[num + 1];
					if (m_Syntax.InFact(UriSyntaxFlags.MustHaveAuthority))
					{
						if ((!IsWindowsFileSystem || (c2 != '/' && c2 != '\\') || (c3 != '/' && c3 != '\\')) && (IsWindowsFileSystem || c2 != '/' || c3 != '/'))
						{
							return ParsingError.BadAuthority;
						}
						m_Flags |= Flags.AuthorityFound;
						num += 2;
					}
					else if (m_Syntax.InFact(UriSyntaxFlags.OptionalAuthority) && (InFact(Flags.AuthorityFound) || (c2 == '/' && c3 == '/')))
					{
						m_Flags |= Flags.AuthorityFound;
						num += 2;
					}
					else if (m_Syntax.NotAny(UriSyntaxFlags.MailToLikeUri))
					{
						m_Flags |= (Flags)((ulong)num | 0x70000uL);
						return ParsingError.None;
					}
				}
				else
				{
					if (m_Syntax.InFact(UriSyntaxFlags.MustHaveAuthority))
					{
						return ParsingError.BadAuthority;
					}
					if (m_Syntax.NotAny(UriSyntaxFlags.MailToLikeUri))
					{
						m_Flags |= (Flags)((ulong)num | 0x70000uL);
						return ParsingError.None;
					}
				}
			}
			if (InFact(Flags.DosPath))
			{
				m_Flags |= (Flags)(((m_Flags & Flags.AuthorityFound) != Flags.Zero) ? 327680 : 458752);
				m_Flags |= (Flags)num;
				return ParsingError.None;
			}
			ParsingError err = ParsingError.None;
			num = CheckAuthorityHelper(ptr, num, num2, ref err, ref m_Flags, m_Syntax, ref newHost);
			if (err != ParsingError.None)
			{
				return err;
			}
			if (num < num2 && ptr[(int)num] == '\\' && NotAny(Flags.ImplicitFile) && m_Syntax.NotAny(UriSyntaxFlags.AllowDOSPath))
			{
				return ParsingError.BadAuthorityTerminator;
			}
			m_Flags |= (Flags)num;
		}
		if (s_IdnScope != UriIdnScope.None || m_iriParsing)
		{
			PrivateParseMinimalIri(newHost, num);
		}
		return ParsingError.None;
	}

	private void PrivateParseMinimalIri(string newHost, ushort idx)
	{
		if (newHost != null)
		{
			m_String = newHost;
		}
		if ((!m_iriParsing && AllowIdn && ((m_Flags & Flags.IdnHost) != Flags.Zero || (m_Flags & Flags.UnicodeHost) != Flags.Zero)) || (m_iriParsing && (m_Flags & Flags.HasUnicode) == Flags.Zero && AllowIdn && (m_Flags & Flags.IdnHost) != Flags.Zero))
		{
			m_Flags &= ~Flags.IndexMask;
			m_Flags |= (Flags)m_String.Length;
			m_String += m_originalUnicodeString.Substring(idx, m_originalUnicodeString.Length - idx);
		}
		if (m_iriParsing && (m_Flags & Flags.HasUnicode) != Flags.Zero)
		{
			m_Flags |= Flags.UseOrigUncdStrOffset;
		}
	}

	private unsafe void CreateUriInfo(Flags cF)
	{
		UriInfo uriInfo = new UriInfo();
		uriInfo.Offset.End = (ushort)m_String.Length;
		if (!UserDrivenParsing)
		{
			bool flag = false;
			ushort num;
			if ((cF & Flags.ImplicitFile) != Flags.Zero)
			{
				num = 0;
				while (num < uriInfo.Offset.End && IsLWS(m_String[num]))
				{
					num++;
					uriInfo.Offset.Scheme++;
				}
				if (StaticInFact(cF, Flags.UncPath))
				{
					num += 2;
					while (num < (ushort)(cF & Flags.IndexMask) && (m_String[num] == '/' || m_String[num] == '\\'))
					{
						num++;
					}
				}
			}
			else
			{
				num = (ushort)m_Syntax.SchemeName.Length;
				while (m_String[num++] != ':')
				{
					uriInfo.Offset.Scheme++;
				}
				if ((cF & Flags.AuthorityFound) != Flags.Zero)
				{
					if (m_String[num] == '\\' || m_String[num + 1] == '\\')
					{
						flag = true;
					}
					num += 2;
					if ((cF & (Flags.DosPath | Flags.UncPath | Flags.CompressedSlashes)) != Flags.Zero)
					{
						while (num < (ushort)(cF & Flags.IndexMask) && (m_String[num] == '/' || m_String[num] == '\\'))
						{
							flag = true;
							num++;
						}
					}
				}
			}
			if (m_Syntax.DefaultPort != -1)
			{
				uriInfo.Offset.PortValue = (ushort)m_Syntax.DefaultPort;
			}
			if ((cF & Flags.HostTypeMask) == Flags.HostTypeMask || StaticInFact(cF, Flags.DosPath))
			{
				uriInfo.Offset.User = (ushort)(cF & Flags.IndexMask);
				uriInfo.Offset.Host = uriInfo.Offset.User;
				uriInfo.Offset.Path = uriInfo.Offset.User;
				cF = (Flags)((ulong)cF & 0xFFFFFFFFFFFF0000uL);
				if (flag)
				{
					cF |= Flags.SchemeNotCanonical;
				}
			}
			else
			{
				uriInfo.Offset.User = num;
				if (HostType == Flags.BasicHostType)
				{
					uriInfo.Offset.Host = num;
					uriInfo.Offset.Path = (ushort)(cF & Flags.IndexMask);
					cF = (Flags)((ulong)cF & 0xFFFFFFFFFFFF0000uL);
				}
				else
				{
					if ((cF & Flags.HasUserInfo) != Flags.Zero)
					{
						while (m_String[num] != '@')
						{
							num++;
						}
						num++;
						uriInfo.Offset.Host = num;
					}
					else
					{
						uriInfo.Offset.Host = num;
					}
					num = (ushort)(cF & Flags.IndexMask);
					cF = (Flags)((ulong)cF & 0xFFFFFFFFFFFF0000uL);
					if (flag)
					{
						cF |= Flags.SchemeNotCanonical;
					}
					uriInfo.Offset.Path = num;
					bool flag2 = false;
					bool flag3 = (cF & Flags.UseOrigUncdStrOffset) != 0;
					cF = (Flags)((ulong)cF & 0xFFFFFFBFFFFFFFFFuL);
					if (flag3)
					{
						uriInfo.Offset.End = (ushort)m_originalUnicodeString.Length;
					}
					if (num < uriInfo.Offset.End)
					{
						fixed (char* ptr = (flag3 ? m_originalUnicodeString : m_String))
						{
							if (ptr[(int)num] == ':')
							{
								int num2 = 0;
								if (++num < uriInfo.Offset.End)
								{
									num2 = (ushort)(ptr[(int)num] - 48);
									if (num2 != 65535 && num2 != 15 && num2 != 65523)
									{
										flag2 = true;
										if (num2 == 0)
										{
											cF |= Flags.PortNotCanonical | Flags.E_PortNotCanonical;
										}
										for (num++; num < uriInfo.Offset.End; num++)
										{
											ushort num3 = (ushort)(ptr[(int)num] - 48);
											if (num3 == ushort.MaxValue || num3 == 15 || num3 == 65523)
											{
												break;
											}
											num2 = num2 * 10 + num3;
										}
									}
								}
								if (flag2 && uriInfo.Offset.PortValue != (ushort)num2)
								{
									uriInfo.Offset.PortValue = (ushort)num2;
									cF |= Flags.NotDefaultPort;
								}
								else
								{
									cF |= Flags.PortNotCanonical | Flags.E_PortNotCanonical;
								}
								uriInfo.Offset.Path = num;
							}
						}
					}
				}
			}
		}
		cF |= Flags.MinimalUriInfoSet;
		uriInfo.DnsSafeHost = m_DnsSafeHost;
		lock (m_String)
		{
			if ((m_Flags & Flags.MinimalUriInfoSet) == Flags.Zero)
			{
				m_Info = uriInfo;
				m_Flags = (Flags)(((ulong)m_Flags & 0xFFFFFFFFFFFF0000uL) | (ulong)cF);
			}
		}
	}

	private unsafe void CreateHostString()
	{
		if (!m_Syntax.IsSimple)
		{
			lock (m_Info)
			{
				if (NotAny(Flags.ErrorOrParsingRecursion))
				{
					m_Flags |= Flags.ErrorOrParsingRecursion;
					GetHostViaCustomSyntax();
					m_Flags &= ~Flags.ErrorOrParsingRecursion;
					return;
				}
			}
		}
		Flags flags = m_Flags;
		string text = CreateHostStringHelper(m_String, m_Info.Offset.Host, m_Info.Offset.Path, ref flags, ref m_Info.ScopeId);
		if (text.Length != 0)
		{
			if (HostType == Flags.BasicHostType)
			{
				ushort idx = 0;
				Check check;
				fixed (char* str = text)
				{
					check = CheckCanonical(str, ref idx, (ushort)text.Length, '\uffff');
				}
				if ((check & Check.DisplayCanonical) == 0 && (NotAny(Flags.ImplicitFile) || (check & Check.ReservedFound) != Check.None))
				{
					flags |= Flags.HostNotCanonical;
				}
				if (InFact(Flags.ImplicitFile) && (check & (Check.EscapedCanonical | Check.ReservedFound)) != Check.None)
				{
					check &= ~Check.EscapedCanonical;
				}
				if ((check & (Check.EscapedCanonical | Check.BackslashInPath)) != Check.EscapedCanonical)
				{
					flags |= Flags.E_HostNotCanonical;
					if (NotAny(Flags.UserEscaped))
					{
						int destPos = 0;
						char[] array = UriHelper.EscapeString(text, 0, text.Length, null, ref destPos, isUriString: true, '?', '#', IsImplicitFile ? '\uffff' : '%');
						if (array != null)
						{
							text = new string(array, 0, destPos);
						}
					}
				}
			}
			else if (NotAny(Flags.CanonicalDnsHost))
			{
				if (m_Info.ScopeId != null)
				{
					flags |= Flags.HostNotCanonical | Flags.E_HostNotCanonical;
				}
				else
				{
					for (ushort num = 0; num < text.Length; num++)
					{
						if (m_Info.Offset.Host + num >= m_Info.Offset.End || text[num] != m_String[m_Info.Offset.Host + num])
						{
							flags |= Flags.HostNotCanonical | Flags.E_HostNotCanonical;
							break;
						}
					}
				}
			}
		}
		m_Info.Host = text;
		lock (m_Info)
		{
			m_Flags |= flags;
		}
	}

	private static string CreateHostStringHelper(string str, ushort idx, ushort end, ref Flags flags, ref string scopeId)
	{
		bool loopback = false;
		string text;
		switch (flags & Flags.HostTypeMask)
		{
		case Flags.DnsHostType:
			text = DomainNameHelper.ParseCanonicalName(str, idx, end, ref loopback);
			break;
		case Flags.IPv6HostType:
			text = IPv6AddressHelper.ParseCanonicalName(str, idx, ref loopback, ref scopeId);
			break;
		case Flags.IPv4HostType:
			text = IPv4AddressHelper.ParseCanonicalName(str, idx, end, ref loopback);
			break;
		case Flags.UncHostType:
			text = UncNameHelper.ParseCanonicalName(str, idx, end, ref loopback);
			break;
		case Flags.BasicHostType:
			text = ((!StaticInFact(flags, Flags.DosPath)) ? str.Substring(idx, end - idx) : string.Empty);
			if (text.Length == 0)
			{
				loopback = true;
			}
			break;
		case Flags.HostTypeMask:
			text = string.Empty;
			break;
		default:
			throw GetException(ParsingError.BadHostName);
		}
		if (loopback)
		{
			flags |= Flags.LoopbackHost;
		}
		return text;
	}

	private unsafe void GetHostViaCustomSyntax()
	{
		if (m_Info.Host != null)
		{
			return;
		}
		string text = m_Syntax.InternalGetComponents(this, UriComponents.Host, UriFormat.UriEscaped);
		if (m_Info.Host == null)
		{
			if (text.Length >= 65520)
			{
				throw GetException(ParsingError.SizeLimit);
			}
			ParsingError err = ParsingError.None;
			Flags flags = (Flags)((ulong)m_Flags & 0xFFFFFFFFFFF8FFFFuL);
			fixed (char* pString = text)
			{
				string newHost = null;
				if (CheckAuthorityHelper(pString, 0, (ushort)text.Length, ref err, ref flags, m_Syntax, ref newHost) != (ushort)text.Length)
				{
					flags = (Flags)((ulong)flags & 0xFFFFFFFFFFF8FFFFuL);
					flags |= Flags.HostTypeMask;
				}
			}
			if (err != ParsingError.None || (flags & Flags.HostTypeMask) == Flags.HostTypeMask)
			{
				m_Flags = (Flags)(((ulong)m_Flags & 0xFFFFFFFFFFF8FFFFuL) | 0x50000);
			}
			else
			{
				text = CreateHostStringHelper(text, 0, (ushort)text.Length, ref flags, ref m_Info.ScopeId);
				for (ushort num = 0; num < text.Length; num++)
				{
					if (m_Info.Offset.Host + num >= m_Info.Offset.End || text[num] != m_String[m_Info.Offset.Host + num])
					{
						m_Flags |= Flags.HostNotCanonical | Flags.E_HostNotCanonical;
						break;
					}
				}
				m_Flags = (Flags)(((ulong)m_Flags & 0xFFFFFFFFFFF8FFFFuL) | (ulong)(flags & Flags.HostTypeMask));
			}
		}
		string text2 = m_Syntax.InternalGetComponents(this, UriComponents.StrongPort, UriFormat.UriEscaped);
		int num2 = 0;
		if (text2 == null || text2.Length == 0)
		{
			m_Flags &= ~Flags.NotDefaultPort;
			m_Flags |= Flags.PortNotCanonical | Flags.E_PortNotCanonical;
			m_Info.Offset.PortValue = 0;
		}
		else
		{
			for (int i = 0; i < text2.Length; i++)
			{
				int num3 = text2[i] - 48;
				if (num3 < 0 || num3 > 9 || (num2 = num2 * 10 + num3) > 65535)
				{
					throw new UriFormatException(global::SR.GetString("A derived type '{0}' has reported an invalid value for the Uri port '{1}'.", m_Syntax.GetType().FullName, text2));
				}
			}
			if (num2 != m_Info.Offset.PortValue)
			{
				if (num2 == m_Syntax.DefaultPort)
				{
					m_Flags &= ~Flags.NotDefaultPort;
				}
				else
				{
					m_Flags |= Flags.NotDefaultPort;
				}
				m_Flags |= Flags.PortNotCanonical | Flags.E_PortNotCanonical;
				m_Info.Offset.PortValue = (ushort)num2;
			}
		}
		m_Info.Host = text;
	}

	internal string GetParts(UriComponents uriParts, UriFormat formatAs)
	{
		return GetComponents(uriParts, formatAs);
	}

	private string GetEscapedParts(UriComponents uriParts)
	{
		ushort num = (ushort)(((ushort)m_Flags & 0x3F80) >> 6);
		if (InFact(Flags.SchemeNotCanonical))
		{
			num |= 1;
		}
		if ((uriParts & UriComponents.Path) != 0)
		{
			if (InFact(Flags.ShouldBeCompressed | Flags.FirstSlashAbsent | Flags.BackslashInPath))
			{
				num |= 0x10;
			}
			else if (IsDosPath && m_String[m_Info.Offset.Path + SecuredPathIndex - 1] == '|')
			{
				num |= 0x10;
			}
		}
		if (((ushort)uriParts & num) == 0)
		{
			string uriPartsFromUserString = GetUriPartsFromUserString(uriParts);
			if (uriPartsFromUserString != null)
			{
				return uriPartsFromUserString;
			}
		}
		return ReCreateParts(uriParts, num, UriFormat.UriEscaped);
	}

	private string GetUnescapedParts(UriComponents uriParts, UriFormat formatAs)
	{
		ushort num = (ushort)((ushort)m_Flags & 0x7F);
		if ((uriParts & UriComponents.Path) != 0)
		{
			if ((m_Flags & (Flags.ShouldBeCompressed | Flags.FirstSlashAbsent | Flags.BackslashInPath)) != Flags.Zero)
			{
				num |= 0x10;
			}
			else if (IsDosPath && m_String[m_Info.Offset.Path + SecuredPathIndex - 1] == '|')
			{
				num |= 0x10;
			}
		}
		if (((ushort)uriParts & num) == 0)
		{
			string uriPartsFromUserString = GetUriPartsFromUserString(uriParts);
			if (uriPartsFromUserString != null)
			{
				return uriPartsFromUserString;
			}
		}
		return ReCreateParts(uriParts, num, formatAs);
	}

	private unsafe string ReCreateParts(UriComponents parts, ushort nonCanonical, UriFormat formatAs)
	{
		EnsureHostString(allowDnsOptimization: false);
		string text = (((parts & UriComponents.Host) == 0) ? string.Empty : m_Info.Host);
		int num = (m_Info.Offset.End - m_Info.Offset.User) * ((formatAs != UriFormat.UriEscaped) ? 1 : 12);
		char[] array = new char[text.Length + num + m_Syntax.SchemeName.Length + 3 + 1];
		num = 0;
		if ((parts & UriComponents.Scheme) != 0)
		{
			m_Syntax.SchemeName.CopyTo(0, array, num, m_Syntax.SchemeName.Length);
			num += m_Syntax.SchemeName.Length;
			if (parts != UriComponents.Scheme)
			{
				array[num++] = ':';
				if (InFact(Flags.AuthorityFound))
				{
					array[num++] = '/';
					array[num++] = '/';
				}
			}
		}
		if ((parts & UriComponents.UserInfo) != 0 && InFact(Flags.HasUserInfo))
		{
			if ((nonCanonical & 2) != 0)
			{
				switch (formatAs)
				{
				case UriFormat.UriEscaped:
					if (NotAny(Flags.UserEscaped))
					{
						array = UriHelper.EscapeString(m_String, m_Info.Offset.User, m_Info.Offset.Host, array, ref num, isUriString: true, '?', '#', '%');
						break;
					}
					InFact(Flags.E_UserNotCanonical);
					m_String.CopyTo(m_Info.Offset.User, array, num, m_Info.Offset.Host - m_Info.Offset.User);
					num += m_Info.Offset.Host - m_Info.Offset.User;
					break;
				case UriFormat.SafeUnescaped:
					array = UriHelper.UnescapeString(m_String, m_Info.Offset.User, m_Info.Offset.Host - 1, array, ref num, '@', '/', '\\', InFact(Flags.UserEscaped) ? UnescapeMode.Unescape : UnescapeMode.EscapeUnescape, m_Syntax, isQuery: false);
					array[num++] = '@';
					break;
				case UriFormat.Unescaped:
					array = UriHelper.UnescapeString(m_String, m_Info.Offset.User, m_Info.Offset.Host, array, ref num, '\uffff', '\uffff', '\uffff', UnescapeMode.Unescape | UnescapeMode.UnescapeAll, m_Syntax, isQuery: false);
					break;
				default:
					array = UriHelper.UnescapeString(m_String, m_Info.Offset.User, m_Info.Offset.Host, array, ref num, '\uffff', '\uffff', '\uffff', UnescapeMode.CopyOnly, m_Syntax, isQuery: false);
					break;
				}
			}
			else
			{
				UriHelper.UnescapeString(m_String, m_Info.Offset.User, m_Info.Offset.Host, array, ref num, '\uffff', '\uffff', '\uffff', UnescapeMode.CopyOnly, m_Syntax, isQuery: false);
			}
			if (parts == UriComponents.UserInfo)
			{
				num--;
			}
		}
		if ((parts & UriComponents.Host) != 0 && text.Length != 0)
		{
			UnescapeMode unescapeMode = ((formatAs != UriFormat.UriEscaped && HostType == Flags.BasicHostType && (nonCanonical & 4) != 0) ? ((formatAs == UriFormat.Unescaped) ? (UnescapeMode.Unescape | UnescapeMode.UnescapeAll) : (InFact(Flags.UserEscaped) ? UnescapeMode.Unescape : UnescapeMode.EscapeUnescape)) : UnescapeMode.CopyOnly);
			if ((parts & UriComponents.NormalizedHost) != 0)
			{
				fixed (char* hostname = text)
				{
					bool allAscii = false;
					bool atLeastOneValidIdn = false;
					try
					{
						text = DomainNameHelper.UnicodeEquivalent(hostname, 0, text.Length, ref allAscii, ref atLeastOneValidIdn);
					}
					catch (UriFormatException)
					{
					}
				}
			}
			array = UriHelper.UnescapeString(text, 0, text.Length, array, ref num, '/', '?', '#', unescapeMode, m_Syntax, isQuery: false);
			if ((parts & UriComponents.SerializationInfoString) != 0 && HostType == Flags.IPv6HostType && m_Info.ScopeId != null)
			{
				m_Info.ScopeId.CopyTo(0, array, num - 1, m_Info.ScopeId.Length);
				num += m_Info.ScopeId.Length;
				array[num - 1] = ']';
			}
		}
		if ((parts & UriComponents.Port) != 0)
		{
			if ((nonCanonical & 8) == 0)
			{
				if (InFact(Flags.NotDefaultPort))
				{
					ushort num2 = m_Info.Offset.Path;
					while (m_String[--num2] != ':')
					{
					}
					m_String.CopyTo(num2, array, num, m_Info.Offset.Path - num2);
					num += m_Info.Offset.Path - num2;
				}
				else if ((parts & UriComponents.StrongPort) != 0 && m_Syntax.DefaultPort != -1)
				{
					array[num++] = ':';
					text = m_Info.Offset.PortValue.ToString(CultureInfo.InvariantCulture);
					text.CopyTo(0, array, num, text.Length);
					num += text.Length;
				}
			}
			else if (InFact(Flags.NotDefaultPort) || ((parts & UriComponents.StrongPort) != 0 && m_Syntax.DefaultPort != -1))
			{
				array[num++] = ':';
				text = m_Info.Offset.PortValue.ToString(CultureInfo.InvariantCulture);
				text.CopyTo(0, array, num, text.Length);
				num += text.Length;
			}
		}
		if ((parts & UriComponents.Path) != 0)
		{
			array = GetCanonicalPath(array, ref num, formatAs);
			if (parts == UriComponents.Path)
			{
				ushort startIndex;
				if (InFact(Flags.AuthorityFound) && num != 0 && array[0] == '/')
				{
					startIndex = 1;
					num--;
				}
				else
				{
					startIndex = 0;
				}
				if (num != 0)
				{
					return new string(array, startIndex, num);
				}
				return string.Empty;
			}
		}
		if ((parts & UriComponents.Query) != 0 && m_Info.Offset.Query < m_Info.Offset.Fragment)
		{
			ushort startIndex = (ushort)(m_Info.Offset.Query + 1);
			if (parts != UriComponents.Query)
			{
				array[num++] = '?';
			}
			if ((nonCanonical & 0x20) != 0)
			{
				switch (formatAs)
				{
				case UriFormat.UriEscaped:
					if (NotAny(Flags.UserEscaped))
					{
						array = UriHelper.EscapeString(m_String, startIndex, m_Info.Offset.Fragment, array, ref num, isUriString: true, '#', '\uffff', '%');
					}
					else
					{
						UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.Fragment, array, ref num, '\uffff', '\uffff', '\uffff', UnescapeMode.CopyOnly, m_Syntax, isQuery: true);
					}
					break;
				case (UriFormat)32767:
					array = UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.Fragment, array, ref num, '#', '\uffff', '\uffff', (UnescapeMode)((InFact(Flags.UserEscaped) ? 2 : 3) | 4), m_Syntax, isQuery: true);
					break;
				case UriFormat.Unescaped:
					array = UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.Fragment, array, ref num, '#', '\uffff', '\uffff', UnescapeMode.Unescape | UnescapeMode.UnescapeAll, m_Syntax, isQuery: true);
					break;
				default:
					array = UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.Fragment, array, ref num, '#', '\uffff', '\uffff', InFact(Flags.UserEscaped) ? UnescapeMode.Unescape : UnescapeMode.EscapeUnescape, m_Syntax, isQuery: true);
					break;
				}
			}
			else
			{
				UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.Fragment, array, ref num, '\uffff', '\uffff', '\uffff', UnescapeMode.CopyOnly, m_Syntax, isQuery: true);
			}
		}
		if ((parts & UriComponents.Fragment) != 0 && m_Info.Offset.Fragment < m_Info.Offset.End)
		{
			ushort startIndex = (ushort)(m_Info.Offset.Fragment + 1);
			if (parts != UriComponents.Fragment)
			{
				array[num++] = '#';
			}
			if ((nonCanonical & 0x40) != 0)
			{
				switch (formatAs)
				{
				case UriFormat.UriEscaped:
					if (NotAny(Flags.UserEscaped))
					{
						array = UriHelper.EscapeString(m_String, startIndex, m_Info.Offset.End, array, ref num, isUriString: true, UriParser.ShouldUseLegacyV2Quirks ? '#' : '\uffff', '\uffff', '%');
					}
					else
					{
						UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.End, array, ref num, '\uffff', '\uffff', '\uffff', UnescapeMode.CopyOnly, m_Syntax, isQuery: false);
					}
					break;
				case (UriFormat)32767:
					array = UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.End, array, ref num, '#', '\uffff', '\uffff', (UnescapeMode)((InFact(Flags.UserEscaped) ? 2 : 3) | 4), m_Syntax, isQuery: false);
					break;
				case UriFormat.Unescaped:
					array = UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.End, array, ref num, '#', '\uffff', '\uffff', UnescapeMode.Unescape | UnescapeMode.UnescapeAll, m_Syntax, isQuery: false);
					break;
				default:
					array = UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.End, array, ref num, '#', '\uffff', '\uffff', InFact(Flags.UserEscaped) ? UnescapeMode.Unescape : UnescapeMode.EscapeUnescape, m_Syntax, isQuery: false);
					break;
				}
			}
			else
			{
				UriHelper.UnescapeString(m_String, startIndex, m_Info.Offset.End, array, ref num, '\uffff', '\uffff', '\uffff', UnescapeMode.CopyOnly, m_Syntax, isQuery: false);
			}
		}
		return new string(array, 0, num);
	}

	private string GetUriPartsFromUserString(UriComponents uriParts)
	{
		switch (uriParts & ~UriComponents.KeepDelimiter)
		{
		case UriComponents.SchemeAndServer:
			if (!InFact(Flags.HasUserInfo))
			{
				return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.Path - m_Info.Offset.Scheme);
			}
			return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.User - m_Info.Offset.Scheme) + m_String.Substring(m_Info.Offset.Host, m_Info.Offset.Path - m_Info.Offset.Host);
		case UriComponents.HostAndPort:
			if (InFact(Flags.HasUserInfo))
			{
				if (InFact(Flags.NotDefaultPort) || m_Syntax.DefaultPort == -1)
				{
					return m_String.Substring(m_Info.Offset.Host, m_Info.Offset.Path - m_Info.Offset.Host);
				}
				return m_String.Substring(m_Info.Offset.Host, m_Info.Offset.Path - m_Info.Offset.Host) + ":" + m_Info.Offset.PortValue.ToString(CultureInfo.InvariantCulture);
			}
			goto case UriComponents.StrongAuthority;
		case UriComponents.AbsoluteUri:
			if (m_Info.Offset.Scheme == 0 && m_Info.Offset.End == m_String.Length)
			{
				return m_String;
			}
			return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.End - m_Info.Offset.Scheme);
		case UriComponents.HttpRequestUrl:
			if (InFact(Flags.HasUserInfo))
			{
				return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.User - m_Info.Offset.Scheme) + m_String.Substring(m_Info.Offset.Host, m_Info.Offset.Fragment - m_Info.Offset.Host);
			}
			if (m_Info.Offset.Scheme == 0 && m_Info.Offset.Fragment == m_String.Length)
			{
				return m_String;
			}
			return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.Fragment - m_Info.Offset.Scheme);
		case UriComponents.SchemeAndServer | UriComponents.UserInfo:
			return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.Path - m_Info.Offset.Scheme);
		case UriComponents.HttpRequestUrl | UriComponents.UserInfo:
			if (m_Info.Offset.Scheme == 0 && m_Info.Offset.Fragment == m_String.Length)
			{
				return m_String;
			}
			return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.Fragment - m_Info.Offset.Scheme);
		case UriComponents.Scheme:
			if (uriParts != UriComponents.Scheme)
			{
				return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.User - m_Info.Offset.Scheme);
			}
			return m_Syntax.SchemeName;
		case UriComponents.Host:
		{
			ushort num2 = m_Info.Offset.Path;
			if (InFact(Flags.PortNotCanonical | Flags.NotDefaultPort))
			{
				while (m_String[--num2] != ':')
				{
				}
			}
			if (num2 - m_Info.Offset.Host != 0)
			{
				return m_String.Substring(m_Info.Offset.Host, num2 - m_Info.Offset.Host);
			}
			return string.Empty;
		}
		case UriComponents.Path:
		{
			ushort num = ((uriParts != UriComponents.Path || !InFact(Flags.AuthorityFound) || m_Info.Offset.End <= m_Info.Offset.Path || m_String[m_Info.Offset.Path] != '/') ? m_Info.Offset.Path : ((ushort)(m_Info.Offset.Path + 1)));
			if (num >= m_Info.Offset.Query)
			{
				return string.Empty;
			}
			return m_String.Substring(num, m_Info.Offset.Query - num);
		}
		case UriComponents.Query:
		{
			ushort num = ((uriParts != UriComponents.Query) ? m_Info.Offset.Query : ((ushort)(m_Info.Offset.Query + 1)));
			if (num >= m_Info.Offset.Fragment)
			{
				return string.Empty;
			}
			return m_String.Substring(num, m_Info.Offset.Fragment - num);
		}
		case UriComponents.Fragment:
		{
			ushort num = ((uriParts != UriComponents.Fragment) ? m_Info.Offset.Fragment : ((ushort)(m_Info.Offset.Fragment + 1)));
			if (num >= m_Info.Offset.End)
			{
				return string.Empty;
			}
			return m_String.Substring(num, m_Info.Offset.End - num);
		}
		case UriComponents.UserInfo | UriComponents.Host | UriComponents.Port:
			if (m_Info.Offset.Path - m_Info.Offset.User != 0)
			{
				return m_String.Substring(m_Info.Offset.User, m_Info.Offset.Path - m_Info.Offset.User);
			}
			return string.Empty;
		case UriComponents.StrongAuthority:
			if (!InFact(Flags.NotDefaultPort) && m_Syntax.DefaultPort != -1)
			{
				return m_String.Substring(m_Info.Offset.User, m_Info.Offset.Path - m_Info.Offset.User) + ":" + m_Info.Offset.PortValue.ToString(CultureInfo.InvariantCulture);
			}
			goto case UriComponents.UserInfo | UriComponents.Host | UriComponents.Port;
		case UriComponents.PathAndQuery:
			return m_String.Substring(m_Info.Offset.Path, m_Info.Offset.Fragment - m_Info.Offset.Path);
		case UriComponents.HttpRequestUrl | UriComponents.Fragment:
			if (InFact(Flags.HasUserInfo))
			{
				return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.User - m_Info.Offset.Scheme) + m_String.Substring(m_Info.Offset.Host, m_Info.Offset.End - m_Info.Offset.Host);
			}
			if (m_Info.Offset.Scheme == 0 && m_Info.Offset.End == m_String.Length)
			{
				return m_String;
			}
			return m_String.Substring(m_Info.Offset.Scheme, m_Info.Offset.End - m_Info.Offset.Scheme);
		case UriComponents.PathAndQuery | UriComponents.Fragment:
			return m_String.Substring(m_Info.Offset.Path, m_Info.Offset.End - m_Info.Offset.Path);
		case UriComponents.UserInfo:
		{
			if (NotAny(Flags.HasUserInfo))
			{
				return string.Empty;
			}
			ushort num = ((uriParts != UriComponents.UserInfo) ? m_Info.Offset.Host : ((ushort)(m_Info.Offset.Host - 1)));
			if (m_Info.Offset.User >= num)
			{
				return string.Empty;
			}
			return m_String.Substring(m_Info.Offset.User, num - m_Info.Offset.User);
		}
		default:
			return null;
		}
	}

	private unsafe void ParseRemaining()
	{
		EnsureUriInfo();
		Flags flags = Flags.Zero;
		if (!UserDrivenParsing)
		{
			bool flag = m_iriParsing && (m_Flags & Flags.HasUnicode) != Flags.Zero && (m_Flags & Flags.RestUnicodeNormalized) == 0;
			ushort scheme = m_Info.Offset.Scheme;
			ushort num = (ushort)m_String.Length;
			Check check = Check.None;
			UriSyntaxFlags flags2 = m_Syntax.Flags;
			fixed (char* ptr = m_String)
			{
				if (num > scheme && IsLWS(ptr[num - 1]))
				{
					num--;
					while (num != scheme && IsLWS(ptr[(int)(--num)]))
					{
					}
					num++;
				}
				if (IsImplicitFile)
				{
					flags |= Flags.SchemeNotCanonical;
				}
				else
				{
					ushort num2 = 0;
					ushort num3 = (ushort)m_Syntax.SchemeName.Length;
					while (num2 < num3)
					{
						if (m_Syntax.SchemeName[num2] != ptr[scheme + num2])
						{
							flags |= Flags.SchemeNotCanonical;
						}
						num2++;
					}
					if ((m_Flags & Flags.AuthorityFound) != Flags.Zero && (scheme + num2 + 3 >= num || ptr[scheme + num2 + 1] != '/' || ptr[scheme + num2 + 2] != '/'))
					{
						flags |= Flags.SchemeNotCanonical;
					}
				}
				if ((m_Flags & Flags.HasUserInfo) != Flags.Zero)
				{
					scheme = m_Info.Offset.User;
					check = CheckCanonical(ptr, ref scheme, m_Info.Offset.Host, '@');
					if ((check & Check.DisplayCanonical) == 0)
					{
						flags |= Flags.UserNotCanonical;
					}
					if ((check & (Check.EscapedCanonical | Check.BackslashInPath)) != Check.EscapedCanonical)
					{
						flags |= Flags.E_UserNotCanonical;
					}
					if (m_iriParsing && (check & (Check.EscapedCanonical | Check.DisplayCanonical | Check.BackslashInPath | Check.NotIriCanonical | Check.FoundNonAscii)) == (Check.DisplayCanonical | Check.FoundNonAscii))
					{
						flags |= Flags.UserIriCanonical;
					}
				}
			}
			scheme = m_Info.Offset.Path;
			ushort idx = m_Info.Offset.Path;
			if (flag)
			{
				if (IsDosPath)
				{
					if (IsImplicitFile)
					{
						m_String = string.Empty;
					}
					else
					{
						m_String = m_Syntax.SchemeName + SchemeDelimiter;
					}
				}
				m_Info.Offset.Path = (ushort)m_String.Length;
				scheme = m_Info.Offset.Path;
				ushort start = idx;
				if (IsImplicitFile || (flags2 & (UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment)) == 0)
				{
					FindEndOfComponent(m_originalUnicodeString, ref idx, (ushort)m_originalUnicodeString.Length, '\uffff');
				}
				else
				{
					FindEndOfComponent(m_originalUnicodeString, ref idx, (ushort)m_originalUnicodeString.Length, m_Syntax.InFact(UriSyntaxFlags.MayHaveQuery) ? '?' : (m_Syntax.InFact(UriSyntaxFlags.MayHaveFragment) ? '#' : '\ufffe'));
				}
				string text = EscapeUnescapeIri(m_originalUnicodeString, start, idx, UriComponents.Path);
				try
				{
					if (UriParser.ShouldUseLegacyV2Quirks)
					{
						m_String += text.Normalize(NormalizationForm.FormC);
					}
					else
					{
						m_String += text;
					}
				}
				catch (ArgumentException)
				{
					throw GetException(ParsingError.BadFormat);
				}
				num = (ushort)m_String.Length;
			}
			fixed (char* ptr2 = m_String)
			{
				check = ((!IsImplicitFile && (flags2 & (UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment)) != UriSyntaxFlags.None) ? CheckCanonical(ptr2, ref scheme, num, ((flags2 & UriSyntaxFlags.MayHaveQuery) != UriSyntaxFlags.None) ? '?' : (m_Syntax.InFact(UriSyntaxFlags.MayHaveFragment) ? '#' : '\ufffe')) : CheckCanonical(ptr2, ref scheme, num, '\uffff'));
				if ((m_Flags & Flags.AuthorityFound) != Flags.Zero && (flags2 & UriSyntaxFlags.PathIsRooted) != UriSyntaxFlags.None && (m_Info.Offset.Path == num || (ptr2[(int)m_Info.Offset.Path] != '/' && ptr2[(int)m_Info.Offset.Path] != '\\')))
				{
					flags |= Flags.FirstSlashAbsent;
				}
			}
			bool flag2 = false;
			if (IsDosPath || ((m_Flags & Flags.AuthorityFound) != Flags.Zero && ((flags2 & (UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath)) != UriSyntaxFlags.None || m_Syntax.InFact(UriSyntaxFlags.UnEscapeDotsAndSlashes))))
			{
				if ((check & Check.DotSlashEscaped) != Check.None && m_Syntax.InFact(UriSyntaxFlags.UnEscapeDotsAndSlashes))
				{
					flags |= Flags.PathNotCanonical | Flags.E_PathNotCanonical;
					flag2 = true;
				}
				if ((flags2 & UriSyntaxFlags.ConvertPathSlashes) != UriSyntaxFlags.None && (check & Check.BackslashInPath) != Check.None)
				{
					flags |= Flags.PathNotCanonical | Flags.E_PathNotCanonical;
					flag2 = true;
				}
				if ((flags2 & UriSyntaxFlags.CompressPath) != UriSyntaxFlags.None && ((flags & Flags.E_PathNotCanonical) != Flags.Zero || (check & Check.DotSlashAttn) != Check.None))
				{
					flags |= Flags.ShouldBeCompressed;
				}
				if ((check & Check.BackslashInPath) != Check.None)
				{
					flags |= Flags.BackslashInPath;
				}
			}
			else if ((check & Check.BackslashInPath) != Check.None)
			{
				flags |= Flags.E_PathNotCanonical;
				flag2 = true;
			}
			if ((check & Check.DisplayCanonical) == 0 && ((m_Flags & Flags.ImplicitFile) == Flags.Zero || (m_Flags & Flags.UserEscaped) != Flags.Zero || (check & Check.ReservedFound) != Check.None))
			{
				flags |= Flags.PathNotCanonical;
				flag2 = true;
			}
			if ((m_Flags & Flags.ImplicitFile) != Flags.Zero && (check & (Check.EscapedCanonical | Check.ReservedFound)) != Check.None)
			{
				check &= ~Check.EscapedCanonical;
			}
			if ((check & Check.EscapedCanonical) == 0)
			{
				flags |= Flags.E_PathNotCanonical;
			}
			if (m_iriParsing && (!flag2 & ((check & (Check.EscapedCanonical | Check.DisplayCanonical | Check.NotIriCanonical | Check.FoundNonAscii)) == (Check.DisplayCanonical | Check.FoundNonAscii))))
			{
				flags |= Flags.PathIriCanonical;
			}
			if (flag)
			{
				ushort start2 = idx;
				if (idx < m_originalUnicodeString.Length && m_originalUnicodeString[idx] == '?')
				{
					idx++;
					FindEndOfComponent(m_originalUnicodeString, ref idx, (ushort)m_originalUnicodeString.Length, ((flags2 & UriSyntaxFlags.MayHaveFragment) != UriSyntaxFlags.None) ? '#' : '\ufffe');
					string text2 = EscapeUnescapeIri(m_originalUnicodeString, start2, idx, UriComponents.Query);
					try
					{
						if (UriParser.ShouldUseLegacyV2Quirks)
						{
							m_String += text2.Normalize(NormalizationForm.FormC);
						}
						else
						{
							m_String += text2;
						}
					}
					catch (ArgumentException)
					{
						throw GetException(ParsingError.BadFormat);
					}
					num = (ushort)m_String.Length;
				}
			}
			m_Info.Offset.Query = scheme;
			fixed (char* ptr3 = m_String)
			{
				if (scheme < num && ptr3[(int)scheme] == '?')
				{
					scheme++;
					check = CheckCanonical(ptr3, ref scheme, num, ((flags2 & UriSyntaxFlags.MayHaveFragment) != UriSyntaxFlags.None) ? '#' : '\ufffe');
					if ((check & Check.DisplayCanonical) == 0)
					{
						flags |= Flags.QueryNotCanonical;
					}
					if ((check & (Check.EscapedCanonical | Check.BackslashInPath)) != Check.EscapedCanonical)
					{
						flags |= Flags.E_QueryNotCanonical;
					}
					if (m_iriParsing && (check & (Check.EscapedCanonical | Check.DisplayCanonical | Check.BackslashInPath | Check.NotIriCanonical | Check.FoundNonAscii)) == (Check.DisplayCanonical | Check.FoundNonAscii))
					{
						flags |= Flags.QueryIriCanonical;
					}
				}
			}
			if (flag)
			{
				ushort start3 = idx;
				if (idx < m_originalUnicodeString.Length && m_originalUnicodeString[idx] == '#')
				{
					idx++;
					FindEndOfComponent(m_originalUnicodeString, ref idx, (ushort)m_originalUnicodeString.Length, '\ufffe');
					string text3 = EscapeUnescapeIri(m_originalUnicodeString, start3, idx, UriComponents.Fragment);
					try
					{
						if (UriParser.ShouldUseLegacyV2Quirks)
						{
							m_String += text3.Normalize(NormalizationForm.FormC);
						}
						else
						{
							m_String += text3;
						}
					}
					catch (ArgumentException)
					{
						throw GetException(ParsingError.BadFormat);
					}
					num = (ushort)m_String.Length;
				}
			}
			m_Info.Offset.Fragment = scheme;
			fixed (char* ptr4 = m_String)
			{
				if (scheme < num && ptr4[(int)scheme] == '#')
				{
					scheme++;
					check = CheckCanonical(ptr4, ref scheme, num, '\ufffe');
					if ((check & Check.DisplayCanonical) == 0)
					{
						flags |= Flags.FragmentNotCanonical;
					}
					if ((check & (Check.EscapedCanonical | Check.BackslashInPath)) != Check.EscapedCanonical)
					{
						flags |= Flags.E_FragmentNotCanonical;
					}
					if (m_iriParsing && (check & (Check.EscapedCanonical | Check.DisplayCanonical | Check.BackslashInPath | Check.NotIriCanonical | Check.FoundNonAscii)) == (Check.DisplayCanonical | Check.FoundNonAscii))
					{
						flags |= Flags.FragmentIriCanonical;
					}
				}
			}
			m_Info.Offset.End = scheme;
		}
		flags |= Flags.AllUriInfoSet;
		lock (m_Info)
		{
			m_Flags |= flags;
		}
		m_Flags |= Flags.RestUnicodeNormalized;
	}

	private unsafe static ushort ParseSchemeCheckImplicitFile(char* uriString, ushort length, ref ParsingError err, ref Flags flags, ref UriParser syntax)
	{
		ushort num = 0;
		while (num < length && IsLWS(uriString[(int)num]))
		{
			num++;
		}
		ushort num2 = num;
		while (num2 < length && uriString[(int)num2] != ':')
		{
			num2++;
		}
		if (IntPtr.Size == 4 && num2 != length && num2 >= num + 2 && CheckKnownSchemes((long*)(uriString + (int)num), (ushort)(num2 - num), ref syntax))
		{
			return (ushort)(num2 + 1);
		}
		if (num + 2 >= length || num2 == num)
		{
			err = ParsingError.BadFormat;
			return 0;
		}
		char c;
		if ((c = uriString[num + 1]) == ':' || c == '|')
		{
			if (IsAsciiLetter(uriString[(int)num]))
			{
				if ((c = uriString[num + 2]) == '\\' || c == '/')
				{
					flags |= Flags.AuthorityFound | Flags.DosPath | Flags.ImplicitFile;
					syntax = UriParser.FileUri;
					return num;
				}
				err = ParsingError.MustRootedPath;
				return 0;
			}
			if (c == ':')
			{
				err = ParsingError.BadScheme;
			}
			else
			{
				err = ParsingError.BadFormat;
			}
			return 0;
		}
		if (((c = uriString[(int)num]) == '/' && IsWindowsFileSystem) || c == '\\')
		{
			if ((c = uriString[num + 1]) == '\\' || c == '/')
			{
				flags |= Flags.AuthorityFound | Flags.UncPath | Flags.ImplicitFile;
				syntax = UriParser.FileUri;
				num += 2;
				while (num < length && ((c = uriString[(int)num]) == '/' || c == '\\'))
				{
					num++;
				}
				return num;
			}
			err = ParsingError.BadFormat;
			return 0;
		}
		if (uriString[(int)num] == '/')
		{
			if (num == 0 || uriString[num - 1] != ':')
			{
				flags |= Flags.AuthorityFound | Flags.ImplicitFile;
				syntax = UriParser.FileUri;
				return num;
			}
			if (uriString[num + 1] == '/' && uriString[num + 2] == '/')
			{
				flags |= Flags.AuthorityFound | Flags.ImplicitFile;
				syntax = UriParser.FileUri;
				return (ushort)(num + 2);
			}
		}
		else if (uriString[(int)num] == '\\')
		{
			err = ParsingError.BadFormat;
			return 0;
		}
		if (num2 == length)
		{
			err = ParsingError.BadFormat;
			return 0;
		}
		if (num2 - num > 1024)
		{
			err = ParsingError.SchemeLimit;
			return 0;
		}
		char* ptr = stackalloc char[num2 - num];
		length = 0;
		while (num < num2)
		{
			ptr[(int)length++] = uriString[(int)num];
			num++;
		}
		err = CheckSchemeSyntax(ptr, length, ref syntax);
		if (err != ParsingError.None)
		{
			return 0;
		}
		return (ushort)(num2 + 1);
	}

	private unsafe static bool CheckKnownSchemes(long* lptr, ushort nChars, ref UriParser syntax)
	{
		if (nChars == 2)
		{
			if (((int)(*lptr) | 0x200020) == 7536759)
			{
				syntax = UriParser.WsUri;
				return true;
			}
			return false;
		}
		switch (*lptr | 0x20002000200020L)
		{
		case 31525695615402088L:
			switch (nChars)
			{
			case 4:
				syntax = UriParser.HttpUri;
				return true;
			case 5:
				if ((((ushort*)lptr)[4] | 0x20) == 115)
				{
					syntax = UriParser.HttpsUri;
					return true;
				}
				break;
			}
			break;
		case 16326042577993847L:
			if (nChars == 3)
			{
				syntax = UriParser.WssUri;
				return true;
			}
			break;
		case 28429436511125606L:
			if (nChars == 4)
			{
				syntax = UriParser.FileUri;
				return true;
			}
			break;
		case 16326029693157478L:
			if (nChars == 3)
			{
				syntax = UriParser.FtpUri;
				return true;
			}
			break;
		case 32370133429452910L:
			if (nChars == 4)
			{
				syntax = UriParser.NewsUri;
				return true;
			}
			break;
		case 31525695615008878L:
			if (nChars == 4)
			{
				syntax = UriParser.NntpUri;
				return true;
			}
			break;
		case 28147948650299509L:
			if (nChars == 4)
			{
				syntax = UriParser.UuidUri;
				return true;
			}
			break;
		case 29273878621519975L:
			if (nChars == 6 && (((int*)lptr)[2] | 0x200020) == 7471205)
			{
				syntax = UriParser.GopherUri;
				return true;
			}
			break;
		case 30399748462674029L:
			if (nChars == 6 && (((int*)lptr)[2] | 0x200020) == 7274612)
			{
				syntax = UriParser.MailToUri;
				return true;
			}
			break;
		case 30962711301259380L:
			if (nChars == 6 && (((int*)lptr)[2] | 0x200020) == 7602277)
			{
				syntax = UriParser.TelnetUri;
				return true;
			}
			break;
		case 12948347151515758L:
			if (nChars == 8 && (lptr[1] | 0x20002000200020L) == 28429453690994800L)
			{
				syntax = UriParser.NetPipeUri;
				return true;
			}
			if (nChars == 7 && (lptr[1] | 0x20002000200020L) == 16326029692043380L)
			{
				syntax = UriParser.NetTcpUri;
				return true;
			}
			break;
		case 31525614009974892L:
			if (nChars == 4)
			{
				syntax = UriParser.LdapUri;
				return true;
			}
			break;
		}
		return false;
	}

	private unsafe static ParsingError CheckSchemeSyntax(char* ptr, ushort length, ref UriParser syntax)
	{
		char c = *ptr;
		if (c < 'a' || c > 'z')
		{
			if (c < 'A' || c > 'Z')
			{
				return ParsingError.BadScheme;
			}
			*ptr = (char)(c | 0x20);
		}
		for (ushort num = 1; num < length; num++)
		{
			char c2 = ptr[(int)num];
			if (c2 < 'a' || c2 > 'z')
			{
				if (c2 >= 'A' && c2 <= 'Z')
				{
					ptr[(int)num] = (char)(c2 | 0x20);
				}
				else if ((c2 < '0' || c2 > '9') && c2 != '+' && c2 != '-' && c2 != '.')
				{
					return ParsingError.BadScheme;
				}
			}
		}
		string lwrCaseScheme = new string(ptr, 0, length);
		syntax = UriParser.FindOrFetchAsUnknownV1Syntax(lwrCaseScheme);
		return ParsingError.None;
	}

	private unsafe ushort CheckAuthorityHelper(char* pString, ushort idx, ushort length, ref ParsingError err, ref Flags flags, UriParser syntax, ref string newHost)
	{
		int i = length;
		int num = idx;
		ushort num2 = idx;
		newHost = null;
		bool justNormalized = false;
		bool flag = s_IriParsing && IriParsingStatic(syntax);
		bool flag2 = (flags & Flags.HasUnicode) != 0;
		bool flag3 = (flags & Flags.HostUnicodeNormalized) == 0;
		UriSyntaxFlags flags2 = syntax.Flags;
		if (flag2 & flag & flag3)
		{
			newHost = m_originalUnicodeString.Substring(0, num);
		}
		char c;
		if (idx == length || (c = pString[(int)idx]) == '/' || (c == '\\' && StaticIsFile(syntax)) || c == '#' || c == '?')
		{
			if (syntax.InFact(UriSyntaxFlags.AllowEmptyHost))
			{
				flags &= ~Flags.UncPath;
				if (StaticInFact(flags, Flags.ImplicitFile) && (pString[(int)idx] != '/' || IsWindowsFileSystem))
				{
					err = ParsingError.BadHostName;
				}
				else
				{
					flags |= Flags.BasicHostType;
				}
			}
			else
			{
				err = ParsingError.BadHostName;
			}
			if (flag2 & flag & flag3)
			{
				flags |= Flags.HostUnicodeNormalized;
			}
			return idx;
		}
		string text = null;
		if ((flags2 & UriSyntaxFlags.MayHaveUserInfo) != UriSyntaxFlags.None)
		{
			while (num2 < i)
			{
				if (num2 == i - 1 || pString[(int)num2] == '?' || pString[(int)num2] == '#' || pString[(int)num2] == '\\' || pString[(int)num2] == '/')
				{
					num2 = idx;
					break;
				}
				if (pString[(int)num2] == '@')
				{
					flags |= Flags.HasUserInfo;
					if (flag || s_IdnScope != UriIdnScope.None)
					{
						if (flag & flag2 & flag3)
						{
							text = IriHelper.EscapeUnescapeIri(pString, num, num2 + 1, UriComponents.UserInfo);
							try
							{
								if (UriParser.ShouldUseLegacyV2Quirks)
								{
									text = text.Normalize(NormalizationForm.FormC);
								}
							}
							catch (ArgumentException)
							{
								err = ParsingError.BadFormat;
								return idx;
							}
							newHost += text;
						}
						else
						{
							text = new string(pString, num, num2 - num + 1);
						}
					}
					num2++;
					c = pString[(int)num2];
					break;
				}
				num2++;
			}
		}
		bool notCanonical = (flags2 & UriSyntaxFlags.SimpleUserSyntax) == 0;
		if (c == '[' && syntax.InFact(UriSyntaxFlags.AllowIPv6Host) && IPv6AddressHelper.IsValid(pString, num2 + 1, ref i))
		{
			flags |= Flags.IPv6HostType;
			if (!s_ConfigInitialized)
			{
				InitializeUriConfig();
				m_iriParsing = s_IriParsing && IriParsingStatic(syntax);
			}
			if (flag2 & flag & flag3)
			{
				newHost += new string(pString, num2, i - num2);
				flags |= Flags.HostUnicodeNormalized;
				justNormalized = true;
			}
		}
		else if (c <= '9' && c >= '0' && syntax.InFact(UriSyntaxFlags.AllowIPv4Host) && IPv4AddressHelper.IsValid(pString, num2, ref i, allowIPv6: false, StaticNotAny(flags, Flags.ImplicitFile), syntax.InFact(UriSyntaxFlags.V1_UnknownUri)))
		{
			flags |= Flags.IPv4HostType;
			if (flag2 & flag & flag3)
			{
				newHost += new string(pString, num2, i - num2);
				flags |= Flags.HostUnicodeNormalized;
				justNormalized = true;
			}
		}
		else if ((flags2 & UriSyntaxFlags.AllowDnsHost) != UriSyntaxFlags.None && !flag && DomainNameHelper.IsValid(pString, num2, ref i, ref notCanonical, StaticNotAny(flags, Flags.ImplicitFile)))
		{
			flags |= Flags.DnsHostType;
			if (!notCanonical)
			{
				flags |= Flags.CanonicalDnsHost;
			}
			if (s_IdnScope != UriIdnScope.None)
			{
				if (s_IdnScope == UriIdnScope.AllExceptIntranet && IsIntranet(new string(pString, 0, i)))
				{
					flags |= Flags.IntranetUri;
				}
				if (AllowIdnStatic(syntax, flags))
				{
					bool allAscii = true;
					bool atLeastOneValidIdn = false;
					string text2 = DomainNameHelper.UnicodeEquivalent(pString, num2, i, ref allAscii, ref atLeastOneValidIdn);
					if (atLeastOneValidIdn)
					{
						if (StaticNotAny(flags, Flags.HasUnicode))
						{
							m_originalUnicodeString = m_String;
						}
						flags |= Flags.IdnHost;
						newHost = m_originalUnicodeString.Substring(0, num) + text + text2;
						flags |= Flags.CanonicalDnsHost;
						m_DnsSafeHost = new string(pString, num2, i - num2);
						justNormalized = true;
					}
					flags |= Flags.HostUnicodeNormalized;
				}
			}
		}
		else if ((flags2 & UriSyntaxFlags.AllowDnsHost) != UriSyntaxFlags.None && ((syntax.InFact(UriSyntaxFlags.AllowIriParsing) & flag3) || syntax.InFact(UriSyntaxFlags.AllowIdn)) && DomainNameHelper.IsValidByIri(pString, num2, ref i, ref notCanonical, StaticNotAny(flags, Flags.ImplicitFile)))
		{
			CheckAuthorityHelperHandleDnsIri(pString, num2, i, num, flag, flag2, syntax, text, ref flags, ref justNormalized, ref newHost, ref err);
		}
		else if ((flags2 & UriSyntaxFlags.AllowUncHost) != UriSyntaxFlags.None && UncNameHelper.IsValid(pString, num2, ref i, StaticNotAny(flags, Flags.ImplicitFile)) && i - num2 <= 256)
		{
			flags |= Flags.UncHostType;
		}
		if (i < length && pString[i] == '\\' && (flags & Flags.HostTypeMask) != Flags.Zero && !StaticIsFile(syntax))
		{
			if (syntax.InFact(UriSyntaxFlags.V1_UnknownUri))
			{
				err = ParsingError.BadHostName;
				flags |= Flags.HostTypeMask;
				return (ushort)i;
			}
			flags &= ~Flags.HostTypeMask;
		}
		else if (i < length && pString[i] == ':')
		{
			if (syntax.InFact(UriSyntaxFlags.MayHavePort))
			{
				int num3 = 0;
				int num4 = i;
				idx = (ushort)(i + 1);
				while (idx < length)
				{
					ushort num5 = (ushort)(pString[(int)idx] - 48);
					if (num5 >= 0 && num5 <= 9)
					{
						if ((num3 = num3 * 10 + num5) > 65535)
						{
							break;
						}
						idx++;
						continue;
					}
					if (num5 == ushort.MaxValue || num5 == 15 || num5 == 65523)
					{
						break;
					}
					if (syntax.InFact(UriSyntaxFlags.AllowAnyOtherHost) && syntax.NotAny(UriSyntaxFlags.V1_UnknownUri))
					{
						flags &= ~Flags.HostTypeMask;
						break;
					}
					err = ParsingError.BadPort;
					return idx;
				}
				if (num3 > 65535)
				{
					if (!syntax.InFact(UriSyntaxFlags.AllowAnyOtherHost))
					{
						err = ParsingError.BadPort;
						return idx;
					}
					flags &= ~Flags.HostTypeMask;
				}
				if (flag & flag2 & justNormalized)
				{
					newHost += new string(pString, num4, idx - num4);
				}
			}
			else
			{
				flags &= ~Flags.HostTypeMask;
			}
		}
		if ((flags & Flags.HostTypeMask) == Flags.Zero)
		{
			flags &= ~Flags.HasUserInfo;
			if (syntax.InFact(UriSyntaxFlags.AllowAnyOtherHost))
			{
				flags |= Flags.BasicHostType;
				for (i = idx; i < length && pString[i] != '/' && pString[i] != '?' && pString[i] != '#'; i++)
				{
				}
				CheckAuthorityHelperHandleAnyHostIri(pString, num, i, flag, flag2, syntax, ref flags, ref newHost, ref err);
			}
			else if (syntax.InFact(UriSyntaxFlags.V1_UnknownUri))
			{
				bool flag4 = false;
				int num6 = idx;
				for (i = idx; i < length && (!flag4 || (pString[i] != '/' && pString[i] != '?' && pString[i] != '#')); i++)
				{
					if (i < idx + 2 && pString[i] == '.')
					{
						flag4 = true;
						continue;
					}
					err = ParsingError.BadHostName;
					flags |= Flags.HostTypeMask;
					return idx;
				}
				flags |= Flags.BasicHostType;
				if ((flag & flag2) && StaticNotAny(flags, Flags.HostUnicodeNormalized))
				{
					string text3 = new string(pString, num6, i - num6);
					try
					{
						newHost += text3.Normalize(NormalizationForm.FormC);
					}
					catch (ArgumentException)
					{
						err = ParsingError.BadFormat;
						return idx;
					}
					flags |= Flags.HostUnicodeNormalized;
				}
			}
			else if (syntax.InFact(UriSyntaxFlags.MustHaveAuthority) || (syntax.InFact(UriSyntaxFlags.MailToLikeUri) && !UriParser.ShouldUseLegacyV2Quirks))
			{
				err = ParsingError.BadHostName;
				flags |= Flags.HostTypeMask;
				return idx;
			}
		}
		return (ushort)i;
	}

	private unsafe void CheckAuthorityHelperHandleDnsIri(char* pString, ushort start, int end, int startInput, bool iriParsing, bool hasUnicode, UriParser syntax, string userInfoString, ref Flags flags, ref bool justNormalized, ref string newHost, ref ParsingError err)
	{
		flags |= Flags.DnsHostType;
		if (s_IdnScope == UriIdnScope.AllExceptIntranet && IsIntranet(new string(pString, 0, end)))
		{
			flags |= Flags.IntranetUri;
		}
		if (AllowIdnStatic(syntax, flags))
		{
			bool allAscii = true;
			bool atLeastOneValidIdn = false;
			string text = DomainNameHelper.IdnEquivalent(pString, start, end, ref allAscii, ref atLeastOneValidIdn);
			string text2 = DomainNameHelper.UnicodeEquivalent(text, pString, start, end);
			if (!allAscii)
			{
				flags |= Flags.UnicodeHost;
			}
			if (atLeastOneValidIdn)
			{
				flags |= Flags.IdnHost;
			}
			if ((allAscii & atLeastOneValidIdn) && StaticNotAny(flags, Flags.HasUnicode))
			{
				m_originalUnicodeString = m_String;
				newHost = m_originalUnicodeString.Substring(0, startInput) + (StaticInFact(flags, Flags.HasUserInfo) ? userInfoString : null);
				justNormalized = true;
			}
			else if (!iriParsing && (StaticInFact(flags, Flags.UnicodeHost) || StaticInFact(flags, Flags.IdnHost)))
			{
				m_originalUnicodeString = m_String;
				newHost = m_originalUnicodeString.Substring(0, startInput) + (StaticInFact(flags, Flags.HasUserInfo) ? userInfoString : null);
				justNormalized = true;
			}
			if (!allAscii || atLeastOneValidIdn)
			{
				m_DnsSafeHost = text;
				newHost += text2;
				justNormalized = true;
			}
			else if ((allAscii && !atLeastOneValidIdn) & iriParsing & hasUnicode)
			{
				newHost += text2;
				justNormalized = true;
			}
		}
		else if (hasUnicode)
		{
			string text3 = StripBidiControlCharacter(pString, start, end - start);
			try
			{
				newHost += text3?.Normalize(NormalizationForm.FormC);
			}
			catch (ArgumentException)
			{
				err = ParsingError.BadHostName;
			}
			justNormalized = true;
		}
		flags |= Flags.HostUnicodeNormalized;
	}

	private unsafe void CheckAuthorityHelperHandleAnyHostIri(char* pString, int startInput, int end, bool iriParsing, bool hasUnicode, UriParser syntax, ref Flags flags, ref string newHost, ref ParsingError err)
	{
		if (!StaticNotAny(flags, Flags.HostUnicodeNormalized) || (!AllowIdnStatic(syntax, flags) && !(iriParsing & hasUnicode)))
		{
			return;
		}
		string text = new string(pString, startInput, end - startInput);
		if (AllowIdnStatic(syntax, flags))
		{
			bool allAscii = true;
			bool atLeastOneValidIdn = false;
			string text2 = DomainNameHelper.UnicodeEquivalent(pString, startInput, end, ref allAscii, ref atLeastOneValidIdn);
			if (((allAscii & atLeastOneValidIdn) || !allAscii) && !(iriParsing & hasUnicode))
			{
				m_originalUnicodeString = m_String;
				newHost = m_originalUnicodeString.Substring(0, startInput);
				flags |= Flags.HasUnicode;
			}
			if (atLeastOneValidIdn || !allAscii)
			{
				newHost += text2;
				string bidiStrippedHost = null;
				m_DnsSafeHost = DomainNameHelper.IdnEquivalent(pString, startInput, end, ref allAscii, ref bidiStrippedHost);
				if (atLeastOneValidIdn)
				{
					flags |= Flags.IdnHost;
				}
				if (!allAscii)
				{
					flags |= Flags.UnicodeHost;
				}
			}
			else if (iriParsing & hasUnicode)
			{
				newHost += text;
			}
		}
		else
		{
			try
			{
				newHost += text.Normalize(NormalizationForm.FormC);
			}
			catch (ArgumentException)
			{
				err = ParsingError.BadHostName;
			}
		}
		flags |= Flags.HostUnicodeNormalized;
	}

	private unsafe void FindEndOfComponent(string input, ref ushort idx, ushort end, char delim)
	{
		fixed (char* str = input)
		{
			FindEndOfComponent(str, ref idx, end, delim);
		}
	}

	private unsafe void FindEndOfComponent(char* str, ref ushort idx, ushort end, char delim)
	{
		char c = '\uffff';
		ushort num;
		for (num = idx; num < end; num++)
		{
			c = str[(int)num];
			if (c == delim || (delim == '?' && c == '#' && m_Syntax != null && m_Syntax.InFact(UriSyntaxFlags.MayHaveFragment)))
			{
				break;
			}
		}
		idx = num;
	}

	private unsafe Check CheckCanonical(char* str, ref ushort idx, ushort end, char delim)
	{
		Check check = Check.None;
		bool flag = false;
		bool flag2 = false;
		char c = '\uffff';
		ushort num;
		for (num = idx; num < end; num++)
		{
			c = str[(int)num];
			if (c <= '\u001f' || (c >= '\u007f' && c <= '\u009f'))
			{
				flag = true;
				flag2 = true;
				check |= Check.ReservedFound;
			}
			else if (c > 'z' && c != '~')
			{
				if (m_iriParsing)
				{
					bool flag3 = false;
					check |= Check.FoundNonAscii;
					if (char.IsHighSurrogate(c))
					{
						if (num + 1 < end)
						{
							bool surrogatePair = false;
							flag3 = IriHelper.CheckIriUnicodeRange(c, str[num + 1], ref surrogatePair, isQuery: true);
						}
					}
					else
					{
						flag3 = IriHelper.CheckIriUnicodeRange(c, isQuery: true);
					}
					if (!flag3)
					{
						check |= Check.NotIriCanonical;
					}
				}
				if (!flag)
				{
					flag = true;
				}
			}
			else
			{
				if (c == delim || (delim == '?' && c == '#' && m_Syntax != null && m_Syntax.InFact(UriSyntaxFlags.MayHaveFragment)))
				{
					break;
				}
				switch (c)
				{
				case '?':
					if (IsImplicitFile || (m_Syntax != null && !m_Syntax.InFact(UriSyntaxFlags.MayHaveQuery) && delim != '\ufffe'))
					{
						check |= Check.ReservedFound;
						flag2 = true;
						flag = true;
					}
					break;
				case '#':
					flag = true;
					if (IsImplicitFile || (m_Syntax != null && !m_Syntax.InFact(UriSyntaxFlags.MayHaveFragment)))
					{
						check |= Check.ReservedFound;
						flag2 = true;
					}
					break;
				case '/':
				case '\\':
					if ((check & Check.BackslashInPath) == 0 && c == '\\')
					{
						check |= Check.BackslashInPath;
					}
					if ((check & Check.DotSlashAttn) == 0 && num + 1 != end && (str[num + 1] == '/' || str[num + 1] == '\\'))
					{
						check |= Check.DotSlashAttn;
					}
					break;
				case '.':
					if (((check & Check.DotSlashAttn) == 0 && num + 1 == end) || str[num + 1] == '.' || str[num + 1] == '/' || str[num + 1] == '\\' || str[num + 1] == '?' || str[num + 1] == '#')
					{
						check |= Check.DotSlashAttn;
					}
					break;
				default:
					if (!flag && ((c <= '"' && c != '!') || (c >= '[' && c <= '^') || c == '>' || c == '<' || c == '`'))
					{
						flag = true;
					}
					else
					{
						if (c != '%')
						{
							break;
						}
						if (!flag2)
						{
							flag2 = true;
						}
						if (num + 2 < end && (c = UriHelper.EscapedAscii(str[num + 1], str[num + 2])) != '\uffff')
						{
							if (c == '.' || c == '/' || c == '\\')
							{
								check |= Check.DotSlashEscaped;
							}
							num += 2;
						}
						else if (!flag)
						{
							flag = true;
						}
					}
					break;
				}
			}
		}
		if (flag2)
		{
			if (!flag)
			{
				check |= Check.EscapedCanonical;
			}
		}
		else
		{
			check |= Check.DisplayCanonical;
			if (!flag)
			{
				check |= Check.EscapedCanonical;
			}
		}
		idx = num;
		return check;
	}

	private unsafe char[] GetCanonicalPath(char[] dest, ref int pos, UriFormat formatAs)
	{
		if (InFact(Flags.FirstSlashAbsent))
		{
			dest[pos++] = '/';
		}
		if (m_Info.Offset.Path == m_Info.Offset.Query)
		{
			return dest;
		}
		int end = pos;
		int securedPathIndex = SecuredPathIndex;
		if (formatAs == UriFormat.UriEscaped)
		{
			if (InFact(Flags.ShouldBeCompressed))
			{
				m_String.CopyTo(m_Info.Offset.Path, dest, end, m_Info.Offset.Query - m_Info.Offset.Path);
				end += m_Info.Offset.Query - m_Info.Offset.Path;
				if (m_Syntax.InFact(UriSyntaxFlags.UnEscapeDotsAndSlashes) && InFact(Flags.PathNotCanonical) && !IsImplicitFile)
				{
					fixed (char* pch = dest)
					{
						UnescapeOnly(pch, pos, ref end, '.', '/', m_Syntax.InFact(UriSyntaxFlags.ConvertPathSlashes) ? '\\' : '\uffff');
					}
				}
			}
			else if (InFact(Flags.E_PathNotCanonical) && NotAny(Flags.UserEscaped))
			{
				string text = m_String;
				if (securedPathIndex != 0 && text[securedPathIndex + m_Info.Offset.Path - 1] == '|')
				{
					text = text.Remove(securedPathIndex + m_Info.Offset.Path - 1, 1);
					text = text.Insert(securedPathIndex + m_Info.Offset.Path - 1, ":");
				}
				dest = UriHelper.EscapeString(text, m_Info.Offset.Path, m_Info.Offset.Query, dest, ref end, isUriString: true, '?', '#', IsImplicitFile ? '\uffff' : '%');
			}
			else
			{
				m_String.CopyTo(m_Info.Offset.Path, dest, end, m_Info.Offset.Query - m_Info.Offset.Path);
				end += m_Info.Offset.Query - m_Info.Offset.Path;
			}
		}
		else
		{
			m_String.CopyTo(m_Info.Offset.Path, dest, end, m_Info.Offset.Query - m_Info.Offset.Path);
			end += m_Info.Offset.Query - m_Info.Offset.Path;
			if (InFact(Flags.ShouldBeCompressed) && m_Syntax.InFact(UriSyntaxFlags.UnEscapeDotsAndSlashes) && InFact(Flags.PathNotCanonical) && !IsImplicitFile)
			{
				fixed (char* pch2 = dest)
				{
					UnescapeOnly(pch2, pos, ref end, '.', '/', m_Syntax.InFact(UriSyntaxFlags.ConvertPathSlashes) ? '\\' : '\uffff');
				}
			}
		}
		if (securedPathIndex != 0 && dest[securedPathIndex + pos - 1] == '|')
		{
			dest[securedPathIndex + pos - 1] = ':';
		}
		if (InFact(Flags.ShouldBeCompressed))
		{
			dest = Compress(dest, (ushort)(pos + securedPathIndex), ref end, m_Syntax);
			if (dest[pos] == '\\')
			{
				dest[pos] = '/';
			}
			if (formatAs == UriFormat.UriEscaped && NotAny(Flags.UserEscaped) && InFact(Flags.E_PathNotCanonical))
			{
				dest = UriHelper.EscapeString(new string(dest, pos, end - pos), 0, end - pos, dest, ref pos, isUriString: true, '?', '#', IsImplicitFile ? '\uffff' : '%');
				end = pos;
			}
		}
		else if (m_Syntax.InFact(UriSyntaxFlags.ConvertPathSlashes) && InFact(Flags.BackslashInPath))
		{
			for (int i = pos; i < end; i++)
			{
				if (dest[i] == '\\')
				{
					dest[i] = '/';
				}
			}
		}
		if (formatAs != UriFormat.UriEscaped && InFact(Flags.PathNotCanonical))
		{
			UnescapeMode unescapeMode;
			if (InFact(Flags.PathNotCanonical))
			{
				switch (formatAs)
				{
				case (UriFormat)32767:
					unescapeMode = (UnescapeMode)((InFact(Flags.UserEscaped) ? 2 : 3) | 4);
					if (IsImplicitFile)
					{
						unescapeMode &= ~UnescapeMode.Unescape;
					}
					break;
				case UriFormat.Unescaped:
					unescapeMode = ((!IsImplicitFile) ? (UnescapeMode.Unescape | UnescapeMode.UnescapeAll) : UnescapeMode.CopyOnly);
					break;
				default:
					unescapeMode = (InFact(Flags.UserEscaped) ? UnescapeMode.Unescape : UnescapeMode.EscapeUnescape);
					if (IsImplicitFile)
					{
						unescapeMode &= ~UnescapeMode.Unescape;
					}
					break;
				}
			}
			else
			{
				unescapeMode = UnescapeMode.CopyOnly;
			}
			char[] array = new char[dest.Length];
			Buffer.BlockCopy(dest, 0, array, 0, end << 1);
			fixed (char* pStr = array)
			{
				dest = UriHelper.UnescapeString(pStr, pos, end, dest, ref pos, '?', '#', '\uffff', unescapeMode, m_Syntax, isQuery: false);
			}
		}
		else
		{
			pos = end;
		}
		return dest;
	}

	private unsafe static void UnescapeOnly(char* pch, int start, ref int end, char ch1, char ch2, char ch3)
	{
		if (end - start < 3)
		{
			return;
		}
		char* ptr = pch + end - 2;
		pch += start;
		char* ptr2 = null;
		while (pch < ptr)
		{
			if (*(pch++) != '%')
			{
				continue;
			}
			char c = UriHelper.EscapedAscii(*(pch++), *(pch++));
			if (c != ch1 && c != ch2 && c != ch3)
			{
				continue;
			}
			ptr2 = pch - 2;
			*(ptr2 - 1) = c;
			while (pch < ptr)
			{
				if ((*(ptr2++) = *(pch++)) == '%')
				{
					c = UriHelper.EscapedAscii(*(ptr2++) = *(pch++), *(ptr2++) = *(pch++));
					if (c == ch1 || c == ch2 || c == ch3)
					{
						ptr2 -= 2;
						*(ptr2 - 1) = c;
					}
				}
			}
			break;
		}
		ptr += 2;
		if (ptr2 == null)
		{
			return;
		}
		if (pch == ptr)
		{
			end -= (int)(pch - ptr2);
			return;
		}
		*(ptr2++) = *(pch++);
		if (pch == ptr)
		{
			end -= (int)(pch - ptr2);
			return;
		}
		*(ptr2++) = *(pch++);
		end -= (int)(pch - ptr2);
	}

	private static char[] Compress(char[] dest, ushort start, ref int destLength, UriParser syntax)
	{
		ushort num = 0;
		ushort num2 = 0;
		ushort num3 = 0;
		ushort num4 = 0;
		ushort num5 = (ushort)((ushort)destLength - 1);
		for (start--; num5 != start; num5--)
		{
			char c = dest[num5];
			if (c == '\\' && syntax.InFact(UriSyntaxFlags.ConvertPathSlashes))
			{
				c = (dest[num5] = '/');
			}
			if (c == '/')
			{
				num++;
			}
			else
			{
				if (num > 1)
				{
					num2 = (ushort)(num5 + 1);
				}
				num = 0;
			}
			if (c == '.')
			{
				num3++;
				continue;
			}
			if (num3 != 0)
			{
				bool flag = syntax.NotAny(UriSyntaxFlags.CanonicalizeAsFilePath) && (num3 > 2 || c != '/' || num5 == start);
				if (!flag && c == '/')
				{
					if ((num2 == num5 + num3 + 1 || (num2 == 0 && num5 + num3 + 1 == destLength)) && (UriParser.ShouldUseLegacyV2Quirks || num3 <= 2))
					{
						num2 = (ushort)(num5 + 1 + num3 + ((num2 != 0) ? 1 : 0));
						Buffer.BlockCopy(dest, num2 << 1, dest, num5 + 1 << 1, destLength - num2 << 1);
						destLength -= num2 - num5 - 1;
						num2 = num5;
						if (num3 == 2)
						{
							num4++;
						}
						num3 = 0;
						continue;
					}
				}
				else if (UriParser.ShouldUseLegacyV2Quirks && !flag && num4 == 0 && (num2 == num5 + num3 + 1 || (num2 == 0 && num5 + num3 + 1 == destLength)))
				{
					num3 = (ushort)(num5 + 1 + num3);
					Buffer.BlockCopy(dest, num3 << 1, dest, num5 + 1 << 1, destLength - num3 << 1);
					destLength -= num3 - num5 - 1;
					num2 = 0;
					num3 = 0;
					continue;
				}
				num3 = 0;
			}
			if (c == '/')
			{
				if (num4 != 0)
				{
					num4--;
					num2++;
					Buffer.BlockCopy(dest, num2 << 1, dest, num5 + 1 << 1, destLength - num2 << 1);
					destLength -= num2 - num5 - 1;
				}
				num2 = num5;
			}
		}
		start++;
		if ((ushort)destLength > start && syntax.InFact(UriSyntaxFlags.CanonicalizeAsFilePath) && num <= 1)
		{
			if (num4 != 0 && dest[start] != '/')
			{
				num2++;
				Buffer.BlockCopy(dest, num2 << 1, dest, start << 1, destLength - num2 << 1);
				destLength -= num2;
			}
			else if (num3 != 0 && (num2 == num3 + 1 || (num2 == 0 && num3 + 1 == destLength)))
			{
				num3 = (ushort)(num3 + ((num2 != 0) ? 1 : 0));
				Buffer.BlockCopy(dest, num3 << 1, dest, start << 1, destLength - num3 << 1);
				destLength -= num3;
			}
		}
		return dest;
	}

	internal static int CalculateCaseInsensitiveHashCode(string text)
	{
		return StringComparer.InvariantCultureIgnoreCase.GetHashCode(text);
	}

	private static string CombineUri(Uri basePart, string relativePart, UriFormat uriFormat)
	{
		char c = relativePart[0];
		if (basePart.IsDosPath && (c == '/' || c == '\\') && (relativePart.Length == 1 || (relativePart[1] != '/' && relativePart[1] != '\\')))
		{
			int num = basePart.OriginalString.IndexOf(':');
			if (basePart.IsImplicitFile)
			{
				return basePart.OriginalString.Substring(0, num + 1) + relativePart;
			}
			num = basePart.OriginalString.IndexOf(':', num + 1);
			return basePart.OriginalString.Substring(0, num + 1) + relativePart;
		}
		if (StaticIsFile(basePart.Syntax) && (c == '\\' || c == '/'))
		{
			if (relativePart.Length >= 2 && (relativePart[1] == '\\' || relativePart[1] == '/'))
			{
				if (!basePart.IsImplicitFile)
				{
					return "file:" + relativePart;
				}
				return relativePart;
			}
			if (basePart.IsUnc)
			{
				string text = basePart.GetParts(UriComponents.Path | UriComponents.KeepDelimiter, UriFormat.Unescaped);
				for (int i = 1; i < text.Length; i++)
				{
					if (text[i] == '/')
					{
						text = text.Substring(0, i);
						break;
					}
				}
				if (basePart.IsImplicitFile)
				{
					return "\\\\" + basePart.GetParts(UriComponents.Host, UriFormat.Unescaped) + text + relativePart;
				}
				return "file://" + basePart.GetParts(UriComponents.Host, uriFormat) + text + relativePart;
			}
			return "file://" + relativePart;
		}
		bool flag = basePart.Syntax.InFact(UriSyntaxFlags.ConvertPathSlashes);
		string text2 = null;
		if (c == '/' || ((c == '\\') & flag))
		{
			if (relativePart.Length >= 2 && relativePart[1] == '/')
			{
				return basePart.Scheme + ":" + relativePart;
			}
			text2 = ((basePart.HostType != Flags.IPv6HostType) ? basePart.GetParts(UriComponents.SchemeAndServer | UriComponents.UserInfo, uriFormat) : (basePart.GetParts(UriComponents.Scheme | UriComponents.UserInfo, uriFormat) + "[" + basePart.DnsSafeHost + "]" + basePart.GetParts(UriComponents.Port | UriComponents.KeepDelimiter, uriFormat)));
			if (flag && c == '\\')
			{
				relativePart = "/" + relativePart.Substring(1);
			}
			return text2 + relativePart;
		}
		text2 = basePart.GetParts(UriComponents.Path | UriComponents.KeepDelimiter, basePart.IsImplicitFile ? UriFormat.Unescaped : uriFormat);
		int num2 = text2.Length;
		char[] array = new char[num2 + relativePart.Length];
		if (num2 > 0)
		{
			text2.CopyTo(0, array, 0, num2);
			while (num2 > 0)
			{
				if (array[--num2] == '/')
				{
					num2++;
					break;
				}
			}
		}
		relativePart.CopyTo(0, array, num2, relativePart.Length);
		c = (basePart.Syntax.InFact(UriSyntaxFlags.MayHaveQuery) ? '?' : '\uffff');
		char c2 = ((!basePart.IsImplicitFile && basePart.Syntax.InFact(UriSyntaxFlags.MayHaveFragment)) ? '#' : '\uffff');
		string text3 = string.Empty;
		if (c != '\uffff' || c2 != '\uffff')
		{
			int j;
			for (j = 0; j < relativePart.Length && array[num2 + j] != c && array[num2 + j] != c2; j++)
			{
			}
			if (j == 0)
			{
				text3 = relativePart;
			}
			else if (j < relativePart.Length)
			{
				text3 = relativePart.Substring(j);
			}
			num2 += j;
		}
		else
		{
			num2 += relativePart.Length;
		}
		if (basePart.HostType == Flags.IPv6HostType)
		{
			text2 = ((!basePart.IsImplicitFile) ? (basePart.GetParts(UriComponents.Scheme | UriComponents.UserInfo, uriFormat) + "[" + basePart.DnsSafeHost + "]" + basePart.GetParts(UriComponents.Port | UriComponents.KeepDelimiter, uriFormat)) : ("\\\\[" + basePart.DnsSafeHost + "]"));
		}
		else if (basePart.IsImplicitFile)
		{
			if (IsWindowsFileSystem)
			{
				if (basePart.IsDosPath)
				{
					array = Compress(array, 3, ref num2, basePart.Syntax);
					return new string(array, 1, num2 - 1) + text3;
				}
				text2 = "\\\\" + basePart.GetParts(UriComponents.Host, UriFormat.Unescaped);
			}
			else
			{
				text2 = basePart.GetParts(UriComponents.Host, UriFormat.Unescaped);
			}
		}
		else
		{
			text2 = basePart.GetParts(UriComponents.SchemeAndServer | UriComponents.UserInfo, uriFormat);
		}
		array = Compress(array, basePart.SecuredPathIndex, ref num2, basePart.Syntax);
		return text2 + new string(array, 0, num2) + text3;
	}

	private static bool IsLWS(char ch)
	{
		if (ch <= ' ')
		{
			if (ch != ' ' && ch != '\n' && ch != '\r')
			{
				return ch == '\t';
			}
			return true;
		}
		return false;
	}

	private static bool IsAsciiLetter(char character)
	{
		if (character < 'a' || character > 'z')
		{
			if (character >= 'A')
			{
				return character <= 'Z';
			}
			return false;
		}
		return true;
	}

	internal static bool IsAsciiLetterOrDigit(char character)
	{
		if (!IsAsciiLetter(character))
		{
			if (character >= '0')
			{
				return character <= '9';
			}
			return false;
		}
		return true;
	}

	internal static bool IsBidiControlCharacter(char ch)
	{
		if (ch != '\u200e' && ch != '\u200f' && ch != '\u202a' && ch != '\u202b' && ch != '\u202c' && ch != '\u202d')
		{
			return ch == '\u202e';
		}
		return true;
	}

	internal unsafe static string StripBidiControlCharacter(char* strToClean, int start, int length)
	{
		if (length <= 0)
		{
			return "";
		}
		char[] array = new char[length];
		int length2 = 0;
		for (int i = 0; i < length; i++)
		{
			char c = strToClean[start + i];
			if (c < '\u200e' || c > '\u202e' || !IsBidiControlCharacter(c))
			{
				array[length2++] = c;
			}
		}
		return new string(array, 0, length2);
	}

	private void CreateThis(string uri, bool dontEscape, UriKind uriKind)
	{
		if ((uriKind < UriKind.RelativeOrAbsolute || uriKind > UriKind.Relative) && uriKind != (UriKind)300)
		{
			throw new ArgumentException(global::SR.GetString("The value '{0}' passed for the UriKind parameter is invalid.", uriKind));
		}
		m_String = ((uri == null) ? string.Empty : uri);
		if (dontEscape)
		{
			m_Flags |= Flags.UserEscaped;
		}
		ParsingError err = ParseScheme(m_String, ref m_Flags, ref m_Syntax);
		InitializeUri(err, uriKind, out var e);
		if (e != null)
		{
			throw e;
		}
	}

	private void InitializeUri(ParsingError err, UriKind uriKind, out UriFormatException e)
	{
		if (err == ParsingError.None)
		{
			if (IsImplicitFile && (uriKind != UriKind.RelativeOrAbsolute || m_String.Length <= 0 || m_String[0] != '/' || useDotNetRelativeOrAbsolute))
			{
				if (NotAny(Flags.DosPath) && uriKind != UriKind.Absolute && (uriKind == UriKind.Relative || (m_String.Length >= 2 && (m_String[0] != '\\' || m_String[1] != '\\'))))
				{
					m_Syntax = null;
					m_Flags &= Flags.UserEscaped;
					e = null;
					return;
				}
				if (uriKind == UriKind.Relative && InFact(Flags.DosPath))
				{
					m_Syntax = null;
					m_Flags &= Flags.UserEscaped;
					e = null;
					return;
				}
			}
		}
		else if (err > ParsingError.EmptyUriString)
		{
			m_String = null;
			e = GetException(err);
			return;
		}
		bool flag = false;
		if (!s_ConfigInitialized && CheckForConfigLoad(m_String))
		{
			InitializeUriConfig();
		}
		m_iriParsing = s_IriParsing && (m_Syntax == null || m_Syntax.InFact(UriSyntaxFlags.AllowIriParsing));
		if (m_iriParsing && (CheckForUnicode(m_String) || CheckForEscapedUnreserved(m_String)))
		{
			m_Flags |= Flags.HasUnicode;
			flag = true;
			m_originalUnicodeString = m_String;
		}
		if (m_Syntax != null)
		{
			if (m_Syntax.IsSimple)
			{
				if ((err = PrivateParseMinimal()) != ParsingError.None)
				{
					if (uriKind != UriKind.Absolute && err <= ParsingError.EmptyUriString)
					{
						m_Syntax = null;
						e = null;
						m_Flags &= Flags.UserEscaped;
					}
					else
					{
						e = GetException(err);
					}
				}
				else if (uriKind == UriKind.Relative)
				{
					e = GetException(ParsingError.CannotCreateRelative);
				}
				else
				{
					e = null;
				}
				if (m_iriParsing & flag)
				{
					EnsureParseRemaining();
				}
				return;
			}
			m_Syntax = m_Syntax.InternalOnNewUri();
			m_Flags |= Flags.UserDrivenParsing;
			m_Syntax.InternalValidate(this, out e);
			if (e != null)
			{
				if (uriKind != UriKind.Absolute && err != ParsingError.None && err <= ParsingError.EmptyUriString)
				{
					m_Syntax = null;
					e = null;
					m_Flags &= Flags.UserEscaped;
				}
				return;
			}
			if (err != ParsingError.None || InFact(Flags.ErrorOrParsingRecursion))
			{
				SetUserDrivenParsing();
			}
			else if (uriKind == UriKind.Relative)
			{
				e = GetException(ParsingError.CannotCreateRelative);
			}
			if (m_iriParsing & flag)
			{
				EnsureParseRemaining();
			}
		}
		else
		{
			if (err != ParsingError.None && uriKind != UriKind.Absolute && err <= ParsingError.EmptyUriString)
			{
				e = null;
				m_Flags &= Flags.UserEscaped | Flags.HasUnicode;
				if (!(m_iriParsing & flag))
				{
					return;
				}
				m_String = EscapeUnescapeIri(m_originalUnicodeString, 0, m_originalUnicodeString.Length, (UriComponents)0);
				try
				{
					if (UriParser.ShouldUseLegacyV2Quirks)
					{
						m_String = m_String.Normalize(NormalizationForm.FormC);
					}
					return;
				}
				catch (ArgumentException)
				{
					e = GetException(ParsingError.BadFormat);
					return;
				}
			}
			m_String = null;
			e = GetException(err);
		}
	}

	private unsafe bool CheckForConfigLoad(string data)
	{
		bool result = false;
		int length = data.Length;
		fixed (char* ptr = data)
		{
			for (int i = 0; i < length; i++)
			{
				if (ptr[i] > '\u007f' || ptr[i] == '%' || (ptr[i] == 'x' && i + 3 < length && ptr[i + 1] == 'n' && ptr[i + 2] == '-' && ptr[i + 3] == '-'))
				{
					result = true;
					break;
				}
			}
		}
		return result;
	}

	private bool CheckForUnicode(string data)
	{
		bool result = false;
		char[] dest = new char[data.Length];
		int destPosition = 0;
		dest = UriHelper.UnescapeString(data, 0, data.Length, dest, ref destPosition, '\uffff', '\uffff', '\uffff', UnescapeMode.Unescape | UnescapeMode.UnescapeAll, null, isQuery: false);
		for (int i = 0; i < destPosition; i++)
		{
			if (dest[i] > '\u007f')
			{
				result = true;
				break;
			}
		}
		return result;
	}

	private unsafe bool CheckForEscapedUnreserved(string data)
	{
		fixed (char* ptr = data)
		{
			for (int i = 0; i < data.Length - 2; i++)
			{
				if (ptr[i] == '%' && IsHexDigit(ptr[i + 1]) && IsHexDigit(ptr[i + 2]) && ptr[i + 1] >= '0' && ptr[i + 1] <= '7')
				{
					char c = UriHelper.EscapedAscii(ptr[i + 1], ptr[i + 2]);
					if (c != '\uffff' && UriHelper.Is3986Unreserved(c))
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	public static bool TryCreate(string uriString, UriKind uriKind, out Uri result)
	{
		if (uriString == null)
		{
			result = null;
			return false;
		}
		UriFormatException e = null;
		result = CreateHelper(uriString, dontEscape: false, uriKind, ref e);
		if (e == null)
		{
			return result != null;
		}
		return false;
	}

	public static bool TryCreate(Uri baseUri, string relativeUri, out Uri result)
	{
		if (TryCreate(relativeUri, (UriKind)300, out var result2))
		{
			if (!result2.IsAbsoluteUri)
			{
				return TryCreate(baseUri, result2, out result);
			}
			result = result2;
			return true;
		}
		result = null;
		return false;
	}

	public static bool TryCreate(Uri baseUri, Uri relativeUri, out Uri result)
	{
		result = null;
		if ((object)baseUri == null || (object)relativeUri == null)
		{
			return false;
		}
		if (baseUri.IsNotAbsoluteUri)
		{
			return false;
		}
		string newUriString = null;
		bool userEscaped;
		UriFormatException parsingError;
		if (baseUri.Syntax.IsSimple)
		{
			userEscaped = relativeUri.UserEscaped;
			result = ResolveHelper(baseUri, relativeUri, ref newUriString, ref userEscaped, out parsingError);
		}
		else
		{
			userEscaped = false;
			newUriString = baseUri.Syntax.InternalResolve(baseUri, relativeUri, out parsingError);
		}
		if (parsingError != null)
		{
			return false;
		}
		if ((object)result == null)
		{
			result = CreateHelper(newUriString, userEscaped, UriKind.Absolute, ref parsingError);
		}
		if (parsingError == null && result != null)
		{
			return result.IsAbsoluteUri;
		}
		return false;
	}

	public string GetComponents(UriComponents components, UriFormat format)
	{
		if ((components & UriComponents.SerializationInfoString) != 0 && components != UriComponents.SerializationInfoString)
		{
			throw new ArgumentOutOfRangeException("components", components, global::SR.GetString("UriComponents.SerializationInfoString must not be combined with other UriComponents."));
		}
		if ((format & (UriFormat)(-4)) != 0)
		{
			throw new ArgumentOutOfRangeException("format");
		}
		if (IsNotAbsoluteUri)
		{
			if (components == UriComponents.SerializationInfoString)
			{
				return GetRelativeSerializationString(format);
			}
			throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
		}
		if (Syntax.IsSimple)
		{
			return GetComponentsHelper(components, format);
		}
		return Syntax.InternalGetComponents(this, components, format);
	}

	public unsafe static string UnescapeDataString(string stringToUnescape)
	{
		if (stringToUnescape == null)
		{
			throw new ArgumentNullException("stringToUnescape");
		}
		if (stringToUnescape.Length == 0)
		{
			return string.Empty;
		}
		fixed (char* ptr = stringToUnescape)
		{
			int i;
			for (i = 0; i < stringToUnescape.Length && ptr[i] != '%'; i++)
			{
			}
			if (i == stringToUnescape.Length)
			{
				return stringToUnescape;
			}
			UnescapeMode unescapeMode = UnescapeMode.Unescape | UnescapeMode.UnescapeAll;
			i = 0;
			char[] dest = new char[stringToUnescape.Length];
			dest = UriHelper.UnescapeString(stringToUnescape, 0, stringToUnescape.Length, dest, ref i, '\uffff', '\uffff', '\uffff', unescapeMode, null, isQuery: false);
			return new string(dest, 0, i);
		}
	}

	public static string EscapeUriString(string stringToEscape)
	{
		if (stringToEscape == null)
		{
			throw new ArgumentNullException("stringToEscape");
		}
		if (stringToEscape.Length == 0)
		{
			return string.Empty;
		}
		int destPos = 0;
		char[] array = UriHelper.EscapeString(stringToEscape, 0, stringToEscape.Length, null, ref destPos, isUriString: true, '\uffff', '\uffff', '\uffff');
		if (array == null)
		{
			return stringToEscape;
		}
		return new string(array, 0, destPos);
	}

	public static string EscapeDataString(string stringToEscape)
	{
		if (stringToEscape == null)
		{
			throw new ArgumentNullException("stringToEscape");
		}
		if (stringToEscape.Length == 0)
		{
			return string.Empty;
		}
		int destPos = 0;
		char[] array = UriHelper.EscapeString(stringToEscape, 0, stringToEscape.Length, null, ref destPos, isUriString: false, '\uffff', '\uffff', '\uffff');
		if (array == null)
		{
			return stringToEscape;
		}
		return new string(array, 0, destPos);
	}

	internal unsafe string EscapeUnescapeIri(string input, int start, int end, UriComponents component)
	{
		fixed (char* pInput = input)
		{
			return IriHelper.EscapeUnescapeIri(pInput, start, end, component);
		}
	}

	private Uri(Flags flags, UriParser uriParser, string uri)
	{
		m_Flags = flags;
		m_Syntax = uriParser;
		m_String = uri;
	}

	internal static Uri CreateHelper(string uriString, bool dontEscape, UriKind uriKind, ref UriFormatException e)
	{
		if ((uriKind < UriKind.RelativeOrAbsolute || uriKind > UriKind.Relative) && uriKind != (UriKind)300)
		{
			throw new ArgumentException(global::SR.GetString("The value '{0}' passed for the UriKind parameter is invalid.", uriKind));
		}
		UriParser syntax = null;
		Flags flags = Flags.Zero;
		ParsingError parsingError = ParseScheme(uriString, ref flags, ref syntax);
		if (dontEscape)
		{
			flags |= Flags.UserEscaped;
		}
		if (parsingError != ParsingError.None)
		{
			if (uriKind != UriKind.Absolute && parsingError <= ParsingError.EmptyUriString)
			{
				return new Uri(flags & Flags.UserEscaped, null, uriString);
			}
			return null;
		}
		Uri uri = new Uri(flags, syntax, uriString);
		try
		{
			uri.InitializeUri(parsingError, uriKind, out e);
			if (e == null)
			{
				return uri;
			}
			return null;
		}
		catch (UriFormatException ex)
		{
			e = ex;
			return null;
		}
	}

	internal static Uri ResolveHelper(Uri baseUri, Uri relativeUri, ref string newUriString, ref bool userEscaped, out UriFormatException e)
	{
		e = null;
		string empty = string.Empty;
		if ((object)relativeUri != null)
		{
			if (relativeUri.IsAbsoluteUri && (IsWindowsFileSystem || relativeUri.OriginalString[0] != '/' || !relativeUri.IsImplicitFile))
			{
				return relativeUri;
			}
			empty = relativeUri.OriginalString;
			userEscaped = relativeUri.UserEscaped;
		}
		else
		{
			empty = string.Empty;
		}
		if (empty.Length > 0 && (IsLWS(empty[0]) || IsLWS(empty[empty.Length - 1])))
		{
			empty = empty.Trim(_WSchars);
		}
		if (empty.Length == 0)
		{
			newUriString = baseUri.GetParts(UriComponents.AbsoluteUri, baseUri.UserEscaped ? UriFormat.UriEscaped : UriFormat.SafeUnescaped);
			return null;
		}
		if (empty[0] == '#' && !baseUri.IsImplicitFile && baseUri.Syntax.InFact(UriSyntaxFlags.MayHaveFragment))
		{
			newUriString = baseUri.GetParts(UriComponents.HttpRequestUrl | UriComponents.UserInfo, UriFormat.UriEscaped) + empty;
			return null;
		}
		if (empty[0] == '?' && !baseUri.IsImplicitFile && baseUri.Syntax.InFact(UriSyntaxFlags.MayHaveQuery))
		{
			newUriString = baseUri.GetParts(UriComponents.SchemeAndServer | UriComponents.UserInfo | UriComponents.Path, UriFormat.UriEscaped) + empty;
			return null;
		}
		if (empty.Length >= 3 && (empty[1] == ':' || empty[1] == '|') && IsAsciiLetter(empty[0]) && (empty[2] == '\\' || empty[2] == '/'))
		{
			if (baseUri.IsImplicitFile)
			{
				newUriString = empty;
				return null;
			}
			if (baseUri.Syntax.InFact(UriSyntaxFlags.AllowDOSPath))
			{
				newUriString = string.Concat(str1: (!baseUri.InFact(Flags.AuthorityFound)) ? (baseUri.Syntax.InFact(UriSyntaxFlags.PathIsRooted) ? ":/" : ":") : (baseUri.Syntax.InFact(UriSyntaxFlags.PathIsRooted) ? ":///" : "://"), str0: baseUri.Scheme, str2: empty);
				return null;
			}
		}
		ParsingError combinedString = GetCombinedString(baseUri, empty, userEscaped, ref newUriString);
		if (combinedString != ParsingError.None)
		{
			e = GetException(combinedString);
			return null;
		}
		if ((object)newUriString == baseUri.m_String)
		{
			return baseUri;
		}
		return null;
	}

	private string GetRelativeSerializationString(UriFormat format)
	{
		switch (format)
		{
		case UriFormat.UriEscaped:
		{
			if (m_String.Length == 0)
			{
				return string.Empty;
			}
			int destPos = 0;
			char[] array = UriHelper.EscapeString(m_String, 0, m_String.Length, null, ref destPos, isUriString: true, '\uffff', '\uffff', '%');
			if (array == null)
			{
				return m_String;
			}
			return new string(array, 0, destPos);
		}
		case UriFormat.Unescaped:
			return UnescapeDataString(m_String);
		case UriFormat.SafeUnescaped:
		{
			if (m_String.Length == 0)
			{
				return string.Empty;
			}
			char[] dest = new char[m_String.Length];
			int destPosition = 0;
			dest = UriHelper.UnescapeString(m_String, 0, m_String.Length, dest, ref destPosition, '\uffff', '\uffff', '\uffff', UnescapeMode.EscapeUnescape, null, isQuery: false);
			return new string(dest, 0, destPosition);
		}
		default:
			throw new ArgumentOutOfRangeException("format");
		}
	}

	internal string GetComponentsHelper(UriComponents uriComponents, UriFormat uriFormat)
	{
		if (uriComponents == UriComponents.Scheme)
		{
			return m_Syntax.SchemeName;
		}
		if ((uriComponents & UriComponents.SerializationInfoString) != 0)
		{
			uriComponents |= UriComponents.AbsoluteUri;
		}
		EnsureParseRemaining();
		if ((uriComponents & UriComponents.NormalizedHost) != 0)
		{
			uriComponents |= UriComponents.Host;
		}
		if ((uriComponents & UriComponents.Host) != 0)
		{
			EnsureHostString(allowDnsOptimization: true);
		}
		if (uriComponents == UriComponents.Port || uriComponents == UriComponents.StrongPort)
		{
			if ((m_Flags & Flags.NotDefaultPort) != Flags.Zero || (uriComponents == UriComponents.StrongPort && m_Syntax.DefaultPort != -1))
			{
				return m_Info.Offset.PortValue.ToString(CultureInfo.InvariantCulture);
			}
			return string.Empty;
		}
		if ((uriComponents & UriComponents.StrongPort) != 0)
		{
			uriComponents |= UriComponents.Port;
		}
		if (uriComponents == UriComponents.Host && (uriFormat == UriFormat.UriEscaped || (m_Flags & (Flags.HostNotCanonical | Flags.E_HostNotCanonical)) == Flags.Zero))
		{
			EnsureHostString(allowDnsOptimization: false);
			return m_Info.Host;
		}
		switch (uriFormat)
		{
		case UriFormat.UriEscaped:
			return GetEscapedParts(uriComponents);
		case UriFormat.Unescaped:
		case UriFormat.SafeUnescaped:
		case (UriFormat)32767:
			return GetUnescapedParts(uriComponents, uriFormat);
		default:
			throw new ArgumentOutOfRangeException("uriFormat");
		}
	}

	public bool IsBaseOf(Uri uri)
	{
		if ((object)uri == null)
		{
			throw new ArgumentNullException("uri");
		}
		if (!IsAbsoluteUri)
		{
			return false;
		}
		if (Syntax.IsSimple)
		{
			return IsBaseOfHelper(uri);
		}
		return Syntax.InternalIsBaseOf(this, uri);
	}

	internal unsafe bool IsBaseOfHelper(Uri uriLink)
	{
		if (!IsAbsoluteUri || UserDrivenParsing)
		{
			return false;
		}
		if (!uriLink.IsAbsoluteUri)
		{
			string newUriString = null;
			bool userEscaped = false;
			uriLink = ResolveHelper(this, uriLink, ref newUriString, ref userEscaped, out var e);
			if (e != null)
			{
				return false;
			}
			if ((object)uriLink == null)
			{
				uriLink = CreateHelper(newUriString, userEscaped, UriKind.Absolute, ref e);
			}
			if (e != null)
			{
				return false;
			}
		}
		if (Syntax.SchemeName != uriLink.Syntax.SchemeName)
		{
			return false;
		}
		string parts = GetParts(UriComponents.HttpRequestUrl | UriComponents.UserInfo, UriFormat.SafeUnescaped);
		string parts2 = uriLink.GetParts(UriComponents.HttpRequestUrl | UriComponents.UserInfo, UriFormat.SafeUnescaped);
		fixed (char* pMe = parts)
		{
			fixed (char* pShe = parts2)
			{
				return UriHelper.TestForSubPath(pMe, (ushort)parts.Length, pShe, (ushort)parts2.Length, IsUncOrDosPath || uriLink.IsUncOrDosPath);
			}
		}
	}

	private void CreateThisFromUri(Uri otherUri)
	{
		m_Info = null;
		m_Flags = otherUri.m_Flags;
		if (InFact(Flags.MinimalUriInfoSet))
		{
			m_Flags &= ~(Flags.IndexMask | Flags.MinimalUriInfoSet | Flags.AllUriInfoSet);
			int num = otherUri.m_Info.Offset.Path;
			if (InFact(Flags.NotDefaultPort))
			{
				while (otherUri.m_String[num] != ':' && num > otherUri.m_Info.Offset.Host)
				{
					num--;
				}
				if (otherUri.m_String[num] != ':')
				{
					num = otherUri.m_Info.Offset.Path;
				}
			}
			m_Flags |= (Flags)num;
		}
		m_Syntax = otherUri.m_Syntax;
		m_String = otherUri.m_String;
		m_iriParsing = otherUri.m_iriParsing;
		if (otherUri.OriginalStringSwitched)
		{
			m_originalUnicodeString = otherUri.m_originalUnicodeString;
		}
		if (otherUri.AllowIdn && (otherUri.InFact(Flags.IdnHost) || otherUri.InFact(Flags.UnicodeHost)))
		{
			m_DnsSafeHost = otherUri.m_DnsSafeHost;
		}
	}
}
