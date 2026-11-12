using System.Collections;

namespace AIScript.Monster._18001LiMingShuangDao;

public class NormalAttack : SkillSimpleBase
{
	private readonly string Attack1 = "Attack1";

	private LogicEntity TargetEnemy;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		TargetEnemy = GetAttackTarget();
		if (TargetEnemy == null)
		{
			TargetEnemy = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(TargetEnemy, 0.2, 400);
		BeginAttack(1, Attack1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		BeginLookAt_NotWait(TargetEnemy, 0.7f, 80);
		yield return WaitTime(1.2);
		BeginLookAt_NotWait(TargetEnemy, 0.2f, 80);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
