using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._30931;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "SupportSkill";

	private const string fireEvent = "CallSandPillar";

	private const string areaEffectAlias = "Area_SupSkill_SandPillar_Soldier";

	private const string endEvent = "End";

	private const int spawnCount = 3;

	private static readonly FP spawnInterval = 0.5;

	private const int spawnCount_2 = 5;

	private static readonly FP spawnInterval_2 = 0.25;

	private CoroutineNode _corSpawn;

	private readonly List<LogicEntity> _usedTargets = new List<LogicEntity>();

	private readonly List<AdventureActor> _candidates = new List<AdventureActor>();

	private int PotentialLv = 1;

	private int spawnCountTmp;

	private FP spawnIntervalTmp = 0;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
		spawnCountTmp = ((PotentialLv >= 2) ? 5 : 3);
		spawnIntervalTmp = ((PotentialLv >= 2) ? spawnInterval_2 : spawnInterval);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref _corSpawn);
		_usedTargets.Clear();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("SupportSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("CallSandPillar"))
		{
			_usedTargets.Clear();
			StartCoroutine(ref _corSpawn, DoSpawn());
		}
		else if (evt.Equals("End"))
		{
			_actor.CancelAttack();
		}
	}

	private IEnumerator DoSpawn()
	{
		for (int i = 0; i < spawnCountTmp; i++)
		{
			TSVector2 position = PickSpawnPosition(i, out var followTarget);
			ILRuntimeAPI.PlayAreaEffect(_actor, "Area_SupSkill_SandPillar_Soldier", position, _actor.tsTransform.Rotation, (AreaEffectEntity entity) =>
			{
				if (!(followTarget == null))
				{
					AreaEffect_FollowComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_FollowComponent>();
					if (!(areaEffectComponent == null))
					{
						areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
						areaEffectComponent.FollowTarget = followTarget;
					}
				}
			});
			if (i < spawnCountTmp - 1)
			{
				yield return _actor.WaitTime(spawnIntervalTmp);
			}
		}
	}

	private TSVector2 PickSpawnPosition(int i, out LogicEntity spawnTarget)
	{
		LogicEntity attackTarget = _actor.attackTarget;
		bool flag = attackTarget != null && !attackTarget.IsDead();
		TSVector2 result = (flag ? attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		if (i == 0)
		{
			if (flag)
			{
				_usedTargets.Add(attackTarget);
				spawnTarget = attackTarget;
			}
			else
			{
				spawnTarget = null;
			}
			return result;
		}
		_candidates.Clear();
		List<AdventureActor> confrontFactionActors = ILRuntimeAPI.GetConfrontFactionActors(_actor);
		for (int j = 0; j < confrontFactionActors.Count; j++)
		{
			AdventureActor adventureActor = confrontFactionActors.get_Item(j);
			if (!(adventureActor == null) && !(adventureActor == attackTarget))
			{
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }) && !_usedTargets.Contains(adventureActor))
				{
					_candidates.Add(adventureActor);
				}
			}
		}
		if (_candidates.Count == 0)
		{
			spawnTarget = (flag ? attackTarget : null);
			return result;
		}
		AdventureActor adventureActor2 = _candidates.get_Item(TSRandom.Range(0, _candidates.Count));
		_usedTargets.Add(adventureActor2);
		spawnTarget = adventureActor2;
		return adventureActor2.tsTransform.Position;
	}
}
