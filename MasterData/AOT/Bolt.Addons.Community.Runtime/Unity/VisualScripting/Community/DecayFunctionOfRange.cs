namespace Unity.VisualScripting.Community;

[UnitOrder(8)]
[UnitTitle("Decay Function of Range")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.DecayFunctionOfRange")]
[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.DecayFunctionOfRange")]
[UnitCategory("Community\\Math\\Functions")]
public class DecayFunctionOfRange : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	[PortLabel("MinimumRange")]
	public ValueInput minimumRange { get; private set; }

	[DoNotSerialize]
	[PortLabel("MaximumRange")]
	public ValueInput maximumRange { get; private set; }

	[PortLabel("MinimumValue")]
	[DoNotSerialize]
	public ValueInput minimumValue { get; private set; }

	[DoNotSerialize]
	[PortLabel("DecayFactor")]
	public ValueInput decayFactor { get; private set; }

	[PortLabel("Scale")]
	[DoNotSerialize]
	public ValueInput scale { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	protected float defaultMinimumRange => 0f;

	[DoNotSerialize]
	protected float defaultMaximumRange => 100f;

	[DoNotSerialize]
	protected float defaultMinimum => 0f;

	[DoNotSerialize]
	protected float defaultDecayFactor => 1f;

	[DoNotSerialize]
	protected float defaultScale => 1f;

	protected override void Definition()
	{
		input = ValueInput("input", 0f);
		minimumRange = ValueInput("minimumRange", defaultMinimumRange);
		maximumRange = ValueInput("maximumRange", defaultMaximumRange);
		minimumValue = ValueInput("minimumValue", defaultMinimum);
		decayFactor = ValueInput("decayFactor", defaultDecayFactor);
		scale = ValueInput("scale", defaultScale);
		output = ValueOutput("output", Operation);
		Requirement(minimumRange, output);
		Requirement(maximumRange, output);
		Requirement(input, output);
		Requirement(minimumValue, output);
		Requirement(decayFactor, output);
		Requirement(scale, output);
	}

	private float Operation(Flow flow)
	{
		return MathLibrary.DecayFunctionOfRange(flow.GetValue<float>(input), flow.GetValue<float>(minimumRange), flow.GetValue<float>(maximumRange), flow.GetValue<float>(maximumRange), flow.GetValue<float>(decayFactor), flow.GetValue<float>(scale));
	}
}
