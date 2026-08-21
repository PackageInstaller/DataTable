using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class BattleStateSystem : BaseSystem, IObserverHandler
{
	private Dictionary<BaseEntity, BattleStateInfo> _battleStateInfos = new Dictionary<BaseEntity, BattleStateInfo>(10);

	private List<BaseEntity> nextFrameRemove = new List<BaseEntity>(10);

	private BattleObserverSystem observerSystem;

	private bool actorEntityBattleState;

	private bool actorEntityBattleBoss;

	protected override bool IsLogicSystem => true;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		observerSystem = GetSystem<BattleObserverSystem>();
		if (observerSystem != null)
		{
			observerSystem.Attach(BattleObserverEventEnum.Attack, this);
			observerSystem.Attach(BattleObserverEventEnum.Damage, this);
			observerSystem.Attach(BattleObserverEventEnum.EntityDead, this);
			observerSystem.Attach(BattleObserverEventEnum.EntityRelease, this);
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (nextFrameRemove.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < nextFrameRemove.Count; i++)
		{
			if (_battleStateInfos.TryGetValue(nextFrameRemove[i], out var value))
			{
				_battleStateInfos.Remove(nextFrameRemove[i]);
				ReferencePool.Release(value);
			}
		}
		nextFrameRemove.Clear();
	}

	public void OnNotify(IObserverParams param)
	{
		if (param.ObserverEventType == BattleObserverEventEnum.Attack)
		{
			AttackHandle(param as ObserverDamageProgressParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.Damage)
		{
			HitHandle(param as ObserverDamageProgressParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.EntityDead)
		{
			EntityDeadHandle(param as ObserverEntityDeadParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.EntityRelease)
		{
			EntityReleaseHandle(param as ObserverEntityReleaseParams);
		}
	}

	private void AttackHandle(ObserverDamageProgressParams damageProgressParams)
	{
		if (damageProgressParams == null || damageProgressParams.Attacker == null || !damageProgressParams.Attacker.IsSurvival || damageProgressParams.Defender == null || ((damageProgressParams.Attacker.GetEntityType() != EntityType.HERO || (damageProgressParams.Defender.GetEntityType() != EntityType.MONSTER && damageProgressParams.Defender.GetEntityType() != EntityType.SummonedEntity)) && (damageProgressParams.Defender.GetEntityType() != EntityType.HERO || (damageProgressParams.Attacker.GetEntityType() != EntityType.MONSTER && damageProgressParams.Attacker.GetEntityType() != EntityType.SummonedEntity))))
		{
			return;
		}
		int id = damageProgressParams.Defender.Id;
		BattleStateInfo battleStateInfo = GetBattleStateInfo(damageProgressParams.Attacker);
		if (battleStateInfo != null && !battleStateInfo.AttackEntityId.Contains(id) && damageProgressParams.Defender.IsSurvival)
		{
			battleStateInfo.AttackEntityId.Add(id);
			battleStateInfo.BattleStateResult = true;
			SendBattleStateChangeEvent(damageProgressParams.Attacker, battleState: true);
			if (damageProgressParams.Attacker.IsActorEntity)
			{
				ActorEntityBattleStateChange(battleStateInfo, damageProgressParams.Attacker);
			}
		}
	}

	private void HitHandle(ObserverDamageProgressParams damageProgressParams)
	{
		if (damageProgressParams != null && damageProgressParams.Attacker != null && damageProgressParams.Defender != null && damageProgressParams.Defender.IsSurvival && ((damageProgressParams.Attacker.GetEntityType() == EntityType.HERO && (damageProgressParams.Defender.GetEntityType() == EntityType.MONSTER || damageProgressParams.Defender.GetEntityType() == EntityType.SummonedEntity)) || (damageProgressParams.Defender.GetEntityType() == EntityType.HERO && (damageProgressParams.Attacker.GetEntityType() == EntityType.MONSTER || damageProgressParams.Attacker.GetEntityType() == EntityType.SummonedEntity))))
		{
			EntityHitedEnter(damageProgressParams.Attacker, damageProgressParams.Defender);
		}
	}

	private void EntityHitedEnter(BaseEntity attack, BaseEntity defender)
	{
		BattleStateInfo battleStateInfo = GetBattleStateInfo(defender);
		if (battleStateInfo != null && !battleStateInfo.HitEntityId.Contains(attack.Id) && attack.IsSurvival)
		{
			battleStateInfo.HitEntityId.Add(attack.Id);
			battleStateInfo.BattleStateResult = true;
			SendBattleStateChangeEvent(defender, battleState: true);
			if (defender.IsActorEntity)
			{
				ActorEntityBattleStateChange(battleStateInfo, defender);
			}
		}
	}

	private void SendBattleStateChangeEvent(BaseEntity entity, bool battleState)
	{
		ObserverBattleStateChangeParams observerBattleStateChangeParams = ReferencePool.Acquire<ObserverBattleStateChangeParams>();
		observerBattleStateChangeParams.Init(entity, battleState);
		observerSystem.Notify(BattleObserverEventEnum.BattleStateChange, observerBattleStateChangeParams);
		ReferencePool.Release(observerBattleStateChangeParams);
	}

	private void EntityDeadHandle(ObserverEntityDeadParams entityDeadParams)
	{
		if (entityDeadParams != null)
		{
			DeadOrReleaseEntity(entityDeadParams.DeadEntity);
		}
	}

	private void EntityReleaseHandle(ObserverEntityReleaseParams entityReleaseParams)
	{
		if (entityReleaseParams != null)
		{
			DeadOrReleaseEntity(entityReleaseParams.ReleaseEntity);
		}
	}

	public void ForceBattleHeroHandle(bool isStart)
	{
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		if (teamHero == null)
		{
			return;
		}
		for (int i = 0; i < teamHero.Count; i++)
		{
			HeroEntity heroEntity = teamHero[i];
			if (!heroEntity.IsSurvival)
			{
				continue;
			}
			BattleStateInfo battleStateInfo = GetBattleStateInfo(heroEntity);
			if (battleStateInfo != null)
			{
				battleStateInfo.ForceBattle = isStart;
				bool battleStateResult = battleStateInfo.BattleStateResult;
				SetEntityBattleState(battleStateInfo);
				if (battleStateResult != battleStateInfo.BattleStateResult)
				{
					SendBattleStateChangeEvent(heroEntity, battleStateInfo.BattleStateResult);
				}
				if (heroEntity.IsActorEntity)
				{
					ActorEntityBattleStateChange(battleStateInfo, heroEntity);
				}
			}
		}
	}

	public void ForceBattleMonsterHandle(BaseEntity monster)
	{
		BattleStateInfo battleStateInfo = GetBattleStateInfo(monster);
		if (battleStateInfo != null)
		{
			battleStateInfo.ForceBattle = true;
			battleStateInfo.BattleStateResult = true;
			SendBattleStateChangeEvent(monster, battleState: true);
		}
	}

	public void BossBattleStartHandle(MonsterEntity boss)
	{
		if (boss == null)
		{
			return;
		}
		BattleStateInfo battleStateInfo = GetBattleStateInfo(boss);
		if (battleStateInfo == null)
		{
			return;
		}
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		if (teamHero == null)
		{
			return;
		}
		for (int i = 0; i < teamHero.Count; i++)
		{
			HeroEntity heroEntity = teamHero[i];
			if (!heroEntity.IsSurvival)
			{
				continue;
			}
			BattleStateInfo battleStateInfo2 = GetBattleStateInfo(heroEntity);
			if (battleStateInfo2 != null)
			{
				battleStateInfo2.BattleBoss = boss;
				battleStateInfo2.BattleStateResult = true;
				SendBattleStateChangeEvent(boss, battleState: true);
				battleStateInfo.HitEntityId.Add(heroEntity.Id);
				if (heroEntity.IsActorEntity)
				{
					ActorEntityBattleStateChange(battleStateInfo2, heroEntity);
				}
			}
		}
		battleStateInfo.BattleStateResult = true;
		SendBattleStateChangeEvent(boss, battleState: true);
	}

	public void CallMonsterHandle(BaseEntity monster, BaseEntity callMonster)
	{
		if (callMonster == null || monster == null || !GetEntityBattleState(monster.Id))
		{
			return;
		}
		BattleStateInfo battleStateInfo = GetBattleStateInfo(callMonster);
		if (battleStateInfo == null)
		{
			return;
		}
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		if (teamHero == null)
		{
			return;
		}
		for (int i = 0; i < teamHero.Count; i++)
		{
			HeroEntity heroEntity = teamHero[i];
			if (!heroEntity.IsSurvival)
			{
				continue;
			}
			BattleStateInfo battleStateInfo2 = GetBattleStateInfo(heroEntity);
			if (battleStateInfo2 != null)
			{
				if (battleStateInfo2.HitEntityId.Contains(callMonster.Id))
				{
					battleStateInfo2.HitEntityId.Add(callMonster.Id);
					battleStateInfo2.BattleStateResult = true;
					SendBattleStateChangeEvent(heroEntity, battleState: true);
				}
				battleStateInfo.HitEntityId.Add(heroEntity.Id);
				if (heroEntity.IsActorEntity)
				{
					ActorEntityBattleStateChange(battleStateInfo2, heroEntity);
				}
			}
		}
		battleStateInfo.BattleStateResult = true;
		SendBattleStateChangeEvent(callMonster, battleState: true);
	}

	public void ResetLevelHandle()
	{
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		if (teamHero != null && teamHero.Count > 0)
		{
			if (_battleStateInfos.TryGetValue(teamHero[0], out var value))
			{
				value.Clear();
				ActorEntityBattleStateChange(value, teamHero[0]);
			}
			else
			{
				GetSystem<BattleSystem>().ActorBattleStateChange(battleStateResult: false);
			}
		}
		foreach (BattleStateInfo value2 in _battleStateInfos.Values)
		{
			ReferencePool.Release(value2);
		}
		_battleStateInfos.Clear();
		nextFrameRemove.Clear();
		actorEntityBattleBoss = false;
		actorEntityBattleState = false;
	}

	public void ForceSetBattleState(BaseEntity entity, BaseEntity nodeEntity)
	{
		EntityHitedEnter(entity, nodeEntity);
		EntityHitedEnter(nodeEntity, entity);
	}

	public bool GetEntityBattleState(int entityId)
	{
		if (_battleStateInfos == null)
		{
			return false;
		}
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(entityId);
		if (entity == null)
		{
			return false;
		}
		if (_battleStateInfos.TryGetValue(entity, out var value))
		{
			return value.BattleStateResult;
		}
		return false;
	}

	public bool GetEntityBattleState(BaseEntity entity)
	{
		if (_battleStateInfos == null || entity == null)
		{
			return false;
		}
		if (_battleStateInfos.TryGetValue(entity, out var value))
		{
			return value.BattleStateResult;
		}
		return false;
	}

	private BattleStateInfo GetBattleStateInfo(BaseEntity entity)
	{
		if (_battleStateInfos == null)
		{
			return null;
		}
		if (!_battleStateInfos.TryGetValue(entity, out var value))
		{
			value = ReferencePool.Acquire<BattleStateInfo>();
			_battleStateInfos.Add(entity, value);
		}
		return value;
	}

	private void DeadOrReleaseEntity(BaseEntity entity)
	{
		if (entity == null || (entity.GetEntityType() != EntityType.HERO && entity.GetEntityType() != EntityType.SummonedEntity && entity.GetEntityType() != EntityType.MONSTER && entity.GetEntityType() != EntityType.BATTLEENTITY))
		{
			return;
		}
		if (_battleStateInfos.TryGetValue(entity, out var value))
		{
			_battleStateInfos.Remove(entity);
			ReferencePool.Release(value);
		}
		int id = entity.Id;
		bool flag = entity is MonsterEntity monsterEntity && monsterEntity.IsBoss;
		foreach (KeyValuePair<BaseEntity, BattleStateInfo> battleStateInfo in _battleStateInfos)
		{
			BattleStateInfo value2 = battleStateInfo.Value;
			bool flag2 = false;
			if (value2.AttackEntityId.Contains(id))
			{
				flag2 = true;
				value2.AttackEntityId.Remove(id);
			}
			if (value2.HitEntityId.Contains(id))
			{
				flag2 = true;
				value2.HitEntityId.Remove(id);
			}
			if (flag)
			{
				value2.BattleBoss = null;
				flag2 = true;
			}
			if (flag2)
			{
				BaseEntity key = battleStateInfo.Key;
				SetEntityBattleState(value2);
				SendBattleStateChangeEvent(key, value2.BattleStateResult);
				if (!value2.BattleStateResult && !nextFrameRemove.Contains(key))
				{
					nextFrameRemove.Add(key);
				}
				if (key.IsActorEntity)
				{
					ActorEntityBattleStateChange(value2, key);
				}
			}
		}
	}

	private void SetEntityBattleState(BattleStateInfo battleStateInfo)
	{
		battleStateInfo.BattleStateResult = battleStateInfo.HitEntityId.Count > 0 || battleStateInfo.AttackEntityId.Count > 0 || battleStateInfo.BattleBoss != null || battleStateInfo.ForceBattle;
	}

	private async void ActorEntityBattleStateChange(BattleStateInfo battleStateInfo, BaseEntity actorEntity)
	{
		if (battleStateInfo == null)
		{
			return;
		}
		GetSystem<BattleSystem>().ActorBattleStateChange(battleStateInfo.BattleStateResult);
		if (battleStateInfo.BattleStateResult == actorEntityBattleState && ((battleStateInfo.BattleBoss == null && !actorEntityBattleBoss) || (battleStateInfo.BattleBoss != null && actorEntityBattleBoss) || (battleStateInfo.BattleBoss == null && battleStateInfo.ForceBattle)))
		{
			return;
		}
		VirtualCameraSystem system = GetSystem<VirtualCameraSystem>();
		if (system == null)
		{
			return;
		}
		if (battleStateInfo.BattleBoss != null)
		{
			IEntityRoom battleBoss = battleStateInfo.BattleBoss;
			if (battleBoss != null && !battleBoss.InLocalActorRoom())
			{
				return;
			}
		}
		if ((Object)(object)GetSystem<SceneSystem>().GetLevelMapData() == null)
		{
			if (battleStateInfo.BattleStateResult && battleStateInfo.BattleBoss != null)
			{
				system.SwitchBindMonsterEntity(battleStateInfo.BattleBoss);
				actorEntityBattleBoss = true;
			}
			else
			{
				system.BattleResumeCameraBaseDistance();
				actorEntityBattleBoss = false;
			}
		}
		else if (battleStateInfo.BattleStateResult)
		{
			system.SetLevelBattleCameraPriority(battleCameraBaseData: false);
			if (battleStateInfo.BattleBoss == null)
			{
				system.SetBattleCameraInLevelBattle();
				actorEntityBattleBoss = false;
			}
			else
			{
				system.SwitchBindMonsterEntity(battleStateInfo.BattleBoss);
				actorEntityBattleBoss = true;
			}
		}
		else
		{
			system.SetLevelBattleCameraPriority(battleCameraBaseData: true);
			system.BattleResumeCameraBaseDistance();
			actorEntityBattleBoss = false;
		}
		actorEntityBattleState = battleStateInfo.BattleStateResult;
		actorEntity?.GetComponent<HeroIndicatorRingComponent>()?.PlayIndicatorRing((!actorEntityBattleState) ? IndicatorDisPlayEnum.ExitBattleState : IndicatorDisPlayEnum.EnterBattleState);
	}

	public void ClearEntityBattleState(int entityId)
	{
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(entityId);
		if (entity != null)
		{
			DeadOrReleaseEntity(entity);
		}
	}
}
