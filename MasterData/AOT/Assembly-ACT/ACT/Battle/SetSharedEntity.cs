using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/SharedVariable")]
[TaskDescription("Sets the SharedEntity variable to the specified object. Returns Success.")]
public class SetSharedEntity : Action
{
	[Tooltip("The value to set the SharedEntity to")]
	public SharedEntity targetValue;

	[RequiredField]
	[Tooltip("The SharedEntity to set")]
	public SharedEntity targetVariable;

	public override TaskStatus OnUpdate()
	{
		targetVariable.Value = targetValue.Value;
		return TaskStatus.Success;
	}

	public override void OnReset()
	{
		targetValue = null;
		targetVariable = null;
	}
}
