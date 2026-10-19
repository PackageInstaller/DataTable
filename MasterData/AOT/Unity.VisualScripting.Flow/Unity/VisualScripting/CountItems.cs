using System.Collections;
using System.Linq;

namespace Unity.VisualScripting;

[UnitCategory("Collections")]
public sealed class CountItems : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput collection { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput count { get; private set; }

	protected override void Definition()
	{
		collection = ValueInput<IEnumerable>("collection");
		count = ValueOutput("count", Count);
		Requirement(collection, count);
	}

	public int Count(Flow flow)
	{
		IEnumerable value = flow.GetValue<IEnumerable>(collection);
		if (value is ICollection)
		{
			return ((ICollection)value).Count;
		}
		return value.Cast<object>().Count();
	}
}
