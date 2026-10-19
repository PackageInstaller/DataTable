using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class TrajectoryHitPattern
{
	public abstract GeneralHitPattern.VirtualPlane[] VirtualPlanes { get; }

	public virtual WhereTargets CreateWhereTargets(Entity bullet, bool canBeAttack = false)
	{
		return new WhereTargets
		{
			alliance = bullet.GetAlliance().GetOp(),
			canBeAttack = canBeAttack
		};
	}

	public abstract bool IgnoreEnvironment(Entity bullet);

	public abstract void OnHitEntity(Entity bullet, FindTargetResult target, Ability ability);

	public abstract void OnHitEnvironment(Entity bullet, Ability ability, Collider collider, Vector3 normal);

	public abstract void OnHitVirtualPanel(Entity bullet, Ability ability);

	public virtual void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
	}
}
