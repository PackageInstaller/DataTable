using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_FireStorm_Lv3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Fly_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly ComboInputBuffer.ActionKey[] Ultra_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private static readonly ComboInputBuffer.ActionKey[] Rest_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private static readonly TSVector2 MoveToPoint = new TSVector2(0, -15);

	private static readonly TSVector2 LookAtPoint = new TSVector2(0, 1);

	private static readonly int AttackTimes = 9;

	private static readonly FP ShapeRadius = 5;

	private TSVector2 DashDirection;

	private FP DashDistance;

	private FP IntervalTime;

	private int AttackCount;

	private TSVector2 AttackPosition;

	private long UltraAreaEffect;

	private CoroutineNode UltraAttackNode;

	private List<LogicEntity> TargetList = new List<LogicEntity>();

	private DeterministicShape AttackShape;

	private bool IsInterrupted;

	protected override void OnSkillEnable()
	{
		AttackCount = AttackTimes;
		IntervalTime = 0.5;
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
			SummonTeammate(1, GetPlaceHolderPosition("CommonSummonPoint1"), TSVector2.up, 4);
			SummonTeammate(1, GetPlaceHolderPosition("CommonSummonPoint2"), TSVector2.up, 4);
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
				IntervalTime = 0.35;
			}
			TargetList = GetTargetsByFaction(isFriend: false);
			foreach (LogicEntity target in TargetList)
			{
				if (CheckTargetIsValid(target))
				{
					AttackPosition = GetEntityPositionObsoleted(target);
					StartCor(ref UltraAttackNode, UltraAttack(AttackPosition, target));
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
		SummonTeammate(1, GetPlaceHolderPosition("CommonSummonPoint1"), TSVector2.up, 4);
		SummonTeammate(1, GetPlaceHolderPosition("CommonSummonPoint2"), TSVector2.up, 4);
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator UltraAttack(TSVector2 AttackPosition, LogicEntity AimTarget)
	{
		yield return WaitTime(IntervalTime);
		if (CheckTargetIsValid(AimTarget))
		{
			AttackPosition = GetEntityPositionObsoleted(AimTarget);
		}
		if (AimTarget == GetCurrentPlayer())
		{
			Skill_FireStorm_Lv3 skill_FireStorm_Lv = this;
			Skill_FireStorm_Lv3 skill_FireStorm_Lv2 = this;
			TSVector2 position = AttackPosition;
			FP shapeRadius = ShapeRadius;
			FP innerRadius = ShapeRadius - 0.1;
			FP angle = 60;
			FP entityAngle = GetEntityAngle(AimTarget);
			skill_FireStorm_Lv.AttackShape = skill_FireStorm_Lv2.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, shapeRadius, innerRadius, angle, entityAngle);
		}
		else
		{
			Skill_FireStorm_Lv3 skill_FireStorm_Lv3 = this;
			Skill_FireStorm_Lv3 skill_FireStorm_Lv4 = this;
			TSVector2 position2 = AttackPosition;
			FP entityAngle = ShapeRadius;
			FP angle = ShapeRadius - 0.1;
			skill_FireStorm_Lv3.AttackShape = skill_FireStorm_Lv4.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, entityAngle, angle);
		}
		PlayWwiseSound("mon_50511_fire_shoot_warning");
		PlayAreaEffect("GroundFireHitUltra", GetShapeRandomPoint(AttackShape, _actor, isReachable: true));
	}
}
