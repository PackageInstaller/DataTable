namespace Unity.VisualScripting;

[UnitShortTitle("Set Variable")]
public abstract class SetVariableUnit : VariableUnit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput assign { get; set; }

	[PortLabelHidden]
	[PortLabel("New Value")]
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput assigned { get; set; }

	[PortLabelHidden]
	[PortLabel("Value")]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected SetVariableUnit()
	{
	}

	protected SetVariableUnit(string defaultName)
		: base(defaultName)
	{
	}

	protected override void Definition()
	{
		base.Definition();
		assign = ControlInput("assign", Assign);
		input = ValueInput<object>("input");
		output = ValueOutput<object>("output");
		assigned = ControlOutput("assigned");
		Requirement(input, assign);
		Requirement(name, assign);
		Assignment(assign, output);
		Succession(assign, assigned);
	}

	protected virtual ControlOutput Assign(Flow flow)
	{
		object value = flow.GetValue<object>(input);
		string value2 = flow.GetValue<string>(name);
		GetDeclarations(flow).Set(value2, value);
		flow.SetValue(output, value);
		return assigned;
	}
}
