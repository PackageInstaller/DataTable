using System;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/技能")]
[TaskDescription("判定当前是否有buff，有buff返还success，没有buff返还failure")]
public class CheckAbility : Conditional
{
	public string abilityName;

	public SharedInt buffStack;

	public Condition condition;

	public override void OnAwake()
	{
	}

	public override void OnStart()
	{
	}

	public override TaskStatus OnUpdate()
	{
		CompAbility compAbility = ((ActBehaviorTree)Owner).Entity.GetCompAbility();
		bool flag = compAbility.HasAbility(abilityName);
		if (flag && buffStack.Value > 0)
		{
			int stack = compAbility.GetAbilityByName(abilityName).stack;
			bool flag2 = flag;
			flag = flag2 & (condition switch
			{
				Condition.Greater => stack > buffStack.Value, 
				Condition.Less => stack < buffStack.Value, 
				Condition.Equal => stack == buffStack.Value, 
				Condition.GreaterAndEqual => stack >= buffStack.Value, 
				Condition.LessAndEqual => stack <= buffStack.Value, 
				_ => throw new ArgumentOutOfRangeException(), 
			});
		}
		if (!flag)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
