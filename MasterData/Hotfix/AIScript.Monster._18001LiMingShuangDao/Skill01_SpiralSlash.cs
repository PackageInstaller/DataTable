using System.Collections;
using TrueSync;

namespace AIScript.Monster._18001LiMingShuangDao;

public class Skill01_SpiralSlash : SkillSimpleBase
{
	private readonly string SpinAttack = "SpinAttack";

	private LogicEntity TargetEnemy;

	protected readonly FP dash_spd = 15.5f;

	protected readonly FP dash_angleLimit = 60;

	private FP dis;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		CancelAttack();
	}

	protected override IEnumerator DoMainLogic()
	{
		TargetEnemy = GetAttackTarget();
		if (TargetEnemy == null)
		{
			TargetEnemy = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(TargetEnemy, 0.3, 500);
		yield return WaitTime(0.3);
		BeginAttack(1, SpinAttack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.8);
		FP fP = Distance(GetPosition(), GetEntityPosition(TargetEnemy));
		if (fP < 6)
		{
			dis = fP + 5;
		}
		else
		{
			dis = fP + 1.5f;
		}
		doDash(dis);
		yield return WaitTime(dis / dash_spd);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash(FP dis)
	{
		BeginDashActorForward(1, dash_spd, dis, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
