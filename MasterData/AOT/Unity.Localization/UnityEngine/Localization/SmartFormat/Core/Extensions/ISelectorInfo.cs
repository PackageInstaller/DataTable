using System.ComponentModel;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Core.Parsing;

namespace UnityEngine.Localization.SmartFormat.Core.Extensions;

public interface ISelectorInfo
{
	object CurrentValue { get; }

	string SelectorText { get; }

	int SelectorIndex { get; }

	string SelectorOperator { get; }

	object Result { get; set; }

	[EditorBrowsable(EditorBrowsableState.Advanced)]
	Placeholder Placeholder { get; }

	[EditorBrowsable(EditorBrowsableState.Advanced)]
	FormatDetails FormatDetails { get; }
}
