using System.Collections;

namespace Unity.VisualScripting;

[UnitShortTitle("Contains Item")]
[UnitCategory("Collections/Lists")]
[UnitSurtitle("List")]
[TypeIcon(typeof(IList))]
public sealed class ListContainsItem : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput list { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput item { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput contains { get; private set; }

	protected override void Definition()
	{
		list = ValueInput<IList>("list");
		item = ValueInput<object>("item");
		contains = ValueOutput("contains", Contains);
		Requirement(list, contains);
		Requirement(item, contains);
	}

	public bool Contains(Flow flow)
	{
		IList value = flow.GetValue<IList>(list);
		object value2 = flow.GetValue<object>(item);
		return value.Contains(value2);
	}
}
