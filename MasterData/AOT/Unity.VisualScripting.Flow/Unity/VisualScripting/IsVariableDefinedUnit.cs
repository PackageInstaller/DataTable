namespace Unity.VisualScripting;

[UnitShortTitle("Is Variable Defined")]
public abstract class IsVariableDefinedUnit : VariableUnit
{
	[DoNotSerialize]
	[PortLabel("Defined")]
	[PortLabelHidden]
	public new ValueOutput isDefined { get; private set; }

	protected IsVariableDefinedUnit()
	{
	}

	protected IsVariableDefinedUnit(string defaultName)
		: base(defaultName)
	{
	}

	protected override void Definition()
	{
		base.Definition();
		isDefined = ValueOutput("isDefined", IsDefined);
		Requirement(name, isDefined);
	}

	protected virtual bool IsDefined(Flow flow)
	{
		string value = flow.GetValue<string>(name);
		return GetDeclarations(flow).IsDefined(value);
	}
}
