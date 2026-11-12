using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_BurrowingMove : SkillSimpleBase
{
	private static readonly string combo_Burrow_Down = "Burrow_Down";

	private static readonly string combo_Burrow_Up = "Burrow_Up";

	private static FP BurrowLoop_Duration = 2.5;

	private bool isHidden;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isHidden = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (isHidden)
		{
			ExitBurrow();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_Burrow_Down, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.2);
		EnterBurrow();
		BeginTrace(GetCurrentPlayer(), 0, -1, BurrowLoop_Duration);
		yield return WaitTime(BurrowLoop_Duration);
		StopTrace();
		CancelAttack();
		BeginAttack(1, combo_Burrow_Up, flushInputedKeys: true, forceInterruptAttack: true);
		ExitBurrow();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void EnterBurrow()
	{
		if (!isHidden)
		{
			CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
			SetHideModelEnable();
			SetCloseBlockEnable();
			isHidden = true;
		}
	}

	private void ExitBurrow()
	{
		if (isHidden)
		{
			CommonUtils_MonsterAPI.SetUnparalleledDisable(_actor);
			SetHideModelDisable();
			SetCloseBlockDisable();
			isHidden = false;
		}
	}
}
