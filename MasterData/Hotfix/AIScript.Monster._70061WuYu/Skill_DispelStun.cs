using System.Collections;

namespace AIScript.Monster._70061WuYu;

public class Skill_DispelStun : SkillSimpleBase
{
	private const string ComboKey_Phase12 = "PerfumeStun_1";

	private const string ComboKey_Phase3 = "PerfumeStun_2";

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "CanGetPerfume", value: false);
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: false);
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "CanGetPerfume", value: true);
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = ((_actor.logicVariable.GetLogicTagValue("Phase").AsInt() >= 3) ? "PerfumeStun_2" : "PerfumeStun_1");
		BeginAttack(0, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(Config.DispelStunTime);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
