using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/SharedVariable")]
[TaskDescription("Returns success if the variable value is equal to the compareTo value.")]
public class CompareSharedEntity : Conditional
{
	[Tooltip("The first variable to compare")]
	public SharedEntity variable;

	[Tooltip("The variable to compare to")]
	public SharedEntity compareTo;

	public override TaskStatus OnUpdate()
	{
		if (!variable.Value.Equals(compareTo.Value))
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}

	public override void OnReset()
	{
		variable = null;
		compareTo = null;
	}
}
