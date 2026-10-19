using System;

namespace Unity.VisualScripting;

[UnitCategory("Control")]
[UnitTitle("Switch On String")]
[UnitShortTitle("Switch")]
[UnitOrder(4)]
[UnitSubtitle("On String")]
public class SwitchOnString : SwitchUnit<string>
{
	[InspectorToggleLeft]
	[UnitHeaderInspectable("Ignore Case")]
	[Serialize]
	[Inspectable]
	public bool ignoreCase { get; set; }

	protected override bool Matches(string a, string b)
	{
		if (string.IsNullOrEmpty(a) && string.IsNullOrEmpty(b))
		{
			return true;
		}
		return string.Equals(a, b, ignoreCase ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal);
	}
}
