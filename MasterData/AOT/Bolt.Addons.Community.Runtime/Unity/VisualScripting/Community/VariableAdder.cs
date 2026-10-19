using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.VariableAdder")]
public abstract class VariableAdder : UnifiedVariableUnit
{
	protected float _preIncrementValue;

	protected float _postIncrementValue;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput assign { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput assigned { get; private set; }

	[DoNotSerialize]
	public ValueInput fallback { get; private set; }

	[InspectorLabel("Fallback")]
	[Serialize]
	[Inspectable]
	public bool specifyFallback { get; set; }

	protected abstract float GetAmount(Flow flow);

	protected override void Definition()
	{
		base.Definition();
		assign = ControlInput("assign", UpdateVariable);
		assigned = ControlOutput("assigned");
		Requirement(name, assign);
		Succession(assign, assigned);
		if (kind == VariableKind.Object)
		{
			Requirement(@object, assign);
		}
		if (specifyFallback)
		{
			fallback = ValueInput("fallback", 0f);
			Requirement(fallback, assign);
		}
	}

	private ControlOutput UpdateVariable(Flow flow)
	{
		string value = flow.GetValue<string>(name);
		VariableDeclarations variableDeclarations = kind switch
		{
			VariableKind.Flow => flow.variables, 
			VariableKind.Graph => Variables.Graph(flow.stack), 
			VariableKind.Object => Variables.Object(flow.GetValue<GameObject>(@object)), 
			VariableKind.Scene => Variables.Scene(flow.stack.scene), 
			VariableKind.Application => Variables.Application, 
			VariableKind.Saved => Variables.Saved, 
			_ => throw new UnexpectedEnumValueException<VariableKind>(kind), 
		};
		if (!variableDeclarations.IsDefined(value) && specifyFallback)
		{
			_preIncrementValue = flow.GetValue<float>(fallback);
		}
		else
		{
			_preIncrementValue = variableDeclarations.Get<float>(value);
		}
		_postIncrementValue = _preIncrementValue + GetAmount(flow);
		variableDeclarations.Set(value, _postIncrementValue);
		return assigned;
	}
}
