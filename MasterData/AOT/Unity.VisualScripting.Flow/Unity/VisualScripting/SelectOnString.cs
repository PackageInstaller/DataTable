using System;

namespace Unity.VisualScripting;

[UnitTitle("Select On String")]
[UnitSubtitle("On String")]
[UnitOrder(7)]
[UnitShortTitle("Select")]
[UnitCategory("Control")]
public class SelectOnString : SelectUnit<string>
{
	[UnitHeaderInspectable("Ignore Case")]
	[Inspectable]
	[Serialize]
	[InspectorToggleLeft]
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
