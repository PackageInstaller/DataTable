using System.Collections.Generic;

namespace Unity.VisualScripting.Community;

[TypeIcon(typeof(Flow))]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.ActionInvokeUnit")]
[UnitCategory("Community/Control/Delegates")]
public sealed class ActionInvokeNode : DelegateInvokeNode<IAction>
{
	protected override void Invoke(Flow flow, List<object> values)
	{
		flow.GetValue<IAction>(@delegate).Invoke(values.ToArray());
	}
}
