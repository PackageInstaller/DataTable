using System;
using System.Collections;

namespace Unity.VisualScripting;

[UnitCategory("Collections/Lists")]
[UnitOrder(5)]
[TypeIcon(typeof(RemoveListItem))]
[UnitSurtitle("List")]
[UnitShortTitle("Remove Item At Index")]
public sealed class RemoveListItemAt : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput listInput { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput listOutput { get; private set; }

	[DoNotSerialize]
	public ValueInput index { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", RemoveAt);
		listInput = ValueInput<IList>("listInput");
		listOutput = ValueOutput<IList>("listOutput");
		index = ValueInput("index", 0);
		exit = ControlOutput("exit");
		Requirement(listInput, enter);
		Requirement(index, enter);
		Assignment(enter, listOutput);
		Succession(enter, exit);
	}

	public ControlOutput RemoveAt(Flow flow)
	{
		IList value = flow.GetValue<IList>(listInput);
		int value2 = flow.GetValue<int>(index);
		if (value is Array)
		{
			ArrayList arrayList = new ArrayList(value);
			arrayList.RemoveAt(value2);
			flow.SetValue(listOutput, arrayList.ToArray(value.GetType().GetElementType()));
		}
		else
		{
			value.RemoveAt(value2);
			flow.SetValue(listOutput, value);
		}
		return exit;
	}
}
