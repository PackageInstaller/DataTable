using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class MiniBoss_Dark_ShadowLaser : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private readonly string ZuanDi = "ZuanDi";

	private readonly string JumpOut = "Spawn_JumpOut";

	private readonly string Fire = "ShadowLaser_Fire";

	private readonly string Daze = "ShadowLaser_Daze";

	private readonly FP FireGap = 0.8;

	private readonly FP ShadowDistance = 10;

	private string Charge;

	private TSVector2 HomePos;

	private TSVector2 SkillPos;

	private DeterministicShape Shape01;

	private DeterministicShape ShadowShape;

	private LogicEntity Targetenemy;

	private List<LogicEntity> Shadow = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		HomePos = new TSVector2(0, 0);
		Shadow.Clear();
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			Charge = "ShadowLaser_Charge";
		}
		else
		{
			Charge = "ShadowLaser_Charge_L";
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, ZuanDi, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("HideModel");
		SetHideModelEnable();
		BeginLookAtCameraDir_NotWait(DirectionType.UP, 0.1, 3600);
		yield return WaitFrame(30);
		FP Rot = GetTSVectToAngle(GetForward(), 0);
		MiniBoss_Dark_ShadowLaser miniBoss_Dark_ShadowLaser = this;
		MiniBoss_Dark_ShadowLaser miniBoss_Dark_ShadowLaser2 = this;
		TSVector2 homePos = HomePos;
		FP radius = 14;
		FP innerRadius = 13;
		FP angle = 60;
		miniBoss_Dark_ShadowLaser.Shape01 = miniBoss_Dark_ShadowLaser2.GetShapeData(DeterministicShape.ShapeType.Fan, homePos, default, default, radius, innerRadius, angle, Rot);
		SkillPos = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
		Teleport(SkillPos);
		PlayEffect("fx_m50251_base_Dark_Atk03_Energy", 1f, 0, SkillPos, 0, 1f, actorScale: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.1, 3600);
		yield return WaitTime(0.5);
		BeginAttack(2, JumpOut, flushInputedKeys: true, forceInterruptAttack: true);
		SetHideModelDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(3, Born, flushInputedKeys: true, forceInterruptAttack: true);
		MiniBoss_Dark_ShadowLaser miniBoss_Dark_ShadowLaser3 = this;
		MiniBoss_Dark_ShadowLaser miniBoss_Dark_ShadowLaser4 = this;
		TSVector2 homePos2 = HomePos;
		FP radius2 = 14;
		angle = 13;
		innerRadius = 300;
		radius = Rot + 180;
		miniBoss_Dark_ShadowLaser3.ShadowShape = miniBoss_Dark_ShadowLaser4.GetShapeData(DeterministicShape.ShapeType.Fan, homePos2, default, default, radius2, angle, innerRadius, radius);
		yield return WaitCustomEvent("Summon");
		GetEnemy();
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			TSVector2 shapeRandomPoint2 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			for (int i = 0; i <= 100; i++)
			{
				if (!(Distance(shapeRandomPoint2, shapeRandomPoint) <= ShadowDistance))
				{
					break;
				}
				shapeRandomPoint2 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			}
			TSVector2 shapeRandomPoint3 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			for (int j = 0; j <= 100; j++)
			{
				if (!(Distance(shapeRandomPoint3, shapeRandomPoint) <= ShadowDistance) && !(Distance(shapeRandomPoint3, shapeRandomPoint2) <= ShadowDistance))
				{
					break;
				}
				shapeRandomPoint3 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			}
			TSVector2 shapeRandomPoint4 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			for (int k = 0; k <= 100; k++)
			{
				if (!(Distance(shapeRandomPoint4, shapeRandomPoint) <= ShadowDistance) && !(Distance(shapeRandomPoint4, shapeRandomPoint2) <= ShadowDistance) && !(Distance(shapeRandomPoint4, shapeRandomPoint3) <= ShadowDistance))
				{
					break;
				}
				shapeRandomPoint4 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			}
			SummonTeammate(1, shapeRandomPoint, GetEntityPosition(Targetenemy) - shapeRandomPoint);
			SummonTeammate(1, shapeRandomPoint2, GetEntityPosition(Targetenemy) - shapeRandomPoint2);
			SummonTeammate(1, shapeRandomPoint3, GetEntityPosition(Targetenemy) - shapeRandomPoint3);
			SummonTeammate(1, shapeRandomPoint4, GetEntityPosition(Targetenemy) - shapeRandomPoint4);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			Shadow.AddRange(GetTargetByTeammateIndex(1));
			BeginAttack(4, Charge, flushInputedKeys: true, forceInterruptAttack: true);
			AimAtMonsterTarget(90);
			DispatchCustomEvent("CastLaserSkill", isSelfEvent: false);
			yield return WaitTime(1.8);
			for (int l = 0; l < Shadow.Count; l++)
			{
				AddBuffToTarget(Shadow.get_Item(l), 502510013);
				yield return WaitTime(FireGap);
			}
		}
		else
		{
			TSVector2 shapeRandomPoint5 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			TSVector2 shapeRandomPoint6 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			for (int m = 0; m <= 100; m++)
			{
				if (!(Distance(shapeRandomPoint6, shapeRandomPoint5) <= ShadowDistance))
				{
					break;
				}
				shapeRandomPoint6 = GetShapeRandomPoint(ShadowShape, _actor, isReachable: true);
			}
			SummonTeammate(1, shapeRandomPoint5, GetEntityPosition(Targetenemy) - shapeRandomPoint5);
			SummonTeammate(1, shapeRandomPoint6, GetEntityPosition(Targetenemy) - shapeRandomPoint6);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			Shadow.AddRange(GetTargetByTeammateIndex(1));
			BeginAttack(5, Charge, flushInputedKeys: true, forceInterruptAttack: true);
			AimAtMonsterTarget(90);
			DispatchCustomEvent("CastLaserSkill", isSelfEvent: false);
			yield return WaitTime(3);
			for (int n = 0; n < Shadow.Count; n++)
			{
				AddBuffToTarget(Shadow.get_Item(n), 502510013);
			}
		}
		CancelAim();
		yield return WaitTime(0.5);
		BeginAttack(6, Fire, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("FireEnd");
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		RemoveBuffFromTarget(_actor, 502510010);
		yield return WaitFrame(8);
		BeginAttack(7, Daze, flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, 502510002);
		yield return WaitTime(1.9);
		RemoveBuffFromTarget(_actor, 502510002);
		CancelAttack();
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
}
