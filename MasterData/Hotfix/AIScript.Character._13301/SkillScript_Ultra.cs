using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13301;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string actionTag_Timeline = "133_Ultra_TL";

	private const string actionTag_NoTimeline = "133_Ultra_NoTL";

	private const string actionTag_41_TL = "133_Ultra_TL_P41";

	private const string actionTag_41_NoTL = "133_Ultra_NoTL_P41";

	private PlayTimeline _playTimeline;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
	}

	public void OnStart()
	{
		Parallel.ultWindCount = 0;
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
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
		if (_actor.attackTarget != null)
		{
			_actor.Aim(_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position);
			return;
		}
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

	private void OnPlayTimelineFinish()
	{
		AimDirec();
		bool flag = false;
		if (GetPerk(513341))
		{
			flag = true;
		}
		string actionTag = (flag ? "133_Ultra_TL_P41" : "133_Ultra_TL");
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		OnUseSkill();
	}

	private void OnNoPlayTimeLine()
	{
		AimDirec();
		bool flag = false;
		if (GetPerk(513341))
		{
			flag = true;
		}
		string actionTag = (flag ? "133_Ultra_NoTL_P41" : "133_Ultra_NoTL");
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		OnUseSkill();
	}

	private void OnUseSkill()
	{
		if (GetPerk(513342))
		{
			_actor.buffComponent?.AddBuff(13354211, _actor);
		}
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
		_actor.CancelAiming();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
	}
}
