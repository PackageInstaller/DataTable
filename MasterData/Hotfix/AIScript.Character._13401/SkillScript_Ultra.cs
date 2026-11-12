using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13401;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private int _maxAttackLoopRound;

	private int _attackLoopRound;

	private Dash _dash;

	private CoroutineNode _perkLogicCor_P43;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.actorSearchTargetInfo.AddSearchRange(Config.addSearchTargetRange_UltraSkill, ActorSearchTarget.SearchType.allRange);
		_actor.actorSearchTargetInfo.visionDeg = Config.changeSearchTargetDeg_UltraSkill;
		_attackLoopRound = 0;
		_maxAttackLoopRound = 2;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513442, out var _))
		{
			_maxAttackLoopRound += 2;
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3))
		{
			_actor.buffComponent.AddBuff(13496311, _actor);
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
	}

	private void OnPlayTimeLineFinish()
	{
		Action onComboLoop = OnComboLoop;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("134_Ultra_TL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnNotPlayTimeLine()
	{
		Action onComboLoop = OnComboLoop;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("134_Ultra_NoTL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		_attackLoopRound++;
		if (_attackLoopRound >= _maxAttackLoopRound)
		{
			comboAttack.CancelAttack();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "134_Ultra_Target"))
		{
			DefaultLookAt();
		}
		else if (string.Equals(eventName, "134_Ultra_Hurt"))
		{
			FP distance = Config.maxDashDistance_UltraSkill;
			TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (tSVector == TSVector2.zero || ((PlayerAdventureActor)_actor).isAssist)
			{
				tSVector = _actor.tsTransform.Forward;
				LogicEntity attackTarget = GetAttackTarget();
				if (attackTarget != null)
				{
					distance = TSMath.Clamp(_actor.DistanceWithRadius(attackTarget), Config.minDashDistance_UltraSkill, Config.maxDashDistance_UltraSkill);
					tSVector = (attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
				}
			}
			_actor.LookAtDir(tSVector, 0f);
			if (_dash == null)
			{
				_dash = new Dash();
			}
			else
			{
				_dash.Interrupte();
			}
			_actor.PauseMovementBlock();
			_dash.BeginDash(_actor, _actor.tsTransform.Forward, Config.dashSpeed_UltraSkill, distance, default, OnDashFinish, null, null, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: true, triggerFriendStop: false);
		}
		else if (string.Equals(eventName, "134_P43_Buff") && CommonUtils.HavePersonalPerk(_actor.dataID, 513443, out perkLevel))
		{
			if (_perkLogicCor_P43 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P43);
			}
			_perkLogicCor_P43 = _actor.StartLogicCoroutine(PerkLogic_43(), runImmediately: true);
		}
	}

	private IEnumerator PerkLogic_43()
	{
		_actor.buffComponent.AddBuffNum(13443011, 6, _actor);
		FP interval = Config.removeBuffInterval_P43;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				if (_actor.buffComponent.GetBuffNumByID(13443011) <= 0)
				{
					break;
				}
				_actor.buffComponent.RemoveBuffByBuffId(13443011, 1);
				interval = Config.removeBuffInterval_P43;
			}
			yield return null;
		}
	}

	private void OnDashFinish()
	{
		_actor.ResumeMovementBlock();
	}

	private LogicEntity GetAttackTarget()
	{
		if (((PlayerAdventureActor)_actor).isAssist)
		{
			return CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
		return _actor.attackTarget;
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
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513441, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13441011);
		}
		if (_perkLogicCor_P43 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P43);
		}
		_perkLogicCor_P43 = null;
		_actor.buffComponent.RemoveBuffByBuffId(13443011);
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13496211);
		}
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.actorSearchTargetInfo.AddSearchRange(-Config.addSearchTargetRange_UltraSkill, ActorSearchTarget.SearchType.allRange);
		_actor.actorSearchTargetInfo.visionDeg = _actor.actorSearchTargetInfo.originVisionDeg;
		_actor.ResumeMovementBlock();
	}
}
