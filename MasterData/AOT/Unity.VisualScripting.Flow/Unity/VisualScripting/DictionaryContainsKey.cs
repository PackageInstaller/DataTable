using System.Collections;

namespace Unity.VisualScripting;

[UnitSurtitle("Dictionary")]
[TypeIcon(typeof(IDictionary))]
[UnitShortTitle("Contains Key")]
[UnitCategory("Collections/Dictionaries")]
public sealed class DictionaryContainsKey : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput dictionary { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput key { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput contains { get; private set; }

	protected override void Definition()
	{
		dictionary = ValueInput<IDictionary>("dictionary");
		key = ValueInput<object>("key");
		contains = ValueOutput("contains", Contains);
		Requirement(dictionary, contains);
		Requirement(key, contains);
	}

	private bool Contains(Flow flow)
	{
		IDictionary value = flow.GetValue<IDictionary>(dictionary);
		object value2 = flow.GetValue<object>(key);
		return value.Contains(value2);
	}
}
