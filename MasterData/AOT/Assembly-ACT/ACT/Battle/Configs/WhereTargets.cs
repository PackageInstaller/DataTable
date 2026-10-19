using System.Collections.Generic;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public struct WhereTargets
{
	public Alliance alliance;

	public bool canBeAttack;

	public bool cantFilterInactive;

	[SerializeField]
	private FilterEntityType? filterEntityType;

	private FilterCantBeAttackType filterCantBeAttackType;

	public bool cantFindDummy;

	public FilterEntityType FilterEntityType
	{
		get
		{
			return filterEntityType ?? GameUtility.defaultFilterEntityType;
		}
		set
		{
			filterEntityType = value;
		}
	}

	private bool Check(Entity target)
	{
		if (!target.IsValid)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("场景内有坏物体，entity层级，无对应逻辑");
			}
			return false;
		}
		if (!target.IsLogicAvailable() || !target.IsAlive() || (!target.IsActive() && !cantFilterInactive) || target.GetRoot() == null)
		{
			return false;
		}
		if (target.InTag(EntityTag.IgnoreAttack))
		{
			return false;
		}
		if (canBeAttack && target.CantBeAttack())
		{
			return false;
		}
		if ((target.GetCompAlliance().alliance & alliance) == 0)
		{
			return false;
		}
		if (!FilterEntityType.HasEntityType(target.GetEntityType()))
		{
			return false;
		}
		if (cantFindDummy && target.IsDummy())
		{
			return false;
		}
		return true;
	}

	public bool Check(Entity owner, Entity target)
	{
		if (!owner.IsValid)
		{
			return Check(target);
		}
		if (Check(target))
		{
			return target.GetBeHitFilter().HasEntityType(owner.GetEntityType());
		}
		return false;
	}

	public void FindTargets(List<FindTargetResult> results)
	{
		for (int num = results.Count - 1; num >= 0; num--)
		{
			if (results[num].targetSourceType != FindTargetResult.TargetSourceType.Damageable && !Check(results[num].entity))
			{
				results.RemoveAt(num);
			}
		}
	}

	public void FindTargets(List<FindTargetResult> results, Entity owner)
	{
		for (int num = results.Count - 1; num >= 0; num--)
		{
			if (results[num].targetSourceType != FindTargetResult.TargetSourceType.Damageable && !Check(owner, results[num].entity))
			{
				results.RemoveAt(num);
			}
		}
	}

	public void FindTargets(BSet<FindTargetResult> results, Entity owner)
	{
		foreach (FindTargetResult result in results)
		{
			if (result.targetSourceType != FindTargetResult.TargetSourceType.Damageable && !Check(owner, result.entity))
			{
				results.Remove(result);
			}
		}
	}

	public bool FindTarget(FindTargetResult result)
	{
		if (result.targetSourceType != FindTargetResult.TargetSourceType.Damageable)
		{
			return Check(result.entity);
		}
		return true;
	}

	public bool FindTarget(FindTargetResult result, Entity owner)
	{
		if (result.targetSourceType != FindTargetResult.TargetSourceType.Damageable)
		{
			return Check(owner, result.entity);
		}
		return true;
	}
}
