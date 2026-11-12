using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._10801;

public class ParallelScript_MainControl : ParallelScript
{
	private static readonly int damageTag_NormalAttack = CommonHelper.StringToHash("108_Attack");

	private static readonly int damageTag_DefaultNormalAttack = CommonHelper.StringToHash("108_Bullet");

	private static readonly int damageTag_SpecialNormalAttack = CommonHelper.StringToHash("108_FireBullet");

	private static readonly int damageTag_MainControl = CommonHelper.StringToHash("108_Main");

	private const int perkId_3 = 510803;

	private const int skillTotalSectionAmount_3 = 5;

	private const int perkId_5 = 510805;

	private const int additionalAttrId_5 = 10850501;

	private const int perkId_6 = 510806;

	private readonly FP cd_6 = 4;

	private const int perkId_7 = 510807;

	private const int triggerCritTimes_7 = 10;

	private const int buffId_7 = 10850711;

	private const int perkId_8 = 510808;

	private const int buffId_8 = 10850801;

	private const int perkId_10 = 510810;

	private const int triggerTimes_10 = 6;

	private const int parameterId_10 = 10851001;

	private const int additionalAttrId_10 = 10851001;

	private const int perkId_11 = 510811;

	private const int parameterId_11 = 10851111;

	private const int additionalAttrId_11 = 10851101;

	private const int perkId_12 = 510812;

	private readonly FP triggerDistance_12 = 4;

	private const int additionalAttrId_12 = 10851201;

	private const int perkId_13 = 510813;

	private const int buffId_13 = 10851301;

	private int _additionalAttrCount_5;

	private FP _lastTriggerTime_6;

	private int _triggerCritTimes_7;

	private int _triggerTimes_10;

	public override void OnEnable()
	{
		base.OnEnable();
		Clear();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510803, out var perkLevel))
		{
			_playerSkillCd.SetSkillTotalSection(ActionKey.B, 5, forceMaxSection: true);
		}
		else
		{
			_playerSkillCd.ResetSkillTotalSection(ActionKey.B);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510813, out perkLevel))
		{
			_damageTag_TriggerFireMark?.Add(ParallelScript.damageTag_UltraSkill);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("KASIMIRA_NORMALATTACK_FINISH", OnNormalAttackFinish);
	}

	protected override void OnCastNormalSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastNormalSkill(castSkillEvent);
		_additionalAttrCount_5 = 0;
	}

	private void OnNormalAttackFinish(IEvent evt)
	{
		KasimiraNormalAttackFinishEvent obj = evt as KasimiraNormalAttackFinishEvent;
		_actor.logicVariable.ToggleLogicTag("TriggerPerk_1", value: false);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510806, out var perkLevel) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_6"))
		{
			_lastTriggerTime_6 = _actor.LogicTime;
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_6", value: false);
		}
		if (obj.isSpecial && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510810, out perkLevel))
		{
			_triggerTimes_10++;
			if (_triggerTimes_10 >= 6)
			{
				FP scriptValue = CommonUtils.GetScriptValue(_actor, 10851001);
				_playerSkillCd.ModifyResumeTimeAbs(-scriptValue, ActionKey.B);
				_triggerTimes_10 = 0;
			}
		}
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastSkill(castSkillEvent);
		_actor.logicVariable.ToggleLogicTag("TriggerPerk_1", value: true);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510806, out var _) && (_lastTriggerTime_6 <= 0 || _actor.LogicTime - _lastTriggerTime_6 > cd_6))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_6", value: true);
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		MonsterAdventureActor monsterAdventureActor = attackEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510805, out var perkLevel) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, damageTag_MainControl))
		{
			_additionalAttrCount_5++;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510808, out perkLevel) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, damageTag_SpecialNormalAttack))
		{
			monsterAdventureActor.buffComponent.AddBuff(10850801, _actor);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor aEntity = beforeHitEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510805, out var perkLevel) && _additionalAttrCount_5 > 0 && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_MainControl))
		{
			AdventureActor.AddFromAttr(10850501, _actor, _additionalAttrCount_5);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510810, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_SpecialNormalAttack))
		{
			AdventureActor.AddFromAttr(10851001, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510811, out perkLevel))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 10851111);
			if (_actor.actorHealthInfo.hpPercentage * 100 > scriptValue)
			{
				AdventureActor.AddFromAttr(10851101, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510812, out perkLevel) && beforeHitEvent.elementType == HotfixEnum.elementType.FE && aEntity.DistanceWithRadius(_actor) < triggerDistance_12)
		{
			AdventureActor.AddFromAttr(10851201, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510807, out var _) && damageEvent.isCrit)
		{
			_triggerCritTimes_7++;
			if (_triggerCritTimes_7 >= 10)
			{
				_actor.buffComponent.AddBuff(10850711, _actor);
				_triggerCritTimes_7 = 0;
			}
		}
	}

	protected override void OnTriggerFireMark()
	{
		base.OnTriggerFireMark();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510813, out var _))
		{
			_actor.buffComponent.AddBuff(10851301, _actor);
		}
	}

	private void Clear()
	{
		_additionalAttrCount_5 = 0;
		_lastTriggerTime_6 = 0;
		_triggerCritTimes_7 = 0;
		_triggerTimes_10 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("KASIMIRA_NORMALATTACK_FINISH", OnNormalAttackFinish);
		Clear();
	}
}
