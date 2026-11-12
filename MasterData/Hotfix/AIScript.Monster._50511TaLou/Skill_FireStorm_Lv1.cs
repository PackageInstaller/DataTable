using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_FireStorm_Lv1 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Fly_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] Ultra_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private static readonly ComboInputBuffer.ActionKey[] Rest_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private static readonly TSVector2 MoveToPoint = new TSVector2(0, -15);

	private static readonly TSVector2 LookAtPoint = new TSVector2(0, 1);

	private static readonly int AttackTimes = 6;

	private TSVector2 DashDirection;

	private FP DashDistance;

	private FP IntervalTime;

	private int AttackCount;

	private long UltraAreaEffect;

	private CoroutineNode UltraAttackNode;

	private List<LogicEntity> TargetList = new List<LogicEntity>();

	private bool IsInterrupted;

	protected override void OnSkillEnable()
	{
		AttackCount = AttackTimes;
		IntervalTime = 0.75;
	}

	protected override void OnSkillDisable()
	{
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990020140);
		StopWaitLookAt();
		StopAreaEffect(UltraAreaEffect);
		StopCor(UltraAttackNode);
		if (IsInterrupted)
		{
			Singleton<InteractiveManager>.Instance.triggerOpListener("FireBoomMinus");
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBlockPriorityToStatic();
		AddBuffToTarget(_actor, 990020140);
		TSVector2 position = GetPosition();
		DashDirection = MoveToPoint - position;
		DashDistance = Distance(MoveToPoint, position);
		BeginAttack(1, Fly_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("StartDash");
		SetCloseBlockEnable();
		BeginDash(1, DashDirection, 15, DashDistance, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		yield return BeginLookAtByPos(LookAtPoint, 0, 150);
		CancelAttack();
		yield return WaitCustomEvent("TurnEnd");
		StopWaitLookAt();
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, Ultra_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		Singleton<InteractiveManager>.Instance.triggerOpListener("FireBoom");
		IsInterrupted = true;
		yield return WaitTime(1);
		UltraAreaEffect = PlayAreaEffect("FireAreaUltra", GetPosition());
		while (AttackCount >= 0)
		{
			if (AttackCount <= AttackTimes * 2 / 3)
			{
				IntervalTime = 0.5;
			}
			TargetList = GetTargetsByFaction(isFriend: false);
			foreach (LogicEntity target in TargetList)
			{
				if (CheckTargetIsValid(target))
				{
					StartCor(ref UltraAttackNode, UltraAttack(target));
					PlayWwiseSound("mon_50511_fire_shoot_warning");
					PlayAreaEffect("GroundFireHitUltra", GetEntityPositionObsoleted(target));
				}
			}
			AttackCount--;
			yield return WaitTime(IntervalTime * 2);
		}
		StopAreaEffect(UltraAreaEffect);
		StopCor(UltraAttackNode);
		BeginAttack(3, Rest_Combo);
		IsInterrupted = false;
		Singleton<InteractiveManager>.Instance.triggerOpListener("FireBoomMinus");
		yield return WaitTime(6);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator UltraAttack(LogicEntity AimTarget)
	{
		yield return WaitTime(IntervalTime);
		if (CheckTargetIsValid(AimTarget))
		{
			PlayWwiseSound("mon_50511_fire_shoot_warning");
			PlayAreaEffect("GroundFireHitUltra", GetEntityPositionObsoleted(AimTarget));
		}
	}
}
