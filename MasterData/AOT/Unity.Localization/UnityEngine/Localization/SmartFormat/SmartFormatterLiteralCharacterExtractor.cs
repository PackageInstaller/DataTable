using System.Collections.Generic;
using System.Linq;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat;

internal class SmartFormatterLiteralCharacterExtractor : SmartFormatter
{
	private IEnumerable<char> m_Characters;

	public SmartFormatterLiteralCharacterExtractor(SmartFormatter parent)
	{
		Settings = parent.Settings;
		Parser = parent.Parser;
		SourceExtensions.AddRange(parent.SourceExtensions);
		FormatterExtensions.AddRange(parent.FormatterExtensions);
	}

	public IEnumerable<char> ExtractLiteralsCharacters(string value)
	{
		m_Characters = "";
		Format(value, null);
		return m_Characters;
	}

	public override void Format(FormattingInfo formattingInfo)
	{
		foreach (FormatItem item in formattingInfo.Format.Items)
		{
			if (item is LiteralText)
			{
				m_Characters = m_Characters.Concat(item.ToEnumerable());
				continue;
			}
			Placeholder placeholder = (Placeholder)item;
			FormattingInfo formattingInfo2 = formattingInfo.CreateChild(placeholder);
			string formatterName = formattingInfo2.Placeholder.FormatterName;
			foreach (IFormatter formatterExtension in FormatterExtensions)
			{
				if (formatterExtension is IFormatterLiteralExtractor formatterLiteralExtractor && formatterExtension.Names.Contains(formatterName))
				{
					formatterLiteralExtractor.WriteAllLiterals(formattingInfo2);
				}
			}
		}
	}
}
