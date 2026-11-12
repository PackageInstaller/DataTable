using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._13901;

public class ActionScript_MainControl : ActionScript
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonBPress()
	{
		int currentBindSkillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.B);
		SkillPhaseFeatureFlag skillCastBehaviourType = SkillPhaseFeatureFlag.Skill1;
		bool ingoreCDAndEnergy = false;
		if ((_actor.logicVariable.GetLogicTagToggle("TriggerPersonalPerk_P1 ") && currentBindSkillId == 13931002) || (CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out var _) && currentBindSkillId == 13931001))
		{
			skillCastBehaviourType = SkillPhaseFeatureFlag.Ultimate;
			ingoreCDAndEnergy = true;
		}
		ILRuntimeAPI.CreateSkill(currentBindSkillId, _actor, skillCastBehaviourType, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, null, null, ingoreCDAndEnergy);
	}

	protected override void OnButtonDPress()
	{
		int currentBindSkillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.D);
		ILRuntimeAPI.CreateSkill(currentBindSkillId, _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End, null, null, currentBindSkillId == 13940001);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		if (_actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
