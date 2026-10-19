namespace Unity.VisualScripting;

[UnitOrder(105)]
public abstract class Modulo<T> : Unit
{
	[PortLabel("A")]
	[DoNotSerialize]
	public ValueInput dividend { get; private set; }

	[PortLabel("B")]
	[DoNotSerialize]
	public ValueInput divisor { get; private set; }

	[DoNotSerialize]
	[PortLabel("A % B")]
	public ValueOutput remainder { get; private set; }

	[DoNotSerialize]
	protected virtual T defaultDivisor => default;

	[DoNotSerialize]
	protected virtual T defaultDividend => default;

	protected override void Definition()
	{
		dividend = ValueInput("dividend", defaultDividend);
		divisor = ValueInput("divisor", defaultDivisor);
		remainder = ValueOutput("remainder", Operation).Predictable();
		Requirement(dividend, remainder);
		Requirement(divisor, remainder);
	}

	public abstract T Operation(T divident, T divisor);

	public T Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(dividend), flow.GetValue<T>(divisor));
	}
}
