using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class DictionarySource : ISource
{
	public DictionarySource(SmartFormatter formatter)
	{
		formatter.Parser.AddAlphanumericSelectors();
		formatter.Parser.AddAdditionalSelectorChars("_");
		formatter.Parser.AddOperators(".");
	}

	public bool TryEvaluateSelector(ISelectorInfo selectorInfo)
	{
		object currentValue = selectorInfo.CurrentValue;
		string selector = selectorInfo.SelectorText;
		if (currentValue is IDictionary dictionary)
		{
			foreach (DictionaryEntry item in dictionary)
			{
				if (((item.Key as string) ?? item.Key.ToString()).Equals(selector, selectorInfo.FormatDetails.Settings.GetCaseSensitivityComparison()))
				{
					selectorInfo.Result = item.Value;
					return true;
				}
			}
		}
		if (currentValue is IDictionary<string, object> source)
		{
			object value = source.FirstOrDefault((KeyValuePair<string, object> x) => x.Key.Equals(selector, selectorInfo.FormatDetails.Settings.GetCaseSensitivityComparison())).Value;
			if (value != null)
			{
				selectorInfo.Result = value;
				return true;
			}
		}
		return false;
	}
}
