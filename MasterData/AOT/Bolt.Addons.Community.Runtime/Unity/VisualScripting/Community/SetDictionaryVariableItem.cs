using System;
using System.Collections;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.SetDictionaryVariableItem")]
[UnitTitle("Set Dictionary Variable")]
public sealed class SetDictionaryVariableItem : DictionaryVariableItem
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput assign { get; set; }

	[DoNotSerialize]
	[PortLabel("New Value")]
	[PortLabelHidden]
	public ValueInput newValue { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput assigned { get; set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		assign = ControlInput("assign", Assign);
		newValue = ValueInput<object>("newValue");
		assigned = ControlOutput("assigned");
		output = ValueOutput<object>("output");
		Requirement(name, assign);
		Requirement(key, assign);
		Requirement(newValue, assign);
		Assignment(assign, output);
		Succession(assign, assigned);
	}

	private ControlOutput Assign(Flow flow)
	{
		object value = flow.GetValue<object>(key);
		object value2 = flow.GetValue<object>(newValue);
		string value3 = flow.GetValue<string>(name);
		(((GetDeclarations(flow).Get(value3) ?? throw new ArgumentException("Indicated variable does not exist.")) as IDictionary) ?? throw new ArgumentException("Indicated variable is not a dictionary."))[value] = value2;
		flow.SetValue(output, value2);
		return assigned;
	}
}
