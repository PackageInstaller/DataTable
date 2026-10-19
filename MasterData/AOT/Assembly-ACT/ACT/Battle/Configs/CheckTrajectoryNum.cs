using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断轨迹数量", "Predicate", new string[] { "check", "trajectory", "num", "predicate", "condition" })]
public class CheckTrajectoryNum : ConfigPredicate
{
	public AbilityEntityType entityType;

	public int num;

	public Condition condition;

	public override bool Check(ActionMemory memory)
	{
		List<Entity> list = ListPool<Entity>.Get();
		SystemProduct.GetCasterProductEntity(memory.target.entity, ref list);
		int count = list.Count;
		ListPool<Entity>.Release(list);
		return condition switch
		{
			Condition.Greater => count > num, 
			Condition.GreaterAndEqual => count >= num, 
			Condition.Equal => count == num, 
			Condition.LessAndEqual => count <= num, 
			Condition.Less => count < num, 
			_ => false, 
		};
	}
}
