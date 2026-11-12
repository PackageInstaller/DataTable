using System.Collections;
using TrueSync;

namespace AIScript.Monster._18011LiMingFaShi;

public class NormalAttack_Melee : SkillSimpleBase
{
	private readonly string Attack2 = "Attack2";

	private LogicEntity TargetEnemy;

	protected readonly FP DashSpeed = 25.5f;

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
		BeginLookAt_NotWait(TargetEnemy, 0.4f, 400);
		yield return WaitTime(0.2);
		BeginAttack(1, Attack2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2);
		BeginLookAt_NotWait(TargetEnemy, 0.3f, 400);
		yield return WaitCustomEvent("DashStart");
		BeginDashActorForward(1, DashSpeed, 5, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
