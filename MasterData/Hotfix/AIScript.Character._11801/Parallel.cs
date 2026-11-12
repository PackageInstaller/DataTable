#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11801;

public class Parallel : ParallelBase
{
	private readonly int hitTag_ultra = CommonHelper.StringToHash("118_Ultra_Atk");

	private readonly int hitTag_sickle = CommonHelper.StringToHash("118_FeiLian_Atk");

	private readonly int hitTag_mainControl_skill = CommonHelper.StringToHash("118_Main_Atk");

	private readonly int hitTag_support_skill_common = CommonHelper.StringToHash("118_Sup_Atk");

	private readonly int hitTag_support_skill_1 = CommonHelper.StringToHash("118_Sup_HengZhan_Hit_1");

	private readonly int hitTag_support_skill_2 = CommonHelper.StringToHash("118_Sup_HengZhan_Hit_2");

	private readonly int hitTag_support_skill_heng_common = CommonHelper.StringToHash("118_Sup_HengZhan_Common");

	private readonly FP normalAttackComboInterval = 1;

	private readonly int addDarkMarkHitTag = CommonHelper.StringToHash("118_AddDarkMark1");

	private readonly int darkMarkBuffId = 5011;

	private readonly int triggerDarkMarkHitTag = CommonHelper.StringToHash("118DarkTagBoom");

	private readonly int darkMarkHitDamageId = 118000001;

	private readonly string darkMarkHitEffectAlias = "fx_11801_base_DarkTagTrigger_Buff_01";

	private readonly int darkMarkHitBuffId_1 = 5031;

	private readonly int darkMarkHitBuffId_2 = 5041;

	private readonly int lockedTag = CommonHelper.StringToHash("DarkAnSuo");

	private readonly string triggerDarkMarkTipKey = "DarkMark_Trigger_Effect_05";

	private readonly int hitTag_ultra_spinningBlade = CommonHelper.StringToHash("118_Ultra_Atk_1");

	private readonly FP rate_fate1 = 1;

	private readonly FP cd_fate1 = 0.5;

	private readonly string bulletAlias_fate1 = "Actor/Character/11801/Weapons/Bullet_118_FeiLian_H1";

	private readonly FP bulletHeight_fate1 = 1.5;

	private readonly int perkId_1 = 511801;

	private readonly int buffId_perk_1 = 11801011;

	private readonly int perkId_2 = 511802;

	private readonly int additionalAttrId_perk_2 = 11802011;

	private readonly int perkId_3 = 511803;

	private readonly int buffId_perk_3 = 11890001;

	private readonly int addBuffCount_perk_3 = 2;

	private readonly int additionalAttrId_perk_3 = 11803011;

	private readonly int perkId_4 = 511804;

	private readonly int additionalAttrId_perk_4 = 11804011;

	private readonly int perkId_5 = 511805;

	private readonly int buffId_perk_5 = 11805011;

	private readonly int perkId_6 = 511806;

	private readonly int additionalAttrId_perk_6 = 11806001;

	private readonly int perkId_7 = 511807;

	private readonly int additionalAttrId_perk_7 = 11807001;

	private readonly int additionalAttr_max_perk_7 = 3;

	private readonly FP detectRadius_perk_7 = 6;

	private readonly int perkId_8 = 511808;

	private readonly int buffId_perk_8 = 11808011;

	private readonly string areaEffectAlias_perk_8 = "AreaEffect_118_P8_YaoShui";

	private readonly int perkId_9 = 511809;

	private readonly int buffId_perk_9 = 11809011;

	private readonly int perkId_10 = 511810;

	private readonly int buffId_perk_10 = 11810011;

	private readonly int perkId_11 = 511811;

	private readonly int buffId_perk_11 = 11811011;

	private readonly int perkId_12 = 511812;

	private readonly int perkId_13 = 511813;

	private readonly int buffId_perk_13 = 11813011;

	private readonly int addSkillSection_perk_13 = 1;

	private readonly int perkId_21 = 511821;

	private readonly int additionalAttrId_perk_21 = 11821011;

	private readonly int perkId_22 = 511822;

	private readonly int additionalAttrId_perk_22 = 11822011;

	private readonly int perkId_23 = 511823;

	private readonly FP rate_perk_23 = 0.5f;

	private readonly string dropItemAlias_23 = "Item_118_P23_YaoShui";

	private readonly int perkId_24 = 511824;

	private readonly FP areaEffectDelay_24 = 0.5f;

	private readonly string areaEffectAlias_24 = "AreaEffect_118_P24_YaoShui";

	private readonly int perkId_25 = 511825;

	private readonly int additionalAttrId_perk_25 = 11825001;

	private readonly int perkId_26 = 511826;

	private readonly int buffId_perk_26 = 11826011;

	private readonly int perkId_27 = 511827;

	private readonly int buffId_perk_27 = 11827011;

	private readonly int perkId_29 = 511829;

	private readonly int additionalAttrId_29 = 11829001;

	private readonly int perkId_30 = 511830;

	private readonly int buffId_perk_30 = 11830011;

	private readonly int perkId_31 = 511831;

	private readonly int buffId_perk_31 = 11831011;

	private readonly int perkId_32 = 511832;

	private readonly FP rate_perk_32 = 1;

	private readonly FP cd_perk_32 = 12;

	private readonly int scriptId_perk_32 = 11832011;

	private readonly int buffId_perk_32 = 11832011;

	private readonly int perkId_33 = 511833;

	private readonly int buffId_perk_33 = 11833011;

	private readonly int perkId_41 = 511841;

	private readonly FP lastHitCheckRadius_ultra = 6;

	private readonly int additionalAttrId_41 = 11841001;

	private readonly int maxAdditionalAttrCount_41 = 3;

	private readonly int hitTag_ultra_horizontalSlash = CommonHelper.StringToHash("118_Ultra_Atk_2");

	private readonly int additionalAttrId_Toughness_41 = 11841012;

	private readonly int perkId_42 = 511842;

	private readonly int buffId_42 = 11842011;

	private readonly int perkId_43 = 511843;

	private readonly int additionalAttrId_43 = 11843001;

	private readonly int buffId_talent_1 = 11896111;

	private readonly int additionalAttrId_talent_x = 11896211;

	private readonly int additionalAttrId_talent_y = 11896221;

	private readonly int buffId_talent_3 = 11896311;

	private readonly int buffId_talent_4 = 11896411;

	private readonly int additionalAttrId_talent_5 = 11896511;

	private CoroutineNode _normalAttackComboBreakNode;

	private FP _fate1TriggerTime;

	private readonly List<LogicEntity> _hitTargets = new List<LogicEntity>();

	public override void OnEnable()
	{
		base.OnEnable();
		NovaLogger.Debug("11801 Parallel OnEnable");
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfectDodge);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_1, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(buffId_perk_1, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_5, out perkLevel))
		{
			_actor.buffComponent.AddBuff(buffId_perk_5, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_8, out perkLevel))
		{
			_actor.buffComponent.AddBuff(buffId_perk_8, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_11, out perkLevel))
		{
			_actor.buffComponent.AddBuff(buffId_perk_11, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_13, out perkLevel))
		{
			(_actor as PlayerAdventureActor).playerSkillCd?.AddSkillTotalSection(ActionKey.A, addSkillSection_perk_13);
			(_actor as PlayerAdventureActor).playerSkillCd?.AddSkillSection(ActionKey.A, addSkillSection_perk_13);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_31, out perkLevel))
		{
			_actor.buffComponent.AddBuff(buffId_perk_31, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_32, out perkLevel))
		{
			_actor.buffComponent.AddBuff(buffId_perk_32, _actor);
		}
		if (!ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_33, out perkLevel))
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				actorL.buffComponent.AddBuff(buffId_perk_33, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		NovaLogger.Debug("11801 Parallel OnDisable");
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		StopCoroutine(ref _normalAttackComboBreakNode);
		_fate1TriggerTime = 0;
		_hitTargets.Clear();
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor == null || adventureActorReceiveDamageBeforeHitEvent.from == null || adventureActorReceiveDamageBeforeHitEvent.hitDamageTag == null || _actor.Id != adventureActorReceiveDamageBeforeHitEvent.from.Id || !(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_41, out var perkLevel))
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_ultra))
			{
				AdventureActor.AddFromAttr(additionalAttrId_Toughness_41, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_ultra_horizontalSlash))
			{
				ILRuntimeAPI.SearchByRange(_actor, lastHitCheckRadius_ultra, (List<LogicEntity> result) =>
				{
					int num2 = Mathf.Clamp(result.Count, 0, maxAdditionalAttrCount_41);
					if (num2 > 0)
					{
						AdventureActor.AddFromAttr(additionalAttrId_41, _actor, num2);
					}
				}, isConfront: true);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_43, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_ultra) && monsterAdventureActor.monsterToughnessInfo.haveToughness && monsterAdventureActor.monsterToughnessInfo.toughness > 0)
		{
			AdventureActor.AddFromAttr(additionalAttrId_43, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_2, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_mainControl_skill))
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("skill_mainControl_attackCount");
			for (int num = 0; num < logicTagValue; num++)
			{
				AdventureActor.AddFromAttr(additionalAttrId_perk_2, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_6, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_mainControl_skill) && monsterAdventureActor.CheckTag(lockedTag))
		{
			AdventureActor.AddFromAttr(additionalAttrId_perk_6, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_7, out perkLevel))
		{
			ILRuntimeAPI.SearchByRange(_actor, detectRadius_perk_7, (List<LogicEntity> result) =>
			{
				int num2 = 0;
				foreach (LogicEntity item in result)
				{
					if (item is MonsterAdventureActor monsterAdventureActor2 && monsterAdventureActor2.CheckTag(lockedTag))
					{
						num2++;
					}
				}
				num2 = Mathf.Clamp(num2, 0, additionalAttr_max_perk_7);
				if (num2 > 0)
				{
					AdventureActor.AddFromAttr(additionalAttrId_perk_7, _actor, num2);
				}
			}, isConfront: true);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_21, out perkLevel) && (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_sickle) || CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_support_skill_heng_common)))
		{
			AdventureActor.AddFromAttr(additionalAttrId_perk_21, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_22, out perkLevel) && (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_sickle) || CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_support_skill_heng_common)))
		{
			AdventureActor.AddFromAttr(additionalAttrId_perk_22, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_25, out perkLevel) && (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_sickle) || CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_support_skill_heng_common)))
		{
			AdventureActor.AddFromAttr(additionalAttrId_perk_25, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_27, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_support_skill_heng_common) && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LORD || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LEADER))
		{
			_actor.buffComponent.AddBuff(buffId_perk_27, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_29, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_support_skill_2))
		{
			AdventureActor.AddFromAttr(additionalAttrId_29, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_30, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_support_skill_2))
		{
			monsterAdventureActor.buffComponent.AddBuff(buffId_perk_30, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_32, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_support_skill_common) && CheckPerkCd(perkId_32, cd_perk_32) && TSRandom.Range(FP.Zero, FP.One) <= rate_perk_32)
		{
			long damage = (long)(CommonUtils.GetScriptValue(_actor, scriptId_perk_32) * monsterAdventureActor.monsterToughnessInfo.toughnessMax);
			monsterAdventureActor.monsterToughnessInfo.DamageToToughness(_actor, damage);
		}
		if (CheckTalentLevel(2) && (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_support_skill_common) || CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_mainControl_skill)))
		{
			AdventureActor.AddFromAttr((adventureActorReceiveDamageBeforeHitEvent.onceAttackTargetCount <= 1) ? additionalAttrId_talent_y : additionalAttrId_talent_x, _actor);
		}
		if (CheckTalentLevel(5) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
		{
			AdventureActor.AddFromAttr(additionalAttrId_talent_5, _actor);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor == null || adventureActorReceiveDamageEvent.from == null || adventureActorReceiveDamageEvent.hitDamageTag == null || _actor.Id != adventureActorReceiveDamageEvent.from.Id)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor == null)
		{
			return;
		}
		bool flag = false;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_31, out var perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_ultra))
		{
			flag = true;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, addDarkMarkHitTag) | flag)
		{
			monsterAdventureActor.buffComponent.AddBuff(darkMarkBuffId, _actor);
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_26, out perkLevel))
			{
				_actor.buffComponent.AddBuff(buffId_perk_26, _actor);
			}
		}
		bool flag2 = false;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_11, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_ultra))
		{
			flag2 = true;
		}
		if ((CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, triggerDarkMarkHitTag) | flag2) && CommonUtils.CheckElementMark(CommonDefine.DarkMark1, monsterAdventureActor) && CommonUtils.CheckTriggerElementMarkCD(_actor, monsterAdventureActor))
		{
			ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, darkMarkHitDamageId, darkMarkHitEffectAlias);
			monsterAdventureActor.buffComponent.AddBuff(darkMarkHitBuffId_1, _actor);
			monsterAdventureActor.buffComponent.AddBuff(darkMarkHitBuffId_2, _actor);
			monsterAdventureActor.buffComponent?.RemoveBuffByTag(CommonDefine.DarkMark1);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.DarkMark1, HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType2, _actor, monsterAdventureActor, triggerDarkMarkTipKey);
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_9, out perkLevel))
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_perk_9, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_8, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_sickle))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias_perk_8, monsterAdventureActor.tsTransform.Position);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_23, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_support_skill_heng_common) && TSRandom.Range(FP.Zero, FP.One) <= rate_perk_23)
		{
			ILRuntimeAPI.PlayDrop(_actor, dropItemAlias_23, monsterAdventureActor.tsTransform.Position);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_24, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_support_skill_2))
		{
			StartCoroutine(DelayPlayAreaEffect(monsterAdventureActor));
		}
	}

	private IEnumerator DelayPlayAreaEffect(AdventureActor target)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(areaEffectDelay_24));
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias_24, target.tsTransform.Position);
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor == null || adventureActorCastSkillEvent.sender != _actor)
		{
			return;
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.NORMAL && adventureActorCastSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.A)
		{
			_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		}
		else if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			StopCoroutine(ref _normalAttackComboBreakNode);
		}
		int perkLevel;
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_42, out perkLevel))
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent.AddBuff(buffId_42, _actor);
			}
			if (CheckTalentLevel(3))
			{
				foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
				{
					actorL.buffComponent.AddBuff(buffId_talent_3, _actor);
				}
			}
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_3, out perkLevel) && !(_actor as PlayerAdventureActor).isAssist)
		{
			for (int i = 0; i < addBuffCount_perk_3; i++)
			{
				_actor.buffComponent.AddBuff(buffId_perk_3, _actor);
			}
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_10, out perkLevel))
			{
				_actor.buffComponent.AddBuff(buffId_perk_10, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_13, out perkLevel))
			{
				_actor.buffComponent.AddBuff(buffId_perk_13, _actor);
			}
		}
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (!(_actor == null) && adventureActorCastSkillEndEvent.sender == _actor && adventureActorCastSkillEndEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			StartCoroutine(ref _normalAttackComboBreakNode, NormalAttackComboBreak());
		}
	}

	private void OnTriggerPerfectDodge(IEvent evt)
	{
		_ = (evt as AdventurePerfectDodgeTrigger).actor != _actor;
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (!(evt is AdventureElementMarkTriggerEvent { elementType: HotfixEnum.elementType.DE }))
		{
			return;
		}
		if (CheckTalentLevel(1))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(buffId_talent_1, _actor);
			}
		}
		if (CheckTalentLevel(4))
		{
			_actor.buffComponent.AddBuff(buffId_talent_4, _actor);
		}
	}

	private IEnumerator NormalAttackComboBreak()
	{
		yield return _actor.WaitTime(normalAttackComboInterval);
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
	}
}
