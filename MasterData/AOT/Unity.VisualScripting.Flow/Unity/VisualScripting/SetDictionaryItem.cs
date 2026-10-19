using System.Collections;

namespace Unity.VisualScripting;

[UnitShortTitle("Set Item")]
[UnitCategory("Collections/Dictionaries")]
[TypeIcon(typeof(IDictionary))]
[UnitOrder(1)]
[UnitSurtitle("Dictionary")]
public sealed class SetDictionaryItem : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput dictionary { get; private set; }

	[DoNotSerialize]
	public ValueInput key { get; private set; }

	[DoNotSerialize]
	public ValueInput value { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Set);
		dictionary = ValueInput<IDictionary>("dictionary");
		key = ValueInput<object>("key");
		value = ValueInput<object>("value");
		exit = ControlOutput("exit");
		Requirement(dictionary, enter);
		Requirement(key, enter);
		Requirement(value, enter);
		Succession(enter, exit);
	}

	public ControlOutput Set(Flow flow)
	{
		IDictionary dictionary = flow.GetValue<IDictionary>(this.dictionary);
		object obj = flow.GetValue<object>(key);
		object obj2 = flow.GetValue<object>(value);
		dictionary[obj] = obj2;
		return exit;
	}
}
