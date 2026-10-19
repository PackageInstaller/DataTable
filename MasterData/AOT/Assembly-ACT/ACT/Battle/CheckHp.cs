using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("自身血量判定，自身血量>Hp Percent返还success，自身血量<=Hp Percent返还failure")]
public class CheckHp : Conditional
{
	public float hpPercent;

	public Condition condition;

	public override TaskStatus OnUpdate()
	{
		CompAbility compAbility = ((ActBehaviorTree)Owner).Entity.GetCompAbility();
		float num = (float)compAbility.hp / (float)compAbility.maxHP;
		bool flag = num > hpPercent;
		switch (condition)
		{
		case Condition.Less:
		case Condition.Equal:
		case Condition.LessAndEqual:
			flag = num < hpPercent;
			break;
		}
		if (!flag)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
