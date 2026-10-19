using System.Collections;

namespace Unity.VisualScripting;

[TypeIcon(typeof(RemoveDictionaryItem))]
[UnitOrder(4)]
[UnitSurtitle("Dictionary")]
[UnitCategory("Collections/Dictionaries")]
[UnitShortTitle("Clear")]
public sealed class ClearDictionary : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[PortLabel("Dictionary")]
	[PortLabelHidden]
	public ValueInput dictionaryInput { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	[PortLabel("Dictionary")]
	public ValueOutput dictionaryOutput { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Clear);
		dictionaryInput = ValueInput<IDictionary>("dictionaryInput");
		dictionaryOutput = ValueOutput<IDictionary>("dictionaryOutput");
		exit = ControlOutput("exit");
		Requirement(dictionaryInput, enter);
		Assignment(enter, dictionaryOutput);
		Succession(enter, exit);
	}

	private ControlOutput Clear(Flow flow)
	{
		IDictionary value = flow.GetValue<IDictionary>(dictionaryInput);
		flow.SetValue(dictionaryOutput, value);
		value.Clear();
		return exit;
	}
}
