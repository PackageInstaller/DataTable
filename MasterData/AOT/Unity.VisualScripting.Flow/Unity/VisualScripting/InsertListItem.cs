using System;
using System.Collections;

namespace Unity.VisualScripting;

[UnitOrder(3)]
[TypeIcon(typeof(AddListItem))]
[UnitShortTitle("Insert Item")]
[UnitCategory("Collections/Lists")]
[UnitSurtitle("List")]
public sealed class InsertListItem : Unit
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
	public ValueInput index { get; private set; }

	[DoNotSerialize]
	public ValueInput item { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Insert);
		listInput = ValueInput<IList>("listInput");
		item = ValueInput<object>("item");
		index = ValueInput("index", 0);
		listOutput = ValueOutput<IList>("listOutput");
		exit = ControlOutput("exit");
		Requirement(listInput, enter);
		Requirement(item, enter);
		Requirement(index, enter);
		Assignment(enter, listOutput);
		Succession(enter, exit);
	}

	public ControlOutput Insert(Flow flow)
	{
		IList value = flow.GetValue<IList>(listInput);
		int value2 = flow.GetValue<int>(index);
		object value3 = flow.GetValue<object>(item);
		if (value is Array)
		{
			ArrayList arrayList = new ArrayList(value);
			arrayList.Insert(value2, value3);
			flow.SetValue(listOutput, arrayList.ToArray(value.GetType().GetElementType()));
		}
		else
		{
			value.Insert(value2, value3);
			flow.SetValue(listOutput, value);
		}
		return exit;
	}
}
