using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

[UnitOrder(303)]
[TypeIcon(typeof(Add<>))]
public abstract class Sum<T> : MultiInputUnit<T>
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput sum { get; private set; }

	protected override void Definition()
	{
		if (this is IDefaultValue<T> defaultValue)
		{
			List<ValueInput> list = new List<ValueInput>();
			multiInputs = list.AsReadOnly();
			for (int i = 0; i < inputCount; i++)
			{
				if (i == 0)
				{
					list.Add(ValueInput<T>(i.ToString()));
				}
				else
				{
					list.Add(ValueInput(i.ToString(), defaultValue.defaultValue));
				}
			}
		}
		else
		{
			base.Definition();
		}
		sum = ValueOutput("sum", Operation).Predictable();
		foreach (ValueInput multiInput in multiInputs)
		{
			Requirement(multiInput, sum);
		}
	}

	public abstract T Operation(T a, T b);

	public abstract T Operation(IEnumerable<T> values);

	public T Operation(Flow flow)
	{
		if (inputCount == 2)
		{
			return Operation(flow.GetValue<T>(multiInputs[0]), flow.GetValue<T>(multiInputs[1]));
		}
		return Operation(multiInputs.Select(flow.GetValue<T>));
	}
}
