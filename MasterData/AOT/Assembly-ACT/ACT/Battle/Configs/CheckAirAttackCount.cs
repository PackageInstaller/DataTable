using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断空中攻击数量", "Predicate", new string[] { "check", "air", "attack", "count", "predicate", "condition" })]
public class CheckAirAttackCount : ConfigPredicate
{
	public Condition condition;

	public int count;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompMotion(out CompMotion component))
		{
			return false;
		}
		int airAttackCount = component.airAttackCount;
		return condition switch
		{
			Condition.Greater => airAttackCount > count, 
			Condition.Less => airAttackCount < count, 
			Condition.Equal => airAttackCount == count, 
			Condition.GreaterAndEqual => airAttackCount >= count, 
			Condition.LessAndEqual => airAttackCount <= count, 
			_ => false, 
		};
	}
}
