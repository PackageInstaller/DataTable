#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_MobileHipFire_LD_02 : SkillBaseMaoYan
{
	private bool interrupt;

	private bool sweepDirection;

	private IEnumerator ShootingCor;

	private LogicEntity target;

	private List<long> fxIdList = new List<long>();

	protected override void OnSkillEnable()
	{
		sweepDirection = false;
		interrupt = true;
	}

	protected override void OnSkillDisable()
	{
		ShootingCor = null;
		if (interrupt && fxIdList.Count > 0)
		{
			foreach (long fxId in fxIdList)
			{
				StopEffect(fxId);
			}
			fxIdList.Clear();
		}
		fxIdList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		BeginAttack(BarrageIndex, BarrageCombo, flushInputedKeys: false, forceInterruptAttack: true);
		yield return WaitTime(0.3);
		List<TSVector2> barragePOS = new List<TSVector2>
		{
			new TSVector2(0, 6.5),
			new TSVector2(-6.5, 0),
			new TSVector2(0, -6.5),
			new TSVector2(6.5, 0)
		};
		for (int i = 0; i < 4; i++)
		{
			StartCor(SpawnBullet(barragePOS.get_Item(i), 8));
			yield return WaitTime(0.8);
		}
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return StartCor(AttackFlow());
	}

	private IEnumerator SpawnBullet(TSVector2 spawnPos, int bulletCount)
	{
		long groundFxID = PlayEffect("fx_m70021_loop_atk_Eyes_Loop_ground", 1f, default, spawnPos);
		fxIdList.Add(groundFxID);
		yield return WaitTime(0.5);
		TSVector2 direction = spawnPos - TSVector2.zero;
		List<long> spawnBulletFxID = new List<long>();
		for (int i = 0; i < bulletCount; i++)
		{
			TSVector2 tSVector = RotateTo(direction, 180 / bulletCount);
			TSVector2 position = TransLocalPosToWorldPos(spawnPos, tSVector, RotateTo(new TSVector2(0, 1.8) - TSVector2.zero, 45 * -i));
			FP tSVectToAngle = GetTSVectToAngle(tSVector, 360 / bulletCount * -i);
			long item = PlayEffect("fx_m70021_base_atk_Eyes_born", 1f, 1, position, tSVectToAngle);
			spawnBulletFxID.Add(item);
			fxIdList.Add(item);
			yield return WaitTime(0.2);
		}
		yield return WaitTime(2.5);
		StopEffect(groundFxID);
		if (spawnBulletFxID != null && spawnBulletFxID.Count > 0)
		{
			for (int j = 0; j < spawnBulletFxID.Count; j++)
			{
				StopEffect(spawnBulletFxID.get_Item(j));
			}
		}
		CircleMultipleShoot("Bullet_Barrage_Slow", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, spawnPos, 1, direction, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 1.8);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mon_70021_base_screen_BrarrageSpreadSlowMULTI");
	}

	protected IEnumerator AttackFlow()
	{
		TSVector2 destination = GetDestination();
		yield return StartCor(Roll(destination, playEarlyWarning: true));
		yield return StartCor(SweepFire());
		destination = GetDestination();
		yield return StartCor(Slide(destination, playEarlyWarning: true));
		yield return StartCor(StationaryFire());
		destination = GetDestination();
		yield return StartCor(Roll(destination, playEarlyWarning: true));
		yield return StartCor(SweepFire());
		interrupt = false;
		yield return StartCor(Reload());
	}

	private TSVector2 GetDestination()
	{
		TSVector2 tSVector = TSVector2.zero;
		TSVector2 position = GetPosition();
		FP fP = Distance(position, TSVector2.zero);
		TSVector2 entityPosition = GetEntityPosition(target);
		FP tSVectToAngle = GetTSVectToAngle(position - entityPosition, 0);
		if (fP > 10)
		{
			entityPosition = position;
			tSVectToAngle = GetTSVectToAngle(TSVector2.zero - position, 0);
			NovaLogger.Debug("猫眼.翻滚.板边");
		}
		else
		{
			entityPosition = GetEntityPosition(target);
			tSVectToAngle = GetTSVectToAngle(position - entityPosition, 0);
			NovaLogger.Debug("猫眼.翻滚.非板边");
		}
		FP fP2 = 0;
		FP fP3 = 1;
		FP fP4 = 1;
		FP fP5 = 0;
		switch (GetPlayerJobType((AdventureActor)GetCurrentPlayer()))
		{
		case 1:
			fP2 = 4;
			fP3 = 7;
			fP4 = 8;
			fP5 = 5;
			NovaLogger.Debug("猫眼.翻滚.近战玩家");
			break;
		case 2:
			fP2 = 10;
			fP3 = 15;
			fP4 = 15;
			fP5 = 7;
			NovaLogger.Debug("猫眼.翻滚.远程玩家");
			break;
		default:
			fP2 = 4;
			fP3 = 7;
			fP4 = 8;
			fP5 = 5;
			NovaLogger.Debug("猫眼.翻滚.玩家角色Job异常,默认近战");
			break;
		}
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, entityPosition, default, default, fP4, fP5, 90, tSVectToAngle);
		for (int i = 0; i < 10; i++)
		{
			tSVector = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			FP fP6 = Distance(tSVector, position);
			if (fP3 > fP6 && fP6 >= fP2)
			{
				break;
			}
		}
		TSVector2 tSVector2 = tSVector;
		NovaLogger.Debug("猫眼.翻滚.终点坐标" + tSVector2.ToString());
		return tSVector;
	}

	private IEnumerator StationaryFire()
	{
		BeginAttack(ShootIndex, ShootAction, flushInputedKeys: true, forceInterruptAttack: true);
		AimAtTarget(target, 450);
		yield return WaitTime(0.2);
		CancelAim();
		HipFire(12, E_TypeOfFire.Tree, out ShootingCor);
		yield return StartCor(ShootingCor);
		CancelAttack();
	}

	private IEnumerator SweepFire()
	{
		if (sweepDirection)
		{
			SetLogicTagToggleValue(_actor, "SweepDirection", value: true);
			BeginAttack(L2RIndex, L2RShoot, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			SetLogicTagToggleValue(_actor, "SweepDirection", value: false);
			BeginAttack(R2LIndex, R2LShoot, flushInputedKeys: true, forceInterruptAttack: true);
		}
		sweepDirection = !sweepDirection;
		BeginLookAt_NotWait(target, 0.2, 900);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		HipFire(10, E_TypeOfFire.Sweep, out ShootingCor);
		yield return StartCor(ShootingCor);
		CancelAttack();
	}
}
