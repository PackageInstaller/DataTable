using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._14101;

public class ParallelScript_Support : ParallelScript
{
	private int _summonedCount;

	private HashSet<long> _triggerSet_P32;

	public override void OnEnable()
	{
		base.OnEnable();
		_summonedCount = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514133, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.FE)
				{
					actorL.buffComponent.AddBuff(14133011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	protected override void OnUltraSkillLogicFinish()
	{
		base.OnUltraSkillLogicFinish();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514132, out var _))
		{
			_triggerSet_P32?.Clear();
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 514132, out var _) || !CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P32))
		{
			return;
		}
		monsterAdventureActor.buffComponent.AddBuff(1011, _actor);
		if (_triggerSet_P32 == null)
		{
			_triggerSet_P32 = new HashSet<long>();
		}
		if (!_triggerSet_P32.Add(monsterAdventureActor.Id))
		{
			return;
		}
		foreach (AdventureActor item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
		{
			item.buffComponent.AddBuff(14132011, _actor);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.owner == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 514123, out var _))
		{
			AdventureBulletBase adventureBulletBase = adventureBulletFinishEvent.sender as AdventureBulletBase;
			if (adventureBulletBase != null && adventureBulletBase.CheckBulletTag(Config_Support.bulletTag_AddBuff_P23) && adventureBulletBase.target != null)
			{
				AdventureActor adventureActor = adventureBulletBase.target as AdventureActor;
				adventureActor?.buffComponent.AddBuff(14123011, _actor);
				new PlayFX().Play(adventureActor, null, "fx_14101_base_Support_Skill_Summon_Strengthen", default, adventureActor.tsTransform.Position, default);
			}
		}
	}

	private void OnActorSpawn(IEvent evt)
	{
		if (evt is AdventurActorSpawned { sender: MonsterAdventureActor sender } && sender.IsPlayerMinion(out var summoner) && summoner == _actor)
		{
			_summonedCount++;
			OnSummonedCountChange();
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent { actor: MonsterAdventureActor actor } && actor.IsPlayerMinion(out var summoner) && summoner == _actor)
		{
			_summonedCount--;
			OnSummonedCountChange();
		}
	}

	private void OnSummonedCountChange()
	{
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 514125, out var _))
		{
			return;
		}
		foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
		{
			if (item is AdventureActor adventureActor)
			{
				int buffNumByID = adventureActor.buffComponent.GetBuffNumByID(14125011);
				if (buffNumByID < _summonedCount)
				{
					adventureActor.buffComponent.AddBuffNum(14125011, _summonedCount - buffNumByID, _actor);
				}
				else if (buffNumByID > _summonedCount)
				{
					adventureActor.buffComponent.RemoveBuffByBuffId(14125011, 1);
				}
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		_summonedCount = 0;
		_triggerSet_P32?.Clear();
	}
}
