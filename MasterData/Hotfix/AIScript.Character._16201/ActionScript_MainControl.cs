using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._16201;

public class ActionScript_MainControl : ActionScript
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516201, out var _))
		{
			_playerSkillCd.ChangeSkillGetEnergyLimit(16231000, CommonUtils.GetScriptValue(_actor, 16201011));
		}
		else
		{
			_playerSkillCd.ResetSkillGetEnergyLimit(16231000);
		}
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	protected override void OnButtonBPress()
	{
		if (!ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516207, out var perkLevel))
		{
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				if (allPlayerActor == _actor)
				{
					allPlayerActor.buffComponent.AddBuff(16207011, _actor);
				}
				else if (allPlayerActor.actorElementInfo.elementType == HotfixEnum.elementType.LE && allPlayerActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance)
				{
					allPlayerActor.buffComponent.AddBuff(16207012, _actor);
				}
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516209, out perkLevel))
		{
			_actor.buffComponent.AddBuff(16209011, _actor);
		}
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
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
