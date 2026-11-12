using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class ActionScript_MainControl : ActionScript
{
	private FP _delayNormalAttackStageDelay;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_delayNormalAttackStageDelay = Config.delay_ResetNormalAttackStage;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514113, out var _))
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
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End))
		{
			ResetNormalAttackStage();
		}
	}

	protected override void OnButtonDPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			ResetNormalAttackStage();
		}
	}

	public void OnUpdate()
	{
		if (!_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill1))
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		}
		if (_actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal))
		{
			_delayNormalAttackStageDelay = Config.delay_ResetNormalAttackStage;
		}
		else if (_delayNormalAttackStageDelay > 0)
		{
			_delayNormalAttackStageDelay -= _actor.LogicDeltaTime;
		}
		else
		{
			ResetNormalAttackStage();
		}
	}

	private void ResetNormalAttackStage()
	{
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
