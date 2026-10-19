using System;

namespace Unity.VisualScripting.Community;

[UnitCategory("Community/Utility")]
[UnitTitle("As")]
public class AsUnit : Unit
{
	[Inspectable]
	[InspectorLabel("Type")]
	[InspectorWide(true)]
	[UnitHeaderInspectable("Type")]
	public Type AsType = typeof(float);

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput Value;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput Result;

	public override bool canDefine => AsType != null;

	protected override void Definition()
	{
		Value = ValueInput<object>("Value");
		Result = ValueOutput(AsType, "Result", (Flow flow) => flow.GetValue(Value).ConvertTo(AsType));
	}
}
