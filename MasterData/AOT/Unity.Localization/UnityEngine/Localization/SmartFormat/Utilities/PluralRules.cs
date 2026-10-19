using System;
using System.Collections.Generic;

namespace UnityEngine.Localization.SmartFormat.Utilities;

public static class PluralRules
{
	public delegate int PluralRuleDelegate(decimal value, int pluralCount);

	public static readonly Dictionary<string, PluralRuleDelegate> IsoLangToDelegate = new Dictionary<string, PluralRuleDelegate>
	{
		{ "az", Singular },
		{ "bm", Singular },
		{ "bo", Singular },
		{ "dz", Singular },
		{ "fa", Singular },
		{ "hu", Singular },
		{ "id", Singular },
		{ "ig", Singular },
		{ "ii", Singular },
		{ "ja", Singular },
		{ "jv", Singular },
		{ "ka", Singular },
		{ "kde", Singular },
		{ "kea", Singular },
		{ "km", Singular },
		{ "kn", Singular },
		{ "ko", Singular },
		{ "ms", Singular },
		{ "my", Singular },
		{ "root", Singular },
		{ "sah", Singular },
		{ "ses", Singular },
		{ "sg", Singular },
		{ "th", Singular },
		{ "to", Singular },
		{ "vi", Singular },
		{ "wo", Singular },
		{ "yo", Singular },
		{ "zh", Singular },
		{ "af", DualOneOther },
		{ "bem", DualOneOther },
		{ "bg", DualOneOther },
		{ "bn", DualOneOther },
		{ "brx", DualOneOther },
		{ "ca", DualOneOther },
		{ "cgg", DualOneOther },
		{ "chr", DualOneOther },
		{ "da", DualOneOther },
		{ "de", DualOneOther },
		{ "dv", DualOneOther },
		{ "ee", DualOneOther },
		{ "el", DualOneOther },
		{ "en", DualOneOther },
		{ "eo", DualOneOther },
		{ "es", DualOneOther },
		{ "et", DualOneOther },
		{ "eu", DualOneOther },
		{ "fi", DualOneOther },
		{ "fo", DualOneOther },
		{ "fur", DualOneOther },
		{ "fy", DualOneOther },
		{ "gl", DualOneOther },
		{ "gsw", DualOneOther },
		{ "gu", DualOneOther },
		{ "ha", DualOneOther },
		{ "haw", DualOneOther },
		{ "he", DualOneOther },
		{ "is", DualOneOther },
		{ "it", DualOneOther },
		{ "kk", DualOneOther },
		{ "kl", DualOneOther },
		{ "ku", DualOneOther },
		{ "lb", DualOneOther },
		{ "lg", DualOneOther },
		{ "lo", DualOneOther },
		{ "mas", DualOneOther },
		{ "ml", DualOneOther },
		{ "mn", DualOneOther },
		{ "mr", DualOneOther },
		{ "nah", DualOneOther },
		{ "nb", DualOneOther },
		{ "ne", DualOneOther },
		{ "nl", DualOneOther },
		{ "nn", DualOneOther },
		{ "no", DualOneOther },
		{ "nyn", DualOneOther },
		{ "om", DualOneOther },
		{ "or", DualOneOther },
		{ "pa", DualOneOther },
		{ "pap", DualOneOther },
		{ "ps", DualOneOther },
		{ "pt", DualOneOther },
		{ "rm", DualOneOther },
		{ "saq", DualOneOther },
		{ "so", DualOneOther },
		{ "sq", DualOneOther },
		{ "ssy", DualOneOther },
		{ "sw", DualOneOther },
		{ "sv", DualOneOther },
		{ "syr", DualOneOther },
		{ "ta", DualOneOther },
		{ "te", DualOneOther },
		{ "tk", DualOneOther },
		{ "tr", DualOneOther },
		{ "ur", DualOneOther },
		{ "wae", DualOneOther },
		{ "xog", DualOneOther },
		{ "zu", DualOneOther },
		{ "ak", DualWithZero },
		{ "am", DualWithZero },
		{ "bh", DualWithZero },
		{ "fil", DualWithZero },
		{ "guw", DualWithZero },
		{ "hi", DualWithZero },
		{ "ln", DualWithZero },
		{ "mg", DualWithZero },
		{ "nso", DualWithZero },
		{ "ti", DualWithZero },
		{ "tl", DualWithZero },
		{ "wa", DualWithZero },
		{ "ff", DualFromZeroToTwo },
		{ "fr", DualFromZeroToTwo },
		{ "kab", DualFromZeroToTwo },
		{ "ga", TripleOneTwoOther },
		{ "iu", TripleOneTwoOther },
		{ "ksh", TripleOneTwoOther },
		{ "kw", TripleOneTwoOther },
		{ "se", TripleOneTwoOther },
		{ "sma", TripleOneTwoOther },
		{ "smi", TripleOneTwoOther },
		{ "smj", TripleOneTwoOther },
		{ "smn", TripleOneTwoOther },
		{ "sms", TripleOneTwoOther },
		{ "be", RussianSerboCroatian },
		{ "bs", RussianSerboCroatian },
		{ "hr", RussianSerboCroatian },
		{ "ru", RussianSerboCroatian },
		{ "sh", RussianSerboCroatian },
		{ "sr", RussianSerboCroatian },
		{ "uk", RussianSerboCroatian },
		{ "ar", Arabic },
		{ "br", Breton },
		{ "cs", Czech },
		{ "cy", Welsh },
		{ "gv", Manx },
		{ "lag", Langi },
		{ "lt", Lithuanian },
		{ "lv", Latvian },
		{ "mb", Macedonian },
		{ "mo", Moldavian },
		{ "mt", Maltese },
		{ "pl", Polish },
		{ "ro", Romanian },
		{ "shi", Tachelhit },
		{ "sk", Slovak },
		{ "sl", Slovenian },
		{ "tzm", CentralMoroccoTamazight }
	};

	private static PluralRuleDelegate Singular => (decimal n, int c) => 0;

	private static PluralRuleDelegate DualOneOther => (decimal n, int c) =>
	{
		switch (c)
		{
		case 2:
			if (!(n == 1m))
			{
				return 1;
			}
			return 0;
		case 3:
			if (!(n == 0m))
			{
				if (!(n == 1m))
				{
					return 2;
				}
				return 1;
			}
			return 0;
		case 4:
			if (!(n < 0m))
			{
				if (!(n == 0m))
				{
					if (!(n == 1m))
					{
						return 3;
					}
					return 2;
				}
				return 1;
			}
			return 0;
		default:
			return -1;
		}
	};

	private static PluralRuleDelegate DualWithZero => (decimal n, int c) => (!(n == 0m) && !(n == 1m)) ? 1 : 0;

	private static PluralRuleDelegate DualFromZeroToTwo => (decimal n, int c) => (!(n == 0m) && !(n == 1m)) ? 1 : 0;

	private static PluralRuleDelegate TripleOneTwoOther => (decimal n, int c) => (!(n == 1m)) ? ((n == 2m) ? 1 : 2) : 0;

	private static PluralRuleDelegate RussianSerboCroatian => (decimal n, int c) => (!(n % 10m == 1m) || !(n % 100m != 11m)) ? (((n % 10m).Between(2m, 4m) && !(n % 100m).Between(12m, 14m)) ? 1 : 2) : 0;

	private static PluralRuleDelegate Arabic => (decimal n, int c) => (!(n == 0m)) ? ((n == 1m) ? 1 : ((!(n == 2m)) ? ((!(n % 100m).Between(3m, 10m)) ? ((!(n % 100m).Between(11m, 99m)) ? 5 : 4) : 3) : 2)) : 0;

	private static PluralRuleDelegate Breton => (decimal n, int c) => (!(n == 0m)) ? ((n == 1m) ? 1 : ((!(n == 2m)) ? ((!(n == 3m)) ? ((!(n == 6m)) ? 5 : 4) : 3) : 2)) : 0;

	private static PluralRuleDelegate Czech => (decimal n, int c) => (!(n == 1m)) ? (n.Between(2m, 4m) ? 1 : 2) : 0;

	private static PluralRuleDelegate Welsh => (decimal n, int c) => (!(n == 0m)) ? ((n == 1m) ? 1 : ((!(n == 2m)) ? ((!(n == 3m)) ? ((!(n == 6m)) ? 5 : 4) : 3) : 2)) : 0;

	private static PluralRuleDelegate Manx => (decimal n, int c) => (!(n % 10m).Between(1m, 2m) && !(n % 20m == 0m)) ? 1 : 0;

	private static PluralRuleDelegate Langi => (decimal n, int c) => (!(n == 0m)) ? ((n > 0m && n < 2m) ? 1 : 2) : 0;

	private static PluralRuleDelegate Lithuanian => (decimal n, int c) => (!(n % 10m == 1m) || (n % 100m).Between(11m, 19m)) ? (((n % 10m).Between(2m, 9m) && !(n % 100m).Between(11m, 19m)) ? 1 : 2) : 0;

	private static PluralRuleDelegate Latvian => (decimal n, int c) => (!(n == 0m)) ? ((n % 10m == 1m && n % 100m != 11m) ? 1 : 2) : 0;

	private static PluralRuleDelegate Macedonian => (decimal n, int c) => (!(n % 10m == 1m) || !(n != 11m)) ? 1 : 0;

	private static PluralRuleDelegate Moldavian => (decimal n, int c) => (!(n == 1m)) ? ((n == 0m || (n != 1m && (n % 100m).Between(1m, 19m))) ? 1 : 2) : 0;

	private static PluralRuleDelegate Maltese => (decimal n, int c) => (!(n == 1m)) ? ((n == 0m || (n % 100m).Between(2m, 10m)) ? 1 : ((!(n % 100m).Between(11m, 19m)) ? 3 : 2)) : 0;

	private static PluralRuleDelegate Polish => (decimal n, int c) => (!(n == 1m)) ? (((n % 10m).Between(2m, 4m) && !(n % 100m).Between(12m, 14m)) ? 1 : ((!(n % 10m).Between(0m, 1m) && !(n % 10m).Between(5m, 9m) && !(n % 100m).Between(12m, 14m)) ? 3 : 2)) : 0;

	private static PluralRuleDelegate Romanian => (decimal n, int c) => (!(n == 1m)) ? ((n == 0m || (n % 100m).Between(1m, 19m)) ? 1 : 2) : 0;

	private static PluralRuleDelegate Tachelhit => (decimal n, int c) => (!(n >= 0m) || !(n <= 1m)) ? (n.Between(2m, 10m) ? 1 : 2) : 0;

	private static PluralRuleDelegate Slovak => (decimal n, int c) => (!(n == 1m)) ? (n.Between(2m, 4m) ? 1 : 2) : 0;

	private static PluralRuleDelegate Slovenian => (decimal n, int c) => (!(n % 100m == 1m)) ? ((n % 100m == 2m) ? 1 : ((!(n % 100m).Between(3m, 4m)) ? 3 : 2)) : 0;

	private static PluralRuleDelegate CentralMoroccoTamazight => (decimal n, int c) => (!n.Between(0m, 1m) && !n.Between(11m, 99m)) ? 1 : 0;

	public static PluralRuleDelegate GetPluralRule(string twoLetterIsoLanguageName)
	{
		if (!IsoLangToDelegate.TryGetValue(twoLetterIsoLanguageName, out var value))
		{
			throw new ArgumentException("IsoLangToDelegate not found for " + twoLetterIsoLanguageName, "twoLetterIsoLanguageName");
		}
		return value;
	}

	private static bool Between(this decimal value, decimal min, decimal max)
	{
		if (value % 1m == 0m && value >= min)
		{
			return value <= max;
		}
		return false;
	}
}
