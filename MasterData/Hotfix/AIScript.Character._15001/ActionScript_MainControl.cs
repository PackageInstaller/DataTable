using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15001;

public class ActionScript_MainControl : ActionScript
{
	private FP _delayNormalAttackStageDelay;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_delayNormalAttackStageDelay = Config.delay_ResetNormalAttackStage;
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonBPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: true);
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: false);
	}

	protected override void OnButtonDPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
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
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
