using Unity.VisualScripting;
using UnityEngine;

namespace Bolt.Addons.Community.Fundamentals.Units.Utility;

[UnitCategory("Community\\Utility")]
[UnitTitle("Copy To Clipboard")]
[TypeIcon(typeof(GUIUtility))]
public class CopyToClipboardUnit : Unit
{
	[PortKey("enter")]
	[DoNotSerialize]
	public ControlInput enter;

	[PortKey("exit")]
	[DoNotSerialize]
	public ControlOutput exit;

	[PortKey("text")]
	[DoNotSerialize]
	public ValueInput text;

	protected override void Definition()
	{
		enter = ControlInput("enter", CopyTextToClipboard);
		exit = ControlOutput("exit");
		text = ValueInput("text", "");
		Succession(enter, exit);
		Requirement(text, enter);
	}

	private ControlOutput CopyTextToClipboard(Flow flow)
	{
		GUIUtility.systemCopyBuffer = flow.GetValue<string>(text);
		return exit;
	}
}
