using System.Collections;
using TrueSync;

namespace AIScript.Monster._Dark._HardLevel._50020ShaYuFaShi;

public class HardLevel_Dark_Skill_03 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private readonly string BulletName = "Bullet_50020ShaYuFaShi_HardLevel_Dark_Skill03_1";

	private readonly string AreaName = "Area_50020ShaYuFaShi_HardLevel_Dark_Skill03";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 1.3, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetAttackTarget());
		TSVector2 multiShootDirection = RotateTo(GetForward(), CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true));
		if (eventName == "Shoot")
		{
			PlayAreaEffect(AreaName, entityPositionObsoleted);
			CircleMultipleShoot(BulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, entityPositionObsoleted, 2.7, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		}
	}
}
