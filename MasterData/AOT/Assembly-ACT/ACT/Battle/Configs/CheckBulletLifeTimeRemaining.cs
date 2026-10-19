using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断子弹Life时间剩余", "Predicate", new string[] { "check", "bullet", "life", "time", "remaining", "predicate", "condition" })]
public class CheckBulletLifeTimeRemaining : ConfigPredicate
{
	public ConfigFunction<float> remainingLife;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.GetEntityType() == EntityType.Trajectory)
		{
			CompTrajectory compTrajectory = memory.target.entity.GetCompTrajectory();
			float num = remainingLife.Return(memory);
			if (!compTrajectory.lifeEnd && compTrajectory.RemainingLifeTime() > num)
			{
				return true;
			}
		}
		return false;
	}
}
