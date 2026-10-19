using System;
using System.Collections;

namespace Unity.VisualScripting;

[UnitCategory("Collections/Lists")]
[UnitSurtitle("List")]
[UnitShortTitle("Clear")]
[UnitOrder(6)]
[TypeIcon(typeof(RemoveListItem))]
public sealed class ClearList : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	[PortLabel("List")]
	public ValueInput listInput { get; private set; }

	[DoNotSerialize]
	[PortLabel("List")]
	[PortLabelHidden]
	public ValueOutput listOutput { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Clear);
		listInput = ValueInput<IList>("listInput");
		listOutput = ValueOutput<IList>("listOutput");
		exit = ControlOutput("exit");
		Requirement(listInput, enter);
		Assignment(enter, listOutput);
		Succession(enter, exit);
	}

	public ControlOutput Clear(Flow flow)
	{
		IList value = flow.GetValue<IList>(listInput);
		if (value is Array)
		{
			flow.SetValue(listOutput, Array.CreateInstance(value.GetType().GetElementType(), 0));
		}
		else
		{
			value.Clear();
			flow.SetValue(listOutput, value);
		}
		return exit;
	}
}
