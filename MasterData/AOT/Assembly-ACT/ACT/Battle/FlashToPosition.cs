using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("辅助机瞬间移动到某个位置,成功返回suceess")]
public class FlashToPosition : Action
{
	public SharedVector3 targetPos;

	private Entity robot;

	public override void OnAwake()
	{
		robot = ((ActBehaviorTree)Owner).Entity;
	}

	public override void OnStart()
	{
	}

	public override void OnEnd()
	{
	}

	public override TaskStatus OnUpdate()
	{
		robot.Teleport(targetPos.Value);
		return TaskStatus.Success;
	}
}
