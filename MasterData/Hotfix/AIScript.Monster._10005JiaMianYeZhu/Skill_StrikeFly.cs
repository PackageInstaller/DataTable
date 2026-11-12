using System.Collections;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_StrikeFly : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] StrikeFly_Combo_Normal = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] StrikeFly_Combo_Fast = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private ComboInputBuffer.ActionKey[] StrikeFly_Combo;

	private FP TurnSpeed;

	protected override void OnSkillEnable()
	{
		TurnSpeed = 45;
		if (GetBuffNum(_actor, 100050110) > 0)
		{
			StrikeFly_Combo = StrikeFly_Combo_Fast;
		}
		else
		{
			StrikeFly_Combo = StrikeFly_Combo_Normal;
		}
	}

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, StrikeFly_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
