using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
public class CheckChildrenMonsterAttackType : Conditional
{
	public MonsterAttackType monsterAttackType;

	[SharedRequired]
	public SharedEntity res;

	public override TaskStatus OnUpdate()
	{
		if (res.Value.GetConfig().MonsterAttackType != monsterAttackType)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
