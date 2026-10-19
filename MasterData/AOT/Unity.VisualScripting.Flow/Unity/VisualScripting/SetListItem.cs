using System.Collections;

namespace Unity.VisualScripting;

[UnitCategory("Collections/Lists")]
[UnitShortTitle("Set Item")]
[UnitOrder(1)]
[TypeIcon(typeof(IList))]
[UnitSurtitle("List")]
public sealed class SetListItem : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput list { get; private set; }

	[DoNotSerialize]
	public ValueInput index { get; private set; }

	[DoNotSerialize]
	public ValueInput item { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Set);
		list = ValueInput<IList>("list");
		index = ValueInput("index", 0);
		item = ValueInput<object>("item");
		exit = ControlOutput("exit");
		Requirement(list, enter);
		Requirement(index, enter);
		Requirement(item, enter);
		Succession(enter, exit);
	}

	public ControlOutput Set(Flow flow)
	{
		IList value = flow.GetValue<IList>(list);
		int value2 = flow.GetValue<int>(index);
		object value3 = flow.GetValue<object>(item);
		value[value2] = value3;
		return exit;
	}
}
