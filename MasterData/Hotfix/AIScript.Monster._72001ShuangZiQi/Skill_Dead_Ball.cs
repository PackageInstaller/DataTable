using System.Collections;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Dead_Ball : SkillSimpleBase
{
	private string Color;

	private string DeathFXName;

	private bool isRed;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetCloseBlockEnable();
		isRed = GetLogicTagToggleValue(_actor, "Red");
		ChessInitialize();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		BeginAttack(1, "Death", flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(DeathFXName, 3f);
		yield return WaitTime(0.6);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "red";
		}
		else
		{
			Color = "green";
		}
		DeathFXName = "fx_qizi_common_base_die_" + Color;
	}
}
