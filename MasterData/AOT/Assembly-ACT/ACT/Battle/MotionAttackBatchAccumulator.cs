using Bamboo.ECS;

namespace ACT.Battle;

internal struct MotionAttackBatchAccumulator
{
	public int resolvedEnemyCount;

	public int damagedEnemyCount;

	public int killedEnemyCount;

	public bool HasEffectiveResult
	{
		get
		{
			if (damagedEnemyCount <= 0)
			{
				return killedEnemyCount > 0;
			}
			return true;
		}
	}

	public void Record(Entity attackee, in AttackResolveResult result)
	{
		if (result.isResolved && IsCountableEnemy(attackee))
		{
			resolvedEnemyCount++;
			if (result.actualDamage > 0)
			{
				damagedEnemyCount++;
			}
			if (result.causedDeath)
			{
				killedEnemyCount++;
			}
		}
	}

	private static bool IsCountableEnemy(Entity attackee)
	{
		CompMonster component;
		if (attackee.IsValid && attackee.GetAlliance() == Alliance.Enemy)
		{
			return attackee.TryGetCompMonster(out component);
		}
		return false;
	}
}
