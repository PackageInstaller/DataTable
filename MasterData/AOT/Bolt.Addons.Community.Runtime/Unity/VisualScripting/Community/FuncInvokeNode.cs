using System.Collections.Generic;

namespace Unity.VisualScripting.Community;

[UnitCategory("Community/Control/Delegates")]
[TypeIcon(typeof(Flow))]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.FuncInvokeUnit")]
public sealed class FuncInvokeNode : DelegateInvokeNode<IFunc>
{
	[DoNotSerialize]
	public ValueOutput @return;

	protected override bool isPure => true;

	protected override void Definition()
	{
		base.Definition();
		if (_delegate == null)
		{
			return;
		}
		@return = ValueOutput(_delegate.ReturnType, "return", (Flow flow) =>
		{
			List<object> list = new List<object>();
			flow.GetValue<IFunc>(@delegate);
			for (int i = 0; i < parameters.Count; i++)
			{
				list.Add(flow.GetValue(parameters[i]));
			}
			return flow.GetValue<IFunc>(@delegate).DynamicInvoke(list.ToArray());
		});
	}

	protected override void Invoke(Flow flow, List<object> values)
	{
		flow.GetValue<IFunc>(@delegate).DynamicInvoke(values.ToArray());
	}
}
