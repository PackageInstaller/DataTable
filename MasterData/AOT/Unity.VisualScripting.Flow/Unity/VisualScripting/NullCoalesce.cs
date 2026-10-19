using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Nulls")]
[TypeIcon(typeof(Null))]
public sealed class NullCoalesce : Unit
{
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	public ValueInput fallback { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput result { get; private set; }

	protected override void Definition()
	{
		input = ValueInput<object>("input").AllowsNull();
		fallback = ValueInput<object>("fallback");
		result = ValueOutput("result", Coalesce).Predictable();
		Requirement(input, result);
		Requirement(fallback, result);
	}

	public object Coalesce(Flow flow)
	{
		object value = flow.GetValue(input);
		if (!((!(value is Object)) ? (value == null) : ((Object)value == null)))
		{
			return value;
		}
		return flow.GetValue(fallback);
	}
}
