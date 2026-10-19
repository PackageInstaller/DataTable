namespace System.Diagnostics;

[SwitchLevel(typeof(bool))]
public class BooleanSwitch : Switch
{
	public BooleanSwitch(string displayName, string description)
		: base(displayName, description)
	{
	}
}
