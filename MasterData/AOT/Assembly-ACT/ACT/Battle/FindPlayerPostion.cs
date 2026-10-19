using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("（废弃节点）获取目标的坐标")]
public class FindPlayerPostion : Action
{
	public SharedVector3 targetPostion;

	public override TaskStatus OnUpdate()
	{
		targetPostion.Value = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		return TaskStatus.Success;
	}
}
