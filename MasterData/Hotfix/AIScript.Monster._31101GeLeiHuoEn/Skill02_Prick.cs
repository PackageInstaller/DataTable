using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill02_Prick : SkillSimpleBase
{
	private readonly string combo_key1 = "Prick";

	private readonly string combo_key2 = "Cut";

	private readonly string Dodge_Left = "Dodge_Left";

	private readonly string Dodge_Right = "Dodge_Right";

	private readonly string combo_key3 = "Rush";

	private readonly string combo_key4 = "RushAttack";

	private long Weapon_EndFX;

	private CoroutineNode DistanceCor;

	private bool _isChecking = true;

	private DeterministicShape ChooseShape;

	private LogicEntity Target;

	private TSVector2 DodgePosition;

	private TSVector2 DodgePosition_Tmp;

	private TSVector2 TargetPosition;

	private bool NeedAnotherDodge;

	private bool IsAnotherDodge;

	private FP SkillTimes01;

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
		SkillTimes01 = 0;
		NeedAnotherDodge = false;
		IsAnotherDodge = false;
	}

	protected override void OnSkillDisable()
	{
		StopCor(DistanceCor);
		_isChecking = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(ChooseDodgePoint(IsAnotherDodge: false));
		yield return StartCor(Dodge());
		if (NeedAnotherDodge)
		{
			IsAnotherDodge = true;
			yield return StartCor(ChooseDodgePoint(IsAnotherDodge: true));
			yield return StartCor(Dodge());
		}
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.6, 7200);
		yield return WaitTime(0.1);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.6);
		if (GetBuffNum(_actor, 311010000) >= 1)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			if (Distance(GetPosition(), GetEntityPosition(currentPlayer)) <= 7)
			{
				BeginAttack(2, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(1.15);
				Weapon_EndFX = PlayEffect("fx_m31101_base_Attack_2_1_weapon_end", 1f, 0, GetPosition(), 0);
				yield return WaitTime(0.15);
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, 0.25, 300);
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
				yield break;
			}
			BeginAttack(3, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.8);
			BeginAttack(4, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			_isChecking = true;
			BeginLookAt_NotWait(Targetenemy, 0.43, 720);
			yield return WaitTime(0.83);
			Dash();
			DistanceCor = StartCor(StartCheckLoop());
			yield return WaitDashFinish();
			StopCor(DistanceCor);
			_isChecking = false;
			if (SkillTimes01 == 0)
			{
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			else
			{
				BeginAttack(5, combo_key4, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
		else
		{
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected IEnumerator StartCheckLoop()
	{
		while (_isChecking)
		{
			yield return null;
			TSVector2 position = GetPosition();
			TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
			if (Distance(position, entityPosition) <= 1.6)
			{
				StopDash();
				_isChecking = false;
				SkillTimes01 = 1;
			}
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, 30, 12.8, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private IEnumerator Dodge()
	{
		if (!(Distance(DodgePosition, GetPosition()) <= 4) || !IsAnotherDodge)
		{
			yield return WaitTime(0.1);
			if (AngleBetween2TSVector(GetPosition() - TargetPosition, GetPosition() - DodgePosition, signed: true) >= 0)
			{
				BeginAttack(6, Dodge_Left, flushInputedKeys: true, forceInterruptAttack: true);
			}
			else
			{
				BeginAttack(7, Dodge_Right, flushInputedKeys: true, forceInterruptAttack: true);
			}
			BeginLookAtByPos_NotWait(TargetPosition, 99, 9999);
			yield return WaitTime(0.25);
			BeginDash(9, DodgePosition - GetPosition(), 100, Distance(DodgePosition, GetPosition()), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
			StopWaitLookAt();
		}
	}

	private IEnumerator ChooseDodgePoint(bool IsAnotherDodge)
	{
		Target = GetAttackTarget();
		if (!CheckTargetIsValid(Target))
		{
			yield break;
		}
		TargetPosition = GetEntityPosition(Target);
		int ChooseShapeRotation = 90;
		Skill02_Prick skill02_Prick = this;
		Skill02_Prick skill02_Prick2 = this;
		TSVector2 targetPosition = TargetPosition;
		FP radius = 1.5;
		FP innerRadius = 1.2;
		FP angle = 15;
		FP rotation = ChooseShapeRotation + GetTSVectToAngle(GetPosition() - TargetPosition, 0);
		skill02_Prick.ChooseShape = skill02_Prick2.GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition, default, default, radius, innerRadius, angle, rotation);
		DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
		int trytime = 0;
		while (DodgePosition == TargetPosition && trytime < 30)
		{
			ChooseShapeRotation *= -1;
			Skill02_Prick skill02_Prick3 = this;
			Skill02_Prick skill02_Prick4 = this;
			TSVector2 targetPosition2 = TargetPosition;
			rotation = 1.5;
			angle = 1.2;
			innerRadius = 15;
			radius = ChooseShapeRotation + GetTSVectToAngle(GetPosition() - TargetPosition, 0);
			skill02_Prick3.ChooseShape = skill02_Prick4.GetShapeData(DeterministicShape.ShapeType.Fan, targetPosition2, default, default, rotation, angle, innerRadius, radius);
			DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
			trytime++;
			if (trytime > 15)
			{
				Skill02_Prick skill02_Prick5 = this;
				Skill02_Prick skill02_Prick6 = this;
				TSVector2 targetPosition3 = TargetPosition;
				radius = 2.5;
				innerRadius = 2.2;
				angle = 15;
				skill02_Prick5.ChooseShape = skill02_Prick6.GetShapeData(DeterministicShape.ShapeType.Circle, targetPosition3, default, default, radius, innerRadius, angle);
				DodgePosition = GetShapeRandomPoint(ChooseShape, _actor, isReachable: true);
			}
			yield return null;
		}
		if (!IsAnotherDodge)
		{
			TSVector2 csOrigin = (DodgePosition_Tmp + GetPosition()) / 2;
			if (Distance(DodgePosition, GetPosition()) > 7)
			{
				DodgePosition_Tmp = DodgePosition;
				DodgePosition = TransLocalPosToWorldPos(csOrigin, RotateTo(DodgePosition_Tmp - GetPosition(), -ChooseShapeRotation), new TSVector2(0, Distance(DodgePosition_Tmp, GetPosition()) / 3));
				NeedAnotherDodge = true;
			}
			else if (Distance(DodgePosition, GetPosition()) < 3)
			{
				DodgePosition_Tmp = DodgePosition;
				DodgePosition = TransLocalPosToWorldPos(csOrigin, RotateTo(DodgePosition_Tmp - GetPosition(), -ChooseShapeRotation), new TSVector2(0, Distance(DodgePosition_Tmp, GetPosition()) * 3));
				NeedAnotherDodge = true;
			}
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
}
