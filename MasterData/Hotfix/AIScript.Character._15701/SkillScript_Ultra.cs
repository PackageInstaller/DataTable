using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15701;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private CoroutineNode _assistTraceCor;

	private TraceTarget _traceTarget;

	private CoroutineNode _perkLogicCor_P42;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515743, out var _))
		{
			_actor.buffComponent.AddBuff(15743011, _actor);
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
		LockDirection(_actor.tsTransform.Forward);
	}

	private void OnPlayTimeLineFinish()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_TL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnNotPlayTimeLine()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_NoTL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "FollowStart"))
		{
			if (((PlayerAdventureActor)_actor).isAssist)
			{
				if (_assistTraceCor != null)
				{
					_actor.StopLogicCoroutine(_assistTraceCor);
				}
				_assistTraceCor = _actor.StartLogicCoroutine(AssistTrace());
			}
		}
		else if (string.Equals(eventName, "FollowEnd"))
		{
			if (((PlayerAdventureActor)_actor).isAssist)
			{
				ILRuntimeAPI.CancelTraceTarget(_traceTarget);
				if (_assistTraceCor != null)
				{
					_actor.StopLogicCoroutine(_assistTraceCor);
				}
				_assistTraceCor = null;
			}
		}
		else if (string.Equals(eventName, "157P42PenSheStart"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515742, out perkLevel))
			{
				if (_perkLogicCor_P42 != null)
				{
					_actor.StopLogicCoroutine(_perkLogicCor_P42);
				}
				_perkLogicCor_P42 = _actor.StartLogicCoroutine(PerkLogic_P42(), runImmediately: true);
			}
		}
		else if (string.Equals(eventName, "157P42PenSheEnd") && CommonUtils.HavePersonalPerk(_actor.dataID, 515742, out perkLevel))
		{
			if (_perkLogicCor_P42 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P42);
			}
			_perkLogicCor_P42 = null;
		}
	}

	public void OnUpdate()
	{
		if (((PlayerAdventureActor)_actor).isAssist)
		{
			AdventureActor actor = _actor;
			LogicEntity attackTarget = (_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true));
			actor.attackTarget = attackTarget;
		}
	}

	private IEnumerator AssistTrace()
	{
		AdventureActor traceTarget = null;
		while (true)
		{
			AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.attackTarget as AdventureActor;
			if (traceTarget != null && !traceTarget.actorHealthInfo.isAlive)
			{
				ILRuntimeAPI.CancelTraceTarget(_traceTarget);
			}
			if (adventureActor != null)
			{
				if (traceTarget != null && adventureActor != traceTarget)
				{
					ILRuntimeAPI.CancelTraceTarget(_traceTarget);
				}
				if (adventureActor != traceTarget && ILRuntimeAPI.CalcDistanceBetweenTwoActor(_actor, adventureActor) > 1)
				{
					traceTarget = adventureActor;
					ILRuntimeAPI.BeginTraceTarget(ref _traceTarget, _actor, traceTarget, 1, -1, -1, null, null, NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode.Walk, () =>
					{
						traceTarget = null;
					});
				}
			}
			yield return null;
		}
	}

	private IEnumerator PerkLogic_P42()
	{
		DeterministicShape randomShape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = 3,
			radius = 3
		};
		FP shootInterval = 0;
		while (true)
		{
			if (shootInterval > 0)
			{
				shootInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
				randomShape.position = ((adventureActor.attackTarget != null) ? adventureActor.attackTarget.tsTransform.Position : adventureActor.tsTransform.Position);
				int num = CommonUtils.GetScriptValue(_actor, 15742002).AsInt();
				for (int i = 0; i < num; i++)
				{
					TSVector2 result = ILRuntimeAPI.GetRandomPointInShape(_actor, randomShape, isReachable: false);
					if (!_actor.QueryPositionWalkable(result))
					{
						_actor.QueryClosestPositionWalkable(result, out result);
					}
					ILRuntimeAPI.Shoot("Bullet_157_P42_ShuiPao", _actor, default, _actor.tsTransform.Position, Config.shootPositionY_P42, result, null, AimType.Position, BulletDirectionType.BulletToTarget);
				}
				shootInterval = CommonUtils.GetScriptValue(_actor, 15742011);
			}
			yield return null;
		}
	}

	private void OnRecoveryBegin()
	{
		CancelLockDirection();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
		ILRuntimeAPI.CancelTraceTarget(_traceTarget);
		if (_assistTraceCor != null)
		{
			_actor.StopLogicCoroutine(_assistTraceCor);
		}
		_assistTraceCor = null;
		if (_perkLogicCor_P42 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P42);
		}
		_perkLogicCor_P42 = null;
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(15796411, _actor);
		}
	}
}
