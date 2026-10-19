namespace Unity.VisualScripting.Community;

[UnitTitle("Increment")]
[UnitCategory("Variables")]
[UnitShortTitle("Increment Variable")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.IncrementUnit")]
[RenamedFrom("Bolt.Addons.Community.Variables.Units.IncrementUnit")]
public class IncrementNode : VariableAdder
{
	[PortLabel("pre")]
	[DoNotSerialize]
	public ValueOutput preIncrement { get; private set; }

	[PortLabel("post")]
	[DoNotSerialize]
	public ValueOutput postIncrement { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		preIncrement = ValueOutput("preIncrement", (Flow x) => _preIncrementValue);
		postIncrement = ValueOutput("postIncrement", (Flow x) => _postIncrementValue);
		if (specifyFallback)
		{
			Requirement(fallback, preIncrement);
			Requirement(fallback, postIncrement);
		}
	}

	protected override float GetAmount(Flow flow)
	{
		return 1f;
	}
}
