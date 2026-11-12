using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._14301;

public class ActionScript_MainControl : ActionScript
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514311, out var _))
		{
			SkillInfo skillCD = _playerSkillCd.GetSkillCD(ActionKey.A);
			if (skillCD != null)
			{
				_playerSkillCd.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
			}
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
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: true);
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: false);
	}

	protected override void OnButtonDPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	public override void OnUpdate()
	{
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		if (_actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
		if (ModuleController<AdventureModuleController>.Instance.SemiAutoBattle && CommonUtils.HavePersonalPerk(_actor.dataID, 514304, out var _))
		{
			SkillInfo skillCD = _playerSkillCd.GetSkillCD(ActionKey.B);
			if (skillCD != null)
			{
				((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, skillCD.currentSectionAmount >= skillCD.totalSectionAmount, Config_MainControl.holdButtonTime_AutoBattle_P4);
			}
			else
			{
				((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, canCast: false);
			}
		}
		base.OnUpdate();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
