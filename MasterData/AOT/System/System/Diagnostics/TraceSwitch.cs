namespace System.Diagnostics;

[SwitchLevel(typeof(TraceLevel))]
public class TraceSwitch : Switch
{
	public TraceSwitch(string displayName, string description)
		: base(displayName, description)
	{
	}
}
