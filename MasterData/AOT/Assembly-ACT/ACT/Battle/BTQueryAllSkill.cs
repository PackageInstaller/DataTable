using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/CD")]
[TaskDescription("查询当帧哪些技能可以使用，必须要有仇恨目标,执行此节点才有意义")]
public class BTQueryAllSkill : Conditional
{
	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}
}
