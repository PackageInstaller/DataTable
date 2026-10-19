using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/血条")]
public class MonsterUIHide : Action
{
	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}
}
