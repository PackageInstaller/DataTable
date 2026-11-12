using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._13401;

public class ParallelScript : ParallelBase
{
	protected List<int> _damageTag_TriggerFireMark;

	private CommomAreaHitConfig _areaHitConfig_FireMark;

	private HitBox.HitBoxFeatureData _featureData_FireMark;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_damageTag_TriggerFireMark == null)
		{
			_damageTag_TriggerFireMark = new List<int>();
		}
		else
		{
			_damageTag_TriggerFireMark.Clear();
		}
		_damageTag_TriggerFireMark.Add(Config.damageTag_TriggerFireMark);
		InitAmmoInfo();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	private void InitAmmoInfo()
	{
		_actor.ammoInfo.ammoType = HotfixEnum.AmmoType.Special1;
		_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Special1, GetAmmoCountMax(), 1);
		if (!ModuleController<AdventureModuleController>.Instance.GetActorAmmoInfo(_actor.dataID, out var _))
		{
			_actor.ammoInfo.ChangeValue(HotfixEnum.AmmoType.Special1, HotfixEnum.ammoParameterType.SET_ABSOLUTE_VALUE, 0);
		}
	}

	protected virtual int GetAmmoCountMax()
	{
		return 3;
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent && adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor)
		{
			OnSelfAttacked(adventureActorReceiveAttackEvent);
		}
	}

	protected virtual void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent && adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513442, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_UltraSkill))
			{
				AdventureActor.AddFromAttr(13442001, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()))
			{
				AdventureActor.AddFromAttr(13496511, _actor);
			}
			OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.from is PlayerAdventureActor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster && adventureActorReceiveDamageEvent.from.Id == _actor.Id)
		{
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerFireMark(monster, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerFireMark(monster, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private bool CheckCanTriggerFireMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		if (_damageTag_TriggerFireMark == null || _damageTag_TriggerFireMark.Count <= 0)
		{
			return false;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.Fire, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			for (int i = 0; i < _damageTag_TriggerFireMark.Count; i++)
			{
				int hitTag = _damageTag_TriggerFireMark.get_Item(i);
				if (CommonUtils.CheckHitByTag(hitDamageTag, hitTag))
				{
					return true;
				}
			}
		}
		return false;
	}

	private void TriggerFireMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (!(monster == null))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.Fire);
			if (_featureData_FireMark == null)
			{
				_featureData_FireMark = new HitBox.HitBoxFeatureData
				{
					StiffDuration = Config.stiffDuration_FireMark,
					hitStrenth = Config.hitStrenth_FireMark
				};
			}
			if (_areaHitConfig_FireMark == null)
			{
				_areaHitConfig_FireMark = new CommomAreaHitConfig
				{
					fxAlias = "fx_common_base_FireTag_Trigger_2",
					hittedEffectAlias = "",
					hitDamageId = 134000001,
					hitFlags = HitBox.FeatureFlag.Stiff,
					hitFeatureData = _featureData_FireMark,
					damageImmuneDuration = -1
				};
			}
			_areaHitConfig_FireMark.position = monster.tsTransform.Position;
			ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig_FireMark, Config.hitRadius_FireMark, 0);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513441, out var _) && CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_UltraSkill))
			{
				_actor.buffComponent.AddBuff(13441011, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
			{
				_actor.buffComponent.AddBuff(13496111, _actor);
			}
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Fire, HotfixEnum.AdventureActorElementTriggerType.FireElementTriggerType2, _actor, monster, "FireMark_Trigger_Effect_02");
			OnTriggerFireMark(hitDamageTag);
		}
	}

	protected virtual void OnTriggerFireMark(IList<int> hitDamageTag)
	{
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.sender is MonsterAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Fire) && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(13496411, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}
}
