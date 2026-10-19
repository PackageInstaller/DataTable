using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class GeneralTrajectory : ConfigTrajectory
{
	public TrajectoryMovementPattern movementPattern;

	public TrajectoryHitPattern hitPattern;

	public TrajectoryLifePattern lifePattern;

	public bool clearHitCache;

	public bool useRaycast;

	public bool staticHitCheckEnvironmentOcclusion;

	public override RuntimeTrajectory Create(Entity abilityEntity, Ability ability)
	{
		RuntimeGeneralTrajectory runtimeGeneralTrajectory = new RuntimeGeneralTrajectory();
		runtimeGeneralTrajectory.Create(this, abilityEntity, ability);
		return runtimeGeneralTrajectory;
	}

	public RuntimeTrajectory Create(TrajectoryMovementPattern overrideMovement, Entity abilityEntity, Ability ability)
	{
		RuntimeGeneralTrajectory runtimeGeneralTrajectory = new RuntimeGeneralTrajectory();
		runtimeGeneralTrajectory.Create(overrideMovement, hitPattern, lifePattern, clearHitCache, useRaycast, staticHitCheckEnvironmentOcclusion, abilityEntity, ability);
		return runtimeGeneralTrajectory;
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		movementPattern?.CacheActionList(list, ab);
		hitPattern?.CacheActionList(list, ab);
		lifePattern?.CacheActionList(list, ab);
	}
}
