using System.Collections;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_02 : SkillSimpleBase
{
	private string Attack_L = "Skill02_L";

	private string Attack_R = "Skill02_R";

	private string Attack;

	protected override void OnSkillEnable()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 0)
		{
			Attack = Attack_R;
		}
		else
		{
			Attack = Attack_L;
		}
	}

	protected override void OnSkillDisable()
	{
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 3, 25);
		yield return WaitCustomEvent("TurnEnd");
		StopWaitLookAt();
		SetBlockPriorityToStatic();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
