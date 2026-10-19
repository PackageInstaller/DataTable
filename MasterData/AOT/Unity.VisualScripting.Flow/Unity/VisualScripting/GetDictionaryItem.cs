using System.Collections;

namespace Unity.VisualScripting;

[UnitCategory("Collections/Dictionaries")]
[UnitOrder(0)]
[TypeIcon(typeof(IDictionary))]
[UnitShortTitle("Get Item")]
[UnitSurtitle("Dictionary")]
public sealed class GetDictionaryItem : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput dictionary { get; private set; }

	[DoNotSerialize]
	public ValueInput key { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput value { get; private set; }

	protected override void Definition()
	{
		dictionary = ValueInput<IDictionary>("dictionary");
		key = ValueInput<object>("key");
		value = ValueOutput("value", Get);
		Requirement(dictionary, value);
		Requirement(key, value);
	}

	private object Get(Flow flow)
	{
		IDictionary dictionary = flow.GetValue<IDictionary>(this.dictionary);
		object obj = flow.GetValue<object>(key);
		return dictionary[obj];
	}
}
