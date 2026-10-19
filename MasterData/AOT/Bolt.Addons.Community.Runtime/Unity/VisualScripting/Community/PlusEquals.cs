namespace Unity.VisualScripting.Community;

[UnitShortTitle("Plus Equals")]
[UnitTitle("Plus Equals")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.PlusEquals")]
[UnitCategory("Variables")]
[RenamedFrom("Bolt.Addons.Community.Variables.Units.PlusEquals")]
public sealed class PlusEquals : VariableAdder
{
	[DoNotSerialize]
	[PortLabel("amount")]
	public ValueInput amount { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput postIncrement { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		amount = ValueInput("amount", 1f);
		postIncrement = ValueOutput("postIncrement", (Flow x) => _postIncrementValue);
		Requirement(amount, assign);
		Requirement(amount, postIncrement);
	}

	protected override float GetAmount(Flow flow)
	{
		return flow.GetValue<float>(amount);
	}
}
