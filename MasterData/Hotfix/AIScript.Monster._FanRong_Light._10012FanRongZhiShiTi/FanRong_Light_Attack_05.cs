using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Light._10012FanRongZhiShiTi;

public class FanRong_Light_Attack_05 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack03 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._3
	};

	private FP HomeDistance;

	private TSVector2 FireStartPos;

	private TSVector2 SelfPos;

	private long PlayEffectName;

	protected override void OnSkillEnable()
	{
		HomeDistance = Distance(GetPosition(), new TSVector2(0, 0));
	}

	protected override void OnInterrupt(int comboIndex)
	{
		StopEffect(PlayEffectName);
		RemoveBuffFromTarget(_actor, 990020140);
		if (!ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FanRonShiTi_003))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FanRonShiTi_003);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990020140);
		if (HomeDistance >= 4)
		{
			SetCloseBlockEnable();
			BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtByPos(new TSVector2(0, 0), 0.5, 360, 0);
			yield return WaitFrame(15);
			DoDash();
			yield return WaitDashFinish();
			CancelAttack();
			SetCloseBlockDisable();
			yield return WaitFrame(10);
			BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.5, 360);
			yield return WaitFrame(30);
			StartCor(AttackCombo01());
			StartCor(AttackCombo02());
			yield return WaitFrame(325);
			CancelAttack();
			BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(70);
			RemoveBuffFromTarget(_actor, 990020140);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.5, 360);
			yield return WaitFrame(30);
			StartCor(AttackCombo01());
			StartCor(AttackCombo02());
			yield return WaitFrame(325);
			CancelAttack();
			BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(70);
			RemoveBuffFromTarget(_actor, 990020140);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private IEnumerator AttackCombo01()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			FireStartPos = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0.5f), _actor.tsTransform.Rotation);
			DoWave02();
			yield return WaitFrame(36);
			DoWave02();
			yield return WaitFrame(36);
			DoWave02();
			yield return WaitFrame(36);
			DoWave02();
			yield return WaitFrame(36);
			DoWave02();
			yield return WaitFrame(36);
			DoWave02();
			yield return WaitFrame(36);
			DoWave02();
			yield return WaitFrame(36);
			DoWave02();
		}
		else
		{
			FireStartPos = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0.5f), _actor.tsTransform.Rotation);
			DoWave01();
			yield return WaitFrame(50);
			DoWave01();
			yield return WaitFrame(50);
			DoWave01();
			yield return WaitFrame(50);
			DoWave01();
			yield return WaitFrame(50);
			DoWave01();
			yield return WaitFrame(50);
			DoWave01();
		}
	}

	private IEnumerator AttackCombo02()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			yield return WaitFrame(12);
			PlayEffectName = PlayEffect("Fx_10012_Light_Atk05_Energy", 1f, 0, FireStartPos);
			yield return WaitFrame(60);
			DoShoot();
			yield return WaitFrame(12);
			PlayEffectName = PlayEffect("Fx_10012_Light_Atk05_Energy", 1f, 0, FireStartPos);
			yield return WaitFrame(60);
			DoShoot();
			yield return WaitFrame(12);
			PlayEffectName = PlayEffect("Fx_10012_Light_Atk05_Energy", 1f, 0, FireStartPos);
			yield return WaitFrame(60);
			DoShoot();
			yield return WaitFrame(12);
			PlayEffectName = PlayEffect("Fx_10012_Light_Atk05_Energy", 1f, 0, FireStartPos);
			yield return WaitFrame(60);
			DoShoot();
		}
		else
		{
			FireStartPos = GetPosition() + TSVector2.Rotate(new TSVector2(0, 0.5f), _actor.tsTransform.Rotation);
			yield return WaitFrame(40);
			PlayEffectName = PlayEffect("Fx_10012_Light_Atk05_Energy", 1f, 0, FireStartPos);
			yield return WaitFrame(60);
			DoShoot();
			yield return WaitFrame(40);
			PlayEffectName = PlayEffect("Fx_10012_Light_Atk05_Energy", 1f, 0, FireStartPos);
			yield return WaitFrame(60);
			DoShoot();
			yield return WaitFrame(40);
			PlayEffectName = PlayEffect("Fx_10012_Light_Atk05_Energy", 1f, 0, FireStartPos);
			yield return WaitFrame(60);
			DoShoot();
		}
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 10, HomeDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void DoShoot()
	{
		PlayEffect("Fx_10012_Light_Atk05_LightWave", 1f, 0, GetPosition(), 0, 1.1f);
		CircleMultipleShoot("Weapon_Light_Skill05", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 45, 0, GetPosition(), 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0);
	}

	private void DoWave01()
	{
		TSVector2 position = new TSVector2(0, 0);
		FP radius = 16;
		FP innerRadius = 0;
		FP angle = 90;
		FP rotation = GetTSVectToAngle(GetForward(), 0) + 0;
		GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		TSVector2 position2 = new TSVector2(0, 0);
		rotation = 16;
		angle = 0;
		innerRadius = 90;
		radius = GetTSVectToAngle(GetForward(), 0) + 90;
		GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, angle, innerRadius, radius);
		TSVector2 position3 = new TSVector2(0, 0);
		radius = 16;
		innerRadius = 0;
		angle = 90;
		rotation = GetTSVectToAngle(GetForward(), 0) + 180;
		GetShapeData(DeterministicShape.ShapeType.Fan, position3, default, default, radius, innerRadius, angle, rotation);
		TSVector2 position4 = new TSVector2(0, 0);
		rotation = 16;
		angle = 0;
		innerRadius = 90;
		radius = GetTSVectToAngle(GetForward(), 0) + 270;
		GetShapeData(DeterministicShape.ShapeType.Fan, position4, default, default, rotation, angle, innerRadius, radius);
		TSVector2 position5 = new TSVector2(0, 0);
		radius = 14;
		innerRadius = 2;
		angle = 90;
		rotation = GetTSVectToAngle(GetForward(), 0) + 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position5, default, default, radius, innerRadius, angle, rotation);
		TSVector2 position6 = new TSVector2(0, 0);
		rotation = 14;
		angle = 2;
		innerRadius = 90;
		radius = GetTSVectToAngle(GetForward(), 0) + 90;
		DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Fan, position6, default, default, rotation, angle, innerRadius, radius);
		TSVector2 position7 = new TSVector2(0, 0);
		radius = 14;
		innerRadius = 2;
		angle = 90;
		rotation = GetTSVectToAngle(GetForward(), 0) + 180;
		DeterministicShape shapeData3 = GetShapeData(DeterministicShape.ShapeType.Fan, position7, default, default, radius, innerRadius, angle, rotation);
		TSVector2 position8 = new TSVector2(0, 0);
		rotation = 14;
		angle = 2;
		innerRadius = 90;
		radius = GetTSVectToAngle(GetForward(), 0) + 270;
		DeterministicShape shapeData4 = GetShapeData(DeterministicShape.ShapeType.Fan, position8, default, default, rotation, angle, innerRadius, radius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 shapeRandomPoint2 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
		TSVector2 shapeRandomPoint3 = GetShapeRandomPoint(shapeData3, _actor, isReachable: true);
		TSVector2 shapeRandomPoint4 = GetShapeRandomPoint(shapeData4, _actor, isReachable: true);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint2);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint3);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint4);
		PlayAreaEffect("AreaEffect_Light_Skill05", GetEntityPositionObsoleted(GetCurrentPlayer()));
	}

	private void DoWave02()
	{
		TSVector2 position = new TSVector2(0, 0);
		FP radius = 14;
		FP innerRadius = 2;
		FP angle = 60;
		FP rotation = GetTSVectToAngle(GetForward(), 0) + 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		TSVector2 position2 = new TSVector2(0, 0);
		rotation = 14;
		angle = 2;
		innerRadius = 60;
		radius = GetTSVectToAngle(GetForward(), 0) + 60;
		DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, angle, innerRadius, radius);
		TSVector2 position3 = new TSVector2(0, 0);
		radius = 14;
		innerRadius = 2;
		angle = 60;
		rotation = GetTSVectToAngle(GetForward(), 0) + 120;
		DeterministicShape shapeData3 = GetShapeData(DeterministicShape.ShapeType.Fan, position3, default, default, radius, innerRadius, angle, rotation);
		TSVector2 position4 = new TSVector2(0, 0);
		rotation = 14;
		angle = 2;
		innerRadius = 60;
		radius = GetTSVectToAngle(GetForward(), 0) + 180;
		DeterministicShape shapeData4 = GetShapeData(DeterministicShape.ShapeType.Fan, position4, default, default, rotation, angle, innerRadius, radius);
		TSVector2 position5 = new TSVector2(0, 0);
		radius = 14;
		innerRadius = 2;
		angle = 60;
		rotation = GetTSVectToAngle(GetForward(), 0) + 240;
		DeterministicShape shapeData5 = GetShapeData(DeterministicShape.ShapeType.Fan, position5, default, default, radius, innerRadius, angle, rotation);
		TSVector2 position6 = new TSVector2(0, 0);
		rotation = 14;
		angle = 2;
		innerRadius = 60;
		radius = GetTSVectToAngle(GetForward(), 0) + 300;
		DeterministicShape shapeData6 = GetShapeData(DeterministicShape.ShapeType.Fan, position6, default, default, rotation, angle, innerRadius, radius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 shapeRandomPoint2 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
		TSVector2 shapeRandomPoint3 = GetShapeRandomPoint(shapeData3, _actor, isReachable: true);
		TSVector2 shapeRandomPoint4 = GetShapeRandomPoint(shapeData4, _actor, isReachable: true);
		TSVector2 shapeRandomPoint5 = GetShapeRandomPoint(shapeData5, _actor, isReachable: true);
		TSVector2 shapeRandomPoint6 = GetShapeRandomPoint(shapeData6, _actor, isReachable: true);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint2);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint3);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint4);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint5);
		PlayAreaEffect("AreaEffect_Light_Skill05", shapeRandomPoint6);
		PlayAreaEffect("AreaEffect_Light_Skill05", GetEntityPositionObsoleted(GetCurrentPlayer()));
	}
}
