using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15701;

public class ActionScript_MainControl : ActionScript
{
	private AimTarget _aimTarget;

	private FP _addEnergyInterval;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		_addEnergyInterval = Config_MainControl.addBuffInterval_Energy;
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonBPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	protected override void OnButtonDPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		if (_addEnergyInterval > 0)
		{
			_addEnergyInterval -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.buffComponent.AddBuffNum(15790011, 10, _actor);
			_addEnergyInterval += Config_MainControl.addBuffInterval_Energy;
		}
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
			if (fP <= CommonUtils.GetAttackRange(_actor))
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
