using System.Collections;
using TrueSync;

namespace AIScript.Monster._Dark._HardLevel._50020ShaYuFaShi;

public class HardLevel_Dark_Skill_02 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly string BulletName = "Bullet_50020ShaYuFaShi_HardLevel_Dark_Skill02";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 1.5, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "Shoot")
		{
			TSVector2 tSVector = GetPosition() + TSVector2.Rotate(new TSVector2(0, 1f), _actor.tsTransform.Rotation);
			TSVector2 multiShootDirection = RotateTo(GetForward(), CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true));
			FP radius = Distance(tSVector, GetEntityPositionObsoleted(GetAttackTarget()));
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, tSVector, 2.7, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, radius, 0);
		}
	}
}
