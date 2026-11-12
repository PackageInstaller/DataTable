using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12001;

public class SkillScript_Ultra : SkillAdvancedBase
{
	protected readonly FP skillDuration = 6;

	private const string actionTag_Timeline = "120_Ultra_TL";

	private const string actionTag_NoTimeline = "120_Ultra_NoTL";

	private const string actionTag_Timeline_41 = "120_Ultra_TL_41";

	private const string actionTag_NoTimeline_41 = "120_Ultra_NoTL_41";

	private const string actionTag_Timeline_m2 = "120_Ultra_TL_H2";

	private const string actionTag_NoTimeline_m2 = "120_Ultra_NoTL_H2";

	private const string actionTag_Timeline_41_m2 = "120_Ultra_TL_41H2";

	private const string actionTag_NoTimeline_41_m2 = "120_Ultra_NoTL_41H2";

	private const int buff_id = 12000011;

	private FP angle_limt = 20;

	protected PlayTimeline _playTimeline;

	private FP currentTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		Parallel.ultraSkill = true;
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		(_actor as PlayerAdventureActor).moveControlType = PlayerActorMoveType.Melee;
		Parallel.monsterId_m3.Clear();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimelineFinish, OnNoPlayTimeLine);
	}

	public void AimDirec()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			_actor.CancelAiming();
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
			if (_actor.attackTarget != null)
			{
				_actor.AimAtTarget(_actor.attackTarget, angle_limt);
			}
		}
		else if (_actor.attackTarget != null)
		{
			_actor.Aim(_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position);
		}
		else
		{
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (movementInputDirection != TSVector2.zero)
			{
				_actor.Aim(movementInputDirection);
			}
			else
			{
				_actor.Aim(_actor.tsTransform.Forward);
			}
		}
	}

	public void AssetAim()
	{
		if ((_actor as PlayerAdventureActor).isAssist && (!(_actor.attackTarget != null) || !((AdventureActor)_actor.attackTarget).actorHealthInfo.isAlive))
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
			if (_actor.attackTarget != null)
			{
				_actor.CancelAiming();
				_actor.AimAtTarget(_actor.attackTarget, angle_limt);
			}
		}
	}

	private void OnPlayTimelineFinish()
	{
		AimDirec();
		string text = "120_Ultra_TL";
		if (GetPerk(512041))
		{
			text = "120_Ultra_TL_41";
		}
		string actionTag = text;
		System.Action onComboLoop = OnComboLoop;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
		OnUseSkill();
	}

	private void OnNoPlayTimeLine()
	{
		AimDirec();
		string text = "120_Ultra_NoTL";
		if (GetPerk(512041))
		{
			text = "120_Ultra_NoTL_41";
		}
		string actionTag = text;
		System.Action onComboLoop = OnComboLoop;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
		OnUseSkill();
	}

	private void OnUseSkill()
	{
		currentTime = 0;
		if (GetPerk(512043))
		{
			_actor.buffComponent.AddBuff(12043011, _actor);
		}
		_actor.buffComponent.AddBuff(12000011, _actor);
	}

	private void OnComboLoop()
	{
		AssetAim();
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
		Parallel.ultraSkill = false;
		_playTimeline?.Clear();
		_actor.CancelAiming();
		_actor.buffComponent.RemoveBuffByBuffId(12000011);
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		(_actor as PlayerAdventureActor).moveControlType = PlayerActorMoveType.Range;
	}

	public void OnUpdate()
	{
		currentTime += _actor.LogicDeltaTime;
		if (!(currentTime > skillDuration + 0.2) && currentTime > skillDuration)
		{
			comboAttack.CancelAttack();
		}
	}
}
