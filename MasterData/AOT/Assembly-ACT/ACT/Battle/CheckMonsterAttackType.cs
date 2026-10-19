using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("监测自身的职业是不是参数中的某一个， 是就返回成功， inverser表示结果取反 即 是就返回失败")]
public class CheckMonsterAttackType : Conditional
{
	public MonsterAttackType[] monsterAttackTypes;

	public bool inverser;

	public override void OnStart()
	{
	}

	public override TaskStatus OnUpdate()
	{
		MonsterAttackType monsterAttackType = (Owner as ActBehaviorTree).Entity.GetConfig().MonsterAttackType;
		bool flag = false;
		for (int i = 0; i < monsterAttackTypes.Length; i++)
		{
			if (monsterAttackType == monsterAttackTypes[i])
			{
				flag = true;
				break;
			}
		}
		if (flag != inverser)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
