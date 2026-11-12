using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14401;

public class ParallelScript_Support : ParallelScript
{
	private int _killCount_P28;

	private HashSet<long> _attackDamageUniqueIdSet_P29;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514433, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.WE)
				{
					_actor.buffComponent.AddBuff(14433011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemoved);
	}

	private void OnBuffRemoved(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (adventureActorRemoveBuff.sender as AdventureActor is MonsterAdventureActor monsterAdventureActor && CommonUtils.HavePersonalPerk(_actor.dataID, 514424, out var _) && adventureActorRemoveBuff.eventInfo.buffId == 14424011)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14401_B2P24_DelayFlash", monsterAdventureActor.tsTransform.Position);
		}
	}

	protected override void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnSelfCastSkill(castSkillEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514428, out var perkLevel))
		{
			_killCount_P28 = 0;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514429, out perkLevel))
		{
			_attackDamageUniqueIdSet_P29?.Clear();
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514429, out var _) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_Support.damageTag_Trigger_P29))
		{
			if (_attackDamageUniqueIdSet_P29 == null)
			{
				_attackDamageUniqueIdSet_P29 = new HashSet<long>();
			}
			_attackDamageUniqueIdSet_P29.Add(attackEvent.uniqueAttackId);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514421, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P21))
		{
			AdventureActor.AddFromAttr(14421011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514422, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22))
		{
			AdventureActor.AddFromAttr(14422011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514425, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(14425011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(14425002, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514426, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			int num = _actor.logicVariable.GetLogicTagValue("SkillAttackTimes").AsInt();
			if (num > 0)
			{
				AdventureActor.AddFromAttr(14426002, _actor, num);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514428, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			AdventureActor.AddFromAttr(14428001, _actor);
			if (_killCount_P28 > 0)
			{
				AdventureActor.AddFromAttr(14428002, _actor, _killCount_P28);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514429, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P29) && _attackDamageUniqueIdSet_P29 != null && _attackDamageUniqueIdSet_P29.Count > 0)
		{
			AdventureActor.AddFromAttr(14429001, _actor, _attackDamageUniqueIdSet_P29.Count);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514430, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 14430011);
			if (monsterAdventureActor != null && monsterAdventureActor.actorHealthInfo.hpPercentage * 100 < scriptValue)
			{
				AdventureActor.AddFromAttr(14430001, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514431, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P31))
		{
			AdventureActor.AddFromAttr(14431001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (!(monsterAdventureActor == null) && CommonUtils.HavePersonalPerk(_actor.dataID, 514424, out var _) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24))
		{
			if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(14424011))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14401_B2P24_DelayFlash", monsterAdventureActor.tsTransform.Position);
			}
			monsterAdventureActor.buffComponent.AddBuff(14424011, _actor);
		}
	}

	protected override void OnKillTarget(AdventureActorDiedEvent diedEvent)
	{
		base.OnKillTarget(diedEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514428, out var _))
		{
			_killCount_P28++;
		}
	}

	protected override void OnMonsterDied(AdventureActorDiedEvent diedEvent)
	{
		base.OnMonsterDied(diedEvent);
		MonsterAdventureActor monsterAdventureActor = diedEvent.actor as MonsterAdventureActor;
		if (!(monsterAdventureActor == null) && CommonUtils.HavePersonalPerk(_actor.dataID, 514424, out var _) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(14424011))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14401_B2P24_DelayFlash", monsterAdventureActor.tsTransform.Position);
		}
	}

	private void Clear()
	{
		_killCount_P28 = 0;
		_attackDamageUniqueIdSet_P29?.Clear();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemoved);
		Clear();
	}
}
