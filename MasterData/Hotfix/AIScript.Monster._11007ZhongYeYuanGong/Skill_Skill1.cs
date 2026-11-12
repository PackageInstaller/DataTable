using System.Collections;
using TrueSync;

namespace AIScript.Monster._11007ZhongYeYuanGong;

public class Skill_Skill1 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	private bool breakOff;

	private long fxWarningLine;

	private long fxWarningLine2;

	private TSVector2 shootPosition;

	protected override void OnSkillEnable()
	{
		breakOff = false;
	}

	protected override void OnSkillDisable()
	{
		if (breakOff)
		{
			StopEffect(fxWarningLine);
		}
		StopEffect(fxWarningLine2);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		BeginLookAt_NotWait(attackTarget, 0.4, 240);
		yield return WaitTime(0.4);
		yield return WaitCustomEvent("Warning1");
		fxWarningLine = WarningLine();
		AimAtTarget(GetAttackTarget(isUpToDate: true), 120);
		yield return WaitCustomEvent("Shoot1");
		CancelAim();
		yield return WaitTime(0.1);
		StopEffect(fxWarningLine);
		breakOff = false;
		for (int i = 0; i < 3; i++)
		{
			shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.4, 1.5));
			FanMultipleShoot("Bullet_01", AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: false, 0, 1, 0, shootPosition, 1.42, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 0, 0);
			yield return WaitTime(0.18f);
		}
		yield return WaitTime(0.1);
		yield return WaitCustomEvent("Warning2");
		fxWarningLine2 = WarningLine();
		AimAtTarget(GetAttackTarget(isUpToDate: true), 80);
		yield return WaitCustomEvent("Shoot2");
		CancelAim();
		StopEffect(fxWarningLine2);
		yield return WaitTime(0.03);
		breakOff = false;
		for (int i = 0; i < 3; i++)
		{
			shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.4, 1.5));
			FanMultipleShoot("Bullet_01", AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: false, 0, 1, 0, shootPosition, 1.42, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 0, 0);
			yield return WaitTime(0.18f);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private long WarningLine()
	{
		long result = PlayEffect("fx_m50551cancha_loop_redline_common");
		breakOff = true;
		return result;
	}
}
