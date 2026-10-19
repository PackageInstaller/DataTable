using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class HateLastAttacker : Action
{
	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		Entity lastAttacker = entity.GetCompHatred().lastAttacker;
		if (lastAttacker.IsValid)
		{
			Entity entity2 = GameManager.entities.GetEntity(lastAttacker.Id);
			if (entity2.IsValid && entity2.IsAlive())
			{
				entity.SetHatred(entity2);
			}
		}
		return TaskStatus.Success;
	}
}
