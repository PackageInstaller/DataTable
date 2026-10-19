using System.Collections;

namespace Unity.VisualScripting;

[UnitOrder(-1)]
[UnitCategory("Collections/Dictionaries")]
[RenamedFrom("Bolt.CreateDitionary")]
[TypeIcon(typeof(IDictionary))]
public sealed class CreateDictionary : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput dictionary { get; private set; }

	protected override void Definition()
	{
		dictionary = ValueOutput("dictionary", Create);
	}

	public IDictionary Create(Flow flow)
	{
		return new AotDictionary();
	}
}
