#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_MobileHipFire_LD : SkillBaseMaoYan
{
	private LogicEntity target;

	private bool sweepDirection;

	private IEnumerator ShootingCor;

	protected override void OnSkillEnable()
	{
		sweepDirection = false;
	}

	protected override void OnSkillDisable()
	{
		ShootingCor = null;
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		TSVector2 destination = GetDestination();
		yield return StartCor(Roll(destination, playEarlyWarning: true));
		yield return StartCor(SweepFire());
		destination = GetDestination();
		yield return StartCor(Slide(destination, playEarlyWarning: true));
		yield return StartCor(StationaryFire());
		destination = GetDestination();
		yield return StartCor(Roll(destination, playEarlyWarning: true));
		yield return StartCor(SweepFire());
		yield return StartCor(Reload());
	}

	private TSVector2 GetDestination()
	{
		TSVector2 tSVector = TSVector2.zero;
		TSVector2 position = GetPosition();
		FP fP = Distance(position, TSVector2.zero);
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(target);
		FP tSVectToAngle = GetTSVectToAngle(position - entityPositionObsoleted, 0);
		if (fP > 10)
		{
			entityPositionObsoleted = position;
			tSVectToAngle = GetTSVectToAngle(TSVector2.zero - position, 0);
			NovaLogger.Debug("猫眼.翻滚.板边");
		}
		else
		{
			entityPositionObsoleted = GetEntityPositionObsoleted(target);
			tSVectToAngle = GetTSVectToAngle(position - entityPositionObsoleted, 0);
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
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, entityPositionObsoleted, default, default, fP4, fP5, 90, tSVectToAngle);
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
		yield return WaitTime(0.3);
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
