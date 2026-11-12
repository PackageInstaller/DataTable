using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class ActionScript_MainControl : ActionScript
{
	private AimTarget _aimTarget;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		else
		{
			_aimTarget.Clear();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515604, out var perkLevel))
		{
			_actor.shootBehaviour.reloadAnimClipIndex = 0;
		}
		else
		{
			_actor.shootBehaviour.reloadAnimClipIndex = -1;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515611, out perkLevel))
		{
			_playerSkillCd.SetSkillTotalSection(ActionKey.A, _playerSkillCd.GetSkillCD(ActionKey.A).originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		else
		{
			_playerSkillCd.ResetSkillTotalSection(ActionKey.A);
		}
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonBPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End);
	}

	protected override void OnButtonDPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	public override void OnUpdate()
	{
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Ultimate))
		{
			return;
		}
		if (_actor.attackTarget == null || _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill2 | SkillPhaseFeatureFlag.Dodge) || IsObstacleBetweenActorAndTargetAndPreventNormalAttack)
		{
			if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget.Cancel();
			}
			return;
		}
		FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
		if (fP < CommonUtils.GetAimRange(_actor))
		{
			if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
			{
				_aimTarget.Aim(_actor, (AdventureActor)_actor.attackTarget, default, playStartAnim: true);
			}
			if (fP <= CommonUtils.GetAttackRange(_actor) && _actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && _actor.ammoInfo.ammoCount > 0)
			{
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			}
		}
		else if (_actor.aimMode != AdventureActor.AimMode.Forward)
		{
			_aimTarget.Cancel();
		}
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_aimTarget.Cancel();
		_aimTarget.Clear();
	}
}
