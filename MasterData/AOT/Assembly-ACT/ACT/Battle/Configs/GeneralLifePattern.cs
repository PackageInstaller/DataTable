using System;
using System.Collections.Generic;
using System.Threading;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class GeneralLifePattern : TrajectoryLifePattern
{
	public float lifetime = 10f;

	public ConfigFunction<float> configLifeTime;

	public ConfigAction[] onInit;

	public ConfigAction[] onLifeEnd;

	public bool onStopDie = true;

	public ConfigAction[] onDie;

	public float destroyDelay;

	public bool dieWithParent;

	public override void Init(Entity bullet, Ability ability)
	{
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		CompProduct compProduct = bullet.GetCompProduct();
		compTrajectory.ability = ability;
		compTrajectory.mpSkill = ability?.skillLevelInfo ?? default(MPSkill);
		float lifePatternLife = configLifeTime?.Return(new ActionMemory(compProduct.actionSource, compProduct.productOwner, FindTargetResult.EntityOnly(bullet), null, compTrajectory.ability)) ?? lifetime;
		if (compTrajectory.isOverrideLifeTime)
		{
			lifePatternLife = compTrajectory.overrideLifeTime;
		}
		compTrajectory.lifePatternLife = lifePatternLife;
		SystemAbility.DoActions(compProduct.actionSource, bullet, FindTargetResult.EntityOnly(bullet), null, ability, onInit);
	}

	public override void FixedUpdate(Entity bullet, float dt)
	{
		if (!bullet.IsAlive())
		{
			return;
		}
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		CompProduct compProduct = bullet.GetCompProduct();
		float num = configLifeTime?.Return(new ActionMemory(compProduct.actionSource, compProduct.productOwner, FindTargetResult.EntityOnly(bullet), null, compTrajectory.ability)) ?? lifetime;
		if (compTrajectory.isOverrideLifeTime)
		{
			num = compTrajectory.overrideLifeTime;
		}
		compTrajectory.lifePatternLife = num;
		if (!compTrajectory.lifeEnd)
		{
			if (dieWithParent && !compProduct.caster.IsAlive())
			{
				compTrajectory.lifeEnd = true;
				compTrajectory.currentFrameLifeEnd = true;
			}
			else if (num > 0f)
			{
				if (compTrajectory.life < num)
				{
					compTrajectory.life = Mathf.Min(compTrajectory.life + dt, num);
				}
				if (compTrajectory.life >= num)
				{
					compTrajectory.lifeEnd = true;
					compTrajectory.currentFrameLifeEnd = true;
				}
			}
			else
			{
				compTrajectory.lifeEnd = true;
				compTrajectory.currentFrameLifeEnd = true;
			}
		}
		if (compTrajectory.currentFrameLifeEnd)
		{
			OnLifeEnd(bullet);
			compTrajectory.currentFrameLifeEnd = false;
		}
		if (compTrajectory.lifeEnd && onStopDie)
		{
			bullet.KillEntity();
		}
	}

	public override void OnHandleDie(Entity bullet)
	{
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		CompProduct compProduct = bullet.GetCompProduct();
		if (!compTrajectory.forceDestroy || compTrajectory.tag.HasFlag(TrajectoryTag.CallOnDieWhenForceDestroy))
		{
			SystemAbility.DoActions(compProduct.actionSource, bullet, FindTargetResult.EntityOnly(bullet), null, compTrajectory.ability, onDie);
		}
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtBulletDie evt = systemAbility.GetEvt<EvtBulletDie>(bullet, compTrajectory.ability);
		evt.mainEntity = compProduct.actionSource;
		evt.bullet = bullet;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
		DestroyDelay(bullet, bullet.GetCancellationTokenOnRelease()).Forget();
	}

	public override void OnLifeEnd(Entity entityBehave)
	{
		SystemAbility.DoActions(entityBehave.GetCompProduct().caster, entityBehave, FindTargetResult.EntityOnly(entityBehave), null, entityBehave.GetCompTrajectory().ability, onLifeEnd);
	}

	private async UniTaskVoid DestroyDelay(Entity entityBehave, CancellationToken destroyToken)
	{
		float timer = 0f;
		CompTime compTime = entityBehave.GetCompTime();
		while (timer < destroyDelay && !destroyToken.IsCancellationRequested)
		{
			timer += compTime.fixedDeltaTime;
			await UniTask.Delay(TimeSpan.FromSeconds(compTime.fixedDeltaTime), ignoreTimeScale: false, PlayerLoopTiming.FixedUpdate);
		}
		if (!destroyToken.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(entityBehave);
		}
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onInit, ab);
		ConfigAbility.CacheActionList(list, onDie, ab);
		ConfigAbility.CacheActionList(list, onLifeEnd, ab);
	}
}
