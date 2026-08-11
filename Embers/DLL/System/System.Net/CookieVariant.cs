namespace System.Net;

internal enum CookieVariant
{
	Unknown = 0,
	Plain = 1,
	Rfc2109 = 2,
	Rfc2965 = 3,
	Default = Rfc2109
}
