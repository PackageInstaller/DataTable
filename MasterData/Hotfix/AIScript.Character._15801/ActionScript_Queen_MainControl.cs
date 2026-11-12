using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Queen_MainControl : ActionScript_Summoned
{
	public override void OnStart()
	{
		base.OnStart();
		EnableTrace();
	}

	protected override void OnReceiveCoordinateAttackEvent()
	{
		base.OnReceiveCoordinateAttackEvent();
		NormalAttack();
	}

	protected override FP GetAttackRange()
	{
		return Config_MainControl.attackRange_Queen;
	}

	protected override int GetNormalAttackSkillId()
	{
		return 15893003;
	}

	public override void OnStop()
	{
		base.OnStop();
		DisableTrace();
	}
}
