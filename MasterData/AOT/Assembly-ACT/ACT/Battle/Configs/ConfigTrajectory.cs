using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

public abstract class ConfigTrajectory
{
	public abstract RuntimeTrajectory Create(Entity abilityEntity, Ability ability);

	public virtual void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
	}
}
