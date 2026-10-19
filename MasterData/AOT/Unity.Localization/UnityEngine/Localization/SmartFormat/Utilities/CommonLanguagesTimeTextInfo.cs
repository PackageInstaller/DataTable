namespace UnityEngine.Localization.SmartFormat.Utilities;

public static class CommonLanguagesTimeTextInfo
{
	public static TimeTextInfo English => new TimeTextInfo(PluralRules.GetPluralRule("en"), new string[2] { "{0} week", "{0} weeks" }, new string[2] { "{0} day", "{0} days" }, new string[2] { "{0} hour", "{0} hours" }, new string[2] { "{0} minute", "{0} minutes" }, new string[2] { "{0} second", "{0} seconds" }, new string[2] { "{0} millisecond", "{0} milliseconds" }, new string[1] { "{0}w" }, new string[1] { "{0}d" }, new string[1] { "{0}h" }, new string[1] { "{0}m" }, new string[1] { "{0}s" }, new string[1] { "{0}ms" }, "less than {0}");

	public static TimeTextInfo GetTimeTextInfo(string twoLetterIsoLanguageName)
	{
		if (twoLetterIsoLanguageName == "en")
		{
			return English;
		}
		return null;
	}
}
