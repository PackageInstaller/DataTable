using System.Collections.Generic;
using UnityEngine.Localization.SmartFormat.Core.Extensions;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat.Core.Formatting;

public class FormattingInfo : IFormattingInfo, ISelectorInfo
{
	public FormattingInfo Parent { get; private set; }

	public Selector Selector { get; set; }

	public FormatDetails FormatDetails { get; private set; }

	public object CurrentValue { get; set; }

	public Placeholder Placeholder { get; private set; }

	public int Alignment => Placeholder.Alignment;

	public string FormatterOptions => Placeholder.FormatterOptions;

	public Format Format { get; private set; }

	public List<FormattingInfo> Children { get; } = new List<FormattingInfo>();

	public string SelectorText => Selector.RawText;

	public int SelectorIndex => Selector.SelectorIndex;

	public string SelectorOperator => Selector.Operator;

	public object Result { get; set; }

	public void Init(FormatDetails formatDetails, Format format, object currentValue)
	{
		Init(null, formatDetails, format, currentValue);
	}

	public void Init(FormattingInfo parent, FormatDetails formatDetails, Format format, object currentValue)
	{
		Parent = parent;
		CurrentValue = currentValue;
		Format = format;
		FormatDetails = formatDetails;
	}

	public void Init(FormattingInfo parent, FormatDetails formatDetails, Placeholder placeholder, object currentValue)
	{
		Parent = parent;
		FormatDetails = formatDetails;
		Placeholder = placeholder;
		Format = placeholder.Format;
		CurrentValue = currentValue;
	}

	public void ReleaseToPool()
	{
		Parent = null;
		FormatDetails = null;
		Placeholder = null;
		Format = null;
		CurrentValue = null;
		foreach (FormattingInfo child in Children)
		{
			FormattingInfoPool.Release(child);
		}
		Children.Clear();
	}

	public void Write(string text)
	{
		FormatDetails.Output.Write(text, this);
	}

	public void Write(string text, int startIndex, int length)
	{
		FormatDetails.Output.Write(text, startIndex, length, this);
	}

	public void Write(Format format, object value)
	{
		FormattingInfo formattingInfo = CreateChild(format, value);
		FormatDetails.Formatter.Format(formattingInfo);
	}

	public FormattingException FormattingException(string issue, FormatItem problemItem = null, int startIndex = -1)
	{
		if (problemItem == null)
		{
			problemItem = Format;
		}
		if (startIndex == -1)
		{
			startIndex = problemItem.startIndex;
		}
		return new FormattingException(problemItem, issue, startIndex);
	}

	private FormattingInfo CreateChild(Format format, object currentValue)
	{
		FormattingInfo formattingInfo = FormattingInfoPool.Get(this, FormatDetails, format, currentValue);
		Children.Add(formattingInfo);
		return formattingInfo;
	}

	public FormattingInfo CreateChild(Placeholder placeholder)
	{
		FormattingInfo formattingInfo = FormattingInfoPool.Get(this, FormatDetails, placeholder, CurrentValue);
		Children.Add(formattingInfo);
		return formattingInfo;
	}
}
