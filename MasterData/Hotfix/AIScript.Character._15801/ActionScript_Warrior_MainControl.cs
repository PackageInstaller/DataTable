using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Warrior_MainControl : ActionScript_Summoned
{
	private long _areaEffectId_P6;

	public override void OnStart()
	{
		base.OnStart();
		EnableTrace();
		if (HavePersonalPerk(515806, out var _))
		{
			_areaEffectId_P6 = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_15801_Main_Skill_P06_Fire", _actor.tsTransform.Position);
		}
	}

	protected override void OnReceiveCoordinateAttackEvent()
	{
		base.OnReceiveCoordinateAttackEvent();
		if (!(_actor.attackTarget == null) && _actor.movementState == ActorState.StandBy)
		{
			ILRuntimeAPI.CreateSkill(15892004, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
		}
	}

	protected override FP GetAttackRange()
	{
		return Config_MainControl.attackRange_Warrior;
	}

	protected override FP GetNormalAttackInterval()
	{
		return Config_MainControl.useInterval_NormalAttack_Warrior;
	}

	protected override int GetNormalAttackSkillId()
	{
		return 15892003;
	}

	public override void OnStop()
	{
		base.OnStop();
		DisableTrace();
		if (_areaEffectId_P6 > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectId_P6);
		}
		_areaEffectId_P6 = 0L;
	}
}
