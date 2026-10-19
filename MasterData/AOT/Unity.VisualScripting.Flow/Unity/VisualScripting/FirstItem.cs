using System.Collections;
using System.Linq;

namespace Unity.VisualScripting;

[UnitCategory("Collections")]
public sealed class FirstItem : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput collection { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput firstItem { get; private set; }

	protected override void Definition()
	{
		collection = ValueInput<IEnumerable>("collection");
		firstItem = ValueOutput("firstItem", First);
		Requirement(collection, firstItem);
	}

	public object First(Flow flow)
	{
		IEnumerable value = flow.GetValue<IEnumerable>(collection);
		if (value is IList)
		{
			return ((IList)value)[0];
		}
		return value.Cast<object>().First();
	}
}
