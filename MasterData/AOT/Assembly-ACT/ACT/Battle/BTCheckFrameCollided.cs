using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/应该要废弃的")]
[TaskDescription("判断此帧是否碰撞到环境")]
public class BTCheckFrameCollided : Conditional
{
	public override TaskStatus OnUpdate()
	{
		if (!((ActBehaviorTree)Owner).Entity.GetCompPhysics().FrameCollided)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
