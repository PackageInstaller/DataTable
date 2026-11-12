using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._HuoChuiHuoDong._99900EmptyMonster;

public class Hail : SkillSimpleBase
{
	private LogicEntity Targetenemy;

	private FP WaitTime1;

	private FP WaitTime2;

	protected override void OnSkillEnable()
	{
		WaitTime1 = GetRandomValue(0, 1.5, isInt: true);
		WaitTime2 = GetRandomValue(0, 2.5, isInt: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		GetEntityPosition(Targetenemy);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_loop_snow", GetPosition());
		yield return WaitTime(0.5);
		if (GetBuffNum(_actor, 999000000) >= 1)
		{
			if (WaitTime1 < 1)
			{
				yield return WaitTime(1);
				StartCor(SpawnBulletGenerator2());
				StartCor(SpawnBulletGenerator1());
				StartCor(SpawnBulletGeneratorPlayer());
				yield return WaitTime(2);
				StartCor(SpawnBulletGenerator1());
				StartCor(SpawnBulletGenerator2());
			}
			else
			{
				yield return WaitTime(2);
				StartCor(SpawnBulletGenerator2());
				StartCor(SpawnBulletGenerator1());
				StartCor(SpawnBulletGeneratorPlayer());
				yield return WaitTime(2);
				StartCor(SpawnBulletGenerator1());
				StartCor(SpawnBulletGenerator2());
			}
		}
		else if (WaitTime2 < 1)
		{
			yield return WaitTime(1.5);
			StartCor(SpawnBulletGenerator4());
			StartCor(SpawnBulletGeneratorPlayer());
			yield return WaitTime(2);
			StartCor(SpawnBulletGenerator3());
		}
		else if (WaitTime2 == 1)
		{
			yield return WaitTime(2.5);
			StartCor(SpawnBulletGenerator4());
			StartCor(SpawnBulletGeneratorPlayer());
			yield return WaitTime(2);
			StartCor(SpawnBulletGenerator3());
		}
		else if (WaitTime2 > 1)
		{
			yield return WaitTime(3.5);
			StartCor(SpawnBulletGenerator4());
			StartCor(SpawnBulletGeneratorPlayer());
			yield return WaitTime(2);
			StartCor(SpawnBulletGenerator3());
		}
		yield return WaitTime(13);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		ClearActors(new List<LogicEntity> { _actor });
	}

	protected IEnumerator SpawnBulletGenerator1()
	{
		StartCor(StartHailBig1());
		yield return WaitTime(0.01);
	}

	protected IEnumerator SpawnBulletGenerator2()
	{
		StartCor(StartHailBig2());
		yield return WaitTime(0.01);
	}

	protected IEnumerator SpawnBulletGenerator3()
	{
		StartCor(StartHailSmall1());
		yield return WaitTime(0.01);
	}

	protected IEnumerator SpawnBulletGenerator4()
	{
		StartCor(StartHailSmall2());
		yield return WaitTime(0.01);
	}

	protected IEnumerator SpawnBulletGeneratorPlayer()
	{
		StartCor(StartHailPlayer());
		yield return WaitTime(0.01);
	}

	protected IEnumerator StartHailBig1()
	{
		Hail hail = this;
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3));
		FP width = 12;
		FP length = 6;
		FP rotation = 0;
		DeterministicShape shapeData = hail.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		Hail hail2 = this;
		TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -3));
		FP width2 = 12;
		FP length2 = 6;
		rotation = 0;
		DeterministicShape shapeData2 = hail2.GetShapeData(DeterministicShape.ShapeType.Rectangle, position2, width2, length2, default, default, default, rotation);
		TSVector2 SpawnPo1 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 SpawnPo2 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, SpawnPo1);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, SpawnPo2);
		yield return WaitTime(0.5);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", SpawnPo1);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", SpawnPo2);
		yield return WaitTime(0.8);
	}

	protected IEnumerator StartHailBig2()
	{
		Hail hail = this;
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 8));
		FP width = 12;
		FP length = 6;
		FP rotation = 0;
		DeterministicShape shapeData = hail.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		Hail hail2 = this;
		TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -8));
		FP width2 = 12;
		FP length2 = 6;
		rotation = 0;
		DeterministicShape shapeData2 = hail2.GetShapeData(DeterministicShape.ShapeType.Rectangle, position2, width2, length2, default, default, default, rotation);
		TSVector2 SpawnPo3 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 SpawnPo4 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, SpawnPo3);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, SpawnPo4);
		yield return WaitTime(0.5);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", SpawnPo3);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", SpawnPo4);
		yield return WaitTime(0.8);
	}

	protected IEnumerator StartHailSmall1()
	{
		Hail hail = this;
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3));
		FP width = 10;
		FP length = 6;
		FP rotation = 0;
		DeterministicShape shapeData = hail.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		Hail hail2 = this;
		TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -3));
		FP width2 = 10;
		FP length2 = 6;
		rotation = 0;
		DeterministicShape shapeData2 = hail2.GetShapeData(DeterministicShape.ShapeType.Rectangle, position2, width2, length2, default, default, default, rotation);
		TSVector2 SpawnPo1 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 SpawnPo2 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, SpawnPo1);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, SpawnPo2);
		yield return WaitTime(0.5);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", SpawnPo1);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", SpawnPo2);
		yield return WaitTime(0.8);
	}

	protected IEnumerator StartHailSmall2()
	{
		Hail hail = this;
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 7));
		FP width = 10;
		FP length = 5;
		FP rotation = 0;
		DeterministicShape shapeData = hail.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		Hail hail2 = this;
		TSVector2 position2 = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -7));
		FP width2 = 10;
		FP length2 = 5;
		rotation = 0;
		DeterministicShape shapeData2 = hail2.GetShapeData(DeterministicShape.ShapeType.Rectangle, position2, width2, length2, default, default, default, rotation);
		TSVector2 SpawnPo3 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 SpawnPo4 = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, SpawnPo3);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, SpawnPo4);
		yield return WaitTime(0.5);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", SpawnPo3);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", SpawnPo4);
		yield return WaitTime(0.8);
	}

	protected IEnumerator StartHailPlayer()
	{
		GetEnemy();
		TSVector2 Enemypos01 = GetEntityPosition(Targetenemy);
		PlayEarlyWarningEffect("fx_common_base_Fire_YuJing_circular_3", 0.8f, default, Enemypos01);
		yield return WaitTime(0.5);
		PlayAreaEffect("Area_99900_HuoChuiHuoDong_S", Enemypos01);
		yield return WaitTime(0.8);
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
