using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Lasm.UAlive.ConvertUnit")]
[RenamedFrom("Lasm.BoltExtensions.ConvertUnit")]
[TypeIcon(typeof(object))]
[UnitCategory("Community/Utility")]
[UnitTitle("Convert")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Utility.ConvertUnit")]
public sealed class ConvertNode : Unit
{
	[Inspectable]
	public ConversionType conversion;

	[Inspectable]
	public Type type = typeof(object);

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput value;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput result;

	protected override void Definition()
	{
		value = ValueInput<object>("value");
		ref ValueOutput reference = ref result;
		ConvertNode convertNode = this;
		Type type;
		if (conversion != ConversionType.Any)
		{
			type = ((conversion == ConversionType.ToArrayOfObject) ? typeof(object[]) : typeof(List<object>));
		}
		else
		{
			type = this.type;
		}
		reference = convertNode.ValueOutput(type, "result", (Flow flow) => conversion switch
		{
			ConversionType.Any => flow.GetValue<object>(value).ConvertTo(this.type), 
			ConversionType.ToArrayOfObject => flow.GetValue<IEnumerable>(value).Cast<object>().ToArray(), 
			ConversionType.ToListOfObject => flow.GetValue<IEnumerable>(value).Cast<object>().ToList(), 
			_ => null, 
		});
	}
}
