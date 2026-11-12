using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_DustSprayingWithBomb_Transform : SkillScript_TransformBase
{
	private string BombFXName;

	private int TmpChooseBomb;

	private FP TmpBombDirection;

	private FP turnAngle;

	protected override IEnumerator DoMainLogic()
	{
		TriggerOpLisener("BB4");
		BeginAttack(1, "ShaJuRen_Attack_3_Slow_Start", flushInputedKeys: true);
		yield return WaitCustomEvent("FindBomb");
		GetBombPoint();
		PlayEffect(BombFXName, 1.5f);
		BeginLookAtMonsterTarget(1, 180);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int i = 0; i < 3; i++)
		{
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4.5));
			SkillScript_DustSprayingWithBomb_Transform skillScript_DustSprayingWithBomb_Transform = this;
			FP radius = 5 + 3 * i;
			FP innerRadius = 3 + 3 * i;
			FP angle = 60;
			FP rotation = GetRotation();
			DeterministicShape shapeData = skillScript_DustSprayingWithBomb_Transform.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
			Shoot("Weapon_30931HaSaNa_Bomb", position, 1.2, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, GetShapeRandomPoint(shapeData, _actor, isReachable: true));
			yield return WaitTime(0.25);
		}
		CancelAttack();
		yield return WaitTime(0.1);
		BeginLookAtMonsterTarget(0.15, 800);
		BeginAttack(2, "ShaJuRen_Attack_3_Slow", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("FindBomb");
		GetBombPoint();
		PlayEffect(BombFXName, 1.5f);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int i = 0; i < 3; i++)
		{
			TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4.5));
			SkillScript_DustSprayingWithBomb_Transform skillScript_DustSprayingWithBomb_Transform2 = this;
			FP rotation = 5 + 3 * i;
			FP angle = 3 + 3 * i;
			FP innerRadius = 60;
			FP radius = GetRotation();
			DeterministicShape shapeData2 = skillScript_DustSprayingWithBomb_Transform2.GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, angle, innerRadius, radius);
			Shoot("Weapon_30931HaSaNa_Bomb", position2, 1.2, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, GetShapeRandomPoint(shapeData2, _actor, isReachable: true));
			yield return WaitTime(0.25);
		}
		CancelAttack();
		yield return WaitTime(0.1);
		BeginLookAtMonsterTarget(0.15, 800);
		BeginAttack(3, "ShaJuRen_Attack_3_Slow", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("FindBomb");
		PlayEffect("fx_m30932_base_Attack_3_SlowStart_line_bomb_01", 1.5f);
		PlayEffect("fx_m30932_base_Attack_3_SlowStart_line_bomb_02", 1.5f);
		PlayEffect("fx_m30932_base_Attack_3_SlowStart_line_bomb_03", 1.5f);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(FinalShoot());
		TSVector2 currentForward = GetForward();
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0)
		{
			turnAngle = 170;
		}
		else
		{
			turnAngle = -170;
		}
		TSVector2 tSVector = RotateTo(currentForward, turnAngle);
		TSVector2 turnForward2 = RotateTo(tSVector, turnAngle);
		yield return BeginLookAtByDir(tSVector, 1.9, 90);
		yield return BeginLookAtByDir(turnForward2, 1.9, 90);
		yield return BeginLookAtByDir(currentForward, 0.2, 90);
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetBombPoint()
	{
		TmpChooseBomb = 0;
		TmpBombDirection = 999;
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("Bombcar1");
		TSVector2 placeHolderPosition2 = GetPlaceHolderPosition("Bombcar2");
		TSVector2 placeHolderPosition3 = GetPlaceHolderPosition("Bombcar3");
		FP item = AngleBetween2TSVector(GetForward(), placeHolderPosition - GetPosition(), signed: false);
		FP item2 = AngleBetween2TSVector(GetForward(), placeHolderPosition2 - GetPosition(), signed: false);
		FP item3 = AngleBetween2TSVector(GetForward(), placeHolderPosition3 - GetPosition(), signed: false);
		List<FP> list = new List<FP> { item, item2, item3 };
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i) < TmpBombDirection)
			{
				TmpBombDirection = list.get_Item(i);
				TmpChooseBomb = i;
			}
		}
		switch (TmpChooseBomb)
		{
		case 0:
			BombFXName = "fx_m30932_base_Attack_3_SlowStart_line_bomb_01";
			break;
		case 1:
			BombFXName = "fx_m30932_base_Attack_3_SlowStart_line_bomb_02";
			break;
		case 2:
			BombFXName = "fx_m30932_base_Attack_3_SlowStart_line_bomb_03";
			break;
		}
	}

	private IEnumerator FinalShoot()
	{
		int BulletAmount = 15;
		for (int i = 0; i < BulletAmount; i++)
		{
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4.5));
			int num = (i + 3) % 3;
			SkillScript_DustSprayingWithBomb_Transform skillScript_DustSprayingWithBomb_Transform = this;
			FP radius = 5 + 3 * num;
			FP innerRadius = 3 + 3 * num;
			FP angle = 360 / BulletAmount;
			FP rotation = GetRotation();
			DeterministicShape shapeData = skillScript_DustSprayingWithBomb_Transform.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
			Shoot("Weapon_30931HaSaNa_Bomb", position, 1.2, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, GetShapeRandomPoint(shapeData, _actor, isReachable: true));
			yield return WaitTime(0.3);
		}
	}
}
