using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._Boss._Light._50251ShanDianLieQuan;

public class MiniBoss_Light_Skill03_1 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack;

	private readonly ComboInputBuffer.ActionKey[] Move;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -15 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 15)
		{
			BeginAttack(1, Attack, flushInputedKeys: true);
			yield return WaitCustomEvent("End");
			CancelAttack();
			yield return WaitCustomEvent("A1");
			Dash();
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 2, 180);
			yield return WaitDashFinish();
			StopWaitLookAt();
			DashMove();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt(Targetenemy, 0.3, 240);
			BeginAttack(2, Attack, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("End");
			CancelAttack();
			yield return WaitCustomEvent("A1");
			Dash();
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 2, 180);
			yield return WaitDashFinish();
			StopWaitLookAt();
			DashMove();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, 24, 8, 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	private void DashMove()
	{
		BeginDashActorForward(2, 5, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
	}

	public MiniBoss_Light_Skill03_1()
	{
		//IL_000d: Field data (rva=0x678) could not be found in any section!
		//IL_000d: Field data (rva=0x678) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._291F8E50FBD783B2E79C62EBCF558FEB3C6AA873DC0ED0A6D156675648515C9B));
		Attack = array;
		Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };
		base._002Ector();
	}
}
