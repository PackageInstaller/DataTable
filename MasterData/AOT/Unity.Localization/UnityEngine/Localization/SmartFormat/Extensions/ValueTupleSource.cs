using System;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Utilities;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class ValueTupleSource : ISource
{
	private SmartFormatter m_Formatter;

	public ValueTupleSource(SmartFormatter formatter)
	{
		m_Formatter = formatter;
	}

	public bool TryEvaluateSelector(ISelectorInfo selectorInfo)
	{
		if (!(selectorInfo is FormattingInfo formattingInfo))
		{
			return false;
		}
		if (formattingInfo.CurrentValue == null || !formattingInfo.CurrentValue.IsValueTuple())
		{
			return false;
		}
		object currentValue = formattingInfo.CurrentValue;
		foreach (object item in formattingInfo.CurrentValue.GetValueTupleItemObjectsFlattened())
		{
			if (m_Formatter == null)
			{
				_ = LocalizationSettings.StringDatabase.SmartFormatter;
			}
			foreach (ISource sourceExtension in m_Formatter.SourceExtensions)
			{
				formattingInfo.CurrentValue = item;
				if (sourceExtension.TryEvaluateSelector(formattingInfo))
				{
					formattingInfo.CurrentValue = currentValue;
					return true;
				}
			}
		}
		formattingInfo.CurrentValue = currentValue;
		return false;
	}
}
