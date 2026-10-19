using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("输出当前位置")]
public class GetCurrentPostion : Action
{
	public static GetCurrentPostion instance;

	public SharedVector3 spawnPoint;

	public override void OnStart()
	{
		instance = this;
		spawnPoint.Value = ((ActBehaviorTree)Owner).Entity.GetCompAI().pos;
	}

	public override TaskStatus OnUpdate()
	{
		spawnPoint.Value = ((ActBehaviorTree)Owner).Entity.GetCompAI().pos;
		_ = spawnPoint.Value;
		return TaskStatus.Success;
	}
}
