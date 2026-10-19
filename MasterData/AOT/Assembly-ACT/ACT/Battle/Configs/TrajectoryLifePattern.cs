using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

public abstract class TrajectoryLifePattern
{
	public abstract void Init(Entity bullet, Ability ability);

	public virtual void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
	}

	public abstract void FixedUpdate(Entity bullet, float dt);

	public abstract void OnHandleDie(Entity bullet);

	public abstract void OnLifeEnd(Entity entityBehave);
}
