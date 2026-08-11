namespace Yarn.Unity;

internal static class DiagnosticUtility
{
	public static string EnglishPluraliseNounCount(int count, string name, bool prefixCount = false)
	{
		string text = ((count != 1) ? (name + "s") : name);
		if (prefixCount)
		{
			return count + " " + text;
		}
		return text;
	}

	public static string EnglishPluraliseWasVerb(int count)
	{
		if (count == 1)
		{
			return "was";
		}
		return "were";
	}
}
