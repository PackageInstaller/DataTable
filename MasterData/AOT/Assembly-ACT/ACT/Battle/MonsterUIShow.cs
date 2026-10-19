using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class MonsterUIShow : Action
{
	public SharedBool useWrapRotation;

	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}
}
