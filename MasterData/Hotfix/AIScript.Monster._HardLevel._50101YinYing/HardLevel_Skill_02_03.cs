using System.Collections;
using TrueSync;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Skill_02_03 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1600352851,
		(ComboInputBuffer.ActionKey)1718906696,
		(ComboInputBuffer.ActionKey)1415346281
	};

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 0.8, 250);
		yield return WaitCustomEvent("Shoot");
		ShootBullet();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void ShootBullet()
	{
		TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 2.5f), _actor.tsTransform.Rotation);
		TSVector2 multiShootDirection = GetEntityPositionObsoleted(GetAttackTarget()) - tSVector;
		CircleMultipleShoot("Bullet_50101YinYing_HardLevel_Dark_Skill02_01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 6, 0, tSVector, 0, multiShootDirection, 30, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}
}
