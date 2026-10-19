using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.ECS.System;

public class SystemTrajectory : EntitySystem
{
	private List<RuntimeTrajectory> _toRelease;

	private Filter _filter;

	private EntityAction<CompBehave, CompTrajectory, CompTime> _onItemFixedUpdateAction;

	private EntityAction<CompTrajectory> _onItemUpdateAction;

	private EntityAction _tryRemoveBehaveAction;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompBehave, CompTransform, CompTime, CompVelocity, CompTrajectory>().Build();
		_onItemFixedUpdateAction = OnItemFixedUpdate;
		_onItemUpdateAction = OnItemUpdate;
		_tryRemoveBehaveAction = TryRemoveBehave;
		_toRelease = new List<RuntimeTrajectory>();
	}

	public override void FixedUpdate()
	{
		_filter.ForEach(_onItemFixedUpdateAction);
		ResetUnusedTrajectories(_toRelease);
	}

	private static void OnItemFixedUpdate(Entity entity, CompBehave compBehave, CompTrajectory compTrajectory, CompTime compTime)
	{
		if (compBehave.IsTickAvailable() && compTrajectory.trajectory != null)
		{
			compTrajectory.trajectory.FixedUpdateBehave(entity, compTime.motionFixedDeltaTime);
		}
	}

	private static void ResetUnusedTrajectories(List<RuntimeTrajectory> entities)
	{
		foreach (RuntimeTrajectory entity in entities)
		{
			entity.Reset();
		}
		entities.Clear();
	}

	public override void Update()
	{
		_filter.ForEach(_onItemUpdateAction);
	}

	private static void OnItemUpdate(Entity entity, CompTrajectory compTrajectory)
	{
		if (entity.IsTickAvailable())
		{
			compTrajectory.trajectory?.UpdateBehave(entity, Time.deltaTime);
		}
	}

	public void ProcessWeaponPartHit(Entity bullet, Collider collider)
	{
		if (!bullet.IsValid || collider == null || !bullet.TryGetCompTrajectory(out CompTrajectory component) || component.trajectory == null || component.shape != Shape.CustomPart || !(component.trajectory is RuntimeGeneralTrajectory { hitPattern: { } hitPattern } runtimeGeneralTrajectory))
		{
			return;
		}
		WhereTargets whereTargets = runtimeGeneralTrajectory.CreateWhereTargets(bullet);
		if (BattleConsts.hitMask == (BattleConsts.hitMask | (1 << collider.gameObject.layer)))
		{
			var (flag, findTargetResult) = BaseFindTargetsByArea.GetResult(bullet.GetCompTransform().physicsPosition, collider, Vector3.zero);
			if (flag && whereTargets.FindTarget(findTargetResult, bullet) && !bullet.GetCompAbility().IsHited(findTargetResult, null))
			{
				hitPattern.OnHitEntity(bullet, findTargetResult, component.ability);
			}
		}
		else if (!hitPattern.IgnoreEnvironment(bullet))
		{
			hitPattern.OnHitEnvironment(bullet, component.ability, collider, Vector3.zero);
		}
	}

	public void BindTrajectory(Entity entityBehave, RuntimeTrajectory trajectory)
	{
		CompTrajectory compTrajectory = entityBehave.GetCompTrajectory();
		if (compTrajectory.trajectory == trajectory)
		{
			return;
		}
		if (compTrajectory.trajectory is RuntimeGeneralTrajectory runtimeGeneralTrajectory && trajectory is RuntimeGeneralTrajectory runtimeGeneralTrajectory2)
		{
			if (runtimeGeneralTrajectory2.hitPattern == null)
			{
				runtimeGeneralTrajectory2.hitPattern = runtimeGeneralTrajectory.hitPattern;
			}
			if (runtimeGeneralTrajectory2.lifePattern == null)
			{
				runtimeGeneralTrajectory2.lifePattern = runtimeGeneralTrajectory.lifePattern;
			}
		}
		if (compTrajectory.trajectory != null)
		{
			_toRelease.Add(compTrajectory.trajectory);
		}
		compTrajectory.trajectory = trajectory;
		compTrajectory.lifeEnd = false;
		compTrajectory.life = 0f;
		compTrajectory.hitCount = 0;
		compTrajectory.isOverrideLifeTime = false;
		compTrajectory.overrideLifeTime = 0f;
	}

	public void TryToRemoveAll()
	{
		_filter.ForEach(_tryRemoveBehaveAction);
	}

	private static void TryRemoveBehave(Entity entity)
	{
		MonoECS.instance.TryRemoveBehave(entity);
	}

	public void ForEachTrajectory(EntityAction drawCustomTrajectory)
	{
		_filter.ForEach(drawCustomTrajectory);
	}
}
