using System.Collections;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack02_Nuji_Atk01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey._1
	};

	protected override IEnumerator DoMainLogic()
	{
		DoWave();
		yield return WaitTime(0.85);
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoWave()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill02_Nuji_Atk01_Wave", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 0, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
	}
}
