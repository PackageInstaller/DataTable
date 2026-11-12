using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Attack03_SpawnKill : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginAttack(1, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(attackTarget, 0.1, 3600);
		yield return WaitFrame(30);
		BeginRotateAngle_NotWait(320, 60);
		Dash();
		yield return WaitFrame(40);
		Dash();
		yield return WaitFrame(40);
		Dash();
		yield return WaitFrame(30);
		Dash();
		yield return WaitFrame(30);
		Dash();
		yield return WaitFrame(30);
		CancelAim();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		ClearActors(new List<LogicEntity> { _actor });
	}

	private void Dash()
	{
		GetEnemy();
		LogicEntity targetenemy = Targetenemy;
		TSVector2 normalized = (GetEntityPosition(targetenemy) - GetPosition()).normalized;
		BeginDash(1, normalized, 0.8, 0.8, 5, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetAttackTarget();
		}
	}
}
