using System.Collections;

namespace AIScript.Monster._17011QingNuWeiBing;

public class NormalAttack_Straight : SkillSimpleBase
{
	private static readonly string Startfx = "fx_m17011_base_atk1_1_start";

	private long fxWarningLine;

	private long fx_start;

	private readonly string ShootLine = "FX/Warning/fx_warning_line_0_5h_45m_2w";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		StopEffect(fx_start);
		StopEffect(fxWarningLine);
	}

	protected override IEnumerator DoMainLogic()
	{
		while (true)
		{
			BeginAttack(1, "Shoot9_1", flushInputedKeys: true, forceInterruptAttack: true);
			fx_start = PlayEffect(Startfx);
			fxWarningLine = PlayEffect(ShootLine);
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			StopEffect(fxWarningLine);
			yield return WaitTime(0.5);
			StopEffect(fx_start);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(5);
		}
	}
}
