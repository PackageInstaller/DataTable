using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._118;

public class MainSkill : SkillAdvancedBase
{
	private const string actionTag = "MainSkill1";

	private const string actionTag_2 = "MainSkill2";

	private static readonly int hitTag_1 = CommonHelper.StringToHash("Skill_Soldier_118_Main");

	private const string linkEffectAlias = "fx_11801_loop_ZhanHun_line";

	private const string linkBrokenEventName = "118_Sup_CheDuan";

	private const string linkBrokenEffectAlias = "fx_11801_base_ZhanHun_hit_02";

	private const int hitDamageId_2 = 118000006;

	private const int buffId_2 = 111;

	private static readonly FP moveSpeed = 15f;

	private const int moveStrength = 3;

	private readonly Dictionary<LogicEntity, PlayFX> _linkFxDict = new Dictionary<LogicEntity, PlayFX>();

	private CoroutineNode _continueCheckTargetAliveNode;

	private int _potentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		if (_linkFxDict.Count > 0)
		{
			foreach (LogicEntity key in _linkFxDict.Keys)
			{
				if (key != null && key is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive)
				{
					ILRuntimeAPI.HitActor(_actor, adventureActor, 118000006, "fx_11801_base_ZhanHun_hit_02");
					adventureActor.buffComponent.AddBuff(111, _actor);
				}
			}
		}
		ClearFxs();
		_linkFxDict.Clear();
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

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		if (_potentialLv >= 2)
		{
			Action<string> onCustomEvent = OnCustom;
			Action onRecoveryBegin = OnPhase1Finish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("MainSkill1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, onRecoveryBegin, null, onInterrupt, onCustomEvent);
		}
		else
		{
			Action<string> onCustomEvent = OnCustom;
			Action onInterrupt = OnFinish;
			Action onRecoveryBegin = OnInterrupt;
			BeginAttack("MainSkill1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onInterrupt, onRecoveryBegin, onCustomEvent);
		}
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		if (_potentialLv < 2 || !(evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent) || _actor == null || adventureActorReceiveDamageEvent.from == null || adventureActorReceiveDamageEvent.hitDamageTag == null || _actor.Id != adventureActorReceiveDamageEvent.from.Id || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_1))
		{
			return;
		}
		SoldierActor soldierActor = adventureActorReceiveDamageEvent.to as SoldierActor;
		if (!(soldierActor == null))
		{
			if (!adventureActorReceiveDamageEvent.isKill)
			{
				PlayFX playFX = new PlayFX();
				playFX.PlayLinFx(_actor, "fx_11801_loop_ZhanHun_line", 1f, useCustSource: false, null, default, default, soldierActor.gameObject, default, default);
				_linkFxDict.set_Item((LogicEntity)soldierActor, playFX);
			}
			if (_linkFxDict.Count >= adventureActorReceiveDamageEvent.onceAttackTargetCount)
			{
				StartCoroutine(ref _continueCheckTargetAliveNode, ContinueCheckTargetAlive());
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
		Action<string> onCustomEvent = OnCustom;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill2", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: true);
	}

	private void OnCustom(string eventName)
	{
		if (!eventName.Equals("118_Sup_CheDuan"))
		{
			return;
		}
		foreach (LogicEntity key in _linkFxDict.Keys)
		{
			if (key != null && key is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive)
			{
				ILRuntimeAPI.HitActor(_actor, adventureActor, 118000006, "fx_11801_base_ZhanHun_hit_02");
				adventureActor.buffComponent.AddBuff(111, _actor);
				FP distance = ILRuntimeAPI.CalcDistanceBetweenTwoActor(_actor, adventureActor);
				ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, _actor.tsTransform.Position, key, distance, moveSpeed, 3, 99, isPull: true, withRadius: false, isCoExist: true, isChangeForward: false);
			}
		}
		ClearFxs();
		_linkFxDict.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}
}
