using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Awake_OctopusBattery : SkillSimpleBase
{
	private static readonly string combo_Awake = "Awake";

	private int buff_shield = 313020010;

	private int phase;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (phase == 3)
		{
			AddBuffToTarget(_actor, buff_shield);
		}
		BeginAttack(1, combo_Awake, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		ReplaceAnimationGroup();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
