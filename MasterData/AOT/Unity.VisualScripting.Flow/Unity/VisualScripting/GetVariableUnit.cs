namespace Unity.VisualScripting;

[UnitShortTitle("Get Variable")]
public abstract class GetVariableUnit : VariableUnit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput value { get; private set; }

	protected GetVariableUnit()
	{
	}

	protected GetVariableUnit(string defaultName)
		: base(defaultName)
	{
	}

	protected override void Definition()
	{
		base.Definition();
		value = ValueOutput("value", Get).PredictableIf(IsDefined);
		Requirement(name, value);
	}

	protected virtual bool IsDefined(Flow flow)
	{
		string variable = flow.GetValue<string>(name);
		return GetDeclarations(flow)?.IsDefined(variable) ?? false;
	}

	protected virtual object Get(Flow flow)
	{
		string variable = flow.GetValue<string>(name);
		return GetDeclarations(flow).Get(variable);
	}
}
