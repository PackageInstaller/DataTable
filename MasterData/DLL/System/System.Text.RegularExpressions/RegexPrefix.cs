namespace System.Text.RegularExpressions;

internal readonly struct RegexPrefix
{
	internal bool CaseInsensitive { get; }

	internal static RegexPrefix Empty { get; } = new RegexPrefix(string.Empty, ci: false);

	internal string Prefix { get; }

	internal RegexPrefix(string prefix, bool ci)
	{
		Prefix = prefix;
		CaseInsensitive = ci;
	}
}
