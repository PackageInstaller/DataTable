using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class IsMatchFormatter : FormatterBase, IFormatterLiteralExtractor
{
	public override string[] DefaultNames => new string[1] { "ismatch" };

	public RegexOptions RegexOptions { get; set; }

	public IsMatchFormatter()
	{
		Names = DefaultNames;
	}

	public override bool TryEvaluateFormat(IFormattingInfo formattingInfo)
	{
		string formatterOptions = formattingInfo.FormatterOptions;
		IList<Format> list = formattingInfo.Format.Split('|');
		if (list.Count == 0)
		{
			return true;
		}
		if (list.Count != 2)
		{
			throw new FormatException("Exactly 2 format options are required.");
		}
		if (new Regex(formatterOptions, RegexOptions).IsMatch(formattingInfo.CurrentValue.ToString()))
		{
			formattingInfo.Write(list[0], formattingInfo.CurrentValue);
		}
		else if (list.Count == 2)
		{
			formattingInfo.Write(list[1], formattingInfo.CurrentValue);
		}
		return true;
	}

	public void WriteAllLiterals(IFormattingInfo formattingInfo)
	{
		IList<Format> list = formattingInfo.Format.Split('|');
		if (list.Count != 0 && list.Count == 2)
		{
			formattingInfo.Write(list[0], formattingInfo.CurrentValue);
			formattingInfo.Write(list[1], formattingInfo.CurrentValue);
		}
	}
}
