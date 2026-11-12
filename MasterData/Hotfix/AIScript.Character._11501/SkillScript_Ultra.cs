using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11501;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private AimTarget _aimTarget;

	private bool _lockDirection;

	private bool _isLoopShootStage;

	private FP _shootLoopTime;

	private FP _addSearchRange;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
		_lockDirection = false;
		_isLoopShootStage = false;
		_shootLoopTime = 0;
		_addSearchRange = (((PlayerAdventureActor)_actor).isAssist ? Config.addSearchRange_Support_UltraSkill : Config.addSearchRange_MainControl_UltraSkill);
		_actor.actorSearchTargetInfo.AddSearchRange(_addSearchRange, ActorSearchTarget.SearchType.allRange);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		SearchTargetAndAim();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, PlayOneStageTimelineCombo, PlayOneStageNoTimelineCombo, 1, addPlayTime: false);
	}

	protected void PlayOneStageTimelineCombo()
	{
		string text = "Ultra_TL";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511542, out var _))
		{
			text = "Ultra_TL_P42";
		}
		string actionTag = text;
		Action onComboLoop = OnOneStageLoopAfterTimeline;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
		_actor.ResumeAnimationGroup();
		_isLoopShootStage = true;
	}

	protected void PlayOneStageNoTimelineCombo()
	{
		string text = "Ultra_NoTL_H6";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511542, out var _))
		{
			text = "Ultra_NoTL_H6_P42";
		}
		string actionTag = text;
		Action onComboLoop = OnOneStageLoopNoTimeline;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
		_actor.ResumeAnimationGroup();
		_isLoopShootStage = true;
	}

	protected void OnOneStageLoopNoTimeline()
	{
		if (_shootLoopTime >= Config.maxShootTime_UltraSkill)
		{
			_isLoopShootStage = false;
			SearchTargetAndAim();
			_lockDirection = true;
			comboAttack.CancelAttack();
		}
	}

	protected void OnOneStageLoopAfterTimeline()
	{
		if (_shootLoopTime >= Config.maxShootTime_UltraSkill)
		{
			_isLoopShootStage = false;
			SearchTargetAndAim();
			_lockDirection = true;
			_playTimeline.Play(_actor, PlayTwoStageCombo, PlayTwoStageCombo, 2);
		}
	}

	public void OnUpdate()
	{
		if (_isLoopShootStage)
		{
			_shootLoopTime += _actor.LogicDeltaTime;
		}
		if (!_lockDirection)
		{
			SearchTargetAndAim();
		}
	}

	protected void SearchTargetAndAim()
	{
		TSVector2 tSVector = _actor.tsTransform.Forward;
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			_actor.attackTarget = null;
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
			if (_actor.attackTarget != null)
			{
				tSVector = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
		}
		else
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
			if (_actor.attackTarget != null)
			{
				tSVector = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			else if (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
			{
				tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			}
		}
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		if (_actor.aimMode != AdventureActor.AimMode.LockDirection)
		{
			_aimTarget.Aim(_actor, null, tSVector);
		}
		else
		{
			_actor.tsTransform.Forward = tSVector;
		}
	}

	protected void PlayTwoStageCombo()
	{
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Ultra_TL_H6", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
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
		_playTimeline?.Clear();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.actorSearchTargetInfo.AddSearchRange(-_addSearchRange, ActorSearchTarget.SearchType.allRange);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
		((PlayerAdventureActor)_actor).playerSkillCd?.ResetSkillCD(ActionKey.B);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511541, out var _))
		{
			_actor.logicVariable.ToggleLogicTag("CanTrigger_P41", value: true);
		}
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		_lockDirection = false;
		_isLoopShootStage = false;
		_shootLoopTime = 0;
	}
}
