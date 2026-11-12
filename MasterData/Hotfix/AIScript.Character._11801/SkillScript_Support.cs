#define LOG_DEBUG
using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11801;

public class SkillScript_Support : SkillAdvancedBase
{
	private static readonly string actionTag_1 = "Skill_Sup_ZhanHun_1";

	private static readonly string actionTag_2 = "Skill_Sup_ZhanHun_2";

	private static readonly int hitTag_1 = CommonHelper.StringToHash("118_Sup_HengZhan_Hit_1");

	private static readonly int hitTag_2 = CommonHelper.StringToHash("118_Sup_HengZhan_Hit_2");

	private static readonly string linkEffectAlias = "fx_11801_loop_ZhanHun_line";

	private static readonly string linkBrokenEventName = "118_Sup_CheDuan";

	private static readonly string linkBrokenEffectAlias = "fx_11801_base_ZhanHun_hit_02";

	private static readonly int hitDamageId_2 = 118000009;

	private static readonly int buffId_2 = 5011;

	private static readonly FP moveSpeed = 15f;

	private static readonly int moveStrength = 3;

	private readonly int perkId_21 = 511821;

	private static readonly string actionTag_1_perk21 = "Skill_Sup_ZhanHun_1_P21";

	private static readonly string actionTag_3_perk21 = "Skill_Sup_P25_HuiKan_P21";

	private readonly int perkId_22 = 511822;

	private static readonly string actionTag_2_perk22 = "Skill_Sup_ZhanHun_2_P22";

	private readonly int perkId_25 = 511825;

	private static readonly string actionTag_3_perk25 = "Skill_Sup_P25_HuiKan";

	private readonly int perkId_28 = 511828;

	private static readonly int hitCount = 3;

	private static readonly string enhanceLinkEffectAlias = "fx_11801_loop_P28_Line";

	private readonly int maxAdditionalAttrCount_perk_28 = 1;

	private readonly int additionalAttrId_perk_28 = 11828001;

	private readonly int perkId_29 = 511829;

	private static readonly int moveStrength_29 = 5;

	private int _hitTag_1_hitCount;

	private int _onceAttrCount_perk_28;

	private readonly Dictionary<LogicEntity, PlayFX> _linkFxDict = new Dictionary<LogicEntity, PlayFX>();

	private CoroutineNode _continueCheckTargetAliveNode;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill OnDisable");
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		if (_linkFxDict.Count > 0)
		{
			foreach (LogicEntity key in _linkFxDict.Keys)
			{
				if (key != null && key is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive)
				{
					ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId_2, linkBrokenEffectAlias);
					adventureActor.buffComponent.AddBuff(buffId_2, _actor);
				}
			}
		}
		ClearFxs();
		_linkFxDict.Clear();
		_hitTag_1_hitCount = 0;
		_onceAttrCount_perk_28 = 0;
		StopCoroutine(ref _continueCheckTargetAliveNode);
	}

	private void ClearFxs()
	{
		foreach (PlayFX value in _linkFxDict.Values)
		{
			value.Stop();
			value.Clear();
		}
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill OnEnable");
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
	}

	public void OnStart()
	{
		NovaLogger.Debug("11801 Skill OnStart");
		string text = actionTag_1;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_21, out var _))
		{
			text = actionTag_1_perk21;
		}
		string actionTag = text;
		System.Action onRecoveryBegin = OnPhase1Finish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, onRecoveryBegin, null, onInterrupt);
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(_actor == null) && !(adventureActorReceiveDamageBeforeHitEvent.from == null) && adventureActorReceiveDamageBeforeHitEvent.hitDamageTag != null && _actor.Id == adventureActorReceiveDamageBeforeHitEvent.from.Id && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_28, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_2) && _onceAttrCount_perk_28 > 0)
		{
			AdventureActor.AddFromAttr(additionalAttrId_perk_28, _actor, _onceAttrCount_perk_28);
		}
	}

	private new void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor == null || adventureActorReceiveDamageEvent.from == null || adventureActorReceiveDamageEvent.hitDamageTag == null || _actor.Id != adventureActorReceiveDamageEvent.from.Id || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_1))
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (!(monsterAdventureActor == null))
		{
			string fxAlias = linkEffectAlias;
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_28, out var perkLevel) && adventureActorReceiveDamageEvent.onceAttackTargetCount >= hitCount)
			{
				fxAlias = enhanceLinkEffectAlias;
				_onceAttrCount_perk_28 = Mathf.Clamp(adventureActorReceiveDamageEvent.onceAttackTargetCount, 0, maxAdditionalAttrCount_perk_28);
			}
			if (!adventureActorReceiveDamageEvent.isKill)
			{
				PlayFX playFX = new PlayFX();
				playFX.PlayLinFx(_actor, fxAlias, 1f, useCustSource: false, null, default, default, monsterAdventureActor.gameObject, default, default);
				_linkFxDict.set_Item((LogicEntity)monsterAdventureActor, playFX);
			}
			if (_linkFxDict.Count >= adventureActorReceiveDamageEvent.onceAttackTargetCount)
			{
				StartCoroutine(ref _continueCheckTargetAliveNode, ContinueCheckTargetAlive());
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_25, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_1))
			{
				_hitTag_1_hitCount++;
			}
		}
	}

	private IEnumerator ContinueCheckTargetAlive()
	{
		while (true)
		{
			foreach (LogicEntity key in _linkFxDict.Keys)
			{
				if (key != null && key is AdventureActor adventureActor && !adventureActor.actorHealthInfo.isAlive && _linkFxDict.TryGetValue(key, out var value))
				{
					value.Stop();
					value.Clear();
				}
			}
			yield return null;
		}
	}

	private void OnPhase1Finish()
	{
		NovaLogger.Debug("11801 Skill phase1 onFinish");
		string text = actionTag_2;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_22, out var _))
		{
			text = actionTag_2_perk22;
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustom;
		System.Action onComboFinish = OnPhase2Finish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: true);
	}

	private void OnCustom(string eventName)
	{
		if (!eventName.Equals(linkBrokenEventName))
		{
			return;
		}
		int num = moveStrength;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_29, out var _))
		{
			num = moveStrength_29;
		}
		foreach (LogicEntity key in _linkFxDict.Keys)
		{
			if (key != null && key is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive)
			{
				ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId_2, linkBrokenEffectAlias);
				adventureActor.buffComponent.AddBuff(buffId_2, _actor);
				FP distance = ILRuntimeAPI.CalcDistanceBetweenTwoActor(_actor, adventureActor);
				ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, _actor.tsTransform.Position, key, distance, moveSpeed, num, 99, isPull: true, withRadius: false, isCoExist: true, isChangeForward: false);
			}
		}
		ClearFxs();
		_linkFxDict.Clear();
	}

	private void OnPhase2Finish()
	{
		NovaLogger.Debug("11801 Skill phase2 onFinish");
		if (_hitTag_1_hitCount == 1)
		{
			string text = actionTag_3_perk25;
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_21, out var _))
			{
				text = actionTag_3_perk21;
			}
			string actionTag = text;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			OnFinish();
		}
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11801 Skill onInterrupt");
		OnFinish();
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11801 Skill onFinish");
		_skill.Clear();
	}
}
