using System.ComponentModel;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat.Core.Extensions;

public interface IFormattingInfo
{
	object CurrentValue { get; }

	Format Format { get; }

	[EditorBrowsable(EditorBrowsableState.Advanced)]
	Placeholder Placeholder { get; }

	int Alignment { get; }

	string FormatterOptions { get; }

	[EditorBrowsable(EditorBrowsableState.Advanced)]
	FormatDetails FormatDetails { get; }

	void Write(string text);

	void Write(string text, int startIndex, int length);

	void Write(Format format, object value);

	FormattingException FormattingException(string issue, FormatItem problemItem = null, int startIndex = -1);
}
