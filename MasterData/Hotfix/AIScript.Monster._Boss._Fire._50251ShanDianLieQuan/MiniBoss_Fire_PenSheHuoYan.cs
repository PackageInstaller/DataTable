using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_PenSheHuoYan : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Teleport01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1750359160,
		(ComboInputBuffer.ActionKey)1348824421,
		(ComboInputBuffer.ActionKey)1550545509
	};

	private readonly ComboInputBuffer.ActionKey[] Teleport02 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1968402017,
		(ComboInputBuffer.ActionKey)1699440963,
		(ComboInputBuffer.ActionKey)1953394499
	};

	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._0
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Stun = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._2
	};

	private long PlayEffectName;

	private TSVector2 HomePos;

	private TSVector2 SkillPos;

	private DeterministicShape Shape01;

	private DeterministicShape Shape02;

	private DeterministicShape Shape03;

	private DeterministicShape Shape04;

	protected override void OnSkillEnable()
	{
		HomePos = new TSVector2(0, 0);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Teleport01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		BeginLookAtCameraDir_NotWait(DirectionType.UP, 0.1, 3600);
		yield return WaitFrame(30);
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		MiniBoss_Fire_PenSheHuoYan miniBoss_Fire_PenSheHuoYan = this;
		MiniBoss_Fire_PenSheHuoYan miniBoss_Fire_PenSheHuoYan2 = this;
		TSVector2 homePos = HomePos;
		FP radius = 14;
		FP innerRadius = 13;
		FP angle = 90;
		FP rotation = tSVectToAngle;
		miniBoss_Fire_PenSheHuoYan.Shape01 = miniBoss_Fire_PenSheHuoYan2.GetShapeData(DeterministicShape.ShapeType.Fan, homePos, default, default, radius, innerRadius, angle, rotation);
		SkillPos = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
		Teleport(SkillPos);
		if (GetBuffNum(_actor, 502510009) == 0)
		{
			BeginLookAtByPos_NotWait(HomePos, 0, 3600);
			yield return WaitFrame(6);
			MiniBoss_Fire_PenSheHuoYan miniBoss_Fire_PenSheHuoYan3 = this;
			MiniBoss_Fire_PenSheHuoYan miniBoss_Fire_PenSheHuoYan4 = this;
			TSVector2 position = GetPosition();
			rotation = 35;
			angle = 0;
			innerRadius = 90;
			radius = GetTSVectToAngle(GetForward(), 0) + 45;
			miniBoss_Fire_PenSheHuoYan3.Shape02 = miniBoss_Fire_PenSheHuoYan4.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, rotation, angle, innerRadius, radius);
			MiniBoss_Fire_PenSheHuoYan miniBoss_Fire_PenSheHuoYan5 = this;
			MiniBoss_Fire_PenSheHuoYan miniBoss_Fire_PenSheHuoYan6 = this;
			TSVector2 position2 = GetPosition();
			radius = 35;
			innerRadius = 0;
			angle = 1;
			rotation = GetTSVectToAngle(GetForward(), 0) + 60;
			miniBoss_Fire_PenSheHuoYan5.Shape03 = miniBoss_Fire_PenSheHuoYan6.GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, radius, innerRadius, angle, rotation);
			MiniBoss_Fire_PenSheHuoYan miniBoss_Fire_PenSheHuoYan7 = this;
			MiniBoss_Fire_PenSheHuoYan miniBoss_Fire_PenSheHuoYan8 = this;
			TSVector2 position3 = GetPosition();
			rotation = 35;
			angle = 0;
			innerRadius = 1;
			radius = GetTSVectToAngle(GetForward(), 0) - 60;
			miniBoss_Fire_PenSheHuoYan7.Shape04 = miniBoss_Fire_PenSheHuoYan8.GetShapeData(DeterministicShape.ShapeType.Fan, position3, default, default, rotation, angle, innerRadius, radius);
			BeginAttack(2, Teleport02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Appear");
			SetHideModelDisable();
			GetCurrentPlayer();
			if (AreaCheckMonsterTarget(Shape02))
			{
				BeginAttack(3, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
				BeginLookAtByPos_NotWait(GetShapeRandomPoint(Shape03, _actor), 0.4, 360);
				yield return WaitFrame(60);
				BeginAttack(4, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Fire");
				BeginRotateAngle_NotWait(-90, 30);
			}
			else
			{
				BeginAttack(3, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
				BeginLookAtByPos_NotWait(GetShapeRandomPoint(Shape04, _actor), 0.4, 360);
				yield return WaitFrame(60);
				BeginAttack(4, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Fire");
				BeginRotateAngle_NotWait(90, 30);
			}
			yield return WaitTime(3);
			CancelAim();
			CancelAttack();
			RemoveBuffFromTarget(_actor, 502510007);
			yield return WaitFrame(8);
			BeginAttack(5, Stun, flushInputedKeys: true, forceInterruptAttack: true);
			AddBuffToTarget(_actor, 502510002);
			yield return WaitTime(1.9);
			RemoveBuffFromTarget(_actor, 502510002);
			CancelAttack();
		}
		else
		{
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.1, 3600);
			yield return WaitFrame(6);
			BeginAttack(2, Teleport02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Appear");
			SetHideModelDisable();
			BeginAttack(3, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(GetCurrentPlayer(), 1.4, 45);
			yield return WaitFrame(60);
			BeginAttack(4, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Fire");
			LogicEntity currentPlayer = GetCurrentPlayer();
			AimAtTarget(currentPlayer, 20);
			yield return WaitTime(3);
			CancelAim();
			CancelAttack();
			RemoveBuffFromTarget(_actor, 502510007);
			yield return WaitFrame(8);
			BeginAttack(5, Stun, flushInputedKeys: true, forceInterruptAttack: true);
			AddBuffToTarget(_actor, 502510002);
			yield return WaitTime(1.9);
			RemoveBuffFromTarget(_actor, 502510002);
			CancelAttack();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
