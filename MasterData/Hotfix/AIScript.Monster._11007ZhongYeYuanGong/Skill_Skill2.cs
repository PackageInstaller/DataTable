using System.Collections;
using TrueSync;

namespace AIScript.Monster._11007ZhongYeYuanGong;

public class Skill_Skill2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private FP toangle1;

	private FP toangle2;

	private CoroutineNode ShootCor;

	private bool isshoot = true;

	protected override void OnSkillEnable()
	{
		isshoot = true;
	}

	protected override void OnSkillDisable()
	{
		isshoot = false;
		StopCor(ShootCor);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		if (CalcAngleBetweenSelfAndAttackTarget() > 80)
		{
			BeginLookAt(attackTarget, 0, 700);
			yield return WaitTime(0.2);
		}
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(0.8);
		ShootCor = StartCor(ShootAction());
		TSVector2 entityForward = GetEntityForward(_actor);
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		if (fP > 0)
		{
			toangle1 = fP + 50;
			toangle2 = -100;
		}
		else
		{
			toangle1 = fP - 50;
			toangle2 = 100;
		}
		BeginLookAtByDir(RotateTo(entityForward, toangle1), 0, 60);
		yield return WaitTime(FP.Abs(toangle1) / 60);
		entityForward = GetEntityForward(_actor);
		BeginLookAtByDir(RotateTo(entityForward, toangle2), 0, 60);
		yield return WaitTime(2);
		CancelAttack();
		isshoot = false;
		StopCor(ShootCor);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, 1, 300);
		yield return WaitTime(1);
	}

	private IEnumerator ShootAction()
	{
		while (isshoot)
		{
			FanMultipleShoot("Bullet_01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, GetPosition() + TSVector2.Rotate(new TSVector2(0.3f, 1.2f), GetEntityAngle(_actor)), 2.05f, GetForward(), 0, AimType.Default, BulletDirectionType.BulletToTarget, 10, 10, 0);
			yield return WaitTime(0.2);
		}
	}
}
