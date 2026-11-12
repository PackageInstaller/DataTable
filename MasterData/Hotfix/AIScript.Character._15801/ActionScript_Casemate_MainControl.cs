using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Casemate_MainControl : ActionScript_Summoned
{
	protected override FP GetAttackRange()
	{
		return Config_MainControl.attackRange_Casemate;
	}

	protected override int GetNormalAttackSkillId()
	{
		return 15894003;
	}

	protected override FP GetNormalAttackInterval()
	{
		return Config_MainControl.useInterval_NormalAttack_Casemate;
	}
}
