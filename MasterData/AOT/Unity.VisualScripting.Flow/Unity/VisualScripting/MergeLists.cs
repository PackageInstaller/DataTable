using System.Collections;

namespace Unity.VisualScripting;

[UnitOrder(7)]
[UnitCategory("Collections/Lists")]
public sealed class MergeLists : MultiInputUnit<IEnumerable>
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput list { get; private set; }

	protected override void Definition()
	{
		list = ValueOutput("list", Merge);
		base.Definition();
		foreach (ValueInput multiInput in multiInputs)
		{
			Requirement(multiInput, list);
		}
	}

	public IList Merge(Flow flow)
	{
		AotList result = new AotList();
		for (int i = 0; i < inputCount; i++)
		{
			result.AddRange(flow.GetValue<IEnumerable>(multiInputs[i]));
		}
		return result;
	}
}
