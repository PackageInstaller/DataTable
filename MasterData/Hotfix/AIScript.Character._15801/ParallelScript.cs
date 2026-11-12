using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._15801;

public class ParallelScript : ParallelBase
{
	protected SummonedController _summonedController;

	protected List<int> _damageTag_TriggerFireMark;

	protected List<int> _damageTag_AddFireMark;

	private CommomAreaHitConfig _areaHitConfig_FireMark;

	private HitBox.HitBoxFeatureData _featureData_FireMark;

	private bool _haveShield;

	protected bool HaveShield
	{
		get
		{
			return _haveShield;
		}
		set
		{
			if (_haveShield == value)
			{
				return;
			}
			_haveShield = value;
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
			{
				if (_haveShield)
				{
					_actor.buffComponent.AddBuff(15896411, _actor);
					_summonedController?.AddBuffToMinion(15896411);
				}
				else
				{
					_actor.buffComponent.RemoveBuffByBuffId(15896411);
					_summonedController?.RemoveBuffFromMinion(15896411);
				}
			}
		}
	}

	public override void OnEnable()
	{
		base.OnEnable();
		if (_damageTag_AddFireMark == null)
		{
			_damageTag_AddFireMark = new List<int>();
		}
		else
		{
			_damageTag_AddFireMark.Clear();
		}
		_damageTag_AddFireMark.Add(Config.damageTag_AddFireMark);
		if (_damageTag_TriggerFireMark == null)
		{
			_damageTag_TriggerFireMark = new List<int>();
		}
		else
		{
			_damageTag_TriggerFireMark.Clear();
		}
		_damageTag_TriggerFireMark.Add(Config.damageTag_TriggerFireMark);
		GenerateSummonerController();
		_summonedController.OnEnable();
		HaveShield = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_START_FINISH", OnLevelStartFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	protected virtual void GenerateSummonerController()
	{
		_summonedController = new SummonedController(_actor as PlayerAdventureActor);
	}

	private void OnLevelStartFinish(IEvent _)
	{
		_summonedController.Init();
	}

	public void OnUpdate()
	{
		HaveShield = _actor.actorShield.shiledValue > 0;
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEndEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEndEvent && sender == _actor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515842, out var _) && adventureActorCastSkillEndEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
			{
				_actor.buffComponent.RemoveBuffByBuffId(15842011);
			}
			OnSelfCastSkillEnd(adventureActorCastSkillEndEvent);
		}
	}

	protected virtual void OnSelfCastSkillEnd(AdventureActorCastSkillEndEvent skillEndEvent)
	{
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent)
		{
			if (adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor)
			{
				OnSelfAttacked(adventureActorReceiveAttackEvent);
			}
			else if (adventureActorReceiveAttackEvent.to == _actor)
			{
				OnSelfBeAttacked(adventureActorReceiveAttackEvent);
			}
		}
	}

	protected virtual void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	protected virtual void OnSelfBeAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent && adventureActorReceiveDamageBeforeHitEvent.from == _actor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
			{
				AdventureActor.AddFromAttr(15896511, _actor);
			}
			OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to } adventureActorReceiveDamageEvent))
		{
			return;
		}
		PlayerAdventureActor summoner;
		if (adventureActorReceiveDamageEvent.from == _actor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515842, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_P42))
			{
				_actor.buffComponent.AddBuff(15842011, _actor);
			}
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			MarkLogic(to, adventureActorReceiveDamageEvent.hitDamageTag);
		}
		else if (adventureActorReceiveDamageEvent.from.IsPlayerMinion(out summoner) && summoner == _actor)
		{
			OnSelfMinionDamaged(adventureActorReceiveDamageEvent);
			MarkLogic(to, adventureActorReceiveDamageEvent.hitDamageTag);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnSelfMinionDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private void MarkLogic(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		List<int> damageTag_AddFireMark = _damageTag_AddFireMark;
		if (damageTag_AddFireMark != null && damageTag_AddFireMark.Count > 0)
		{
			foreach (int item in _damageTag_AddFireMark)
			{
				if (CommonUtils.CheckHitByTag(hitDamageTag, item))
				{
					monster.buffComponent.AddBuff(1011, _actor);
					break;
				}
			}
		}
		if (CheckCanTriggerFireMark(monster, hitDamageTag))
		{
			TriggerFireMark(monster, hitDamageTag);
		}
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
					hitDamageId = 158000001,
					hitFlags = HitBox.FeatureFlag.Stiff,
					hitFeatureData = _featureData_FireMark,
					damageImmuneDuration = -1
				};
			}
			_areaHitConfig_FireMark.position = monster.tsTransform.Position;
			ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig_FireMark, Config.hitRadius_FireMark, 0);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Fire, HotfixEnum.AdventureActorElementTriggerType.FireElementTriggerType2, _actor, monster, "FireMark_Trigger_Effect_02");
			OnTriggerFireMark(hitDamageTag);
		}
	}

	protected virtual void OnTriggerFireMark(IList<int> hitDamageTag)
	{
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.FE)
		{
			_actor.buffComponent?.AddBuff(15896211, _actor);
			_summonedController.AddBuffToMinion(15896221);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_START_FINISH", OnLevelStartFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_summonedController.OnDisable();
		_summonedController = null;
		HaveShield = false;
	}
}
