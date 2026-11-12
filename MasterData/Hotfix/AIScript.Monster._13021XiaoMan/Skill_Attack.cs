using System.Collections;
using TrueSync;

namespace AIScript.Monster._13021XiaoMan;

public class Skill_Attack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Punch_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] Kick_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly FP PunchMoveDistance = 2;

	private static readonly FP PunchMoveSpeed = 40;

	private static readonly FP KickMoveDistance = 4;

	private static readonly FP KickMoveSpeed = 12;

	private ComboInputBuffer.ActionKey[] Attack_Combo;

	private FP AttackMoveDistance;

	private FP AttackMoveSpeed;

	private FP TurnSpeed;

	protected override void OnSkillEnable()
	{
		FP randomValue = GetRandomValue(0, 1);
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 3)
		{
			Attack_Combo = Kick_Combo;
			AttackMoveDistance = KickMoveDistance;
			TurnSpeed = 200;
			AttackMoveSpeed = KickMoveSpeed;
		}
		else if (randomValue <= 0.8)
		{
			Attack_Combo = Punch_Combo;
			AttackMoveDistance = PunchMoveDistance;
			TurnSpeed = 150;
			AttackMoveSpeed = PunchMoveSpeed;
		}
		else
		{
			Attack_Combo = Kick_Combo;
			AttackMoveDistance = KickMoveDistance;
			TurnSpeed = 200;
			AttackMoveSpeed = KickMoveSpeed;
		}
	}

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetAttackTarget(), 999, TurnSpeed);
		yield return WaitCustomEvent("StopTurn");
		StopWaitLookAt();
		yield return WaitCustomEvent("Move");
		BeginDashActorForward(1, AttackMoveSpeed, AttackMoveDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
