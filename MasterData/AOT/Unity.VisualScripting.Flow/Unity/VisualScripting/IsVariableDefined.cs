using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Has Variable")]
public sealed class IsVariableDefined : UnifiedVariableUnit
{
	[DoNotSerialize]
	[PortKey("isDefined")]
	[PortLabel("Defined")]
	[PortLabelHidden]
	public ValueOutput isVariableDefined { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		isVariableDefined = ValueOutput("isDefined", IsDefined);
		Requirement(name, isVariableDefined);
		if (kind == VariableKind.Object)
		{
			Requirement(@object, isVariableDefined);
		}
	}

	private bool IsDefined(Flow flow)
	{
		string value = flow.GetValue<string>(name);
		return kind switch
		{
			VariableKind.Flow => flow.variables.IsDefined(value), 
			VariableKind.Graph => Variables.Graph(flow.stack).IsDefined(value), 
			VariableKind.Object => Variables.Object(flow.GetValue<GameObject>(@object)).IsDefined(value), 
			VariableKind.Scene => Variables.Scene(flow.stack.scene).IsDefined(value), 
			VariableKind.Application => Variables.Application.IsDefined(value), 
			VariableKind.Saved => Variables.Saved.IsDefined(value), 
			_ => throw new UnexpectedEnumValueException<VariableKind>(kind), 
		};
	}
}
