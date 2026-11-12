using System.Collections;

namespace AIScript.Monster._18011LiMingFaShi;

public class Skill1_Shield_9_5 : SkillSimpleBase
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
			if (GetBuffNum(item, 311010010) < 1)
			{
				AddShieldToTarget(item, 180110302);
			}
		}
		AddShieldToTarget(_actor, 180110302);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
