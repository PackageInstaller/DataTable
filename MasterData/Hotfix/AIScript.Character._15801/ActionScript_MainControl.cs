using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_MainControl : ActionScript
{
	private FP _holdTime_NormalAttackStage;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515813, out var _))
		{
			_playerSkillCd.SetSkillTotalSection(ActionKey.A, _playerSkillCd.GetSkillCD(ActionKey.A).originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		else
		{
			_playerSkillCd.ResetSkillTotalSection(ActionKey.A);
		}
		_holdTime_NormalAttackStage = 0;
	}

	protected override int GetDefaultSkillId()
	{
		return 15831000;
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
		BeginTransfrom();
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (!InTransformState)
		{
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
	}

	protected override LogicEntity GetTransformAttackTarget()
	{
		return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
	}
}
