using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_HorizontalSlash : SkillScript_MeeleBase
{
	private readonly string comboTag_Stage1 = "Attack_1";

	private readonly string comboTag_Stage2 = "Attack_2_1";

	private readonly string comboTag_Stage2_Strength = "Attack_2_2";

	private readonly FP rotateDuration = 0.2;

	private readonly FP rotateSpeed = 300;

	private readonly string eventName_AddStrengthBuff = "TurnToHammer";

	private readonly string eventName_RemoveStrengthBuff = "HammerEnd";

	private readonly int buffId_Strength = 309310010;

	protected readonly string LeftDodge_Combo = "LeftDodge";

	protected readonly string RightDodge_Combo = "RightDodge";

	protected readonly string LeftDodge_Combo_Fast = "LeftDodge_Fast";

	protected readonly string RightDodge_Combo_Fast = "RightDodge_Fast";

	private DeterministicShape ChooseShape;

	private LogicEntity Target;

	private TSVector2 DodgePosition;

	private TSVector2 DodgePosition_Tmp;

	private TSVector2 TargetPosition;

	private string Dodge_Combo;

	private bool NeedAnotherDodge;

	private bool IsAnotherDodge;

	private long FlashFX;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		NeedAnotherDodge = false;
		IsAnotherDodge = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(), 0.25, 999);
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
		BeginAttack(1, comboTag_Stage1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("NextCombo");
		BeginAttack(2, _isStrength ? comboTag_Stage2_Strength : comboTag_Stage2, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtMonsterTarget(rotateDuration, rotateSpeed);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (_isStrength && string.Equals(eventName, eventName_AddStrengthBuff))
		{
			AddBuffToTarget(_actor, buffId_Strength);
		}
		if (_isStrength && string.Equals(eventName, eventName_RemoveStrengthBuff))
		{
			RemoveBuffFromTarget(_actor, buffId_Strength);
		}
	}

	private IEnumerator Dodge()
	{
		if ((Distance(DodgePosition, GetPosition()) <= 4 && IsAnotherDodge) || Distance(DodgePosition, GetPosition()) == 0)
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
		if (!IsAnotherDodge)
		{
			yield return WaitCustomEvent("Dodge");
		}
		BeginDash(9, DodgePosition - GetPosition(), 40, Distance(DodgePosition, GetPosition()), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopEffect(FlashFX);
		StopWaitLookAt();
	}

	private IEnumerator ChooseDodgePoint(bool IsAnotherDodge)
	{
		Target = GetAttackTarget();
		if (CheckTargetIsValid(Target))
		{
			TargetPosition = GetEntityPosition(Target);
		}
		int ChooseShapeRotation = 90;
		SkillScript_HorizontalSlash skillScript_HorizontalSlash = this;
		SkillScript_HorizontalSlash skillScript_HorizontalSlash2 = this;
		TSVector2 targetPosition = TargetPosition;
		FP radius = 2.5;
		FP innerRadius = 2.2;
		FP angle = 15;
		FP rotation = ChooseShapeRotation + GetTSVectToAngle(GetPosition() - TargetPosition, 0);
		skillScript_HorizontalSlash.ChooseShape = skillScript_HorizontalSlash2.GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition, default, default, radius, innerRadius, angle, rotation);
		DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
		int trytime = 0;
		while (DodgePosition == TargetPosition && trytime < 15)
		{
			ChooseShapeRotation *= -1;
			SkillScript_HorizontalSlash skillScript_HorizontalSlash3 = this;
			SkillScript_HorizontalSlash skillScript_HorizontalSlash4 = this;
			TSVector2 targetPosition2 = TargetPosition;
			rotation = 2.5;
			angle = 2.2;
			innerRadius = 15;
			radius = ChooseShapeRotation + GetTSVectToAngle(GetPosition() - TargetPosition, 0);
			skillScript_HorizontalSlash3.ChooseShape = skillScript_HorizontalSlash4.GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition2, default, default, rotation, angle, innerRadius, radius);
			DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
			trytime++;
			if (trytime >= 15)
			{
				SkillScript_HorizontalSlash skillScript_HorizontalSlash5 = this;
				SkillScript_HorizontalSlash skillScript_HorizontalSlash6 = this;
				TSVector2 targetPosition3 = TargetPosition;
				radius = 2.5;
				innerRadius = 2.2;
				angle = 15;
				skillScript_HorizontalSlash5.ChooseShape = skillScript_HorizontalSlash6.GetShapeData(DeterministicShape.ShapeType.Circle, targetPosition3, default, default, radius, innerRadius, angle);
				DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
			}
			yield return null;
		}
		if (!IsAnotherDodge && Distance(DodgePosition, GetPosition()) > 15)
		{
			DodgePosition_Tmp = DodgePosition;
			DodgePosition = TransLocalPosToWorldPos((DodgePosition_Tmp + GetPosition()) / 2, RotateTo(DodgePosition_Tmp - GetPosition(), -ChooseShapeRotation), new TSVector2(0, Distance(DodgePosition_Tmp, GetPosition()) / 3));
			NeedAnotherDodge = true;
		}
	}
}
