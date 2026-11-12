using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill06_SwallowSlash : SkillSimpleBase
{
	private readonly string combo_key1 = "Maline_9_3";

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.5, 7200);
		yield return WaitTime(0.5);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		Skill06_SwallowSlash skill06_SwallowSlash = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill06_SwallowSlash.PlayEarlyWarningEffect("fx_warning_square_3side_2x17.5", 1.4f, default, position, rotation, 1.5f);
		yield return WaitTime(0.9);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
