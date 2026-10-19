using System;
using UnityEngine.Localization.SmartFormat.Utilities;

namespace UnityEngine.Localization.SmartFormat.Extensions;

public class CustomPluralRuleProvider : IFormatProvider
{
	private readonly PluralRules.PluralRuleDelegate _pluralRule;

	public CustomPluralRuleProvider(PluralRules.PluralRuleDelegate pluralRule)
	{
		_pluralRule = pluralRule;
	}

	public object GetFormat(Type formatType)
	{
		if (!(formatType == typeof(CustomPluralRuleProvider)))
		{
			return null;
		}
		return this;
	}

	public PluralRules.PluralRuleDelegate GetPluralRule()
	{
		return _pluralRule;
	}
}
