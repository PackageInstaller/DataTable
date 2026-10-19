using System.Collections;

namespace Unity.VisualScripting;

[UnitCategory("Collections/Dictionaries")]
[UnitSurtitle("Dictionary")]
[UnitShortTitle("Remove Item")]
[UnitOrder(3)]
public sealed class RemoveDictionaryItem : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[PortLabel("Dictionary")]
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput dictionaryInput { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	[PortLabel("Dictionary")]
	public ValueOutput dictionaryOutput { get; private set; }

	[DoNotSerialize]
	public ValueInput key { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Remove);
		dictionaryInput = ValueInput<IDictionary>("dictionaryInput");
		dictionaryOutput = ValueOutput<IDictionary>("dictionaryOutput");
		key = ValueInput<object>("key");
		exit = ControlOutput("exit");
		Requirement(dictionaryInput, enter);
		Requirement(key, enter);
		Assignment(enter, dictionaryOutput);
		Succession(enter, exit);
	}

	public ControlOutput Remove(Flow flow)
	{
		IDictionary value = flow.GetValue<IDictionary>(dictionaryInput);
		object value2 = flow.GetValue<object>(key);
		flow.SetValue(dictionaryOutput, value);
		value.Remove(value2);
		return exit;
	}
}
