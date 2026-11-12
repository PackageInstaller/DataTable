using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._13301;

public class ActionScript : ActorActionBase
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_actor.logicVariable.SetLogicTagValue("SkillNormalAttackStage_133", 1);
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonBPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1);
	}

	protected override void OnButtonDPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate);
	}

	public void OnUpdate()
	{
		if (!(_actor as PlayerAdventureActor).isAssist)
		{
			if (!_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill1))
			{
				_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
			}
			if (_actor.attackTarget != null && !_player.dodgeButtonHold && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
			{
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			}
		}
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
