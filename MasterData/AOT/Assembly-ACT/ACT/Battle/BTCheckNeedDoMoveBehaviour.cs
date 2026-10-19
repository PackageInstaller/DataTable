using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("单位需不需要执行移动")]
public class BTCheckNeedDoMoveBehaviour : Conditional
{
	public SharedAIBehaviourList allBehaviourList;

	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		CompAI compAI = entity.GetCompAI();
		if (!compAI.CanStartCombatMove("BTCheckNeedDoMoveBehaviour"))
		{
			return TaskStatus.Failure;
		}
		if (entity.GetCompPhysics().state == ACTMovementMode.BeCarryed)
		{
			return TaskStatus.Failure;
		}
		bool flag = allBehaviourList?.Value != null && allBehaviourList.Value.Count > 0;
		if (compAI.HasAttackToken() && flag)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
