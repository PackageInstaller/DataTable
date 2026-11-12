using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10801;

public class ParallelScript : ParallelBase
{
	protected static readonly int damageTag_UltraSkill = CommonHelper.StringToHash("108_Ultra");

	private static readonly int triggerDamageTag_FireMark = CommonHelper.StringToHash("FireTag1_Trigger");

	private const int hitDamageId_FireMark = 108000001;

	private static readonly FP hitRadius_FireMark = 6;

	private const string hitFxPath_FireMark = "FX/ActorCommon/fx_common_buff_typel_fire_stamp_burst_6m";

	private const string hittedFxPath_FireMark = "fx_10801_hit_common_middle";

	private static readonly FP stiffDuration_FireMark = 0.5f;

	private static readonly FP hitStrenth_FireMark = 1;

	private const string tipsKey_TriggerMark = "FireMark_Trigger_Effect_01";

	private const int perkId_41 = 510841;

	private const int buffId_41 = 10854101;

	private const int perkId_42 = 510842;

	private static readonly int damageTag_42 = CommonHelper.StringToHash("108_Ultra_Last");

	private const int additionalAttrId_42 = 10854201;

	private const int perkId_43 = 510843;

	private const int buffId_43 = 10854301;

	public static readonly int damageTag_Trigger_D1 = CommonHelper.StringToHash("108_Ultra");

	public const int parameterId_D1 = 10896111;

	public const int buffId_D1 = 10896111;

	public static readonly int damageTag_Trigger_D2 = CommonHelper.StringToHash("108_Skill");

	public const int additionalAttrId_D2 = 10896211;

	public const int parameterId_D3 = 10896311;

	public const int buffId_D3 = 10896311;

	public static readonly int damageTag_Trigger_D4 = CommonHelper.StringToHash("108_Skill");

	public const int buffId_D4 = 10896411;

	public const int parameterId_D4 = 10896411;

	public const int buffId_D5 = 10896511;

	protected PlayerSkillCd _playerSkillCd;

	protected List<int> _damageTag_TriggerFireMark;

	private CommomAreaHitConfig _areaHitConfig_FireMark;

	private HitBox.HitBoxFeatureData _featureData_FireMark;

	private FP _lastTriggerTime_D4;

	public override void OnEnable()
	{
		base.OnEnable();
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		if (_damageTag_TriggerFireMark == null)
		{
			_damageTag_TriggerFireMark = new List<int>();
		}
		else
		{
			_damageTag_TriggerFireMark.Clear();
		}
		_damageTag_TriggerFireMark.Add(triggerDamageTag_FireMark);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		AdventureActor adventureActor = adventureActorCastSkillEvent.sender as AdventureActor;
		if (!(adventureActor is PlayerAdventureActor))
		{
			return;
		}
		if (adventureActor == _actor)
		{
			if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
			{
				OnCastNormalSkill(adventureActorCastSkillEvent);
			}
			else if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
			{
				OnCastSkill(adventureActorCastSkillEvent);
			}
		}
		else if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5))
		{
			_actor.buffComponent.AddBuff(10896511, _actor);
		}
	}

	protected virtual void OnCastNormalSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		AdventureActor adventureActor = adventureActorCastSkillEndEvent.sender as AdventureActor;
		if (adventureActor is PlayerAdventureActor && adventureActor == _actor && adventureActorCastSkillEndEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5))
		{
			_actor.buffComponent.RemoveBuffByBuffId(10896511);
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, damageTag_UltraSkill) && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510841, out var _))
			{
				monsterAdventureActor.buffComponent.AddBuff(10854101, _actor);
			}
			OnSelfAttacked(adventureActorReceiveAttackEvent);
		}
	}

	protected virtual void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor) || !(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor target))
		{
			return;
		}
		OnBeforePlayerHit(adventureActorReceiveDamageBeforeHitEvent);
		if (adventureActorReceiveDamageBeforeHitEvent.from == _actor)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510842, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, damageTag_42))
			{
				AdventureActor.AddFromAttr(10854201, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, damageTag_Trigger_D2) && CommonUtils.CheckElementMark(CommonDefine.FireMark1, target))
			{
				AdventureActor.AddFromAttr(10896211, _actor);
			}
			OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnBeforePlayerHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from is PlayerAdventureActor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster) || !(adventureActorReceiveDamageEvent.from == _actor))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_Trigger_D1) && TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, 10896111))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(10896111, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, 10896311))
		{
			foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL2.buffComponent.AddBuff(10896311, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4) && (_lastTriggerTime_D4 <= 0 || _actor.LogicTime - _lastTriggerTime_D4 > CommonUtils.GetScriptValue(_actor, 10896411)) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_Trigger_D4))
		{
			_actor.buffComponent.AddBuff(10896411, _actor);
			_lastTriggerTime_D4 = _actor.LogicTime;
		}
		OnSelfDamaged(adventureActorReceiveDamageEvent);
		if (CheckCanTriggerFireMark(monster, adventureActorReceiveDamageEvent.hitDamageTag))
		{
			TriggerFireMark(monster);
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
		if (CommonUtils.CheckElementMark(CommonDefine.FireMark1, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
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

	private void TriggerFireMark(MonsterAdventureActor monster)
	{
		if (!(monster == null))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.FireMark1);
			if (_featureData_FireMark == null)
			{
				_featureData_FireMark = new HitBox.HitBoxFeatureData
				{
					StiffDuration = stiffDuration_FireMark,
					hitStrenth = hitStrenth_FireMark
				};
			}
			if (_areaHitConfig_FireMark == null)
			{
				_areaHitConfig_FireMark = new CommomAreaHitConfig
				{
					fxAlias = "FX/ActorCommon/fx_common_buff_typel_fire_stamp_burst_6m",
					hittedEffectAlias = "fx_10801_hit_common_middle",
					hitDamageId = 108000001,
					hitFlags = HitBox.FeatureFlag.Stiff,
					hitFeatureData = _featureData_FireMark,
					damageImmuneDuration = -1
				};
			}
			_areaHitConfig_FireMark.position = monster.tsTransform.Position;
			ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig_FireMark, hitRadius_FireMark, 0);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.FireMark1, HotfixEnum.AdventureActorElementTriggerType.FireElementTriggerType1, _actor, monster, "FireMark_Trigger_Effect_01");
			OnTriggerFireMark();
		}
	}

	protected virtual void OnTriggerFireMark()
	{
	}

	private void OnDied(IEvent evt)
	{
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (adventureActorDiedEvent.killer == _actor && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510843, out var _) && adventureActorDiedEvent.damageTag != null && CommonUtils.CheckHitByTag(adventureActorDiedEvent.damageTag, damageTag_UltraSkill))
		{
			_actor.buffComponent.AddBuff(10854301, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		_lastTriggerTime_D4 = 0;
	}
}
