using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Attack01_Temporary : SkillSimpleBase
{
	private static readonly string NormalAttack01 = "NormalAttack01";

	private static readonly string NormalAttack02 = "NormalAttack02";

	protected readonly string LeftDodge_Combo = "LeftDodge";

	protected readonly string RightDodge_Combo = "RightDodge";

	protected readonly string LeftDodge_Combo_Fast = "LeftDodge_Fast";

	protected readonly string RightDodge_Combo_Fast = "RightDodge_Fast";

	private LogicEntity Targetenemy;

	private DeterministicShape ChooseShape;

	private TSVector2 DodgePosition;

	private TSVector2 DodgePosition_Tmp;

	private TSVector2 TargetPosition;

	private bool NeedAnotherDodge;

	private bool IsAnotherDodge;

	private string Dodge_Combo;

	protected override void OnSkillEnable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			GetEnemy();
			yield return BeginLookAt(Targetenemy, 0.25, 999);
			if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 3.5)
			{
				yield return StartCor(ChooseDodgePoint(IsAnotherDodge: false));
				yield return StartCor(Dodge());
				if (NeedAnotherDodge)
				{
					IsAnotherDodge = true;
					yield return StartCor(ChooseDodgePoint(IsAnotherDodge: true));
					yield return StartCor(Dodge());
				}
			}
		}
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.3, 600);
		BeginAttack(1, NormalAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("combo");
		BeginAttack(2, NormalAttack02, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 0.5, 360);
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

	private IEnumerator Dodge()
	{
		if (Distance(DodgePosition, GetPosition()) <= 4 && IsAnotherDodge)
		{
			yield break;
		}
		if (AngleBetween2TSVector(GetPosition() - TargetPosition, GetPosition() - DodgePosition, signed: true) >= 0)
		{
			if (IsAnotherDodge)
			{
				Dodge_Combo = LeftDodge_Combo_Fast;
			}
			else
			{
				Dodge_Combo = LeftDodge_Combo;
			}
		}
		else if (IsAnotherDodge)
		{
			Dodge_Combo = RightDodge_Combo_Fast;
		}
		else
		{
			Dodge_Combo = RightDodge_Combo;
		}
		BeginAttack(2, Dodge_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByPos_NotWait(TargetPosition, 99, 9999);
		yield return WaitCustomEvent("Dodge");
		BeginDash(9, DodgePosition - GetPosition(), 40, Distance(DodgePosition, GetPosition()), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopWaitLookAt();
	}

	private IEnumerator ChooseDodgePoint(bool IsAnotherDodge)
	{
		GetEnemy();
		if (CheckTargetIsValid(Targetenemy))
		{
			TargetPosition = GetEntityPosition(Targetenemy);
		}
		int ChooseShapeRotation = 90;
		Attack01_Temporary attack01_Temporary = this;
		Attack01_Temporary attack01_Temporary2 = this;
		TSVector2 targetPosition = TargetPosition;
		FP radius = 2.5;
		FP innerRadius = 2.2;
		FP angle = 15;
		FP rotation = ChooseShapeRotation + GetTSVectToAngle(GetPosition() - TargetPosition, 0);
		attack01_Temporary.ChooseShape = attack01_Temporary2.GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition, default, default, radius, innerRadius, angle, rotation);
		DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
		int trytime = 0;
		while (DodgePosition == TargetPosition && trytime < 15)
		{
			ChooseShapeRotation *= -1;
			Attack01_Temporary attack01_Temporary3 = this;
			Attack01_Temporary attack01_Temporary4 = this;
			TSVector2 targetPosition2 = TargetPosition;
			rotation = 2.5;
			angle = 2.2;
			innerRadius = 15;
			radius = ChooseShapeRotation + GetTSVectToAngle(GetPosition() - TargetPosition, 0);
			attack01_Temporary3.ChooseShape = attack01_Temporary4.GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition2, default, default, rotation, angle, innerRadius, radius);
			DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
			trytime++;
			if (trytime >= 15)
			{
				Attack01_Temporary attack01_Temporary5 = this;
				Attack01_Temporary attack01_Temporary6 = this;
				TSVector2 targetPosition3 = TargetPosition;
				radius = 2.5;
				innerRadius = 2.2;
				angle = 15;
				attack01_Temporary5.ChooseShape = attack01_Temporary6.GetShapeData(DeterministicShape.ShapeType.Circle, targetPosition3, default, default, radius, innerRadius, angle);
				DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
			}
			yield return null;
		}
		if (!IsAnotherDodge && Distance(DodgePosition, GetPosition()) > 15)
		{
			DodgePosition_Tmp = DodgePosition;
			DodgePosition = TransLocalPosToWorldPos(DodgePosition_Tmp + GetPosition() / 2, RotateTo(DodgePosition_Tmp - GetPosition(), -ChooseShapeRotation), new TSVector2(0, Distance(DodgePosition_Tmp, GetPosition()) / 3));
			NeedAnotherDodge = true;
		}
	}
}
