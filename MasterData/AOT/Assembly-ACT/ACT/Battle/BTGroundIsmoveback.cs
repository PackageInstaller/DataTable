using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("是不是后退动画的移动")]
public class BTGroundIsmoveback : Conditional
{
	public override TaskStatus OnUpdate()
	{
		CompMotion compMotion = Owner.ToEntity().GetCompMotion();
		if (compMotion.layer0PeakConfig.name.ToLower().Contains("move") && compMotion.layer0PeakConfig.name.ToLower().Contains("back"))
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
