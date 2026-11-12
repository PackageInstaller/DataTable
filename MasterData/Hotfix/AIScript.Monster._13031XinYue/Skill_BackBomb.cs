using System.Collections;
using TrueSync;

namespace AIScript.Monster._13031XinYue;

public class Skill_BackBomb : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly int BulletAmount = 3;

	private static readonly FP IntervalTime = 0.1;

	private int BulletCount;

	private FP ShootDistance;

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		BulletCount = 0;
		ShootDistance = 7;
		yield return BeginLookAt(GetAttackTarget(), 0, 99999);
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("ShootStart");
		StopWaitLookAt();
		while (BulletCount <= BulletAmount)
		{
			FanMultipleShoot("Weapon_13031XinYue_Bomb", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.2, 0.4)), 1.9, GetForward(), 0, AimType.Default, BulletDirectionType.BulletToTarget, 120, ShootDistance, 0);
			BulletCount++;
			ShootDistance -= (FP)2;
			yield return WaitTime(IntervalTime);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
