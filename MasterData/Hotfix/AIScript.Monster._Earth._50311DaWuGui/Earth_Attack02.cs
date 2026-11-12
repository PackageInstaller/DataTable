#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Attack02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] L_Atk = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] R_Atk = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._2
	};

	private TSVector2 ShootTarget01;

	private TSVector2 ShootTarget02;

	private TSVector2 ShootTarget03;

	protected override IEnumerator DoMainLogic()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180)
		{
			NovaLogger.Debug("youshuaiwei");
			BeginAttack(1, R_Atk, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Shoot");
			Shoot01();
			yield return WaitCustomEvent("Turn");
			if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 160)
			{
				BeginLookAt_NotWait(GetCurrentPlayer(), 1, 150);
			}
			else
			{
				BeginRotateAngle(120, 200);
			}
			yield return WaitFrame(20);
			StopWaitLookAt();
		}
		else
		{
			BeginAttack(1, L_Atk, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Shoot");
			Shoot02();
			yield return WaitCustomEvent("Turn");
			if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -160 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 0)
			{
				BeginLookAt_NotWait(GetCurrentPlayer(), 1, 150);
			}
			else
			{
				BeginRotateAngle(-120, 200);
			}
			yield return WaitFrame(20);
			StopWaitLookAt();
		}
		yield return WaitFrame(15);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void Shoot01()
	{
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.2, 1.9));
		FP fP = Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
		FP fP2 = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (fP > 5 && fP < 10 && fP2 >= -20 && fP2 <= 120)
		{
			ShootTarget01 = GetEntityPositionObsoleted(GetCurrentPlayer());
			ShootTarget02 = TransLocalPosToWorldPos(ShootTarget01, ShootTarget01 - GetPosition(), new TSVector2(4, -1));
			ShootTarget03 = TransLocalPosToWorldPos(ShootTarget01, ShootTarget01 - GetPosition(), new TSVector2(-4, -1));
		}
		else if (fP2 > 120 && fP2 <= 180)
		{
			TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 7f), _actor.tsTransform.Rotation);
			ShootTarget01 = RotateTo(tSVector, 100);
			ShootTarget02 = RotateTo(tSVector, 80);
			ShootTarget03 = RotateTo(tSVector, 60);
		}
		else
		{
			TSVector2 tSVector2 = GetPosition() + TSVector2.Rotate(new TSVector2(0, 7f), _actor.tsTransform.Rotation);
			ShootTarget01 = RotateTo(tSVector2, 30);
			ShootTarget02 = RotateTo(tSVector2, 10);
			ShootTarget03 = RotateTo(tSVector2, -10);
		}
		Shoot("Bullet_50311_DaWuGui_Skill02", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, ShootTarget01);
		if (GetBuffNum(_actor, 503110002) >= 1)
		{
			Shoot("Bullet_50311_DaWuGui_Skill02", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, ShootTarget02);
			Shoot("Bullet_50311_DaWuGui_Skill02", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, ShootTarget03);
		}
	}

	protected void Shoot02()
	{
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-0.2, 1.9));
		FP fP = Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
		FP fP2 = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (fP > 5 && fP < 10 && fP2 >= -120 && fP2 <= 20)
		{
			ShootTarget01 = GetEntityPositionObsoleted(GetCurrentPlayer());
			ShootTarget02 = TransLocalPosToWorldPos(ShootTarget01, ShootTarget01 - GetPosition(), new TSVector2(4, -1));
			ShootTarget03 = TransLocalPosToWorldPos(ShootTarget01, ShootTarget01 - GetPosition(), new TSVector2(-4, -1));
		}
		else if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -180 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < -120)
		{
			TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 7f), _actor.tsTransform.Rotation);
			ShootTarget01 = RotateTo(tSVector, -60);
			ShootTarget02 = RotateTo(tSVector, -40);
			ShootTarget03 = RotateTo(tSVector, -20);
		}
		else
		{
			TSVector2 tSVector2 = GetPosition() + TSVector2.Rotate(new TSVector2(0, 7f), _actor.tsTransform.Rotation);
			ShootTarget01 = RotateTo(tSVector2, -20);
			ShootTarget02 = RotateTo(tSVector2, 0);
			ShootTarget03 = RotateTo(tSVector2, 20);
		}
		Shoot("Bullet_50311_DaWuGui_Skill02", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, ShootTarget01);
		if (GetBuffNum(_actor, 503110002) >= 1)
		{
			Shoot("Bullet_50311_DaWuGui_Skill02", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, ShootTarget02);
			Shoot("Bullet_50311_DaWuGui_Skill02", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, ShootTarget03);
		}
	}
}
