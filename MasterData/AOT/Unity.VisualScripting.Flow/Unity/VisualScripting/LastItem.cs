using System.Collections;
using System.Linq;

namespace Unity.VisualScripting;

[UnitCategory("Collections")]
public sealed class LastItem : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput collection { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput lastItem { get; private set; }

	protected override void Definition()
	{
		collection = ValueInput<IEnumerable>("collection");
		lastItem = ValueOutput("lastItem", First);
		Requirement(collection, lastItem);
	}

	public object First(Flow flow)
	{
		IEnumerable value = flow.GetValue<IEnumerable>(collection);
		if (value is IList)
		{
			IList list = (IList)value;
			return list[list.Count - 1];
		}
		return value.Cast<object>().Last();
	}
}
