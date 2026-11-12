using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Water._50181ShunYiGuai;

public class Water_Attack05 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack05 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly ComboInputBuffer.ActionKey[] Teleport01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly ComboInputBuffer.ActionKey[] Teleport02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._2
	};

	private TSVector2 ShadowPosition1;

	private TSVector2 ShadowPosition2;

	private TSVector2 ShadowPosition3;

	private LogicEntity Targetenemy;

	protected override void OnInterrupt(int comboIndex)
	{
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(2);
		ClearActors(targetByTeammateIndex);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), new TSVector2(0, 0)) > 0.1)
		{
			BeginAttack(1, Teleport01, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Disappear");
			SetHideModelEnable();
			SetUnparalleledEnable();
			Teleport(new TSVector2(0, 0));
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.1, 360);
			yield return WaitTime(0.15);
			BeginAttack(1, Teleport02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Appear");
			SetUnparalleledDisable();
			SetHideModelDisable();
		}
		BeginAttack(3, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity attackTarget = GetAttackTarget();
		yield return BeginLookAt(attackTarget, 0.1, 3600);
		yield return WaitCustomEvent("Summon");
		if (GetBuffNum(_actor, 501810005) >= 1)
		{
			SummonTeammatesInCircle1();
			StartCor(SummonTeammatesInCircle2());
			yield return WaitFrame(310);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			StartCor(SummonTeammatesInCircle2());
			yield return WaitFrame(310);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void SummonTeammatesInCircle1()
	{
		int index = 1;
		TSVector2 tSVector = new TSVector2(FP.Zero, FP.Zero);
		FP fP = FP.FromFloat(13f);
		int num = 3;
		FP fP2 = 360 / num;
		for (int i = 0; i < num; i++)
		{
			FP x = i * fP2 * FP.Pi / 180;
			TSVector2 tSVector2 = ((!(fP * fP < FP.FromFloat(0.001f))) ? new TSVector2(FP.Cos(x), FP.Sin(x)) : new TSVector2(FP.One, FP.Zero));
			TSVector2 spawnPosition = tSVector - fP * tSVector2;
			SummonTeammate(index, spawnPosition, tSVector2);
		}
	}

	private IEnumerator SummonTeammatesInCircle2()
	{
		TSVector2 tSVector = new TSVector2(FP.Zero, FP.Zero);
		FP fP = FP.FromFloat(7f);
		int num = 3;
		FP fP2 = 360 / num;
		for (int i = 0; i < num; i++)
		{
			FP x = (i * fP2 + 60) * FP.Pi / 180;
			TSVector2 tSVector2 = ((!(fP * fP < FP.FromFloat(0.001f))) ? new TSVector2(FP.Cos(x), FP.Sin(x)) : new TSVector2(FP.One, FP.Zero));
			TSVector2 tSVector3 = tSVector - fP * tSVector2;
			switch (i)
			{
			case 0:
				ShadowPosition1 = tSVector3;
				break;
			case 1:
				ShadowPosition2 = tSVector3;
				break;
			case 2:
				ShadowPosition3 = tSVector3;
				break;
			}
			PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill05_Ex_BigDoor_S_Warning", tSVector3);
		}
		yield return WaitTime(2.5);
		GetEnemy();
		PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill05_Fountain_Big", ShadowPosition1);
		TSVector2 entityPosition = GetEntityPosition(Targetenemy);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill05_Ex_Big", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, ShadowPosition1, 0, entityPosition - ShadowPosition1, 0, AimType.Position, BulletDirectionType.BulletToTarget, default, 0, entityPosition);
		yield return WaitTime(1.8);
		GetEnemy();
		PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill05_Fountain_Big", ShadowPosition2);
		TSVector2 entityPosition2 = GetEntityPosition(Targetenemy);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill05_Ex_Big", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, ShadowPosition2, 0, entityPosition2 - ShadowPosition2, 0, AimType.Position, BulletDirectionType.BulletToTarget, default, 0, entityPosition2);
		yield return WaitTime(1.8);
		GetEnemy();
		PlayAreaEffect("Area_50181_ShunYiGuai_Water_Skill05_Fountain_Big", ShadowPosition3);
		TSVector2 entityPosition3 = GetEntityPosition(Targetenemy);
		CircleMultipleShoot("Bullet_50181_ShunYiGuai_Water_Skill05_Ex_Big", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, ShadowPosition3, 0, entityPosition3 - ShadowPosition3, 0, AimType.Position, BulletDirectionType.BulletToTarget, default, 0, entityPosition3);
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
