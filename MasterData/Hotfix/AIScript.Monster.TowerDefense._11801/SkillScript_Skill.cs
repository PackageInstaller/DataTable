using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11801;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private FP searchRange = 6.5;

	private static readonly string actionTag_1 = "Skill_1";

	private static readonly string actionTag_2 = "Skill_2";

	private string evt_jump1 = "evt_jump1";

	private string evt_jump2 = "evt_jump2";

	private FP jumpDistance = 3;

	private FP jumpDuration = 0.15;

	private static readonly int hitTag_P2 = CommonHelper.StringToHash("Skill_4");

	private static readonly int hitTag_1 = CommonHelper.StringToHash("Skill_1");

	private static readonly int hitTag_2 = CommonHelper.StringToHash("Skill_2");

	private static readonly string linkEffectAlias = "fx_11801_loop_ZhanHun_line";

	private static readonly string linkBrokenEventName = "Skill_2_CheDuan";

	private static readonly string linkBrokenEffectAlias = "fx_11801_base_ZhanHun_hit_02";

	private static readonly int hitDamageId_2 = 80118022;

	private static readonly FP moveSpeed = 15f;

	private static readonly int moveStrength = 3;

	private static readonly FP moveDistance = 6;

	private const int perkId_1 = 1180101;

	private int stength_1 = 1;

	private int hitDmgId_1 = 80118025;

	private const int perkId_2 = 1180102;

	private static readonly string actionTag_1_perk21 = "Skill_1_P2";

	private int count_2 = 3;

	private const int searchRange_2 = 3;

	private const int perkId_3 = 1180103;

	private int count_3 = 3;

	private static readonly string actionTag_3_perk25 = "Skill_3";

	private const int perkId_4 = 1180104;

	private static readonly int hitCount = 3;

	private static readonly string enhanceLinkEffectAlias = "fx_11801_loop_P28_Line";

	private readonly int additionalAttrId_perk_28 = 811180001;

	private CoroutineNode corMain;

	private int _hitTag_1_hitCount;

	private readonly Dictionary<LogicEntity, PlayFX> _linkFxDict = new Dictionary<LogicEntity, PlayFX>();

	private readonly Dictionary<LogicEntity, PlayFX> _linkFxDictP2 = new Dictionary<LogicEntity, PlayFX>();

	private CoroutineNode _continueCheckTargetAliveNode;

	private TSVector2 orginalPos;

	private TSVector2 targetPos;

	private LogicEntity target;

	private List<LogicEntity> entities = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		StartCoroutine(ref _continueCheckTargetAliveNode, ContinueCheckTargetAlive());
		orginalPos = _actor.tsTransform.Position;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		if (_linkFxDict.Count > 0)
		{
			foreach (LogicEntity key in _linkFxDict.Keys)
			{
				if (key != null && key is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive)
				{
					int hitDamageId = (GetPerk(1180101) ? hitDmgId_1 : hitDamageId_2);
					ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId, linkBrokenEffectAlias);
				}
			}
		}
		if (_linkFxDictP2.Count > 0)
		{
			foreach (LogicEntity key2 in _linkFxDictP2.Keys)
			{
				if (key2 != null && key2 is AdventureActor adventureActor2 && adventureActor2.actorHealthInfo.isAlive)
				{
					int hitDamageId2 = (GetPerk(1180101) ? hitDmgId_1 : hitDamageId_2);
					ILRuntimeAPI.HitActor(_actor, adventureActor2, hitDamageId2, linkBrokenEffectAlias);
				}
			}
		}
		ClearFxs();
		_linkFxDict.Clear();
		_linkFxDictP2.Clear();
		_hitTag_1_hitCount = 0;
		StopCoroutine(ref _continueCheckTargetAliveNode);
		entities.Clear();
		target = null;
		if (_actor.tsTransform.Position != orginalPos)
		{
			_actor.Teleport(orginalPos);
		}
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void ClearFxs()
	{
		foreach (PlayFX value in _linkFxDict.Values)
		{
			value.Stop();
			value.Clear();
		}
		foreach (PlayFX value2 in _linkFxDictP2.Values)
		{
			value2.Stop();
			value2.Clear();
		}
	}

	private void DoMainLogic()
	{
		FP range = (GetPerk(1180102) ? (searchRange + 3) : searchRange);
		CommonUtils.SearchNearTargetsByCircleInTD(_actor, _actor.tsTransform.Position, range, entities, isConfront: true);
		if (entities.Count > 0)
		{
			target = entities.get_Item(0);
		}
		string actionTag = (GetPerk(1180102) ? actionTag_1_perk21 : actionTag_1);
		if (target != null)
		{
			_actor.LookAt(target.tsTransform.Position, 0);
		}
		Action<string> onCustomEvent = OnCustom;
		System.Action onRecoveryBegin = OnPhase1Finish;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from is TowerDefenseCharacterActor towerDefenseCharacterActor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor && towerDefenseCharacterActor == _actor && GetPerk(1180104) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_2) && _linkFxDict.Count + _linkFxDictP2.Count >= 3)
		{
			AdventureActor.AddFromAttr(additionalAttrId_perk_28, _actor);
		}
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from is TowerDefenseCharacterActor towerDefenseCharacterActor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor) || !(towerDefenseCharacterActor == _actor))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_1))
		{
			if (!adventureActorReceiveDamageEvent.isKill)
			{
				string fxAlias = linkEffectAlias;
				if (GetPerk(1180104) && adventureActorReceiveDamageEvent.onceAttackTargetCount >= hitCount)
				{
					fxAlias = enhanceLinkEffectAlias;
				}
				if (!_linkFxDictP2.ContainsKey(monsterAdventureActor))
				{
					PlayFX playFX = new PlayFX();
					playFX.PlayLinFx(_actor, fxAlias, 1f, useCustSource: false, null, default, default, monsterAdventureActor.gameObject, default, default);
					_linkFxDict.set_Item((LogicEntity)monsterAdventureActor, playFX);
				}
			}
			if (GetPerk(1180103))
			{
				_hitTag_1_hitCount++;
			}
		}
		else if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_P2) && !_linkFxDict.ContainsKey(monsterAdventureActor) && _linkFxDictP2.Count < count_2)
		{
			if (GetPerk(1180103))
			{
				_hitTag_1_hitCount++;
			}
			string fxAlias2 = linkEffectAlias;
			PlayFX playFX2 = new PlayFX();
			playFX2.PlayLinFx(_actor, fxAlias2, 1f, useCustSource: false, null, default, default, monsterAdventureActor.gameObject, default, default);
			_linkFxDictP2.set_Item((LogicEntity)monsterAdventureActor, playFX2);
		}
	}

	private IEnumerator ContinueCheckTargetAlive()
	{
		while (true)
		{
			foreach (LogicEntity key in _linkFxDict.Keys)
			{
				if (key != null && key is AdventureActor adventureActor && !adventureActor.actorHealthInfo.isAlive && _linkFxDict.TryGetValue(key, out var value) && value.GetFxPlayerToken() != 0L)
				{
					value.Stop();
					value.Clear();
				}
			}
			foreach (LogicEntity key2 in _linkFxDictP2.Keys)
			{
				if (key2 != null && key2 is AdventureActor adventureActor2 && !adventureActor2.actorHealthInfo.isAlive && _linkFxDictP2.TryGetValue(key2, out var value2) && value2.GetFxPlayerToken() != 0L)
				{
					value2.Stop();
					value2.Clear();
				}
			}
			yield return null;
		}
	}

	private void OnPhase1Finish()
	{
		string actionTag = actionTag_2;
		Action<string> onCustomEvent = OnCustom;
		System.Action onComboFinish = OnPhase2Finish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: true);
	}

	private void OnCustom(string eventName)
	{
		if (eventName.Equals(linkBrokenEventName))
		{
			int num = moveStrength;
			if (GetPerk(1180101))
			{
				num += stength_1;
			}
			foreach (LogicEntity key in _linkFxDict.Keys)
			{
				if (key != null && key is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive)
				{
					int hitDamageId = (GetPerk(1180101) ? hitDmgId_1 : hitDamageId_2);
					ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId, linkBrokenEffectAlias);
					ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, _actor.tsTransform.Position, key, moveDistance, moveSpeed, num, 99, isPull: true, withRadius: false, isCoExist: true, isChangeForward: false);
				}
			}
			foreach (LogicEntity key2 in _linkFxDictP2.Keys)
			{
				if (key2 != null && key2 is AdventureActor adventureActor2 && adventureActor2.actorHealthInfo.isAlive)
				{
					int hitDamageId2 = (GetPerk(1180101) ? hitDmgId_1 : hitDamageId_2);
					ILRuntimeAPI.HitActor(_actor, adventureActor2, hitDamageId2, linkBrokenEffectAlias);
					ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, _actor.tsTransform.Position, key2, moveDistance, moveSpeed, num, 99, isPull: true, withRadius: false, isCoExist: true, isChangeForward: false);
				}
			}
			ClearFxs();
			_linkFxDict.Clear();
			_linkFxDictP2.Clear();
		}
		else if (eventName.Equals(evt_jump1))
		{
			targetPos = _actor.tsTransform.Position + _actor.tsTransform.Forward * jumpDistance;
			FP speed = jumpDistance / jumpDuration;
			_actor.Jump(targetPos, speed, jumpDuration, null, comboWithAttack: true, forbiddenHeight: true, checkPositionReachable: false);
		}
		else if (eventName.Equals(evt_jump2))
		{
			FP speed2 = jumpDistance / jumpDuration;
			_actor.Jump(orginalPos, speed2, jumpDuration, null, comboWithAttack: true, forbiddenHeight: true, checkPositionReachable: false);
		}
	}

	private void OnPhase2Finish()
	{
		if (GetPerk(1180103) && _hitTag_1_hitCount <= count_3)
		{
			string actionTag = actionTag_3_perk25;
			System.Action onComboFinish = SkillFinish;
			System.Action onInterrupt = SkillInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			SkillFinish();
		}
	}
}
