using System;
using System.Collections.Generic;
using UnityEngine.Localization.SmartFormat.Core.Output;
using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Localization.SmartFormat.Core.Settings;

namespace UnityEngine.Localization.SmartFormat.Core.Formatting;

public class FormatDetails
{
	public SmartFormatter Formatter { get; private set; }

	public Format OriginalFormat { get; private set; }

	public IList<object> OriginalArgs { get; private set; }

	public FormatCache FormatCache { get; private set; }

	public IFormatProvider Provider { get; private set; }

	public IOutput Output { get; private set; }

	public FormattingException FormattingException { get; set; }

	public SmartSettings Settings => Formatter.Settings;

	public void Init(SmartFormatter formatter, Format originalFormat, IList<object> originalArgs, FormatCache formatCache, IFormatProvider provider, IOutput output)
	{
		Formatter = formatter;
		OriginalFormat = originalFormat;
		OriginalArgs = originalArgs;
		FormatCache = formatCache;
		Provider = provider;
		Output = output;
	}

	internal void Clear()
	{
		Formatter = null;
		OriginalFormat = null;
		OriginalArgs = null;
		FormatCache = null;
		Provider = null;
		Output = null;
		FormattingException = null;
	}
}
