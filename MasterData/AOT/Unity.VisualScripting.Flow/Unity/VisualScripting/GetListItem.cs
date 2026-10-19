using System.Collections;

namespace Unity.VisualScripting;

[TypeIcon(typeof(IList))]
[UnitOrder(0)]
[UnitSurtitle("List")]
[UnitCategory("Collections/Lists")]
[UnitShortTitle("Get Item")]
public sealed class GetListItem : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput list { get; private set; }

	[DoNotSerialize]
	public ValueInput index { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput item { get; private set; }

	protected override void Definition()
	{
		list = ValueInput<IList>("list");
		index = ValueInput("index", 0);
		item = ValueOutput("item", Get);
		Requirement(list, item);
		Requirement(index, item);
	}

	public object Get(Flow flow)
	{
		IList value = flow.GetValue<IList>(list);
		int value2 = flow.GetValue<int>(index);
		return value[value2];
	}
}
