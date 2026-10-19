using System.Collections;

namespace Unity.VisualScripting;

[UnitOrder(5)]
[UnitCategory("Collections/Dictionaries")]
public sealed class MergeDictionaries : MultiInputUnit<IDictionary>
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput dictionary { get; private set; }

	protected override void Definition()
	{
		dictionary = ValueOutput("dictionary", Merge);
		base.Definition();
		foreach (ValueInput multiInput in multiInputs)
		{
			Requirement(multiInput, dictionary);
		}
	}

	public IDictionary Merge(Flow flow)
	{
		AotDictionary aotDictionary = new AotDictionary();
		for (int i = 0; i < inputCount; i++)
		{
			IDictionaryEnumerator enumerator = flow.GetValue<IDictionary>(multiInputs[i]).GetEnumerator();
			while (enumerator.MoveNext())
			{
				if (!aotDictionary.Contains(enumerator.Key))
				{
					aotDictionary.Add(enumerator.Key, enumerator.Value);
				}
			}
		}
		return aotDictionary;
	}
}
