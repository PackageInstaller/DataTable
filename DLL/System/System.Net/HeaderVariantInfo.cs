namespace System.Net;

internal struct HeaderVariantInfo
{
	private string m_name;

	private CookieVariant m_variant;

	internal string Name => m_name;

	internal CookieVariant Variant => m_variant;

	internal HeaderVariantInfo(string name, CookieVariant variant)
	{
		m_name = name;
		m_variant = variant;
	}
}
