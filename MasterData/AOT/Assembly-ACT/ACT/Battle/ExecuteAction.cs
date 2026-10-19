using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("执行行为节点(UseSkill)")]
public class ExecuteAction : Action
{
	public SharedString actionName;

	public override void OnStart()
	{
		base.OnStart();
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		if (entity.IsValid && !string.IsNullOrEmpty(actionName.Value))
		{
			CompMotion? compMotion = entity.GetCompMotion();
			compMotion.SetBool(actionName.Value, b: true);
			compMotion.SetTrigger("UseSkill");
		}
	}

	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		if (string.IsNullOrEmpty(actionName.Value))
		{
			return TaskStatus.Success;
		}
		if (entity.GetCompMotion().curMotionState != MotionState.Attack)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Running;
	}
}
