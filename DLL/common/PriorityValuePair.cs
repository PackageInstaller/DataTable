public class PriorityValuePair<TValue>
{
	public double Priority { get; set; }

	public TValue Value { get; set; }

	public PriorityValuePair()
	{
		Priority = 0.0;
		Value = default(TValue);
	}

	public PriorityValuePair(double priority, TValue value)
	{
		Priority = priority;
		Value = value;
	}
}
