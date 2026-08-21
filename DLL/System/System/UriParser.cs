using System.Collections.Generic;
using System.Runtime.Versioning;

namespace System;

public abstract class UriParser
{
	private enum UriQuirksVersion
	{
		V2 = 2,
		V3
	}

	private class BuiltInUriParser : UriParser
	{
		internal BuiltInUriParser(string lwrCaseScheme, int defaultPort, UriSyntaxFlags syntaxFlags)
			: base(syntaxFlags | UriSyntaxFlags.SimpleUserSyntax | UriSyntaxFlags.BuiltInSyntax)
		{
			m_Scheme = lwrCaseScheme;
			m_Port = defaultPort;
		}
	}

	private const UriSyntaxFlags SchemeOnlyFlags = UriSyntaxFlags.MayHavePath;

	private static readonly Dictionary<string, UriParser> m_Table;

	private static Dictionary<string, UriParser> m_TempTable;

	private UriSyntaxFlags m_Flags;

	private volatile UriSyntaxFlags m_UpdatableFlags;

	private volatile bool m_UpdatableFlagsUsed;

	private const UriSyntaxFlags c_UpdatableFlags = UriSyntaxFlags.UnEscapeDotsAndSlashes;

	private int m_Port;

	private string m_Scheme;

	internal const int NoDefaultPort = -1;

	private const int c_InitialTableSize = 25;

	internal static UriParser HttpUri;

	internal static UriParser HttpsUri;

	internal static UriParser WsUri;

	internal static UriParser WssUri;

	internal static UriParser FtpUri;

	internal static UriParser FileUri;

	internal static UriParser GopherUri;

	internal static UriParser NntpUri;

	internal static UriParser NewsUri;

	internal static UriParser MailToUri;

	internal static UriParser UuidUri;

	internal static UriParser TelnetUri;

	internal static UriParser LdapUri;

	internal static UriParser NetTcpUri;

	internal static UriParser NetPipeUri;

	internal static UriParser VsMacrosUri;

	private static readonly UriQuirksVersion s_QuirksVersion;

	private const int c_MaxCapacity = 512;

	private const UriSyntaxFlags UnknownV1SyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.OptionalAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.V1_UnknownUri | UriSyntaxFlags.AllowDOSPath | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private static readonly UriSyntaxFlags HttpSyntaxFlags;

	private const UriSyntaxFlags FtpSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.CanonicalizeAsFilePath | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private static readonly UriSyntaxFlags FileSyntaxFlags;

	private const UriSyntaxFlags VsmacrosSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.FileLikeUri | UriSyntaxFlags.AllowDOSPath | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.CanonicalizeAsFilePath | UriSyntaxFlags.UnEscapeDotsAndSlashes | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private const UriSyntaxFlags GopherSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private const UriSyntaxFlags NewsSyntaxFlags = UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowIriParsing;

	private const UriSyntaxFlags NntpSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private const UriSyntaxFlags TelnetSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private const UriSyntaxFlags LdapSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private const UriSyntaxFlags MailtoSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.MailToLikeUri | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private const UriSyntaxFlags NetPipeSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.CanonicalizeAsFilePath | UriSyntaxFlags.UnEscapeDotsAndSlashes | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	private const UriSyntaxFlags NetTcpSyntaxFlags = UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.CanonicalizeAsFilePath | UriSyntaxFlags.UnEscapeDotsAndSlashes | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing;

	internal string SchemeName => m_Scheme;

	internal int DefaultPort => m_Port;

	internal static bool ShouldUseLegacyV2Quirks => s_QuirksVersion <= UriQuirksVersion.V2;

	internal UriSyntaxFlags Flags => m_Flags;

	internal bool IsSimple => InFact(UriSyntaxFlags.SimpleUserSyntax);

	protected virtual UriParser OnNewUri()
	{
		return this;
	}

	protected virtual void InitializeAndValidate(Uri uri, out UriFormatException parsingError)
	{
		parsingError = uri.ParseMinimal();
	}

	protected virtual string Resolve(Uri baseUri, Uri relativeUri, out UriFormatException parsingError)
	{
		if (baseUri.UserDrivenParsing)
		{
			throw new InvalidOperationException(global::SR.GetString("A derived type '{0}' is responsible for parsing this Uri instance. The base implementation must not be used.", GetType().FullName));
		}
		if (!baseUri.IsAbsoluteUri)
		{
			throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
		}
		string newUriString = null;
		bool userEscaped = false;
		Uri uri = Uri.ResolveHelper(baseUri, relativeUri, ref newUriString, ref userEscaped, out parsingError);
		if (parsingError != null)
		{
			return null;
		}
		if (uri != null)
		{
			return uri.OriginalString;
		}
		return newUriString;
	}

	protected virtual bool IsBaseOf(Uri baseUri, Uri relativeUri)
	{
		return baseUri.IsBaseOfHelper(relativeUri);
	}

	protected virtual string GetComponents(Uri uri, UriComponents components, UriFormat format)
	{
		if ((components & UriComponents.SerializationInfoString) != 0 && components != UriComponents.SerializationInfoString)
		{
			throw new ArgumentOutOfRangeException("components", components, global::SR.GetString("UriComponents.SerializationInfoString must not be combined with other UriComponents."));
		}
		if ((format & (UriFormat)(-4)) != 0)
		{
			throw new ArgumentOutOfRangeException("format");
		}
		if (uri.UserDrivenParsing)
		{
			throw new InvalidOperationException(global::SR.GetString("A derived type '{0}' is responsible for parsing this Uri instance. The base implementation must not be used.", GetType().FullName));
		}
		if (!uri.IsAbsoluteUri)
		{
			throw new InvalidOperationException(global::SR.GetString("This operation is not supported for a relative URI."));
		}
		return uri.GetComponentsHelper(components, format);
	}

	static UriParser()
	{
		s_QuirksVersion = (BinaryCompatibility.TargetsAtLeast_Desktop_V4_5 ? UriQuirksVersion.V3 : UriQuirksVersion.V2);
		HttpSyntaxFlags = (UriSyntaxFlags)(0x1E00F7D | (ShouldUseLegacyV2Quirks ? 33554432 : 0) | 0x4000000 | 0x10000000);
		FileSyntaxFlags = (UriSyntaxFlags)(0xFD1 | ((!ShouldUseLegacyV2Quirks) ? 32 : 0) | 0x2000 | 0x200000 | 0x100000 | 0x400000 | 0x800000 | 0x1000000 | 0x2000000 | 0x4000000 | 0x10000000);
		m_Table = new Dictionary<string, UriParser>(25);
		m_TempTable = new Dictionary<string, UriParser>(25);
		HttpUri = new BuiltInUriParser("http", 80, HttpSyntaxFlags);
		m_Table[HttpUri.SchemeName] = HttpUri;
		HttpsUri = new BuiltInUriParser("https", 443, HttpUri.m_Flags);
		m_Table[HttpsUri.SchemeName] = HttpsUri;
		WsUri = new BuiltInUriParser("ws", 80, HttpSyntaxFlags);
		m_Table[WsUri.SchemeName] = WsUri;
		WssUri = new BuiltInUriParser("wss", 443, HttpSyntaxFlags);
		m_Table[WssUri.SchemeName] = WssUri;
		FtpUri = new BuiltInUriParser("ftp", 21, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.CanonicalizeAsFilePath | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[FtpUri.SchemeName] = FtpUri;
		FileUri = new BuiltInUriParser("file", -1, FileSyntaxFlags);
		m_Table[FileUri.SchemeName] = FileUri;
		GopherUri = new BuiltInUriParser("gopher", 70, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[GopherUri.SchemeName] = GopherUri;
		NntpUri = new BuiltInUriParser("nntp", 119, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[NntpUri.SchemeName] = NntpUri;
		NewsUri = new BuiltInUriParser("news", -1, UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowIriParsing);
		m_Table[NewsUri.SchemeName] = NewsUri;
		MailToUri = new BuiltInUriParser("mailto", 25, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.MailToLikeUri | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[MailToUri.SchemeName] = MailToUri;
		UuidUri = new BuiltInUriParser("uuid", -1, NewsUri.m_Flags);
		m_Table[UuidUri.SchemeName] = UuidUri;
		TelnetUri = new BuiltInUriParser("telnet", 23, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[TelnetUri.SchemeName] = TelnetUri;
		LdapUri = new BuiltInUriParser("ldap", 389, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[LdapUri.SchemeName] = LdapUri;
		NetTcpUri = new BuiltInUriParser("net.tcp", 808, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.CanonicalizeAsFilePath | UriSyntaxFlags.UnEscapeDotsAndSlashes | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[NetTcpUri.SchemeName] = NetTcpUri;
		NetPipeUri = new BuiltInUriParser("net.pipe", -1, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.CanonicalizeAsFilePath | UriSyntaxFlags.UnEscapeDotsAndSlashes | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[NetPipeUri.SchemeName] = NetPipeUri;
		VsMacrosUri = new BuiltInUriParser("vsmacros", -1, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.MustHaveAuthority | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.FileLikeUri | UriSyntaxFlags.AllowDOSPath | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.CanonicalizeAsFilePath | UriSyntaxFlags.UnEscapeDotsAndSlashes | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
		m_Table[VsMacrosUri.SchemeName] = VsMacrosUri;
	}

	internal bool NotAny(UriSyntaxFlags flags)
	{
		return IsFullMatch(flags, UriSyntaxFlags.None);
	}

	internal bool InFact(UriSyntaxFlags flags)
	{
		return !IsFullMatch(flags, UriSyntaxFlags.None);
	}

	internal bool IsAllSet(UriSyntaxFlags flags)
	{
		return IsFullMatch(flags, flags);
	}

	private bool IsFullMatch(UriSyntaxFlags flags, UriSyntaxFlags expected)
	{
		UriSyntaxFlags uriSyntaxFlags = (((flags & UriSyntaxFlags.UnEscapeDotsAndSlashes) != UriSyntaxFlags.None && m_UpdatableFlagsUsed) ? ((m_Flags & ~UriSyntaxFlags.UnEscapeDotsAndSlashes) | m_UpdatableFlags) : m_Flags);
		return (uriSyntaxFlags & flags) == expected;
	}

	internal UriParser(UriSyntaxFlags flags)
	{
		m_Flags = flags;
		m_Scheme = string.Empty;
	}

	internal static UriParser FindOrFetchAsUnknownV1Syntax(string lwrCaseScheme)
	{
		UriParser value = null;
		m_Table.TryGetValue(lwrCaseScheme, out value);
		if (value != null)
		{
			return value;
		}
		m_TempTable.TryGetValue(lwrCaseScheme, out value);
		if (value != null)
		{
			return value;
		}
		lock (m_Table)
		{
			if (m_TempTable.Count >= 512)
			{
				m_TempTable = new Dictionary<string, UriParser>(25);
			}
			value = new BuiltInUriParser(lwrCaseScheme, -1, UriSyntaxFlags.AllowAnInternetHost | UriSyntaxFlags.OptionalAuthority | UriSyntaxFlags.MayHaveUserInfo | UriSyntaxFlags.MayHavePort | UriSyntaxFlags.MayHavePath | UriSyntaxFlags.MayHaveQuery | UriSyntaxFlags.MayHaveFragment | UriSyntaxFlags.AllowEmptyHost | UriSyntaxFlags.AllowUncHost | UriSyntaxFlags.V1_UnknownUri | UriSyntaxFlags.AllowDOSPath | UriSyntaxFlags.PathIsRooted | UriSyntaxFlags.ConvertPathSlashes | UriSyntaxFlags.CompressPath | UriSyntaxFlags.AllowIdn | UriSyntaxFlags.AllowIriParsing);
			m_TempTable[lwrCaseScheme] = value;
			return value;
		}
	}

	internal static UriParser GetSyntax(string lwrCaseScheme)
	{
		UriParser value = null;
		m_Table.TryGetValue(lwrCaseScheme, out value);
		if (value == null)
		{
			m_TempTable.TryGetValue(lwrCaseScheme, out value);
		}
		return value;
	}

	internal UriParser InternalOnNewUri()
	{
		UriParser uriParser = OnNewUri();
		if (this != uriParser)
		{
			uriParser.m_Scheme = m_Scheme;
			uriParser.m_Port = m_Port;
			uriParser.m_Flags = m_Flags;
		}
		return uriParser;
	}

	internal void InternalValidate(Uri thisUri, out UriFormatException parsingError)
	{
		InitializeAndValidate(thisUri, out parsingError);
	}

	internal string InternalResolve(Uri thisBaseUri, Uri uriLink, out UriFormatException parsingError)
	{
		return Resolve(thisBaseUri, uriLink, out parsingError);
	}

	internal bool InternalIsBaseOf(Uri thisBaseUri, Uri uriLink)
	{
		return IsBaseOf(thisBaseUri, uriLink);
	}

	internal string InternalGetComponents(Uri thisUri, UriComponents uriComponents, UriFormat uriFormat)
	{
		return GetComponents(thisUri, uriComponents, uriFormat);
	}
}
