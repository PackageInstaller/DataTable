using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14901;

public class ActionScript_MainControl : ActionScript
{
	private FP _holdTime_NormalAttackStage;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_holdTime_NormalAttackStage = 0;
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
		if (_actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal))
		{
			_holdTime_NormalAttackStage = 0;
			return;
		}
		if (_holdTime_NormalAttackStage < Config.holdTime_NormalAttackStage)
		{
			_holdTime_NormalAttackStage += _actor.LogicDeltaTime;
			return;
		}
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		_holdTime_NormalAttackStage = 0;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
	}
}
