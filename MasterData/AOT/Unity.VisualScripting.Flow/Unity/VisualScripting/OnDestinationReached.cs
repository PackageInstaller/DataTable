using UnityEngine.AI;

namespace Unity.VisualScripting;

[UnitCategory("Events/Navigation")]
public sealed class OnDestinationReached : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "Update";

	[DoNotSerialize]
	public ValueInput threshold { get; private set; }

	[DoNotSerialize]
	public ValueInput requireSuccess { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		threshold = ValueInput("threshold", 0.05f);
		requireSuccess = ValueInput("requireSuccess", @default: true);
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		NavMeshAgent component = flow.stack.gameObject.GetComponent<NavMeshAgent>();
		if (component != null && component.remainingDistance <= flow.GetValue<float>(threshold))
		{
			if (component.pathStatus != NavMeshPathStatus.PathComplete)
			{
				return !flow.GetValue<bool>(requireSuccess);
			}
			return true;
		}
		return false;
	}
}
