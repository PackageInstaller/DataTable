using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._11011ZhongYeJingYing;

public class Skill_FanSpray : SkillAdvancedBase
{
	protected const string beginRotateEvt = "Turn";

	protected const string endRotateEvt = "TurnOver";

	protected FP rotateSpeed = 240;

	protected const int buffId = 990041100;

	protected const string attackFx = "fx_11011zhongyejingying_atk_loop_03";

	protected const string hitterAttackFx = "fx_11007_hit_skill";

	protected FP attackOffsetX = 1.0;

	protected FP attackOffsetY = 2.3;

	protected FP attackWaitTime = 0.3;

	protected FP attackInterval = 0.2;

	protected FP attackLastTime = 8;

	protected FP attackRotateSpeed = 50;

	protected FP switchStateDistance = 8;

	protected FP randomAngle = 300;

	protected FP randomInnerRadius = 3;

	protected FP randomOuterRadius = 5;

	protected const int hitDamageId = 11011011;

	protected FP damageImmuneDuration = 0.4;

	protected FP fanAngel = 90;

	protected FP fanRadius = 6;

	protected ComboAttack _comboAttack;

	protected ComboInputBuffer.ActionKey[] _actionKeys;

	protected LookAtTarget _lookAtTarget;

	protected AimTarget _aimTarget;

	protected TraceTarget _traceTarget;

	protected AdventureFXPlayer _fXPlayer;

	protected CoroutineNode _attackCor;

	protected CommomAreaHitConfig _commomAreaHitConfig;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		StopCoroutine(ref _attackCor);
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		InitData();
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.buffComponent?.AddBuff(990041100, _actor);
		_actor.HurtAnimOff();
	}

	protected virtual void InitData()
	{
		_actionKeys = new ComboInputBuffer.ActionKey[1];
	}

	protected virtual void OnCustomEvent(string eventName)
	{
		if (_lookAtTarget == null)
		{
			_lookAtTarget = new LookAtTarget();
		}
		if (string.Equals(eventName, "Turn"))
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null)
			{
				_lookAtTarget?.BeginLookAt(_actor, activedPlayerActor, 0, rotateSpeed, null);
			}
		}
		else if (string.Equals(eventName, "TurnOver"))
		{
			_lookAtTarget?.StopLookAt();
		}
	}

	protected void OnAnticipationEnd()
	{
		_actor.buffComponent?.RemoveBuffByBuffId(990041100);
		_actor.HurtAnimOn();
		StartCoroutine(ref _attackCor, BeginAttack());
	}

	protected IEnumerator BeginAttack()
	{
		bool inMove = false;
		bool inTrace = false;
		FP lastTime = 0;
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor != null)
		{
			_actor.AimAtTarget(activedPlayerActor, attackRotateSpeed);
		}
		else
		{
			_actor.CancelAiming();
		}
		GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias("fx_11011zhongyejingying_atk_loop_03");
		if (gameObject != null)
		{
			_fXPlayer = AdventureFXPlayer.PlayFX(gameObject, 1f, _actor.transform.position, _actor.transform.rotation);
			_fXPlayer.Bind(_actor.gameObject, null, ActorState.Null, null, Combo.Phase.All, cancelOnInterrupt: true);
		}
		Move(ref inMove, ref inTrace);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(attackWaitTime));
		lastTime += attackWaitTime;
		Move(ref inMove, ref inTrace);
		Attack();
		while (lastTime <= attackLastTime)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(attackInterval));
			lastTime += attackInterval;
			Move(ref inMove, ref inTrace);
			Attack();
		}
		_fXPlayer?.Stop();
		_traceTarget?.CancelTrace();
		_actor.StandBy();
		_actor.CancelAiming();
		_comboAttack.CancelAttack();
	}

	protected void Move(ref bool inMove, ref bool inTrace)
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor == null)
		{
			return;
		}
		if (TSVector2.Distance(_actor.tsTransform.Position, activedPlayerActor.tsTransform.Position) <= switchStateDistance)
		{
			if (!inMove)
			{
				_traceTarget?.CancelTrace();
				TSVector2 tSVector = activedPlayerActor.tsTransform.Position - _actor.tsTransform.Position;
				DeterministicShape shape = new DeterministicShape
				{
					shapeType = DeterministicShape.ShapeType.Fan,
					innerRadius = randomInnerRadius,
					radius = randomOuterRadius,
					angle = randomAngle,
					position = _actor.tsTransform.Position,
					rotation = tSVector.GetAngle()
				};
				TSVector2 targetPosition = _actor.RandomActorReachablePointInsideShape(shape);
				_actor.MoveTo(targetPosition, 0.1f, enableNavigation: true, AdventureActor.MovementMode.Walk);
				inMove = true;
				inTrace = false;
			}
		}
		else if (!inTrace)
		{
			if (_traceTarget == null)
			{
				_traceTarget = new TraceTarget();
			}
			_traceTarget.BeginTrace(_actor, activedPlayerActor, 0.1, -1, -1, null, null, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Walk);
			inTrace = true;
			inMove = false;
		}
	}

	protected void Attack()
	{
		if (_commomAreaHitConfig == null)
		{
			_commomAreaHitConfig = new CommomAreaHitConfig();
		}
		TSVector2 position = ILRuntimeAPI.TransLocalPosToWorldPosByPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, new TSVector2(attackOffsetX, attackOffsetY));
		_commomAreaHitConfig.hitDamageId = 11011011;
		_commomAreaHitConfig.position = position;
		_commomAreaHitConfig.direction = _actor.tsTransform.Forward;
		_commomAreaHitConfig.damageImmuneDuration = damageImmuneDuration;
		_commomAreaHitConfig.hittedEffectAlias = "fx_11007_hit_skill";
		ILRuntimeAPI.FanAreaHit(_actor, _commomAreaHitConfig, fanAngel, fanRadius, 0);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref _attackCor);
		_actor.buffComponent?.RemoveBuffByBuffId(990041100);
		_actor.CancelAiming();
		_comboAttack?.Clear();
		_comboAttack = null;
		_lookAtTarget?.StopLookAt();
		_lookAtTarget?.Clear();
		_lookAtTarget = null;
	}
}
