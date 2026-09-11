namespace System.Net;

internal class HeaderInfo
{
	internal readonly bool IsRequestRestricted;

	internal readonly bool IsResponseRestricted;

	internal readonly HeaderParser Parser;

	internal readonly string HeaderName;

	internal readonly bool AllowMultiValues;

	internal HeaderInfo(string name, bool requestRestricted, bool responseRestricted, bool multi, HeaderParser p)
	{
		HeaderName = name;
		IsRequestRestricted = requestRestricted;
		IsResponseRestricted = responseRestricted;
		Parser = p;
		AllowMultiValues = multi;
	}
}
