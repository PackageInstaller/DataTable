using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Soldier_MainControl : ActionScript_Summoned
{
	public override void OnStart()
	{
		base.OnStart();
		EnableTrace();
	}

	protected override void OnReceiveCoordinateAttackEvent()
	{
		base.OnReceiveCoordinateAttackEvent();
		if (!(_actor.attackTarget == null) && _actor.movementState == ActorState.StandBy)
		{
			ILRuntimeAPI.CreateSkill(15891004, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
		}
	}

	protected override FP GetAttackRange()
	{
		return Config_MainControl.attackRange_Soldier;
	}

	protected override FP GetNormalAttackInterval()
	{
		return Config_MainControl.useInterval_NormalAttack_Soldier;
	}

	protected override int GetNormalAttackSkillId()
	{
		return 15891003;
	}

	public override void OnStop()
	{
		base.OnStop();
		DisableTrace();
	}
}
