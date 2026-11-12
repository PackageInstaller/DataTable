using System.Collections;

namespace AIScript.Monster._18011LiMingFaShi;

public class Skill1_Shield : SkillSimpleBase
{
	private readonly string Skill1 = "Skill1_Shield";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Skill1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("AddShield");
		foreach (LogicEntity item in GetTargetsByFaction(isFriend: true))
		{
			AddShieldToTarget(item, 180110301);
		}
		AddShieldToTarget(_actor, 180110301);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
