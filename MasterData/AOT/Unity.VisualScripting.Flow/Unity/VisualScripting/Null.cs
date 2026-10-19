namespace Unity.VisualScripting;

[UnitCategory("Nulls")]
public sealed class Null : Unit
{
	[DoNotSerialize]
	public ValueOutput @null { get; private set; }

	protected override void Definition()
	{
		@null = ValueOutput("null", (Flow recursion) => (object)null).Predictable();
	}
}
