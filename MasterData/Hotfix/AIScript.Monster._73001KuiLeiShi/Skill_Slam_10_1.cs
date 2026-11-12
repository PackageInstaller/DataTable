using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Slam_10_1 : SkillSimpleBase
{
	private LogicEntity Targetenemy;

	private readonly string combo_key1 = "Slam";

	private long WarningFX;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		StopEffect(WarningFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.5, 7200);
		yield return WaitTime(0.5);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		Skill_Slam_10_1 skill_Slam_10_ = this;
		Skill_Slam_10_1 skill_Slam_10_2 = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Slam_10_.WarningFX = skill_Slam_10_2.PlayEarlyWarningEffect("fx_warning_fan_140c_7r", 1.1f, default, position, rotation);
		yield return WaitTime(0.85);
		PlayEffect("fx_m72014_base_Skill3_LHand_ready", 1f, 0, GetPosition(), GetRotation(), 0.8f);
		PlayEffect("fx_m72014_base_Skill3_RHand_ready", 1f, 0, GetPosition(), GetRotation(), 0.8f);
		yield return WaitTime(0.25);
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
