using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private CoroutineNode _assistTraceCor;

	private TraceTarget _traceTarget;

	private AimTarget _aimTarget;

	private long _areaEffectId_P42;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515641, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(15641011, _actor);
			}
		}
		_areaEffectId_P42 = 0L;
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
	}

	private void OnPlayTimeLineFinish()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_TimelineOn", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnNotPlayTimeLine()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_TimelineOff", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "ZhuiZongStart"))
		{
			if (((PlayerAdventureActor)_actor).isAssist)
			{
				if (_assistTraceCor != null)
				{
					_actor.StopLogicCoroutine(_assistTraceCor);
				}
				_assistTraceCor = _actor.StartLogicCoroutine(AssistTrace());
			}
			return;
		}
		if (string.Equals(eventName, "156UltraBoom"))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(15694011, _actor);
			}
			return;
		}
		if (string.Equals(eventName, "ZhuiZongEnd"))
		{
			ILRuntimeAPI.CancelTraceTarget(_traceTarget);
			if (_assistTraceCor != null)
			{
				_actor.StopLogicCoroutine(_assistTraceCor);
			}
			_assistTraceCor = null;
		}
		else
		{
			if (!CommonUtils.HavePersonalPerk(_actor.dataID, 515642, out var _))
			{
				return;
			}
			if (string.Equals(eventName, "XiYinStart"))
			{
				if (!string.IsNullOrEmpty("AreaEffect_156_P42_UltraXiYin"))
				{
					_areaEffectId_P42 = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_156_P42_UltraXiYin", _actor.tsTransform.Position);
				}
			}
			else if (string.Equals(eventName, "XiYinEnd"))
			{
				if (_areaEffectId_P42 > 0)
				{
					ILRuntimeAPI.StopAreaEffect(_areaEffectId_P42);
				}
				_areaEffectId_P42 = 0L;
			}
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

	private void OnRecoveryBegin()
	{
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
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
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		ILRuntimeAPI.CancelTraceTarget(_traceTarget);
		if (_assistTraceCor != null)
		{
			_actor.StopLogicCoroutine(_assistTraceCor);
		}
		_assistTraceCor = null;
		if (_areaEffectId_P42 > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectId_P42);
		}
		_areaEffectId_P42 = 0L;
	}
}
