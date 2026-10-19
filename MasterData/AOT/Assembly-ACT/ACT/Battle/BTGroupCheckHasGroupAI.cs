using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskDescription("ACT/废弃节点/判断这个怪有没有组AI控制，有就返回True")]
public class BTGroupCheckHasGroupAI : Conditional
{
	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Success;
	}
}
