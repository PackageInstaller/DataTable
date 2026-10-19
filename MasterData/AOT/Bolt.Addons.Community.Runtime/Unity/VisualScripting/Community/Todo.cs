using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitCategory("Community\\Documentation")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Documenting.Todo")]
public class Todo : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	[Serialize]
	[InspectorLabel("Error on hit")]
	[Inspectable]
	public bool ErrorIfHit { get; set; }

	[Inspectable]
	[InspectorLabel("Message")]
	[Serialize]
	[UnitHeaderInspectable]
	[InspectorTextArea]
	public string CustomMessage { get; set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", (Flow x) => Enter(x));
		exit = ControlOutput("exit");
		Succession(enter, exit);
	}

	private ControlOutput Enter(Flow x)
	{
		string message = string.Format("Todo{0}", string.IsNullOrEmpty(CustomMessage) ? "" : (" - " + CustomMessage));
		Debug.LogWarning(message);
		if (ErrorIfHit)
		{
			throw new NotImplementedException(message);
		}
		return exit;
	}
}
