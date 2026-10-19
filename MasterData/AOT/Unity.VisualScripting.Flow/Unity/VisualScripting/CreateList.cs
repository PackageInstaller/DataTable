using System.Collections;

namespace Unity.VisualScripting;

[UnitCategory("Collections/Lists")]
[UnitOrder(-1)]
[TypeIcon(typeof(IList))]
public sealed class CreateList : MultiInputUnit<object>
{
	[DoNotSerialize]
	protected override int minInputCount => 0;

	[Inspectable]
	[UnitHeaderInspectable("Elements")]
	[InspectorLabel("Elements")]
	public override int inputCount
	{
		get
		{
			return base.inputCount;
		}
		set
		{
			base.inputCount = value;
		}
	}

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput list { get; private set; }

	protected override void Definition()
	{
		list = ValueOutput("list", Create);
		base.Definition();
		foreach (ValueInput multiInput in multiInputs)
		{
			Requirement(multiInput, list);
		}
		InputsAllowNull();
	}

	public IList Create(Flow flow)
	{
		AotList aotList = new AotList();
		for (int i = 0; i < inputCount; i++)
		{
			aotList.Add(flow.GetValue<object>(multiInputs[i]));
		}
		return aotList;
	}
}
