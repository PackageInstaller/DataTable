using System;
using System.Collections;

namespace Unity.VisualScripting;

[UnitShortTitle("Add Item")]
[UnitCategory("Collections/Lists")]
[UnitOrder(2)]
[UnitSurtitle("List")]
public sealed class AddListItem : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[PortLabel("List")]
	[DoNotSerialize]
	public ValueInput listInput { get; private set; }

	[PortLabelHidden]
	[PortLabel("List")]
	[DoNotSerialize]
	public ValueOutput listOutput { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput item { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Add);
		listInput = ValueInput<IList>("listInput");
		item = ValueInput<object>("item");
		listOutput = ValueOutput<IList>("listOutput");
		exit = ControlOutput("exit");
		Requirement(listInput, enter);
		Requirement(item, enter);
		Assignment(enter, listOutput);
		Succession(enter, exit);
	}

	public ControlOutput Add(Flow flow)
	{
		IList value = flow.GetValue<IList>(listInput);
		object value2 = flow.GetValue<object>(item);
		if (value is Array)
		{
			ArrayList arrayList = new ArrayList(value);
			arrayList.Add(value2);
			flow.SetValue(listOutput, arrayList.ToArray(value.GetType().GetElementType()));
		}
		else
		{
			value.Add(value2);
			flow.SetValue(listOutput, value);
		}
		return exit;
	}
}
