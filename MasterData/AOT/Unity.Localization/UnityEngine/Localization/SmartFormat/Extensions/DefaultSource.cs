using System;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Formatting;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class DefaultSource : ISource
{
	public DefaultSource(SmartFormatter formatter)
	{
		formatter.Parser.AddOperators(",");
		formatter.Parser.AddAdditionalSelectorChars("-");
	}

	public bool TryEvaluateSelector(ISelectorInfo selectorInfo)
	{
		object currentValue = selectorInfo.CurrentValue;
		string selectorText = selectorInfo.SelectorText;
		FormatDetails formatDetails = selectorInfo.FormatDetails;
		if (int.TryParse(selectorText, out var result))
		{
			if (selectorInfo.SelectorIndex == 0 && result < formatDetails.OriginalArgs.Count && selectorInfo.SelectorOperator == "")
			{
				selectorInfo.Result = formatDetails.OriginalArgs[result];
				return true;
			}
			if (selectorInfo.SelectorOperator == ",")
			{
				if (selectorInfo.Placeholder != null)
				{
					selectorInfo.Placeholder.Alignment = result;
				}
				selectorInfo.Result = currentValue;
				return true;
			}
		}
		return false;
	}
}
